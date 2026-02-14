"""Shared utilities for Domus Python scripts."""
from __future__ import annotations

from pathlib import Path


def unique_dest(dest: Path) -> Path:
    """Return a non-colliding path by appending -N suffix.

    Uses the same convention as normalize-names for consistency
    across all Domus file-management scripts.
    """
    if not dest.exists():
        return dest
    stem = dest.stem
    suffix = dest.suffix
    counter = 1
    while True:
        candidate = dest.with_name(f"{stem}-{counter}{suffix}")
        if not candidate.exists():
            return candidate
        counter += 1
