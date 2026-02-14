"""Tests for photo-sort script."""
from __future__ import annotations

import datetime as dt
import importlib.util
import os
import struct
import subprocess
import sys
import tempfile
from pathlib import Path

# Import functions from the script
SCRIPT_DIR = Path(__file__).resolve().parent.parent / "dot_local" / "bin"
SCRIPT = SCRIPT_DIR / "executable_photo-sort"


def _import_module():
    import importlib.machinery

    loader = importlib.machinery.SourceFileLoader("photo_sort", str(SCRIPT))
    spec = importlib.util.spec_from_loader("photo_sort", loader)
    mod = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(mod)
    return mod


mod = _import_module()
read_exif_date = mod.read_exif_date
get_file_date = mod.get_file_date
unique_dest = mod.unique_dest


# ─── Helper: create a minimal JPEG with EXIF DateTimeOriginal ───


def make_jpeg_with_exif(path: Path, date_str: str = "2024:06:15 14:30:00") -> None:
    """Create a minimal JPEG file with an EXIF DateTimeOriginal tag."""
    # Build minimal EXIF APP1 segment
    date_bytes = date_str.encode("ascii") + b"\x00"  # null-terminated

    # TIFF header (little-endian)
    tiff_header = b"II"  # little-endian
    tiff_header += struct.pack("<H", 42)  # magic
    tiff_header += struct.pack("<I", 8)  # offset to IFD0

    # IFD0: one entry pointing to ExifIFD
    ifd0_count = struct.pack("<H", 1)
    # ExifIFD pointer (tag 0x8769, type LONG, count 1, value = offset to ExifIFD)
    exif_ifd_offset = 8 + 2 + 12 + 4  # after IFD0
    ifd0_entry = struct.pack("<HHII", 0x8769, 4, 1, exif_ifd_offset)
    ifd0_next = struct.pack("<I", 0)  # no next IFD

    # ExifIFD: one entry for DateTimeOriginal (0x9003)
    exif_ifd_count = struct.pack("<H", 1)
    date_value_offset = exif_ifd_offset + 2 + 12 + 4  # after ExifIFD
    exif_entry = struct.pack("<HHII", 0x9003, 2, 20, date_value_offset)
    exif_next = struct.pack("<I", 0)

    tiff_data = (
        tiff_header
        + ifd0_count
        + ifd0_entry
        + ifd0_next
        + exif_ifd_count
        + exif_entry
        + exif_next
        + date_bytes
    )

    # APP1 segment: "Exif\x00\x00" + TIFF data
    app1_data = b"Exif\x00\x00" + tiff_data
    app1_length = len(app1_data) + 2  # +2 for the length field itself
    app1_segment = b"\xff\xe1" + struct.pack(">H", app1_length) + app1_data

    # Minimal JPEG: SOI + APP1 + EOI
    jpeg = b"\xff\xd8" + app1_segment + b"\xff\xd9"
    path.write_bytes(jpeg)


# ─── read_exif_date tests ───


class TestReadExifDate:
    def test_reads_date_from_jpeg(self):
        with tempfile.TemporaryDirectory() as d:
            img = Path(d) / "test.jpg"
            make_jpeg_with_exif(img, "2024:06:15 14:30:00")
            result = read_exif_date(img)
            assert result is not None
            assert result == dt.datetime(2024, 6, 15, 14, 30, 0)

    def test_returns_none_for_png(self):
        with tempfile.TemporaryDirectory() as d:
            img = Path(d) / "test.png"
            img.write_bytes(b"\x89PNG\r\n\x1a\n")
            result = read_exif_date(img)
            assert result is None

    def test_returns_none_for_non_jpeg(self):
        with tempfile.TemporaryDirectory() as d:
            img = Path(d) / "test.txt"
            img.write_text("not an image")
            result = read_exif_date(img)
            assert result is None

    def test_returns_none_for_jpeg_without_exif(self):
        with tempfile.TemporaryDirectory() as d:
            img = Path(d) / "test.jpg"
            img.write_bytes(b"\xff\xd8\xff\xd9")  # minimal JPEG, no EXIF
            result = read_exif_date(img)
            assert result is None


