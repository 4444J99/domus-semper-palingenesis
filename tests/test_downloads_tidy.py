"""Tests for domus-downloads-tidy script."""
from __future__ import annotations

import subprocess
import sys
import tempfile
import time
from pathlib import Path

SCRIPT_DIR = Path(__file__).resolve().parent.parent / "dot_local" / "bin"
SCRIPT = SCRIPT_DIR / "executable_domus-downloads-tidy"


def _import_module():
    import importlib.machinery
    import importlib.util

    loader = importlib.machinery.SourceFileLoader("downloads_tidy", str(SCRIPT))
    spec = importlib.util.spec_from_loader("downloads_tidy", loader)
    mod = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(mod)
    return mod


_mod = _import_module()
split_name = _mod.split_name
category_for = _mod.category_for
unique_dest = _mod.unique_dest


# ─── split_name tests ───


class TestSplitName:
    def test_simple_ext(self):
        assert split_name("file.txt") == ("file", ".txt")

    def test_no_ext(self):
        assert split_name("README") == ("README", "")

    def test_multi_ext_tar_gz(self):
        assert split_name("archive.tar.gz") == ("archive", ".tar.gz")

    def test_multi_ext_tar_xz(self):
        assert split_name("backup.tar.xz") == ("backup", ".tar.xz")

    def test_dotfile(self):
        assert split_name(".hidden") == (".hidden", "")

    def test_multi_dots(self):
        assert split_name("my.file.name.txt") == ("my.file.name", ".txt")


# ─── category_for tests ───


class TestCategoryFor:
    def test_installer(self):
        assert category_for("app.dmg") == "installers"

    def test_archive(self):
        assert category_for("data.zip") == "archives"

    def test_document(self):
        assert category_for("report.pdf") == "documents"

    def test_image(self):
        assert category_for("photo.png") == "images"

    def test_video(self):
        assert category_for("clip.mp4") == "videos"

    def test_audio(self):
        assert category_for("song.mp3") == "audio"

    def test_code(self):
        assert category_for("main.py") == "code"

    def test_other(self):
        assert category_for("data.xyz") == "other"

    def test_skip_download(self):
        assert category_for("file.crdownload") == "skip"

    def test_case_insensitive(self):
        assert category_for("Photo.JPG") == "images"

    def test_spreadsheet(self):
        assert category_for("budget.xlsx") == "spreadsheets"

    def test_font(self):
        assert category_for("mono.ttf") == "fonts"


# ─── unique_dest tests ───


class TestUniqueDest:
    def test_no_collision(self):
        with tempfile.TemporaryDirectory() as d:
            dest = Path(d) / "file.txt"
            assert unique_dest(dest) == dest

    def test_collision_appends_suffix(self):
        with tempfile.TemporaryDirectory() as d:
            dest = Path(d) / "file.txt"
            dest.touch()
            result = unique_dest(dest)
            assert result.name == "file-1.txt"

    def test_multiple_collisions(self):
        with tempfile.TemporaryDirectory() as d:
            dest = Path(d) / "file.txt"
            dest.touch()
            (Path(d) / "file-1.txt").touch()
            result = unique_dest(dest)
            assert result.name == "file-2.txt"

    def test_no_ext(self):
        with tempfile.TemporaryDirectory() as d:
            dest = Path(d) / "README"
            dest.touch()
            result = unique_dest(dest)
            assert result.name == "README-1"


# ─── CLI tests ───


class TestCLI:
    def test_dry_run_no_moves(self):
        with tempfile.TemporaryDirectory() as d:
            f = Path(d) / "report.pdf"
            f.write_text("content")
            # Make it old enough (>14 days)
            old_time = time.time() - (15 * 86400)
            import os

            os.utime(f, (old_time, old_time))

            result = subprocess.run(
                [sys.executable, str(SCRIPT), "--root", d, "--since-days", "14"],
                capture_output=True,
                text=True,
            )
            assert result.returncode == 0
            assert "would move" in result.stdout
            assert f.exists()

    def test_apply_moves_file(self):
        with tempfile.TemporaryDirectory() as d:
            f = Path(d) / "report.pdf"
            f.write_text("content")
            old_time = time.time() - (15 * 86400)
            import os

            os.utime(f, (old_time, old_time))

            result = subprocess.run(
                [sys.executable, str(SCRIPT), "--root", d, "--apply", "--since-days", "14"],
                capture_output=True,
                text=True,
            )
            assert result.returncode == 0
            assert "move" in result.stdout
            assert not f.exists()

    def test_recent_files_skipped(self):
        with tempfile.TemporaryDirectory() as d:
            f = Path(d) / "new.pdf"
            f.write_text("content")
            # File is brand new, so --since-days 14 should skip it

            result = subprocess.run(
                [sys.executable, str(SCRIPT), "--root", d, "--since-days", "14"],
                capture_output=True,
                text=True,
            )
            assert result.returncode == 0
            assert "skip recent" in result.stdout

    def test_hidden_files_skipped(self):
        with tempfile.TemporaryDirectory() as d:
            f = Path(d) / ".hidden"
            f.write_text("content")

            result = subprocess.run(
                [sys.executable, str(SCRIPT), "--root", d, "--since-days", "0"],
                capture_output=True,
                text=True,
            )
            assert result.returncode == 0
            assert ".hidden" not in result.stdout

    def test_nonexistent_root(self):
        result = subprocess.run(
            [sys.executable, str(SCRIPT), "--root", "/nonexistent/path"],
            capture_output=True,
            text=True,
        )
        assert result.returncode != 0
