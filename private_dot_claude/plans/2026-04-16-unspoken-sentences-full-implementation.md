# Unspoken Sentences — Full Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Instantiate six grammatically valid but unspoken sentences in the ORGANVM system — filling empty cells in the 15-ideal-form × 8-organ coverage matrix — plus unify the distributed patchbay into a single signal substrate.

**Architecture:** Each subsystem is an independent ORGANVM repo with a seed.yaml automation contract, a Python package, tests, and a registry-v2.json entry. All repos are scaffolded locally, committed, and pushed to remote GitHub orgs. The patchbay (`organvm--patchbay`) is built first as it provides the emit/query protocol the other five repos will use.

**Tech Stack:** Python 3.11+, pyproject.toml, pytest, ruff, PyYAML, FastAPI (logos--commercium only), appendonly JSONL storage (patchbay).

**Session date:** 2026-04-16  
**Derived from:** Coverage matrix analysis — 31/120 cells populated; 89 empty. These 6 address the highest-adjacency gaps.

---

## Subsystem Map

| # | Repo | Organ | Form | IRF | Why now |
|---|------|-------|------|-----|---------|
| 1 | `organvm--patchbay` | META | XIV | new | Substrate all others need |
| 2 | `logos--commercium` | V | XII | new | Revenue (zero-income crisis) |
| 3 | `salon--editorial` | V | X | new | Revenue + closes VI→V gap |
| 4 | `organvm--auto-agents` | META | IX | new | System self-maintenance |
| 5 | `theoria--gubernans` | I | VIII | new | Closes I→VIII gap |
| 6 | `theoria--viva` | I | VI | new | Closes I→VI gap |

**Execution order:** 1 → 2 → 3 → 4 → 5 → 6 (each independent after 1 is scaffolded)

---

## Subsystem 1: `organvm--patchbay` (META / Form XIV)

**Thesis:** One location. One protocol. Every module emits to the patchbay; every module reads from it. No direct imports between modules. No lateral dependencies. Shared state flows through the substrate.

**Files created:**
- `~/organvm--patchbay/seed.yaml`
- `~/organvm--patchbay/pyproject.toml`
- `~/organvm--patchbay/README.md`
- `~/organvm--patchbay/CLAUDE.md`
- `~/organvm--patchbay/.gitignore`
- `~/organvm--patchbay/.github/workflows/ci-python.yml`
- `~/organvm--patchbay/src/organvm_patchbay/__init__.py`
- `~/organvm--patchbay/src/organvm_patchbay/schema.py`
- `~/organvm--patchbay/src/organvm_patchbay/store.py`
- `~/organvm--patchbay/src/organvm_patchbay/emit.py`
- `~/organvm--patchbay/src/organvm_patchbay/query.py`
- `~/organvm--patchbay/src/organvm_patchbay/cli.py`
- `~/organvm--patchbay/tests/test_emit.py`
- `~/organvm--patchbay/tests/test_query.py`
- `~/organvm--patchbay/tests/test_schema.py`

**Files modified:**
- `~/Workspace/meta-organvm/organvm-corpvs-testamentvm/registry-v2.json` — add entry under `organs.META.repositories`

### Task 1.1 — Scaffold the repo

- [ ] **Create the directory and git init**

```bash
mkdir ~/organvm--patchbay
cd ~/organvm--patchbay
git init
git checkout -b main
```

- [ ] **Create pyproject.toml**

```toml
[build-system]
requires = ["setuptools>=68", "wheel"]
build-backend = "setuptools.backends.legacy:build"

[project]
name = "organvm-patchbay"
version = "0.1.0"
description = "The unified signal substrate for the ORGANVM system"
requires-python = ">=3.11"
dependencies = ["pyyaml>=6.0"]

[project.optional-dependencies]
dev = ["pytest>=8.0", "pytest-cov", "ruff"]
cli = ["click>=8.0"]

[project.scripts]
patchbay = "organvm_patchbay.cli:main"

[tool.pytest.ini_options]
testpaths = ["tests"]
addopts = "-v --tb=short"

[tool.ruff]
line-length = 100
target-version = "py311"
```

- [ ] **Create src layout**

```bash
mkdir -p src/organvm_patchbay tests
touch src/organvm_patchbay/__init__.py
touch tests/__init__.py
```

- [ ] **Install in editable mode**

```bash
python -m venv .venv
source .venv/bin/activate
pip install -e ".[dev,cli]"
```

Expected: no errors

- [ ] **Create .gitignore**

```
.venv/
__pycache__/
*.pyc
*.egg-info/
dist/
.coverage
.pytest_cache/
*.jsonl
```

### Task 1.2 — Define the signal schema

- [ ] **Write failing test for schema validation**

`tests/test_schema.py`:
```python
import pytest
from organvm_patchbay.schema import Signal, validate_signal, VALID_FORMS, VALID_CATEGORIES

def test_signal_requires_type():
    with pytest.raises(ValueError, match="type"):
        validate_signal({})

def test_signal_requires_valid_form():
    with pytest.raises(ValueError, match="form"):
        validate_signal({"type": "TRANSFORM", "form": "XVI", "category": "moves",
                         "source": "test/repo", "payload": {}})

def test_signal_valid():
    s = validate_signal({
        "type": "TRANSFORM",
        "form": "II",
        "category": "cuts",
        "source": "organvm-i-theoria/sema-metra--alchemica-mundi",
        "payload": {"data": "raw material"},
    })
    assert s["type"] == "TRANSFORM"
    assert s["form"] == "II"
    assert "timestamp" in s

def test_all_fifteen_forms_valid():
    for f in VALID_FORMS:
        s = validate_signal({"type": "OBSERVE", "form": f, "category": "holds",
                             "source": "test/repo", "payload": {}})
        assert s["form"] == f

def test_all_six_categories_valid():
    for c in VALID_CATEGORIES:
        s = validate_signal({"type": "OBSERVE", "form": "I", "category": c,
                             "source": "test/repo", "payload": {}})
        assert s["category"] == c
```

- [ ] **Run test to verify it fails**

```bash
pytest tests/test_schema.py -v
```

Expected: `ModuleNotFoundError: No module named 'organvm_patchbay.schema'`

- [ ] **Implement schema.py**

`src/organvm_patchbay/schema.py`:
```python
"""Signal schema definitions for the ORGANVM patchbay."""
from datetime import datetime, timezone
from typing import Any

VALID_FORMS = {"I", "II", "III", "IV", "V", "VI", "VII", "VIII",
               "IX", "X", "XI", "XII", "XIII", "XIV", "XV"}

VALID_CATEGORIES = {"holds", "cuts", "joins", "bounds", "lacks", "moves"}

VALID_TYPES = {
    "OBSERVE",    # READ + COUNT verbs
    "ROUTE",      # GRAPH + COMPARE verbs
    "EXECUTE",    # CALL verb
    "TRANSFORM",  # PARSE verb
    "VERIFY",     # COMPARE verb
    "RECORD",     # WRITE verb
    "PRESENT",    # WRITE verb (output-facing)
}


class Signal(dict):
    """A validated signal in the patchbay. Subclasses dict for easy serialization."""


def validate_signal(data: dict[str, Any]) -> Signal:
    """Validate and normalize a signal dict. Returns a Signal with timestamp injected.

    Raises ValueError if required fields are missing or invalid.
    """
    errors = []

    if "type" not in data or not data["type"]:
        errors.append("type is required")
    elif data["type"] not in VALID_TYPES:
        errors.append(f"type must be one of {sorted(VALID_TYPES)}, got {data['type']!r}")

    if "form" not in data or not data["form"]:
        errors.append("form is required")
    elif data["form"] not in VALID_FORMS:
        errors.append(f"form must be one of I–XV, got {data['form']!r}")

    if "category" not in data or not data["category"]:
        errors.append("category is required")
    elif data["category"] not in VALID_CATEGORIES:
        errors.append(f"category must be one of {sorted(VALID_CATEGORIES)}, got {data['category']!r}")

    if "source" not in data or not data["source"]:
        errors.append("source is required (format: org/repo or organ/repo/module)")

    if errors:
        raise ValueError("; ".join(errors))

    signal = Signal(data)
    if "timestamp" not in signal:
        signal["timestamp"] = datetime.now(timezone.utc).isoformat()
    if "payload" not in signal:
        signal["payload"] = {}
    if "target" not in signal:
        signal["target"] = None

    return signal
```

- [ ] **Run test to verify it passes**

```bash
pytest tests/test_schema.py -v
```

Expected: 5 passed

- [ ] **Commit**

```bash
git add src/organvm_patchbay/schema.py tests/test_schema.py pyproject.toml src/organvm_patchbay/__init__.py
git commit -m "feat: define signal schema with 15 forms, 6 categories, 7 types"
```

### Task 1.3 — Implement the append-only store

- [ ] **Write failing test**

