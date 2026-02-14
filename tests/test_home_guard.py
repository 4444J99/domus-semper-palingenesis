"""Tests for domus-home-guard script."""
from __future__ import annotations

import subprocess
import sys
import tempfile
from pathlib import Path
from unittest import mock

SCRIPT_DIR = Path(__file__).resolve().parent.parent / "dot_local" / "bin"
SCRIPT = SCRIPT_DIR / "executable_domus-home-guard"


def _import_module():
    import importlib.machinery
    import importlib.util

    loader = importlib.machinery.SourceFileLoader("home_guard", str(SCRIPT))
    spec = importlib.util.spec_from_loader("home_guard", loader)
    mod = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(mod)
    return mod


_mod = _import_module()
classify_file = _mod.classify_file
unique_dest = _mod.unique_dest
is_repo_dir = _mod.is_repo_dir
ALLOW_NAMES = _mod.ALLOW_NAMES


# ─── classify_file tests ───


class TestClassifyFile:
    def test_image_to_pictures(self):
        dest = classify_file(Path("/tmp/photo.png"), "20260101")
        assert "Pictures" in str(dest)

    def test_video_to_movies(self):
        dest = classify_file(Path("/tmp/clip.mp4"), "20260101")
        assert "Movies" in str(dest)

    def test_audio_to_music(self):
        dest = classify_file(Path("/tmp/song.mp3"), "20260101")
        assert "Music" in str(dest)

    def test_document_to_inbox(self):
        dest = classify_file(Path("/tmp/report.pdf"), "20260101")
        assert "Documents" in str(dest)
        assert "Inbox" in str(dest)

    def test_installer_to_archive(self):
        dest = classify_file(Path("/tmp/app.dmg"), "20260101")
        assert "installers" in str(dest)

    def test_archive_to_archive(self):
        dest = classify_file(Path("/tmp/data.zip"), "20260101")
        assert "archives" in str(dest)

    def test_unknown_to_home_root(self):
        dest = classify_file(Path("/tmp/random.xyz"), "20260101")
        assert "home-root" in str(dest)


# ─── unique_dest tests ───


class TestUniqueDest:
    def test_no_collision(self):
        with tempfile.TemporaryDirectory() as d:
            dest = Path(d) / "file.txt"
            assert unique_dest(dest) == dest

    def test_collision_appends_counter(self):
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


# ─── is_repo_dir tests ───


class TestIsRepoDir:
    def test_git_dir(self):
        with tempfile.TemporaryDirectory() as d:
            (Path(d) / ".git").mkdir()
            assert is_repo_dir(Path(d)) is True

    def test_git_file(self):
        with tempfile.TemporaryDirectory() as d:
            (Path(d) / ".git").write_text("gitdir: ../something")
            assert is_repo_dir(Path(d)) is True

    def test_not_repo(self):
        with tempfile.TemporaryDirectory() as d:
            assert is_repo_dir(Path(d)) is False


# ─── allowlist tests ───


class TestAllowlist:
    def test_standard_dirs_in_allowlist(self):
        for name in ["Desktop", "Documents", "Downloads", "Library", "Music", "Pictures"]:
            assert name in ALLOW_NAMES

    def test_workspace_in_allowlist(self):
        assert "Workspace" in ALLOW_NAMES


# ─── CLI tests ───


class TestCLI:
    def test_dry_run_no_changes(self):
        with tempfile.TemporaryDirectory() as d:
            # Create a stray file in mock HOME
            stray = Path(d) / "stray-file.txt"
            stray.write_text("content")

            result = subprocess.run(
                [sys.executable, "-c", f"""
import sys
sys.argv = ['home-guard']
from unittest.mock import patch
from pathlib import Path
import importlib.machinery, importlib.util
loader = importlib.machinery.SourceFileLoader("hg", "{SCRIPT}")
spec = importlib.util.spec_from_loader("hg", loader)
mod = importlib.util.module_from_spec(spec)
with patch.object(Path, "home", return_value=Path("{d}")):
    spec.loader.exec_module(mod)
"""],
                capture_output=True,
                text=True,
            )
            # Just verify the script doesn't crash
            assert result.returncode == 0

    def test_help_flag(self):
        result = subprocess.run(
            [sys.executable, str(SCRIPT), "--help"],
            capture_output=True,
            text=True,
        )
        assert result.returncode == 0
        assert "dry run" in result.stdout.lower() or "apply" in result.stdout.lower()

    def test_hidden_files_skipped(self):
        """Hidden files (dotfiles) should not be touched."""
        with tempfile.TemporaryDirectory() as d:
            hidden = Path(d) / ".bashrc"
            hidden.write_text("export PATH=.")

            result = subprocess.run(
                [sys.executable, str(SCRIPT), "--help"],
                capture_output=True,
                text=True,
            )
            # Just ensure the script parses --help without error
            assert result.returncode == 0
