"""Tests for modify_dot_claude.json.tmpl — the safety-critical chezmoi modify script
that guards ~/.claude.json (~6000 lines of Claude Code state).

The script reads JSON from stdin, parses it, and writes it back as pretty-printed
JSON (2-space indent, no trailing newline, unicode preserved). On malformed input
it falls back to an empty object `{}`.
"""
from __future__ import annotations

import json
import os
import subprocess
import sys
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parent.parent
SCRIPT = REPO_ROOT / "modify_dot_claude.json.tmpl"


def _run_script(stdin_data: str) -> subprocess.CompletedProcess:
    """Invoke the modify script via subprocess, piping stdin_data."""
    env = {**os.environ, "CHEZMOI_MODIFY_TEST": "1"}
    return subprocess.run(
        [sys.executable, str(SCRIPT)],
        input=stdin_data,
        capture_output=True,
        text=True,
        env=env,
    )


# ─── Valid input passthrough ───


class TestValidJsonPassthrough:
    def test_valid_json_passthrough(self):
        """Feed valid JSON with multiple keys, verify output is valid JSON
        with the same keys and values."""
        data = {"name": "claude", "version": 3, "enabled": True}
        result = _run_script(json.dumps(data))
        assert result.returncode == 0, f"stderr: {result.stderr}"
        parsed = json.loads(result.stdout)
        assert parsed == data

    def test_empty_json_object(self):
        """Feed `{}`, verify output is `{}`."""
        result = _run_script("{}")
        assert result.returncode == 0, f"stderr: {result.stderr}"
        parsed = json.loads(result.stdout)
        assert parsed == {}


# ─── Malformed and empty input fallback ───


class TestFallbackBehavior:
    def test_malformed_json_input(self):
        """Feed invalid JSON, verify output falls back to `{}`."""
        result = _run_script("not json at all")
        assert result.returncode == 0, f"stderr: {result.stderr}"
        parsed = json.loads(result.stdout)
        assert parsed == {}

    def test_empty_input(self):
        """Feed empty string, verify output falls back to `{}`."""
        result = _run_script("")
        assert result.returncode == 0, f"stderr: {result.stderr}"
        parsed = json.loads(result.stdout)
        assert parsed == {}

    def test_truncated_json(self):
        """Feed truncated JSON (opening brace only), verify fallback."""
        result = _run_script('{"key": "val')
        assert result.returncode == 0, f"stderr: {result.stderr}"
        parsed = json.loads(result.stdout)
        assert parsed == {}

    def test_json_array_not_object(self):
        """Feed a JSON array — valid JSON but not an object. The script
        should preserve it (json.load accepts arrays too)."""
        data = [1, 2, 3]
        result = _run_script(json.dumps(data))
        assert result.returncode == 0, f"stderr: {result.stderr}"
        parsed = json.loads(result.stdout)
        assert parsed == data


# ─── Output formatting ───