`tests/test_emit.py`:
```python
import json
import tempfile
from pathlib import Path
import pytest
from organvm_patchbay.store import SignalStore
from organvm_patchbay.emit import emit
from organvm_patchbay.query import query


@pytest.fixture
def store_path(tmp_path):
    return tmp_path / "signals.jsonl"


def test_emit_writes_to_store(store_path):
    emit(type="RECORD", form="XIV", category="holds",
         source="meta-organvm/organvm-engine", payload={"note": "test"},
         store_path=store_path)
    assert store_path.exists()
    lines = store_path.read_text().strip().splitlines()
    assert len(lines) == 1
    signal = json.loads(lines[0])
    assert signal["type"] == "RECORD"
    assert signal["form"] == "XIV"


def test_emit_appends(store_path):
    for i in range(3):
        emit(type="OBSERVE", form="I", category="holds",
             source="test/repo", payload={"i": i}, store_path=store_path)
    lines = store_path.read_text().strip().splitlines()
    assert len(lines) == 3


def test_query_by_type(store_path):
    emit(type="RECORD", form="XIV", category="holds",
         source="meta/engine", payload={}, store_path=store_path)
    emit(type="OBSERVE", form="I", category="holds",
         source="organ-i/recursive", payload={}, store_path=store_path)
    results = query(type="RECORD", store_path=store_path)
    assert len(results) == 1
    assert results[0]["type"] == "RECORD"


def test_query_by_form(store_path):
    emit(type="OBSERVE", form="I", category="holds",
         source="a/b", payload={}, store_path=store_path)
    emit(type="OBSERVE", form="II", category="cuts",
         source="c/d", payload={}, store_path=store_path)
    results = query(form="II", store_path=store_path)
    assert len(results) == 1
    assert results[0]["form"] == "II"


def test_query_all(store_path):
    for form in ["I", "II", "III"]:
        emit(type="OBSERVE", form=form, category="holds",
             source="x/y", payload={}, store_path=store_path)
    results = query(store_path=store_path)
    assert len(results) == 3
```

- [ ] **Run to verify failure**

```bash
pytest tests/test_emit.py -v
```

Expected: `ModuleNotFoundError`

- [ ] **Implement store.py**

`src/organvm_patchbay/store.py`:
```python
"""Append-only JSONL signal store."""
import json
from pathlib import Path
from typing import Iterator

DEFAULT_STORE = Path.home() / ".local" / "share" / "organvm" / "patchbay" / "signals.jsonl"


class SignalStore:
    """Append-only JSONL store for signals."""

    def __init__(self, path: Path = DEFAULT_STORE):
        self.path = Path(path)
        self.path.parent.mkdir(parents=True, exist_ok=True)

    def append(self, signal: dict) -> None:
        """Append a signal to the store."""
        with open(self.path, "a") as f:
            f.write(json.dumps(signal, default=str) + "\n")

    def iter_signals(self) -> Iterator[dict]:
        """Yield all signals from the store."""
        if not self.path.exists():
            return
        with open(self.path) as f:
            for line in f:
                line = line.strip()
                if line:
                    yield json.loads(line)
```

- [ ] **Implement emit.py**

`src/organvm_patchbay/emit.py`:
```python
"""Emit a signal to the patchbay store."""
from pathlib import Path
from typing import Any
from organvm_patchbay.schema import validate_signal
from organvm_patchbay.store import SignalStore, DEFAULT_STORE


def emit(
    type: str,
    form: str,
    category: str,
    source: str,
    payload: dict[str, Any] | None = None,
    target: str | None = None,
    primitives: list[str] | None = None,
    store_path: Path | None = None,
) -> dict:
    """Emit a signal to the patchbay.

    Args:
        type: Signal type (OBSERVE, ROUTE, EXECUTE, TRANSFORM, VERIFY, RECORD, PRESENT)
        form: Ideal form (I through XV)
        category: Arrow category (holds, cuts, joins, bounds, lacks, moves)
        source: Signal origin in org/repo or organ/repo/module format
        payload: The signal data
        target: Optional destination (org/repo)
        primitives: Optional list of primitive operations (READ, PARSE, COUNT, etc.)
        store_path: Override for the store file path (used in tests)
    """
    signal = validate_signal({
        "type": type,
        "form": form,
        "category": category,
        "source": source,
        "payload": payload or {},
        "target": target,
        "primitives": primitives or [],
    })
    store = SignalStore(path=store_path or DEFAULT_STORE)
    store.append(signal)
    return signal
```

- [ ] **Implement query.py**

`src/organvm_patchbay/query.py`:
```python
"""Query signals from the patchbay store."""
from datetime import datetime, timezone
from pathlib import Path
from typing import Any
from organvm_patchbay.store import SignalStore, DEFAULT_STORE


def query(
    type: str | None = None,
    form: str | None = None,
    category: str | None = None,
    source: str | None = None,
    since: str | datetime | None = None,
    store_path: Path | None = None,
) -> list[dict[str, Any]]:
    """Query signals from the patchbay.

    All filters are AND-combined. Omit a filter to match all.

    Args:
        type: Filter by signal type
        form: Filter by ideal form (I–XV)
        category: Filter by arrow category
        source: Filter by source (exact match)
        since: ISO timestamp or datetime — return signals after this time
        store_path: Override for the store file path (used in tests)
    """
    store = SignalStore(path=store_path or DEFAULT_STORE)
    since_dt: datetime | None = None
    if isinstance(since, str):
        since_dt = datetime.fromisoformat(since)
    elif isinstance(since, datetime):
        since_dt = since

    results = []
    for signal in store.iter_signals():
        if type is not None and signal.get("type") != type:
            continue
        if form is not None and signal.get("form") != form:
            continue
        if category is not None and signal.get("category") != category:
            continue
        if source is not None and signal.get("source") != source:
            continue
        if since_dt is not None:
            ts = datetime.fromisoformat(signal.get("timestamp", "1970-01-01"))
            if ts.tzinfo is None:
                ts = ts.replace(tzinfo=timezone.utc)
            if ts <= since_dt:
                continue
        results.append(signal)
    return results
```

- [ ] **Run tests to verify all pass**

```bash
pytest tests/ -v
```

Expected: 10 passed (5 schema + 5 emit/query)

- [ ] **Commit**

```bash
git add src/organvm_patchbay/ tests/
git commit -m "feat: implement append-only patchbay with emit/query protocol"
```

### Task 1.4 — Create seed.yaml

- [ ] **Create seed.yaml**

`~/organvm--patchbay/seed.yaml`:
```yaml
# seed.yaml — Automation Contract for meta-organvm/organvm--patchbay
# Schema: seed/v1.0
# Generated: 2026-04-16

schema_version: "1.0"
organ: Meta
organ_name: Meta
repo: organvm--patchbay
org: meta-organvm

metadata:
  implementation_status: ACTIVE
  tier: infrastructure
  promotion_status: LOCAL
  last_validated: "2026-04-16"
  generated: "2026-04-16"
  language: python
  note: >-
    Unified signal substrate. One emit/query protocol for all ORGANVM modules.
    Replaces distributed: registry-v2.json, signal-graph.yaml, atom-registry.yaml, ledger.jsonl.
    Form XIV (Computational Substrate) instantiated in META.

agents:
  - name: ci
    trigger: on_push
    workflow: .github/workflows/ci-python.yml
    description: "Run tests and type checks"

produces:
  - type: signal-substrate
    format: jsonl
    description: "Append-only signal log queryable by type, form, category, source, since"
    consumers:
      - organ: META
        repos: ["organvm--auto-agents", "organvm-engine"]
        relationship: "reads-from-substrate"
      - organ: I
        repos: ["theoria--gubernans", "theoria--viva"]
        relationship: "emits-to-substrate"
      - organ: V
        repos: ["logos--commercium", "salon--editorial"]
        relationship: "emits-to-substrate"

consumes: []

subscriptions:
  - event: registry.updated
    source: META
    action: "Accept updated registry signals from organvm-engine"
```

- [ ] **Commit**

```bash
git add seed.yaml
git commit -m "chore: add seed.yaml automation contract"
```

### Task 1.5 — Add registry entry

- [ ] **Add entry to registry-v2.json** (targeted edit — insert into `organs.META.repositories` array)

Find the META repositories array in:
`~/Workspace/meta-organvm/organvm-corpvs-testamentvm/registry-v2.json`

Insert this entry (after the last repo in the META repositories list):
```json
{
  "name": "organvm--patchbay",
  "org": "meta-organvm",
  "status": "ACTIVE",
  "public": false,
  "description": "Unified signal substrate — one append-only JSONL store with emit/query protocol for all ORGANVM modules. Replaces distributed registry-v2.json + signal-graph.yaml + atom-registry.yaml + ledger.jsonl.",
  "documentation_status": "STANDARD README",
  "portfolio_relevance": "HIGH — infrastructure enabling all cross-organ signal flow",
  "dependencies": [],
  "promotion_status": "LOCAL",
  "tier": "infrastructure",
  "last_validated": "2026-04-16",
  "implementation_status": "ACTIVE",
  "ci_workflow": "ci-python.yml",
  "note": "Created 2026-04-16. Form XIV (Computational Substrate) in META. Addresses SYNTHESIS.md Part 4 gap: patchbay was conceptual, distributed across 4 files in 3 repos."
}
```

