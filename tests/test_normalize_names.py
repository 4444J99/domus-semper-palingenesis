"""Tests for normalize-names script."""
from __future__ import annotations

import subprocess
import sys
import tempfile
from pathlib import Path

# Import normalize_name from the script
SCRIPT_DIR = Path(__file__).resolve().parent.parent / "dot_local" / "bin"
SCRIPT = SCRIPT_DIR / "executable_normalize-names"

# Add the script directory to sys.path for import
sys.path.insert(0, str(SCRIPT_DIR))


def _import_module():
    """Import the script as a module by creating a loader manually."""
    import importlib.machinery
    import importlib.util

    loader = importlib.machinery.SourceFileLoader("normalize_names", str(SCRIPT))
    spec = importlib.util.spec_from_loader("normalize_names", loader)
    mod = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(mod)
    return mod


_mod = _import_module()
normalize_name = _mod.normalize_name
unique_dest = _mod.unique_dest


# ─── normalize_name unit tests ───


class TestNormalizeName:
    def test_spaces_to_dashes(self):
        assert normalize_name("My File Name.txt") == "my-file-name.txt"

    def test_uppercase_to_lowercase(self):
        assert normalize_name("README.TXT") == "readme.txt"

    def test_underscores_to_dashes(self):
        assert normalize_name("my_file_name.py") == "my-file-name.py"

    def test_empty_brackets_removed(self):
        assert normalize_name("file ().txt") == "file.txt"
        assert normalize_name("file [].txt") == "file.txt"
        assert normalize_name("file {}.txt") == "file.txt"

    def test_brackets_with_content_become_dashes(self):
        assert normalize_name("file (copy).txt") == "file-copy.txt"
        assert normalize_name("file [v2].txt") == "file-v2.txt"

    def test_multi_ext_preserved(self):
        assert normalize_name("Archive.tar.gz") == "archive.tar.gz"
        assert normalize_name("Backup.tar.xz") == "backup.tar.xz"

    def test_consecutive_dashes_collapsed(self):
        assert normalize_name("a---b.txt") == "a-b.txt"
        assert normalize_name("a   b.txt") == "a-b.txt"

    def test_leading_trailing_dashes_stripped(self):
        assert normalize_name("-file-.txt") == "file.txt"

    def test_empty_stem_becomes_unnamed(self):
        assert normalize_name("().txt") == "unnamed.txt"

    def test_dots_in_stem_become_dashes(self):
        assert normalize_name("file.name.v2.txt") == "file-name-v2.txt"

    def test_special_chars_removed(self):
        assert normalize_name("file!@#$%.txt") == "file.txt"

    def test_plus_signs_become_dashes(self):
        assert normalize_name("c++.txt") == "c.txt"  # ++ -> dashes -> stripped

    def test_already_normalized(self):
        assert normalize_name("clean-file.txt") == "clean-file.txt"


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
            assert not result.exists()

    def test_multiple_collisions(self):
        with tempfile.TemporaryDirectory() as d:
            dest = Path(d) / "file.txt"
            dest.touch()
            (Path(d) / "file-1.txt").touch()
            result = unique_dest(dest)
            assert result.name == "file-2.txt"


# ─── CLI integration tests ───


class TestCLI:
    def test_dry_run_no_changes(self):
        with tempfile.TemporaryDirectory() as d:
            (Path(d) / "My File.txt").touch()
            result = subprocess.run(
                [sys.executable, str(SCRIPT), "--root", d],
                capture_output=True,
                text=True,
            )
            assert result.returncode == 0
            assert "would rename" in result.stdout
            # File should still have original name
            assert (Path(d) / "My File.txt").exists()

    def test_apply_renames(self):
        with tempfile.TemporaryDirectory() as d:
            (Path(d) / "My File.txt").write_text("content")
            result = subprocess.run(
                [sys.executable, str(SCRIPT), "--root", d, "--apply"],
                capture_output=True,
                text=True,
            )
            assert result.returncode == 0
            assert "rename" in result.stdout
            assert (Path(d) / "my-file.txt").exists()
            assert not (Path(d) / "My File.txt").exists()

    def test_remove_zero_byte(self):
        with tempfile.TemporaryDirectory() as d:
            (Path(d) / "empty.txt").touch()
            (Path(d) / "notempty.txt").write_text("content")
            result = subprocess.run(
                [sys.executable, str(SCRIPT), "--root", d, "--remove-zero", "--apply"],
                capture_output=True,
                text=True,
            )
            assert result.returncode == 0
            assert not (Path(d) / "empty.txt").exists()
            assert (Path(d) / "notempty.txt").exists()

    def test_nonexistent_root(self):
        result = subprocess.run(
            [sys.executable, str(SCRIPT), "--root", "/nonexistent/dir"],
            capture_output=True,
            text=True,
        )
        assert result.returncode == 1
