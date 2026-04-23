"""Tests for domus_lib shared Python library."""
from __future__ import annotations

import sys
import tempfile
from pathlib import Path

SCRIPT_DIR = Path(__file__).resolve().parent.parent / "dot_local" / "bin"

# Ensure domus_lib is importable (lives alongside the scripts)
if str(SCRIPT_DIR) not in sys.path:
    sys.path.insert(0, str(SCRIPT_DIR))

from domus_lib import MULTI_EXT, split_name, unique_dest  # noqa: E402


# ─── split_name tests ───


class TestSplitName:
    def test_simple_extension(self):
        assert split_name("photo.png") == ("photo", ".png")

    def test_no_extension(self):
        assert split_name("Makefile") == ("Makefile", "")

    def test_dotfile(self):
        assert split_name(".bashrc") == (".bashrc", "")

    def test_multiple_dots(self):
        assert split_name("my.cool.project.tar") == ("my.cool.project", ".tar")

    def test_case_preserved(self):
        stem, ext = split_name("README.MD")
        assert stem == "README"
        assert ext == ".MD"

    def test_tar_gz(self):
        assert split_name("archive.tar.gz") == ("archive", ".tar.gz")

    def test_tar_xz(self):
        assert split_name("archive.tar.xz") == ("archive", ".tar.xz")

    def test_tar_bz2(self):
        assert split_name("archive.tar.bz2") == ("archive", ".tar.bz2")

    def test_tar_zst(self):
        assert split_name("data.tar.zst") == ("data", ".tar.zst")

    def test_tar_lz4(self):
        assert split_name("data.tar.lz4") == ("data", ".tar.lz4")

    def test_tar_lz(self):
        assert split_name("data.tar.lz") == ("data", ".tar.lz")

    def test_multi_ext_case_insensitive(self):
        """Multi-ext matching is case-insensitive; returns the MULTI_EXT form."""
        stem, ext = split_name("FILE.TAR.GZ")
        assert stem == "FILE"
        assert ext.lower() == ".tar.gz"

    def test_multi_ext_with_dots_in_stem(self):
        assert split_name("my.project.v2.tar.gz") == ("my.project.v2", ".tar.gz")

    def test_all_multi_ext_covered(self):
        """Every entry in MULTI_EXT is properly handled."""
        for ext in MULTI_EXT:
            stem, got = split_name(f"test{ext}")
            assert got == ext, f"Expected {ext}, got {got}"


# ─── unique_dest tests ───


class TestUniqueDest:
    def test_no_collision(self):
        with tempfile.TemporaryDirectory() as d:
            dest = Path(d) / "file.txt"
            assert unique_dest(dest) == dest

    def test_single_collision(self):
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
            (Path(d) / "file-2.txt").touch()
            result = unique_dest(dest)
            assert result.name == "file-3.txt"

    def test_no_extension(self):
        with tempfile.TemporaryDirectory() as d:
            dest = Path(d) / "Makefile"
            dest.touch()
            result = unique_dest(dest)
            assert result.name == "Makefile-1"

    def test_multi_ext_collision(self):
        with tempfile.TemporaryDirectory() as d:
            dest = Path(d) / "backup.tar.gz"
            dest.touch()
            result = unique_dest(dest)
            assert result.name == "backup-1.tar.gz"

    def test_multi_ext_multiple_collisions(self):
        with tempfile.TemporaryDirectory() as d:
            dest = Path(d) / "backup.tar.gz"
            dest.touch()
            (Path(d) / "backup-1.tar.gz").touch()
            result = unique_dest(dest)
            assert result.name == "backup-2.tar.gz"
