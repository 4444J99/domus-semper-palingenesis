"""Tests for routing-law.yaml compilation."""

from __future__ import annotations

import importlib.machinery
import importlib.util
import subprocess
import sys
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parent.parent
SCRIPT = REPO_ROOT / "dot_local" / "bin" / "executable_compile-routing-law"
ROUTING_LAW = REPO_ROOT / "dot_config" / "domus" / "routing-law.yaml"


def _import_module():
    loader = importlib.machinery.SourceFileLoader("compile_routing_law", str(SCRIPT))
    spec = importlib.util.spec_from_loader("compile_routing_law", loader)
    mod = importlib.util.module_from_spec(spec)
    sys.modules[spec.name] = mod
    spec.loader.exec_module(mod)
    return mod


mod = _import_module()


EXPECTED_SORTING_BLOCK = """sorting:
  directories:
    - ~/Downloads
    - ~/Desktop

  rules:
    - name: screenshots
      match:
        location: ~/Desktop
        pattern: "Screenshot*.png"
        extension: [png]
      action:
        move_to: "~/Pictures/Screenshots/{year}/{month}/"
    - name: pdfs
      match:
        extension: [pdf]
      action:
        move_to: "~/Documents/PDFs/{year}/"
        rename: "{smart_name}"
    - name: installers
      match:
        extension: [dmg, pkg]
      action:
        move_to: "~/Downloads/_Installers/"
    - name: archives
      match:
        extension: [zip, tar, gz, 7z, rar]
      action:
        move_to: "~/Downloads/_Archives/{year}/"
    - name: images
      match:
        location: ~/Downloads
        extension: [jpg, jpeg, png, gif, webp, heic]
      action:
        move_to: "~/Pictures/Downloads/{year}/{month}/"
    - name: old-downloads
      match:
        location: ~/Downloads
        age_days_min: 30
        exclude_pattern: "^_"
      action:
        move_to: "~/Downloads/_Archive/{year}/"
"""


def test_loads_proposed_routing_law_shape():
    law = mod.load_routing_law(ROUTING_LAW)

    assert law["schema"] == "routing-law/v1"
    assert law["sorter"]["roots"] == ["~/Downloads", "~/Desktop"]
    assert law["sorter"]["defaults"]["ignore_partial_downloads"] == [
        ".crdownload",
        ".part",
        ".download",
    ]
    assert [route["id"] for route in law["routes"]] == [
        "screenshots",
        "pdfs",
        "installers",
        "archives",
        "images",
        "old-downloads",
    ]


def test_compiles_current_routing_law_to_manifest_sorting_block():
    law = mod.load_routing_law(ROUTING_LAW)
    block = mod.compile_sorting_block(law)

    assert mod.render_sorting_block(block) == EXPECTED_SORTING_BLOCK


def test_cli_emits_manifest_sorting_block():
    result = subprocess.run(
        [sys.executable, str(SCRIPT), str(ROUTING_LAW)],
        capture_output=True,
        check=False,
        text=True,
    )

    assert result.returncode == 0
    assert result.stdout == EXPECTED_SORTING_BLOCK
    assert result.stderr == ""


def test_priority_controls_first_match_rule_order():
    law = {
        "schema": "routing-law/v1",
        "sorter": {"roots": ["~/Downloads"]},
        "routes": [
            {
                "id": "catch-all",
                "priority": 90,
                "when": {"source": {"path": "~/Downloads"}},
                "route": {"destination": "~/Downloads/_Archive/{year}/"},
            },
            {
                "id": "pdfs",
                "priority": 20,
                "when": {"file": {"extension": ["pdf"]}},
                "route": {"destination": "~/Documents/PDFs/{year}/"},
            },
        ],
    }

    block = mod.compile_sorting_block(law)

    assert [rule["name"] for rule in block["sorting"]["rules"]] == [
        "pdfs",
        "catch-all",
    ]


def test_rejects_unsupported_predicates():
    law = {
        "schema": "routing-law/v1",
        "sorter": {"roots": ["~/Downloads"]},
        "routes": [
            {
                "id": "unsupported",
                "priority": 10,
                "when": {"content": {"mime": "application/pdf"}},
                "route": {"destination": "~/Documents/PDFs/{year}/"},
            },
        ],
    }

    try:
        mod.compile_sorting_block(law)
    except mod.RoutingLawError as exc:
        assert "unsupported key(s): content" in str(exc)
    else:
        raise AssertionError("unsupported predicate compiled successfully")
