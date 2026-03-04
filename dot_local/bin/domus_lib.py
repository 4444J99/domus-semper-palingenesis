"""Shared utilities for Domus Python scripts."""

from __future__ import annotations

from pathlib import Path


MULTI_EXT = [
    ".tar.gz",
    ".tar.xz",
    ".tar.bz2",
    ".tar.zst",
    ".tar.lz4",
    ".tar.lz",
]


def split_name(name: str) -> tuple[str, str]:
    """Split a filename into stem and extension, handling multi-part extensions."""
    lower = name.lower()
    for ext in MULTI_EXT:
        if lower.endswith(ext):
            return name[: -len(ext)], ext
    if "." in name:
        stem, _, ext = name.rpartition(".")
        if stem:
            return stem, f".{ext}"
    return name, ""


def unique_dest(dest: Path) -> Path:
    """Return a non-colliding path by appending -N suffix.

    Handles multi-part extensions (.tar.gz, etc.) via split_name.
    Uses the same convention as normalize-names for consistency
    across all Domus file-management scripts.
    """
    if not dest.exists():
        return dest
    stem, ext = split_name(dest.name)
    counter = 1
    while True:
        candidate = dest.with_name(f"{stem}-{counter}{ext}")
        if not candidate.exists():
            return candidate
        counter += 1