- [ ] **Verify the registry still parses**

```bash
python3 -c "import json; data = json.load(open('registry-v2.json')); print(f'OK: {len(data)} keys')"
```

Run from: `~/Workspace/meta-organvm/organvm-corpvs-testamentvm/`

Expected: `OK: N keys` (no parse error)

- [ ] **Commit registry change**

```bash
cd ~/Workspace/meta-organvm/organvm-corpvs-testamentvm
git add registry-v2.json
git commit -m "chore: register organvm--patchbay in registry (Form XIV, META)"
```

### Task 1.6 — Push to remote

- [ ] **Create GitHub repo** (if not already exists)

```bash
cd ~/organvm--patchbay
gh repo create meta-organvm/organvm--patchbay --private --description "Unified signal substrate for ORGANVM" --source . --remote origin --push
```

- [ ] **Verify remote exists**

```bash
gh repo view meta-organvm/organvm--patchbay --json name,url
```

Expected: JSON with name `organvm--patchbay`

---

## Subsystem 2: `logos--commercium` (Organ V / Form XII)

**Thesis:** Essays and analytics as commercial products. public-process produces free discourse; logos--commercium makes it revenue-generating. Paid newsletter delivery, premium research reports, subscriber analytics dashboard.

**Files created:**
- `~/Workspace/organvm-v-logos/logos--commercium/seed.yaml`
- `~/Workspace/organvm-v-logos/logos--commercium/pyproject.toml`
- `~/Workspace/organvm-v-logos/logos--commercium/README.md`
- `~/Workspace/organvm-v-logos/logos--commercium/CLAUDE.md`
- `~/Workspace/organvm-v-logos/logos--commercium/.github/workflows/ci-python.yml`
- `~/Workspace/organvm-v-logos/logos--commercium/src/logos_commercium/__init__.py`
- `~/Workspace/organvm-v-logos/logos--commercium/src/logos_commercium/tiers.py`
- `~/Workspace/organvm-v-logos/logos--commercium/src/logos_commercium/paywall.py`
- `~/Workspace/organvm-v-logos/logos--commercium/src/logos_commercium/delivery.py`
- `~/Workspace/organvm-v-logos/logos--commercium/tests/test_tiers.py`
- `~/Workspace/organvm-v-logos/logos--commercium/tests/test_paywall.py`

**Files modified:**
- `~/Workspace/meta-organvm/organvm-corpvs-testamentvm/registry-v2.json` — add entry under `organs.ORGAN-V.repositories`

### Task 2.1 — Scaffold

- [ ] **Create and init**

```bash
mkdir -p ~/Workspace/organvm-v-logos/logos--commercium
cd ~/Workspace/organvm-v-logos/logos--commercium
git init && git checkout -b main
mkdir -p src/logos_commercium tests .github/workflows
touch src/logos_commercium/__init__.py tests/__init__.py
```

- [ ] **Create pyproject.toml**

```toml
[build-system]
requires = ["setuptools>=68", "wheel"]
build-backend = "setuptools.backends.legacy:build"

[project]
name = "logos-commercium"
version = "0.1.0"
description = "Monetized discourse — essays and analytics as commercial products (ORGAN-V, Form XII)"
requires-python = ">=3.11"
dependencies = ["pyyaml>=6.0", "fastapi>=0.110", "uvicorn>=0.29"]

[project.optional-dependencies]
dev = ["pytest>=8.0", "pytest-cov", "ruff", "httpx>=0.27"]

[tool.pytest.ini_options]
testpaths = ["tests"]
addopts = "-v --tb=short"
```

- [ ] **Install**

```bash
python -m venv .venv && source .venv/bin/activate
pip install -e ".[dev]"
```

### Task 2.2 — Subscriber tier model

- [ ] **Write failing test**

`tests/test_tiers.py`:
```python
import pytest
from logos_commercium.tiers import SubscriberTier, can_access

def test_free_tier_cannot_access_premium():
    assert can_access(SubscriberTier.FREE, "premium-research") is False

def test_free_tier_can_access_public():
    assert can_access(SubscriberTier.FREE, "public-essay") is True

def test_paid_tier_can_access_premium():
    assert can_access(SubscriberTier.PAID, "premium-research") is True

def test_paid_tier_can_access_analytics():
    assert can_access(SubscriberTier.PAID, "analytics-report") is True

def test_founder_tier_can_access_everything():
    for content_type in ["public-essay", "premium-research", "analytics-report", "raw-data"]:
        assert can_access(SubscriberTier.FOUNDER, content_type) is True
```

- [ ] **Run to verify failure**

```bash
pytest tests/test_tiers.py -v
```

Expected: `ModuleNotFoundError`

- [ ] **Implement tiers.py**

`src/logos_commercium/tiers.py`:
```python
"""Subscriber tier model for logos--commercium."""
from enum import Enum

class SubscriberTier(str, Enum):
    FREE = "free"
    PAID = "paid"
    FOUNDER = "founder"

# Content types accessible per tier
TIER_ACCESS: dict[SubscriberTier, set[str]] = {
    SubscriberTier.FREE: {"public-essay"},
    SubscriberTier.PAID: {"public-essay", "premium-research", "analytics-report"},
    SubscriberTier.FOUNDER: {"public-essay", "premium-research", "analytics-report", "raw-data"},
}

def can_access(tier: SubscriberTier, content_type: str) -> bool:
    """Return True if the given tier can access the given content type."""
    return content_type in TIER_ACCESS.get(tier, set())
```

- [ ] **Run to verify pass**

```bash
pytest tests/test_tiers.py -v
```

Expected: 5 passed

- [ ] **Commit**

```bash
git add src/logos_commercium/tiers.py tests/test_tiers.py pyproject.toml src/logos_commercium/__init__.py
git commit -m "feat: add subscriber tier model (free/paid/founder) for logos--commercium"
```

### Task 2.3 — Paywall gate

- [ ] **Write failing test**

`tests/test_paywall.py`:
```python
import pytest
from logos_commercium.tiers import SubscriberTier
from logos_commercium.paywall import PaywallGate, PaywallError

def test_free_subscriber_blocked_from_premium():
    gate = PaywallGate()
    with pytest.raises(PaywallError, match="premium-research requires paid"):
        gate.check(subscriber_tier=SubscriberTier.FREE, content_type="premium-research")

def test_paid_subscriber_passes_premium():
    gate = PaywallGate()
    result = gate.check(subscriber_tier=SubscriberTier.PAID, content_type="premium-research")
    assert result is True

def test_paywall_error_includes_upgrade_hint():
    gate = PaywallGate()
    with pytest.raises(PaywallError) as exc_info:
        gate.check(subscriber_tier=SubscriberTier.FREE, content_type="analytics-report")
    assert "upgrade" in str(exc_info.value).lower()
```

- [ ] **Run to verify failure**

```bash
pytest tests/test_paywall.py -v
```

Expected: `ModuleNotFoundError`

- [ ] **Implement paywall.py**

`src/logos_commercium/paywall.py`:
```python
"""Paywall gate for logos--commercium content."""
from logos_commercium.tiers import SubscriberTier, can_access

class PaywallError(Exception):
    """Raised when a subscriber does not have access to requested content."""

class PaywallGate:
    """Checks subscriber access and raises PaywallError when blocked."""

    def check(self, subscriber_tier: SubscriberTier, content_type: str) -> bool:
        """Check if the subscriber tier can access the content type.

        Returns True on success. Raises PaywallError with upgrade hint on failure.
        """
        if can_access(subscriber_tier, content_type):
            return True
        raise PaywallError(
            f"{content_type} requires paid subscription — "
            f"upgrade at public-process.netlify.app/subscribe"
        )
```

- [ ] **Run all tests**

```bash
pytest tests/ -v
```

Expected: 8 passed

- [ ] **Commit**

```bash
git add src/logos_commercium/paywall.py tests/test_paywall.py
git commit -m "feat: add paywall gate with upgrade hint for logos--commercium"
```

### Task 2.4 — Create seed.yaml and register

- [ ] **Create seed.yaml**

`seed.yaml`:
```yaml
schema_version: "1.0"
organ: V
organ_name: Public Process
repo: logos--commercium
org: organvm-v-logos

metadata:
  implementation_status: PROTOTYPE
  tier: standard
  promotion_status: LOCAL
  last_validated: "2026-04-16"
  generated: "2026-04-16"
  language: python
  revenue_model: subscription
  revenue_status: pre-launch
  note: >-
    Form XII (Commercial Products) in Organ V (Logos).
    Monetizes the discourse organ. Fills the V/XII empty cell.

agents:
  - name: ci
    trigger: on_push
    workflow: .github/workflows/ci-python.yml
    description: "Run tests and type checks"

produces:
  - type: premium-content-api
    format: json
    description: "Gated essay content, analytics reports, subscriber data"
    consumers:
      - organ: EXTERNAL
        repos: []
        relationship: "paying-subscribers"

consumes:
  - type: essay-markdown
    source: organvm-v-logos/public-process
    description: "Free essays that become premium when combined with analytics"
  - type: analytics-data
    source: organvm-v-logos/analytics-engine
    description: "Traffic and engagement data for premium reports"

subscriptions:
  - event: essay.published
    source: ORGAN-V
    action: "Gate premium version behind paywall"
  - event: governance.updated
    source: ORGAN-IV
    action: "Check compliance with updated governance rules"
```