# ─── get_file_date tests ───


class TestGetFileDate:
    def test_falls_back_to_mtime(self):
        with tempfile.TemporaryDirectory() as d:
            f = Path(d) / "test.png"
            f.write_bytes(b"\x89PNG\r\n\x1a\n")
            result = get_file_date(f)
            assert isinstance(result, dt.datetime)
            # Should be close to now
            assert (dt.datetime.now() - result).total_seconds() < 10

    def test_prefers_exif_over_mtime(self):
        with tempfile.TemporaryDirectory() as d:
            img = Path(d) / "test.jpg"
            make_jpeg_with_exif(img, "2020:01:15 08:00:00")
            result = get_file_date(img)
            assert result == dt.datetime(2020, 1, 15, 8, 0, 0)


# ─── unique_dest tests ───


class TestUniqueDest:
    def test_no_collision(self):
        with tempfile.TemporaryDirectory() as d:
            dest = Path(d) / "photo.jpg"
            assert unique_dest(dest) == dest

    def test_collision(self):
        with tempfile.TemporaryDirectory() as d:
            dest = Path(d) / "photo.jpg"
            dest.touch()
            result = unique_dest(dest)
            assert result.name == "photo-1.jpg"

    def test_multiple_collisions(self):
        with tempfile.TemporaryDirectory() as d:
            dest = Path(d) / "photo.jpg"
            dest.touch()
            (Path(d) / "photo-1.jpg").touch()
            result = unique_dest(dest)
            assert result.name == "photo-2.jpg"


# ─── CLI integration tests ───


class TestCLI:
    def test_dry_run_no_changes(self):
        with tempfile.TemporaryDirectory() as d:
            inbox = Path(d) / "inbox"
            inbox.mkdir()
            (inbox / "photo.jpg").write_bytes(b"\xff\xd8\xff\xd9")
            result = subprocess.run(
                [sys.executable, str(SCRIPT), "--root", str(inbox)],
                capture_output=True,
                text=True,
            )
            assert result.returncode == 0
            assert "would move" in result.stdout
            assert (inbox / "photo.jpg").exists()

    def test_apply_moves_files(self):
        with tempfile.TemporaryDirectory() as d:
            inbox = Path(d) / "inbox"
            inbox.mkdir()
            (inbox / "photo.jpg").write_bytes(b"\xff\xd8\xff\xd9")
            result = subprocess.run(
                [sys.executable, str(SCRIPT), "--root", str(inbox), "--apply"],
                capture_output=True,
                text=True,
            )
            assert result.returncode == 0
            assert "move" in result.stdout
            # File should have been moved out of inbox
            assert not (inbox / "photo.jpg").exists()

    def test_skips_non_media(self):
        with tempfile.TemporaryDirectory() as d:
            inbox = Path(d) / "inbox"
            inbox.mkdir()
            (inbox / "readme.txt").write_text("hello")
            result = subprocess.run(
                [sys.executable, str(SCRIPT), "--root", str(inbox)],
                capture_output=True,
                text=True,
            )
            assert result.returncode == 0
            assert "skip non-media" in result.stdout

    def test_nonexistent_root(self):
        result = subprocess.run(
            [sys.executable, str(SCRIPT), "--root", "/nonexistent/dir"],
            capture_output=True,
            text=True,
        )
        assert result.returncode == 1

    def test_skips_hidden_files(self):
        with tempfile.TemporaryDirectory() as d:
            inbox = Path(d) / "inbox"
            inbox.mkdir()
            (inbox / ".hidden.jpg").write_bytes(b"\xff\xd8\xff\xd9")
            result = subprocess.run(
                [sys.executable, str(SCRIPT), "--root", str(inbox)],
                capture_output=True,
                text=True,
            )
            assert result.returncode == 0
            assert "skipped=1" in result.stdout