class TestOutputFormatting:
    def test_no_trailing_newline(self):
        """Verify output does NOT end with a newline character.
        chezmoi modify scripts must produce exact content — a trailing
        newline would cause an unnecessary diff on every apply."""
        data = {"key": "value"}
        result = _run_script(json.dumps(data))
        assert result.returncode == 0, f"stderr: {result.stderr}"
        assert not result.stdout.endswith("\n"), (
            f"Output should not end with newline, got: {result.stdout!r}"
        )

    def test_no_trailing_newline_empty_object(self):
        """Verify the fallback empty object also has no trailing newline."""
        result = _run_script("garbage")
        assert result.returncode == 0, f"stderr: {result.stderr}"
        assert not result.stdout.endswith("\n"), (
            f"Output should not end with newline, got: {result.stdout!r}"
        )

    def test_pretty_prints_with_indent_2(self):
        """Verify output uses 2-space indentation, matching the script's
        `indent=2` parameter."""
        data = {"outer": {"inner": "value"}}
        result = _run_script(json.dumps(data))
        assert result.returncode == 0, f"stderr: {result.stderr}"
        lines = result.stdout.split("\n")
        # Line 0: {
        # Line 1:   "outer": {      (2-space indent)
        # Line 2:     "inner": ...  (4-space indent)
        assert lines[1].startswith("  "), (
            f"Expected 2-space indent on line 1, got: {lines[1]!r}"
        )
        assert lines[2].startswith("    "), (
            f"Expected 4-space indent on line 2, got: {lines[2]!r}"
        )
        # Verify it matches the canonical json.dumps format exactly
        expected = json.dumps(data, indent=2, ensure_ascii=False)
        assert result.stdout == expected

    def test_ensure_ascii_false(self):
        """Feed JSON with unicode characters (emoji, accented chars), verify
        they are preserved literally rather than \\u-escaped."""
        data = {
            "emoji": "\U0001f680",
            "accented": "\u00e9\u00e0\u00fc\u00f1",
            "cjk": "\u4e16\u754c",
            "greek": "\u03b1\u03b2\u03b3",
        }
        result = _run_script(json.dumps(data))
        assert result.returncode == 0, f"stderr: {result.stderr}"
        parsed = json.loads(result.stdout)
        assert parsed == data
        # The literal characters should appear in stdout, not escape sequences
        assert "\U0001f680" in result.stdout, "Emoji should appear literally"
        assert "\u00e9" in result.stdout, "Accented chars should appear literally"
        assert "\\u" not in result.stdout, (
            "Unicode escape sequences should not appear in output"
        )


# ─── Data preservation (round-trip fidelity) ───


class TestDataPreservation:
    def test_preserves_all_keys(self):
        """Feed JSON with nested objects, arrays, unicode, numbers,
        booleans, and null — verify all survive the round-trip."""
        data = {
            "string": "hello",
            "number_int": 42,
            "number_float": 3.14,
            "boolean_true": True,
            "boolean_false": False,
            "null_value": None,
            "array": [1, "two", None, True],
            "nested_object": {
                "level2": {
                    "level3": "deep"
                }
            },
            "empty_object": {},
            "empty_array": [],
            "unicode": "\U0001f30d \u00e9\u00e8\u00ea",
        }
        result = _run_script(json.dumps(data))
        assert result.returncode == 0, f"stderr: {result.stderr}"
        parsed = json.loads(result.stdout)
        assert parsed == data

    def test_preserves_large_nested_structure(self):
        """Simulate a realistic ~/.claude.json fragment with MCP server
        config, permissions, and project settings."""
        data = {
            "mcpServers": {
                "filesystem": {
                    "command": "npx",
                    "args": [
                        "-y",
                        "@modelcontextprotocol/server-filesystem",
                        "/Users/4jp/Workspace",
                    ],
                },
                "memory": {
                    "command": "npx",
                    "args": ["-y", "@modelcontextprotocol/server-memory"],
                },
            },
            "permissions": {
                "allow": ["Read", "Write", "Bash(git *)"],
                "deny": ["Bash(rm -rf /*)"],
            },
            "projects": {
                "/Users/4jp/Workspace": {
                    "allowedTools": ["Read", "Write", "Bash"],
                    "mcpServers": {},
                }
            },
            "numericId": 12345,
            "isActive": True,
            "metadata": None,
        }
        result = _run_script(json.dumps(data))
        assert result.returncode == 0, f"stderr: {result.stderr}"
        parsed = json.loads(result.stdout)
        assert parsed == data

    def test_preserves_key_order(self):
        """Verify that key insertion order is preserved (CPython 3.7+ dict
        ordering guarantee)."""
        data = {"zebra": 1, "apple": 2, "mango": 3}
        result = _run_script(json.dumps(data))
        assert result.returncode == 0, f"stderr: {result.stderr}"
        parsed_keys = list(json.loads(result.stdout).keys())
        assert parsed_keys == ["zebra", "apple", "mango"]

    def test_preserves_special_json_strings(self):
        """Strings with backslashes, quotes, and control characters must
        survive the round-trip."""
        data = {
            "path": "C:\\Users\\test\\file.txt",
            "quoted": 'He said "hello"',
            "tab": "col1\tcol2",
            "newline": "line1\nline2",
        }
        result = _run_script(json.dumps(data))
        assert result.returncode == 0, f"stderr: {result.stderr}"
        parsed = json.loads(result.stdout)
        assert parsed == data