- [ ] **Add registry entry** under `organs.ORGAN-V.repositories` in `registry-v2.json`:

```json
{
  "name": "logos--commercium",
  "org": "organvm-v-logos",
  "status": "PROTOTYPE",
  "public": false,
  "description": "Monetized discourse — essays and analytics as commercial products. Subscriber tiers (free/paid/founder), paywall gate, premium research delivery. Form XII (Commercial Products) in Organ V (Logos).",
  "documentation_status": "SKELETON",
  "portfolio_relevance": "HIGH — first commercial surface for the discourse organ",
  "dependencies": ["organvm-v-logos/public-process", "organvm-v-logos/analytics-engine"],
  "promotion_status": "LOCAL",
  "tier": "standard",
  "last_validated": "2026-04-16",
  "implementation_status": "PROTOTYPE",
  "ci_workflow": "ci-python.yml",
  "revenue_model": "subscription",
  "revenue_status": "pre-launch",
  "note": "Created 2026-04-16. Fills the V/XII empty cell in the ideal-form coverage matrix."
}
```

- [ ] **Verify registry**

```bash
python3 -c "import json; data = json.load(open('registry-v2.json')); print('OK')"
```

- [ ] **Commit all and push**

```bash
git add seed.yaml
git commit -m "chore: add seed.yaml for logos--commercium"
gh repo create organvm-v-logos/logos--commercium --private --source . --remote origin --push
```

---

## Subsystem 3: `salon--editorial` (Organ V / Form X)

**Thesis:** The pipeline from community discussion → published essay. Community IS the editorial board. Salon transcripts from Organ VI become structured discourse in Organ V. Closes the VI→V signal gap.

**Files created:**
- `~/Workspace/organvm-v-logos/salon--editorial/seed.yaml`
- `~/Workspace/organvm-v-logos/salon--editorial/pyproject.toml`
- `~/Workspace/organvm-v-logos/salon--editorial/src/salon_editorial/__init__.py`
- `~/Workspace/organvm-v-logos/salon--editorial/src/salon_editorial/ingester.py`
- `~/Workspace/organvm-v-logos/salon--editorial/src/salon_editorial/distiller.py`
- `~/Workspace/organvm-v-logos/salon--editorial/src/salon_editorial/formatter.py`
- `~/Workspace/organvm-v-logos/salon--editorial/tests/test_ingester.py`
- `~/Workspace/organvm-v-logos/salon--editorial/tests/test_distiller.py`

### Task 3.1 — Scaffold

```bash
mkdir -p ~/Workspace/organvm-v-logos/salon--editorial
cd ~/Workspace/organvm-v-logos/salon--editorial
git init && git checkout -b main
mkdir -p src/salon_editorial tests
touch src/salon_editorial/__init__.py tests/__init__.py
```

`pyproject.toml`:
```toml
[build-system]
requires = ["setuptools>=68"]
build-backend = "setuptools.backends.legacy:build"

[project]
name = "salon-editorial"
version = "0.1.0"
description = "Community-to-discourse pipeline — salon transcripts become publishable essays (ORGAN-V, Form X)"
requires-python = ">=3.11"
dependencies = ["pyyaml>=6.0"]

[project.optional-dependencies]
dev = ["pytest>=8.0", "ruff"]

[tool.pytest.ini_options]
testpaths = ["tests"]
addopts = "-v --tb=short"
```

### Task 3.2 — Ingester

- [ ] **Write failing test**

`tests/test_ingester.py`:
```python
import pytest
from salon_editorial.ingester import ingest_transcript, TranscriptRecord

SAMPLE_TRANSCRIPT = """
# Salon: Recursive Systems and Self-Reference
date: 2026-03-15
participants: [Alice, Bob, Carol]

Alice: The system reads itself to know what it is.
Bob: But what reads the reader?
Carol: That's the strange loop — the reader IS the reading.
Alice: Spencer Brown's mark of distinction applied recursively.
"""

def test_ingest_returns_record():
    record = ingest_transcript(SAMPLE_TRANSCRIPT)
    assert isinstance(record, TranscriptRecord)

def test_ingest_extracts_title():
    record = ingest_transcript(SAMPLE_TRANSCRIPT)
    assert "Recursive Systems" in record.title

def test_ingest_extracts_participants():
    record = ingest_transcript(SAMPLE_TRANSCRIPT)
    assert "Alice" in record.participants
    assert "Bob" in record.participants

def test_ingest_preserves_exchanges():
    record = ingest_transcript(SAMPLE_TRANSCRIPT)
    assert len(record.exchanges) >= 4

def test_ingest_empty_transcript_raises():
    with pytest.raises(ValueError, match="empty"):
        ingest_transcript("")
```

- [ ] **Run to verify failure**

```bash
pytest tests/test_ingester.py -v
```

Expected: `ModuleNotFoundError`

- [ ] **Implement ingester.py**

`src/salon_editorial/ingester.py`:
```python
"""Ingest salon transcripts into structured records."""
import re
from dataclasses import dataclass, field

@dataclass
class TranscriptRecord:
    title: str
    date: str
    participants: list[str]
    exchanges: list[dict[str, str]]  # [{"speaker": "Alice", "text": "..."}]
    raw: str

def ingest_transcript(text: str) -> TranscriptRecord:
    """Parse a raw salon transcript into a structured TranscriptRecord.

    Expected format:
        # Salon: <title>
        date: <ISO date>
        participants: [<name>, <name>, ...]

        <Name>: <statement>
        <Name>: <response>
        ...
    """
    if not text or not text.strip():
        raise ValueError("empty transcript — nothing to ingest")

    lines = text.strip().splitlines()

    # Extract title from first # heading
    title = ""
    for line in lines:
        stripped = line.strip()
        if stripped.startswith("# Salon:"):
            title = stripped.removeprefix("# Salon:").strip()
            break
        elif stripped.startswith("#"):
            title = stripped.lstrip("#").strip()
            break

    # Extract date
    date = ""
    for line in lines:
        if line.strip().startswith("date:"):
            date = line.split(":", 1)[1].strip()
            break

    # Extract participants from inline list
    participants: list[str] = []
    for line in lines:
        if line.strip().startswith("participants:"):
            raw_list = line.split(":", 1)[1].strip()
            participants = [p.strip().strip("[]") for p in raw_list.split(",")]
            participants = [p for p in participants if p]
            break

    # Extract exchanges: lines matching "Name: text"
    exchange_pattern = re.compile(r"^([A-Z][a-zA-Z]+):\s+(.+)$")
    exchanges = []
    for line in lines:
        m = exchange_pattern.match(line.strip())
        if m:
            exchanges.append({"speaker": m.group(1), "text": m.group(2)})

    return TranscriptRecord(
        title=title or "Untitled Salon",
        date=date,
        participants=participants,
        exchanges=exchanges,
        raw=text,
    )
```

- [ ] **Run to verify pass**

```bash
pytest tests/test_ingester.py -v
```

Expected: 5 passed

### Task 3.3 — Distiller

- [ ] **Write failing test**

`tests/test_distiller.py`:
```python
import pytest
from salon_editorial.ingester import ingest_transcript, TranscriptRecord
from salon_editorial.distiller import distill, DistilledInsight

SAMPLE_TRANSCRIPT = """
# Salon: Strange Loops
date: 2026-03-15
participants: [Alice, Bob]

Alice: The system reads itself to know what it is.
Bob: But what reads the reader?
Alice: Spencer Brown's mark of distinction applied recursively.
Bob: Then the system and its self-model are the same object.
Alice: Exactly — it's not representation, it's identity.
"""

def test_distill_returns_insights():
    record = ingest_transcript(SAMPLE_TRANSCRIPT)
    insights = distill(record)
    assert isinstance(insights, list)
    assert len(insights) > 0
    assert all(isinstance(i, DistilledInsight) for i in insights)

def test_distill_extracts_speaker_turns():
    record = ingest_transcript(SAMPLE_TRANSCRIPT)
    insights = distill(record)
    speakers = {i.speaker for i in insights}
    assert "Alice" in speakers
    assert "Bob" in speakers

def test_distill_preserves_text():
    record = ingest_transcript(SAMPLE_TRANSCRIPT)
    insights = distill(record)
    all_text = " ".join(i.text for i in insights)
    assert "Spencer Brown" in all_text
```

- [ ] **Run to verify failure**

