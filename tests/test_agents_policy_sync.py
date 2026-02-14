"""Tests for domus-agents-policy-sync script."""
from __future__ import annotations

import tempfile
from pathlib import Path
from unittest.mock import patch

SCRIPT_DIR = Path(__file__).resolve().parent.parent / "dot_local" / "bin"
SCRIPT = SCRIPT_DIR / "executable_domus-agents-policy-sync"


def _import_module(home_dir: Path):
    """Import the module with a patched HOME directory."""
    import importlib.machinery
    import importlib.util

    loader = importlib.machinery.SourceFileLoader("agents_policy_sync", str(SCRIPT))
    spec = importlib.util.spec_from_loader("agents_policy_sync", loader)
    mod = importlib.util.module_from_spec(spec)
    with patch.object(Path, "home", return_value=home_dir):
        spec.loader.exec_module(mod)
    return mod


# ─── insert_notice tests ───


class TestInsertNotice:
    def test_inserts_notice_after_heading(self):
        with tempfile.TemporaryDirectory() as d:
            home = Path(d)
            mod = _import_module(home)

            agents = home / "project" / "AGENTS.md"
            agents.parent.mkdir()
            agents.write_text("# Project Rules\n\nSome content here.\n")

            result = mod.insert_notice(agents)
            assert result is True
            text = agents.read_text()
            assert mod.NOTICE_LINE in text
            # Notice should come after first heading
            lines = text.splitlines()
            heading_idx = next(i for i, l in enumerate(lines) if l.startswith("# "))
            notice_idx = next(i for i, l in enumerate(lines) if mod.NOTICE_LINE in l)
            assert notice_idx > heading_idx

    def test_idempotent(self):
        with tempfile.TemporaryDirectory() as d:
            home = Path(d)
            mod = _import_module(home)

            agents = home / "project" / "AGENTS.md"
            agents.parent.mkdir()
            agents.write_text("# Rules\n\nContent.\n")

            mod.insert_notice(agents)
            text_after_first = agents.read_text()

            result = mod.insert_notice(agents)
            assert result is False
            assert agents.read_text() == text_after_first

    def test_handles_yaml_front_matter(self):
        with tempfile.TemporaryDirectory() as d:
            home = Path(d)
            mod = _import_module(home)

            agents = home / "project" / "AGENTS.md"
            agents.parent.mkdir()
            agents.write_text("---\ntitle: Rules\n---\n# Rules\n\nContent.\n")

            result = mod.insert_notice(agents)
            assert result is True
            text = agents.read_text()
            assert mod.NOTICE_LINE in text
            # Notice should come after front matter closing ---
            lines = text.splitlines()
            dashes = [i for i, l in enumerate(lines) if l.strip() == "---"]
            assert len(dashes) >= 2
            notice_idx = next(i for i, l in enumerate(lines) if mod.NOTICE_LINE in l)
            assert notice_idx > dashes[1]


# ─── global skip tests ───


class TestGlobalSkip:
    def test_skips_global_agents_md(self):
        with tempfile.TemporaryDirectory() as d:
            home = Path(d)
            mod = _import_module(home)

            # Create global AGENTS.md
            global_agents = home / "AGENTS.md"
            global_agents.write_text("# Global Policy\n")

            # Create a project AGENTS.md
            project_agents = home / "project" / "AGENTS.md"
            project_agents.parent.mkdir()
            project_agents.write_text("# Project Rules\n")

            with patch.object(Path, "home", return_value=home):
                updated = mod.main()
            assert updated == 1
            # Global file should NOT have the notice
            assert mod.NOTICE_LINE not in global_agents.read_text()
            # Project file should have the notice
            assert mod.NOTICE_LINE in project_agents.read_text()


# ─── excluded directories tests ───


class TestExcludedDirs:
    def test_skips_excluded_dirs(self):
        with tempfile.TemporaryDirectory() as d:
            home = Path(d)
            mod = _import_module(home)

            # Create AGENTS.md in excluded path
            excluded = home / "Library" / "CloudStorage" / "project" / "AGENTS.md"
            excluded.parent.mkdir(parents=True)
            excluded.write_text("# Cloud Rules\n")

            with patch.object(Path, "home", return_value=home):
                updated = mod.main()
            assert updated == 0
            assert mod.NOTICE_LINE not in excluded.read_text()

    def test_skips_prune_dirs(self):
        with tempfile.TemporaryDirectory() as d:
            home = Path(d)
            mod = _import_module(home)

            # Create AGENTS.md in node_modules
            nm = home / "project" / "node_modules" / "pkg" / "AGENTS.md"
            nm.parent.mkdir(parents=True)
            nm.write_text("# Package Rules\n")

            with patch.object(Path, "home", return_value=home):
                updated = mod.main()
            assert updated == 0


# ─── main integration tests ───


class TestMain:
    def test_processes_multiple_projects(self):
        with tempfile.TemporaryDirectory() as d:
            home = Path(d)
            mod = _import_module(home)

            for name in ["proj-a", "proj-b", "proj-c"]:
                agents = home / name / "AGENTS.md"
                agents.parent.mkdir()
                agents.write_text(f"# {name} Rules\n")

            with patch.object(Path, "home", return_value=home):
                updated = mod.main()
            assert updated == 3

    def test_returns_zero_when_nothing_to_update(self):
        with tempfile.TemporaryDirectory() as d:
            home = Path(d)
            mod = _import_module(home)
            with patch.object(Path, "home", return_value=home):
                updated = mod.main()
            assert updated == 0