```bash
pytest tests/test_distiller.py -v
```

Expected: `ModuleNotFoundError`

- [ ] **Implement distiller.py**

`src/salon_editorial/distiller.py`:
```python
"""Distill a TranscriptRecord into publishable insights."""
from dataclasses import dataclass
from salon_editorial.ingester import TranscriptRecord

@dataclass
class DistilledInsight:
    speaker: str
    text: str
    turn: int  # Position in the exchange sequence

def distill(record: TranscriptRecord) -> list[DistilledInsight]:
    """Extract key insights from a TranscriptRecord.

    Currently: returns all exchanges as insights (each turn is a potential
    editorial contribution). Future: NLP-based selection of high-signal turns.
    """
    return [
        DistilledInsight(speaker=ex["speaker"], text=ex["text"], turn=i)
        for i, ex in enumerate(record.exchanges)
    ]
```

- [ ] **Run all tests**

```bash
pytest tests/ -v
```

Expected: 8 passed

- [ ] **Commit**

```bash
git add src/ tests/ pyproject.toml
git commit -m "feat: implement salon transcript ingester and distiller"
```

### Task 3.4 — seed.yaml and registry

- [ ] **Create seed.yaml**

```yaml
schema_version: "1.0"
organ: V
organ_name: Public Process
repo: salon--editorial
org: organvm-v-logos

metadata:
  implementation_status: PROTOTYPE
  tier: standard
  promotion_status: LOCAL
  last_validated: "2026-04-16"
  generated: "2026-04-16"
  language: python
  note: >-
    Form X (Communal Knowledge) in Organ V (Logos).
    Pipeline: salon transcripts → distilled insights → published essays.
    Closes VI→V signal gap. Community IS the editorial board.

produces:
  - type: community-sourced-essay
    format: markdown
    description: "Essays derived from salon discussions and reading groups"
    consumers:
      - organ: ORGAN-V
        repos: ["public-process"]
        relationship: "editorial-source"

consumes:
  - type: salon-transcript
    source: organvm-vi-koinonia/salon-archive
    description: "Raw salon session transcripts and metadata"
  - type: reading-curriculum
    source: organvm-vi-koinonia/reading-group-curriculum
    description: "Reading lists and discussion questions as editorial seeds"

subscriptions:
  - event: salon.session_archived
    source: ORGAN-VI
    action: "Trigger ingestion and distillation pipeline"
  - event: essay.published
    source: ORGAN-V
    action: "Record which salon session sourced this essay"
```

- [ ] **Add registry entry** under `organs.ORGAN-V.repositories`:

```json
{
  "name": "salon--editorial",
  "org": "organvm-v-logos",
  "status": "PROTOTYPE",
  "public": false,
  "description": "Community-to-discourse pipeline. Ingests salon transcripts from Organ VI, distills insights, formats as publishable essays for Organ V. Form X (Communal Knowledge) in Organ V (Logos). Closes VI→V signal gap.",
  "documentation_status": "SKELETON",
  "portfolio_relevance": "HIGH — demonstrates community-generated editorial, cross-organ pipeline",
  "dependencies": ["organvm-vi-koinonia/salon-archive", "organvm-vi-koinonia/reading-group-curriculum"],
  "promotion_status": "LOCAL",
  "tier": "standard",
  "last_validated": "2026-04-16",
  "implementation_status": "PROTOTYPE",
  "ci_workflow": "ci-python.yml",
  "note": "Created 2026-04-16. Fills V/X empty cell. Implements the VI→V edge: community knowledge → public discourse."
}
```

- [ ] **Commit and push**

```bash
git add seed.yaml
git commit -m "chore: add seed.yaml for salon--editorial"
gh repo create organvm-v-logos/salon--editorial --private --source . --remote origin --push
```

---

## Subsystem 4: `organvm--auto-agents` (META / Form IX)

**Thesis:** Agents whose domain IS the system itself. Not dispatched for user work — dispatched for system maintenance. Auto-classify unclassified repos, audit coverage matrix drift, generate IRF items for empty cells.

**Files created:**
- `~/Workspace/meta-organvm/organvm--auto-agents/seed.yaml`
- `~/Workspace/meta-organvm/organvm--auto-agents/pyproject.toml`
- `~/Workspace/meta-organvm/organvm--auto-agents/src/organvm_auto_agents/__init__.py`
- `~/Workspace/meta-organvm/organvm--auto-agents/src/organvm_auto_agents/classifier.py`
- `~/Workspace/meta-organvm/organvm--auto-agents/src/organvm_auto_agents/auditor.py`
- `~/Workspace/meta-organvm/organvm--auto-agents/tests/test_classifier.py`
- `~/Workspace/meta-organvm/organvm--auto-agents/tests/test_auditor.py`

### Task 4.1 — Scaffold

```bash
mkdir -p ~/Workspace/meta-organvm/organvm--auto-agents
cd ~/Workspace/meta-organvm/organvm--auto-agents
git init && git checkout -b main
mkdir -p src/organvm_auto_agents tests
touch src/organvm_auto_agents/__init__.py tests/__init__.py
```

`pyproject.toml`:
```toml
[build-system]
requires = ["setuptools>=68"]
build-backend = "setuptools.backends.legacy:build"

[project]
name = "organvm-auto-agents"
version = "0.1.0"
description = "System self-maintenance agents for ORGANVM (META, Form IX)"
requires-python = ">=3.11"
dependencies = ["pyyaml>=6.0"]

[project.optional-dependencies]
dev = ["pytest>=8.0", "ruff"]

[tool.pytest.ini_options]
testpaths = ["tests"]
addopts = "-v --tb=short"
```

### Task 4.2 — Form classifier agent

- [ ] **Write failing test**

`tests/test_classifier.py`:
```python
import pytest
from organvm_auto_agents.classifier import classify_by_name, FORM_KEYWORDS

def test_governance_keywords_map_to_form_viii():
    result = classify_by_name("system-governance-framework")
    assert result == "VIII"

def test_agent_keywords_map_to_form_ix():
    result = classify_by_name("agentic-swarm-coordinator")
    assert result == "IX"

def test_narrative_keywords_map_to_form_iii():
    result = classify_by_name("narratological-engine-v2")
    assert result == "III"

def test_unknown_repo_returns_none():
    result = classify_by_name("xyz-123-abc")
    assert result is None

def test_all_forms_have_keywords():
    forms = ["I","II","III","IV","V","VI","VII","VIII","IX","X","XI","XII","XIII","XIV","XV"]
    for form in forms:
        assert form in FORM_KEYWORDS, f"Form {form} missing from FORM_KEYWORDS"
        assert len(FORM_KEYWORDS[form]) >= 2, f"Form {form} needs at least 2 keywords"
```

- [ ] **Run to verify failure**

```bash
pytest tests/test_classifier.py -v
```

Expected: `ModuleNotFoundError`

- [ ] **Implement classifier.py**

`src/organvm_auto_agents/classifier.py`:
```python
"""Keyword-based ideal form classifier for ORGANVM repos."""

FORM_KEYWORDS: dict[str, list[str]] = {
    "I": ["recursive", "self-read", "ontological", "reflexive", "self-model", "epistemic-engine"],
    "II": ["alchemical", "transmut", "ingest", "collider", "solve-coagula", "synthesizer"],
    "III": ["narrative", "narratological", "rhetoric", "linguistic", "story", "mythic", "horror"],
    "IV": ["knowledge", "atomiz", "corpus", "conversation-corpus", "ledger", "knowledge-base"],
    "V": ["behavioral", "styx", "prospect-theory", "game-theory", "stakeable", "blockchain-audit"],
    "VI": ["performance", "metasystem", "generative-music", "choreograph", "installation", "waveform"],
    "VII": ["identity", "portfolio", "cv-", "myself", "life-my", "persona", "operating-system"],
    "VIII": ["governance", "orchestration", "petasum", "conductor", "collective-persona", "cvrsvs"],
    "IX": ["agent", "agentic", "multi-agent", "swarm", "smith", "skills", "titan"],
    "X": ["community", "salon", "curriculum", "syllabus", "koinonia", "reading-group", "communal"],
    "XI": ["amplif", "distribution", "social-automation", "announcement", "posse", "newsletter"],
    "XII": ["commercial", "product", "saas", "scrapper", "aetheria", "news", "bookmark"],
    "XIII": ["world-build", "theatrum", "cosmogon", "simulation", "metaverse", "block-warfare"],
    "XIV": ["substrate", "engine", "schema", "mcp-server", "dashboard", "praxis", "portal"],
    "XV": ["contrib--", "contribution", "upstream", "xenograft", "alien-codebase"],
}

def classify_by_name(repo_name: str) -> str | None:
    """Classify a repo name into an ideal form using keyword matching.

    Returns the form Roman numeral (I–XV) or None if unclassifiable.
    Uses longest-match: the form with the most matching keywords wins.
    """
    name_lower = repo_name.lower()
    scores: dict[str, int] = {}
    for form, keywords in FORM_KEYWORDS.items():
        score = sum(1 for kw in keywords if kw.lower() in name_lower)
        if score > 0:
            scores[form] = score
    if not scores:
        return None
    return max(scores, key=lambda f: scores[f])
```

- [ ] **Run to verify pass**

```bash
pytest tests/test_classifier.py -v
```

Expected: 5 passed

### Task 4.3 — Coverage auditor

- [ ] **Write failing test**

`tests/test_auditor.py`:
```python
import pytest
from organvm_auto_agents.auditor import CoverageMatrix, CoverageCell

def test_matrix_tracks_populated_cells():
    matrix = CoverageMatrix()
    matrix.add("I", "II", "recursive-engine--generative-entity")
    matrix.add("VIII", "IV", "orchestration-start-here")
    assert matrix.populated_count() == 2

def test_matrix_finds_empty_cells():
    matrix = CoverageMatrix()
    matrix.add("I", "II", "some-repo")
    empty = matrix.empty_cells()
    # Should have 120 - 1 = 119 empty cells
    assert len(empty) == 119

def test_matrix_reports_form_gaps():
    matrix = CoverageMatrix()
    # Form XIV only in META
    matrix.add("XIV", "META", "organvm-engine")
    gaps = matrix.gaps_for_form("XIV")
    # All organs except META should be gaps
    assert "I" in gaps
    assert "META" not in gaps

def test_cell_is_populated():
    matrix = CoverageMatrix()
    matrix.add("I", "II", "repo-a")
    assert matrix.is_populated("I", "II") is True
    assert matrix.is_populated("I", "III") is False
```

- [ ] **Run to verify failure**

```bash
pytest tests/test_auditor.py -v
```

Expected: `ModuleNotFoundError`

- [ ] **Implement auditor.py**

`src/organvm_auto_agents/auditor.py`:
```python
"""Coverage matrix auditor for ORGANVM ideal-form × organ grid."""
from dataclasses import dataclass, field

FORMS = ["I","II","III","IV","V","VI","VII","VIII","IX","X","XI","XII","XIII","XIV","XV"]
ORGANS = ["I","II","III","IV","V","VI","VII","META"]

@dataclass
class CoverageCell:
    form: str
    organ: str
    repos: list[str] = field(default_factory=list)

class CoverageMatrix:
    """Tracks which ideal forms are instantiated in which organs."""

    def __init__(self):
        self._cells: dict[tuple[str, str], CoverageCell] = {}

    def add(self, form: str, organ: str, repo: str) -> None:
        """Record that a repo instantiates a form in an organ."""
        key = (form, organ)
        if key not in self._cells:
            self._cells[key] = CoverageCell(form=form, organ=organ)
        self._cells[key].repos.append(repo)

    def is_populated(self, form: str, organ: str) -> bool:
        return (form, organ) in self._cells

    def populated_count(self) -> int:
        return len(self._cells)

    def empty_cells(self) -> list[tuple[str, str]]:
        """Return all (form, organ) pairs with no repos."""
        return [
            (f, o)
            for f in FORMS
            for o in ORGANS
            if not self.is_populated(f, o)
        ]

    def gaps_for_form(self, form: str) -> list[str]:
        """Return organs where a given form has no repos."""
        return [o for o in ORGANS if not self.is_populated(form, o)]
```

- [ ] **Run all tests**

```bash
pytest tests/ -v
```

Expected: 9 passed

- [ ] **Commit**

```bash
git add src/ tests/ pyproject.toml
git commit -m "feat: implement form classifier and coverage matrix auditor"
```

### Task 4.4 — seed.yaml and registry

- [ ] **Create seed.yaml**

```yaml
schema_version: "1.0"
organ: Meta
organ_name: Meta
repo: organvm--auto-agents
org: meta-organvm

metadata:
  implementation_status: PROTOTYPE
  tier: infrastructure
  promotion_status: LOCAL
  last_validated: "2026-04-16"
  generated: "2026-04-16"
  language: python
  note: >-
    Form IX (Multi-Agent Orchestration) in META.
    Agents whose domain IS the system: auto-classifier, coverage auditor, IRF generator.
    Fills META/IX empty cell. System self-maintenance without human dispatch.

produces:
  - type: classification-report
    format: json
    description: "Ideal form classifications for unclassified repos"
  - type: coverage-audit
    format: json
    description: "Coverage matrix with empty cells identified as IRF candidates"

consumes:
  - type: registry
    source: meta-organvm/organvm-corpvs-testamentvm
    description: "Registry of all repos for classification and audit"
  - type: signal-substrate
    source: meta-organvm/organvm--patchbay
    description: "Signal history for trend analysis"

subscriptions:
  - event: registry.updated
    source: META
    action: "Re-run classification audit on newly added repos"
```

- [ ] **Add registry entry** under `organs.META.repositories`:

```json
{
  "name": "organvm--auto-agents",
  "org": "meta-organvm",
  "status": "PROTOTYPE",
  "public": false,
  "description": "System self-maintenance agents. Auto-classify unclassified repos by ideal form, audit coverage matrix for gaps, generate IRF items for empty cells. Form IX (Multi-Agent Orchestration) in META.",
  "documentation_status": "SKELETON",
  "portfolio_relevance": "HIGH — demonstrates ORGANVM self-governance",
  "dependencies": ["meta-organvm/organvm--patchbay", "meta-organvm/organvm-corpvs-testamentvm"],
  "promotion_status": "LOCAL",
  "tier": "infrastructure",
  "last_validated": "2026-04-16",
  "implementation_status": "PROTOTYPE",
  "ci_workflow": "ci-python.yml",
  "note": "Created 2026-04-16. Fills META/IX empty cell. System reads and maintains itself."
}
```

- [ ] **Commit and push**

```bash
git add seed.yaml
git commit -m "chore: add seed.yaml for organvm--auto-agents"
gh repo create meta-organvm/organvm--auto-agents --private --source . --remote origin --push
```

---

## Subsystem 5: `theoria--gubernans` (Organ I / Form VIII)

**Thesis:** The governance of theoretical artifacts — not meta-governance (Organ IV's domain) but epistemic governance within theory itself. When does a theory get archived? What makes a concept CANDIDATE vs LOCAL? The theoretical framework that polices its own frameworks.

**Files created:**
- `~/Workspace/organvm-i-theoria/theoria--gubernans/seed.yaml`
- `~/Workspace/organvm-i-theoria/theoria--gubernans/pyproject.toml`
- `~/Workspace/organvm-i-theoria/theoria--gubernans/src/theoria_gubernans/__init__.py`
- `~/Workspace/organvm-i-theoria/theoria--gubernans/src/theoria_gubernans/lifecycle.py`
- `~/Workspace/organvm-i-theoria/theoria--gubernans/src/theoria_gubernans/criteria.py`
- `~/Workspace/organvm-i-theoria/theoria--gubernans/tests/test_lifecycle.py`

### Task 5.1 — Scaffold

```bash
mkdir -p ~/Workspace/organvm-i-theoria/theoria--gubernans
cd ~/Workspace/organvm-i-theoria/theoria--gubernans
git init && git checkout -b main
mkdir -p src/theoria_gubernans tests
touch src/theoria_gubernans/__init__.py tests/__init__.py
```

`pyproject.toml`:
```toml
[build-system]
requires = ["setuptools>=68"]
build-backend = "setuptools.backends.legacy:build"

[project]
name = "theoria-gubernans"
version = "0.1.0"
description = "Epistemic governance — lifecycle management for theoretical artifacts (Organ I, Form VIII)"
requires-python = ">=3.11"
dependencies = ["pyyaml>=6.0"]

[project.optional-dependencies]
dev = ["pytest>=8.0", "ruff"]

[tool.pytest.ini_options]
testpaths = ["tests"]
addopts = "-v --tb=short"
```

### Task 5.2 — Theoretical artifact lifecycle

- [ ] **Write failing test**

`tests/test_lifecycle.py`:
```python
import pytest
from theoria_gubernans.lifecycle import TheoreticalArtifact, TheoreticalStatus, promote, archive

def test_artifact_starts_local():
    artifact = TheoreticalArtifact(name="recursive-ontology", author="system")
    assert artifact.status == TheoreticalStatus.LOCAL

def test_promote_local_to_candidate():
    artifact = TheoreticalArtifact(name="strange-loop-axiom", author="system")
    promoted = promote(artifact)
    assert promoted.status == TheoreticalStatus.CANDIDATE

def test_promote_candidate_to_graduated():
    artifact = TheoreticalArtifact(name="eigenform", author="system",
                                    status=TheoreticalStatus.CANDIDATE)
    graduated = promote(artifact)
    assert graduated.status == TheoreticalStatus.GRADUATED

def test_cannot_promote_archived():
    artifact = TheoreticalArtifact(name="defunct-theory", author="system",
                                    status=TheoreticalStatus.ARCHIVED)
    with pytest.raises(ValueError, match="archived"):
        promote(artifact)

def test_archive_any_non_archived_status():
    for status in [TheoreticalStatus.LOCAL, TheoreticalStatus.CANDIDATE,
                   TheoreticalStatus.GRADUATED]:
        artifact = TheoreticalArtifact(name="test", author="s", status=status)
        archived = archive(artifact, reason="superseded")
        assert archived.status == TheoreticalStatus.ARCHIVED
        assert "superseded" in archived.archive_reason
```

- [ ] **Run to verify failure**

```bash
pytest tests/test_lifecycle.py -v
```

Expected: `ModuleNotFoundError`

- [ ] **Implement lifecycle.py**

`src/theoria_gubernans/lifecycle.py`:
```python
"""Lifecycle management for theoretical artifacts — the epistemic state machine."""
from dataclasses import dataclass, field
from enum import Enum

class TheoreticalStatus(str, Enum):
    LOCAL = "LOCAL"
    CANDIDATE = "CANDIDATE"
    GRADUATED = "GRADUATED"
    ARCHIVED = "ARCHIVED"

_PROMOTION_PATH = {
    TheoreticalStatus.LOCAL: TheoreticalStatus.CANDIDATE,
    TheoreticalStatus.CANDIDATE: TheoreticalStatus.GRADUATED,
}

@dataclass
class TheoreticalArtifact:
    name: str
    author: str
    status: TheoreticalStatus = TheoreticalStatus.LOCAL
    archive_reason: str = ""
    history: list[str] = field(default_factory=list)

def promote(artifact: TheoreticalArtifact) -> TheoreticalArtifact:
    """Advance a theoretical artifact to the next status in the lifecycle.

    LOCAL → CANDIDATE → GRADUATED

    Raises ValueError if the artifact is ARCHIVED (terminal state).
    """
    if artifact.status == TheoreticalStatus.ARCHIVED:
        raise ValueError(f"cannot promote archived artifact '{artifact.name}'")
    next_status = _PROMOTION_PATH.get(artifact.status)
    if next_status is None:
        raise ValueError(f"no promotion path from {artifact.status}")
    return TheoreticalArtifact(
        name=artifact.name,
        author=artifact.author,
        status=next_status,
        archive_reason=artifact.archive_reason,
        history=artifact.history + [f"{artifact.status} → {next_status}"],
    )

def archive(artifact: TheoreticalArtifact, reason: str) -> TheoreticalArtifact:
    """Archive a theoretical artifact with a reason. Terminal state."""
    return TheoreticalArtifact(
        name=artifact.name,
        author=artifact.author,
        status=TheoreticalStatus.ARCHIVED,
        archive_reason=reason,
        history=artifact.history + [f"{artifact.status} → ARCHIVED: {reason}"],
    )
```

- [ ] **Run to verify pass**

```bash
pytest tests/test_lifecycle.py -v
```

Expected: 5 passed

- [ ] **Commit**

```bash
git add src/ tests/ pyproject.toml
git commit -m "feat: implement theoretical artifact lifecycle (LOCAL→CANDIDATE→GRADUATED→ARCHIVED)"
```

### Task 5.3 — seed.yaml and registry

- [ ] **Create seed.yaml**

```yaml
schema_version: "1.0"
organ: I
organ_name: Theory
repo: theoria--gubernans
org: ivviiviivvi

metadata:
  implementation_status: PROTOTYPE
  tier: standard
  promotion_status: LOCAL
  last_validated: "2026-04-16"
  generated: "2026-04-16"
  language: python
  note: >-
    Form VIII (Governance as Art) in Organ I (Theoria).
    Epistemic governance — lifecycle state machine for theoretical artifacts.
    Sol LeWitt applied to epistemology: the theory becomes a system that governs theory.
    Fills I/VIII empty cell.

produces:
  - type: theory-governance-schema
    format: python-api
    description: "Lifecycle state machine and validation criteria for theoretical artifacts"
    consumers:
      - organ: ORGAN-I
        repos: ["recursive-engine--generative-entity", "auto-revision-epistemic-engine"]
        relationship: "validates-theory-lifecycle"

consumes:
  - type: theory
    source: organvm-i-theoria/recursive-engine--generative-entity
    description: "Theoretical artifacts to be governed and lifecycle-managed"

subscriptions:
  - event: governance.updated
    source: ORGAN-IV
    action: "Align epistemic governance criteria with system governance rules"
  - event: health-audit.completed
    source: ORGAN-IV
    action: "Review theoretical artifacts for archival candidates"
```

- [ ] **Add registry entry** under `organs.ORGAN-I.repositories`:

```json
{
  "name": "theoria--gubernans",
  "org": "ivviiviivvi",
  "status": "PROTOTYPE",
  "public": false,
  "description": "Epistemic governance — lifecycle state machine for theoretical artifacts (LOCAL→CANDIDATE→GRADUATED→ARCHIVED). The theoretical framework that governs other theoretical frameworks. Form VIII (Governance as Art) in Organ I (Theoria).",
  "documentation_status": "SKELETON",
  "portfolio_relevance": "MEDIUM — demonstrates recursive self-governance at the theory level",
  "dependencies": ["organvm-i-theoria/recursive-engine--generative-entity"],
  "promotion_status": "LOCAL",
  "tier": "standard",
  "last_validated": "2026-04-16",
  "implementation_status": "PROTOTYPE",
  "ci_workflow": "ci-python.yml",
  "note": "Created 2026-04-16. Fills I/VIII empty cell. The Sol LeWitt insight: 'the idea becomes a machine that makes the art' → 'the theory becomes a system that governs theory.'"
}
```

- [ ] **Commit and push**

```bash
git add seed.yaml
git commit -m "chore: add seed.yaml for theoria--gubernans"
gh repo create ivviiviivvi/theoria--gubernans --private --source . --remote origin --push
```

---

## Subsystem 6: `theoria--viva` (Organ I / Form VI)

**Thesis:** Theory as live performance. Not a paper — an interactive system. Theoretical models computed and rendered in real-time. The audience watches axioms execute. Spencer Brown's Laws of Form computed live. Recursive engines that visibly perform their own recursion.

**Files created:**
- `~/Workspace/organvm-i-theoria/theoria--viva/seed.yaml`
- `~/Workspace/organvm-i-theoria/theoria--viva/pyproject.toml`
- `~/Workspace/organvm-i-theoria/theoria--viva/src/theoria_viva/__init__.py`
- `~/Workspace/organvm-i-theoria/theoria--viva/src/theoria_viva/models.py`
- `~/Workspace/organvm-i-theoria/theoria--viva/src/theoria_viva/executor.py`
- `~/Workspace/organvm-i-theoria/theoria--viva/tests/test_models.py`
- `~/Workspace/organvm-i-theoria/theoria--viva/tests/test_executor.py`

### Task 6.1 — Scaffold

```bash
mkdir -p ~/Workspace/organvm-i-theoria/theoria--viva
cd ~/Workspace/organvm-i-theoria/theoria--viva
git init && git checkout -b main
mkdir -p src/theoria_viva tests
touch src/theoria_viva/__init__.py tests/__init__.py
```

`pyproject.toml`:
```toml
[build-system]
requires = ["setuptools>=68"]
build-backend = "setuptools.backends.legacy:build"

[project]
name = "theoria-viva"
version = "0.1.0"
description = "Living theory — theoretical models computed and performed in real-time (Organ I, Form VI)"
requires-python = ">=3.11"
dependencies = []

[project.optional-dependencies]
dev = ["pytest>=8.0", "ruff"]

[tool.pytest.ini_options]
testpaths = ["tests"]
addopts = "-v --tb=short"
```

### Task 6.2 — Theoretical models

- [ ] **Write failing test**

`tests/test_models.py`:
```python
import pytest
from theoria_viva.models import Axiom, TheoreticalModel, MarkCalculus

def test_axiom_has_name_and_statement():
    a = Axiom(name="distinction", statement="Draw a distinction.")
    assert a.name == "distinction"
    assert a.statement == "Draw a distinction."

def test_model_holds_axioms():
    model = TheoreticalModel(name="Laws of Form")
    a1 = Axiom(name="distinction", statement="Draw a distinction.")
    a2 = Axiom(name="condensation", statement="Calling twice is calling once.")
    model.add(a1)
    model.add(a2)
    assert len(model.axioms) == 2

def test_mark_calculus_cross_evaluates():
    calc = MarkCalculus()
    # (()) = empty (a mark inside a mark cancels)
    result = calc.evaluate("(())")
    assert result == ""

def test_mark_calculus_mark_evaluates():
    calc = MarkCalculus()
    # () = the mark itself
    result = calc.evaluate("()")
    assert result == "()"

def test_mark_calculus_double_cancellation():
    calc = MarkCalculus()
    # (()()) = () — two marks inside a mark condense to one
    result = calc.evaluate("(()())")
    assert result == "()"
```

- [ ] **Run to verify failure**

```bash
pytest tests/test_models.py -v
```

Expected: `ModuleNotFoundError`

- [ ] **Implement models.py**

`src/theoria_viva/models.py`:
```python
"""Theoretical models for live performance — Spencer Brown's Laws of Form and extensions."""
from dataclasses import dataclass, field
import re

@dataclass
class Axiom:
    name: str
    statement: str

@dataclass
class TheoreticalModel:
    name: str
    axioms: list[Axiom] = field(default_factory=list)

    def add(self, axiom: Axiom) -> None:
        self.axioms.append(axiom)


class MarkCalculus:
    """Spencer Brown's Laws of Form — mark calculus evaluator.

    Two laws:
    1. Condensation: (()()) → () — calling twice is calling once
    2. Cancellation: (()) → empty — crossing twice returns to origin

    Notation: () is the mark. (X) is a marked X. Empty string is the void.
    """

    def evaluate(self, expression: str) -> str:
        """Evaluate a mark calculus expression to its simplest form.

        Applies condensation and cancellation until no further reduction is possible.
        """
        prev = None
        expr = expression.strip()
        while expr != prev:
            prev = expr
            expr = self._cancel(self._condense(expr))
        return expr

    def _condense(self, expr: str) -> str:
        """Apply condensation: multiple marks inside a mark → one mark.

        (()()) → ()
        """
        # Match a mark containing two or more marks: (()...())
        # Replace with a single mark ()
        return re.sub(r'\((\(\))+\)', '()', expr)

    def _cancel(self, expr: str) -> str:
        """Apply cancellation: a mark inside a mark → empty.

        (()) → ''
        """
        return re.sub(r'\(\(\)\)', '', expr)
```

- [ ] **Run to verify pass**

```bash
pytest tests/test_models.py -v
```

Expected: 5 passed

### Task 6.3 — Live executor

- [ ] **Write failing test**

`tests/test_executor.py`:
```python
import pytest
from theoria_viva.models import TheoreticalModel, Axiom, MarkCalculus
from theoria_viva.executor import execute_step, ExecutionTrace

def test_execute_step_returns_trace():
    calc = MarkCalculus()
    trace = execute_step(calc, "(()())")
    assert isinstance(trace, ExecutionTrace)

def test_execution_trace_shows_input_and_output():
    calc = MarkCalculus()
    trace = execute_step(calc, "(()())")
    assert trace.input == "(()())"
    assert trace.output == "()"

def test_execution_trace_records_step_count():
    calc = MarkCalculus()
    # (()()) requires 2 steps: condense then nothing
    trace = execute_step(calc, "(()())")
    assert trace.steps >= 1

def test_null_step_on_already_reduced():
    calc = MarkCalculus()
    trace = execute_step(calc, "()")
    assert trace.input == trace.output  # Already at fixed point
    assert trace.steps == 0
```

- [ ] **Run to verify failure**

```bash
pytest tests/test_executor.py -v
```

Expected: `ModuleNotFoundError`

- [ ] **Implement executor.py**

`src/theoria_viva/executor.py`:
```python
"""Live executor for theoretical models — shows each reduction step."""
from dataclasses import dataclass
from theoria_viva.models import MarkCalculus

@dataclass
class ExecutionTrace:
    input: str
    output: str
    steps: int
    intermediate: list[str]  # Each intermediate form during reduction

def execute_step(calc: MarkCalculus, expression: str) -> ExecutionTrace:
    """Execute one full reduction of a mark calculus expression.

    Records each intermediate form so the audience can watch the axioms fire.
    """
    current = expression.strip()
    intermediate = []
    steps = 0
    prev = None

    while current != prev:
        prev = current
        after_condense = calc._condense(current)
        after_cancel = calc._cancel(after_condense)
        if after_cancel != current:
            intermediate.append(after_cancel)
            steps += 1
        current = after_cancel

    return ExecutionTrace(
        input=expression.strip(),
        output=current,
        steps=steps,
        intermediate=intermediate,
    )
```

- [ ] **Run all tests**

```bash
pytest tests/ -v
```

Expected: 9 passed

- [ ] **Commit**

```bash
git add src/ tests/ pyproject.toml
git commit -m "feat: implement mark calculus evaluator and live executor for theoria--viva"
```

### Task 6.4 — seed.yaml and registry

- [ ] **Create seed.yaml**

```yaml
schema_version: "1.0"
organ: I
organ_name: Theory
repo: theoria--viva
org: ivviiviivvi

metadata:
  implementation_status: PROTOTYPE
  tier: standard
  promotion_status: LOCAL
  last_validated: "2026-04-16"
  generated: "2026-04-16"
  language: python
  note: >-
    Form VI (Live Performance) in Organ I (Theoria).
    Theory computed and performed in real-time. Spencer Brown's Laws of Form
    as an interactive reduction engine. The audience watches axioms fire.
    Fills I/VI empty cell.

produces:
  - type: live-computation-artifact
    format: python-api
    description: "Executable theoretical models with step-by-step reduction traces"
    consumers:
      - organ: ORGAN-II
        repos: ["metasystem-master"]
        relationship: "theory-feeds-live-performance"

consumes:
  - type: theory
    source: organvm-i-theoria/recursive-engine--generative-entity
    description: "Theoretical frameworks to be performed live"

subscriptions:
  - event: theory.published
    source: ORGAN-I
    action: "Ingest new theoretical framework for live performance"
  - event: governance.updated
    source: ORGAN-IV
    action: "Check compliance with updated governance rules"
```

- [ ] **Add registry entry** under `organs.ORGAN-I.repositories`:

```json
{
  "name": "theoria--viva",
  "org": "ivviiviivvi",
  "status": "PROTOTYPE",
  "public": false,
  "description": "Living theory — theoretical models computed and performed in real-time. Mark calculus evaluator (Spencer Brown's Laws of Form), step-by-step reduction traces. Form VI (Live Performance) in Organ I (Theoria).",
  "documentation_status": "SKELETON",
  "portfolio_relevance": "HIGH — demonstrates theory as interactive performance; novel intersection of formal logic and live art",
  "dependencies": ["organvm-i-theoria/recursive-engine--generative-entity"],
  "promotion_status": "LOCAL",
  "tier": "standard",
  "last_validated": "2026-04-16",
  "implementation_status": "PROTOTYPE",
  "ci_workflow": "ci-python.yml",
  "note": "Created 2026-04-16. Fills I/VI empty cell. Theory as performance: the audience watches axioms execute."
}
```

- [ ] **Commit and push**

```bash
git add seed.yaml
git commit -m "chore: add seed.yaml for theoria--viva"
gh repo create ivviiviivvi/theoria--viva --private --source . --remote origin --push
```

---

## Final Verification

After all 6 subsystems are implemented:

- [ ] **Run all tests across all 6 repos**

```bash
for repo in ~/organvm--patchbay \
    ~/Workspace/organvm-v-logos/logos--commercium \
    ~/Workspace/organvm-v-logos/salon--editorial \
    ~/Workspace/meta-organvm/organvm--auto-agents \
    ~/Workspace/organvm-i-theoria/theoria--gubernans \
    ~/Workspace/organvm-i-theoria/theoria--viva; do
  echo "=== $repo ==="
  cd "$repo" && source .venv/bin/activate && pytest tests/ -q
done
```

Expected: all pass

- [ ] **Verify registry parses cleanly** after all 6 entries added

```bash
python3 -c "
import json
data = json.load(open('/Users/4jp/Workspace/meta-organvm/organvm-corpvs-testamentvm/registry-v2.json'))
total = sum(len(o.get('repositories', [])) for o in data.get('organs', {}).values())
print(f'Registry OK: {total} repos')
"
```

Expected: `Registry OK: N repos` (at least 151 — original 145 + 6 new)

- [ ] **Run edge extraction script to verify new coverage**

```bash
python3 /tmp/extract_edges.py 2>&1 | grep -A3 "COVERAGE MATRIX"
```

Expected: populated cells ≥ 37 (was 31, adding 6 new cells)

- [ ] **Commit registry update**

```bash
cd ~/Workspace/meta-organvm/organvm-corpvs-testamentvm
git add registry-v2.json
git commit -m "chore: register 6 new repos — unspoken sentences implemented (2026-04-16)"
git push
```

---

## IRF Items to Create

After implementation, add these to `INST-INDEX-RERUM-FACIENDARUM.md`:

- `IRF-SYS-102` — `organvm--patchbay`: migrate existing 4 files (registry, signal-graph, atoms, ledger) into unified store
- `IRF-SYS-103` — `logos--commercium`: integrate with real payment provider (Stripe/Lemon Squeezy)
- `IRF-SYS-104` — `salon--editorial`: add NLP-based distiller (replace keyword extraction with semantic selection)
- `IRF-SYS-105` — `organvm--auto-agents`: hook into registry.updated event to auto-run classifier
- `IRF-SYS-106` — `theoria--gubernans`: add validation criteria for when to archive vs promote theoretical artifacts
- `IRF-SYS-107` — `theoria--viva`: add WebSocket server for browser-based live theory performance
