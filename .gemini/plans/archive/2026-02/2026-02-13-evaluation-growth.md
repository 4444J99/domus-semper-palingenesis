# Evaluation-to-Growth Plan: Domus Semper Palingenesis

## Executive Summary
This document outlines a comprehensive evaluation and improvement plan for the `domus-semper-palingenesis` repository. Using the **Evaluation-to-Growth** framework, we have analyzed the system's architecture, code quality, and user experience to identify key strengths and critical areas for evolution.

The system is a high-maturity, "self-healing" environment manager that successfully solves the problem of configuration drift and secret management. However, its heavy reliance on tight integration (Chezmoi + 1Password + Custom Daemons) creates complexity and potential fragility ("Shatter Points") that need addressing.

## Phase 1: Evaluation

### 1.1 Critique
*   **Strengths**:
    *   **Security-First Architecture**: Zero secrets in Git is a massive win. The `onepasswordRead` template pattern is robust.
    *   **Self-Healing**: The concept of a launchd daemon (`com.chezmoi.self-heal`) that actively fights configuration drift is excellent and rare in dotfile setups.
    *   **Unified Interface**: The `domus` CLI abstracts away the complexity of underlying tools (`chezmoi`, `brew`, `pipx`), providing a consistent UX.
*   **Weaknesses**:
    *   **Bootstrap Paradox**: The installation relies on `curl` and `1Password` being present/configurable immediately. If 1Password CLI authentication fails during the initial `chezmoi apply`, the entire process halts with cryptic template errors.
    *   **Observability**: While `domus status` exists, it mostly checks *if* things are running, not *how well* (e.g., last successful sync timestamp, specific error logs from background daemons).
    *   **Shell Script fragility**: The `domus` executable is a 400-line Bash script. As logic grows (telemetry, JSON output, perf monitoring), Bash becomes a liability for maintainability and testing.

### 1.2 Logic & Logos (Code Analysis)
*   **Analysis of `dot_local/bin/executable_domus`**:
    *   *Consistency*: Good use of `set -euo pipefail`.
    *   *Error Handling*: Basic `die()` function exists, but many pipeline commands (like `grep` or `tail`) might fail silently or produce misleading output if files are missing (handled by `|| true` in some places, but could be more robust).
    *   *Telemetry*: Reading JSONL files via `grep` and `sed` is fragile. A dedicated parser or moving the core logic to a typed language (Go/Rust/Python) would be logically sounder.

### 1.3 Pathos & Ethos (UX & Trust)
*   **Docs**: `README.md` and `ARCHITECTURE.md` are clear, professional, and inspire confidence. The "Tokyo Night" aesthetic consistency appeals to the target audience (developers).
*   **Trust**: The "Doctor" command builds trust, but the lack of "Fix" suggestions for some errors lowers it.

## Phase 2: Reinforcement

### 2.1 Synthesis
To resolve the contradiction between "High Automation" and "Fragile Bootstrap," we must reinforce the error handling and dependency checks.

*   **Action**: Improve `domus doctor` to not just report issues, but suggest specific remediation commands.
*   **Action**: Create a "Safe Mode" for the `domus` CLI that skips telemetry or non-essential checks if the system is unstable.

## Phase 3: Risk Analysis

### 3.1 Blind Spots
*   **Offline Capability**: The system assumes constant connectivity to 1Password and GitHub. If offline, `chezmoi apply` might fail catastrophically if it tries to fetch secrets.
*   **Daemon Resource Usage**: A background file watcher (`domus-sort`) via FSEvents is efficient, but if the `Downloads` folder becomes massive, it could spike CPU.

### 3.2 Shatter Points
*   **1Password CLI (op) Dependency**: If the `op` CLI syntax changes (which it has in v2), all templates break.
*   **OS Compatibility**: The scripts heavily favor macOS (`launchctl`, `FSEvents`). Linux support appears theoretical or secondary in the architecture diagrams.

## Phase 4: Growth (Implementation Plan)

This phase defines the roadmap for the next iteration of `domus`.

### Priority 1: harden the Core (Week 1)
1.  **Refactor `domus` CLI**:
    *   Move complex JSON parsing logic out of Bash or strictly use `jq`/`yq` (enforcing them as dependencies).
    *   Add a `--debug` flag that traces all internal commands.
2.  **Enhance Bootstrap Robustness**:
    *   Add a pre-flight check script that verifies `op` authentication *before* `chezmoi` attempts to render templates.

### Priority 2: Improve Observability (Week 2)
1.  **Centralized Logging**:
    *   Direct all daemons (sort, self-heal, health) to write to a structured log file in `~/.local/state/domus/domus.log`.
    *   Add `domus logs` command to tail this file.
2.  **Daemon Health**:
    *   Update `domus doctor` to parse the exit codes of the launchd jobs, not just their presence.

### Priority 3: AI & Documentation (Week 3)
1.  **Local Skill Definition**:
    *   Create a local MCP server or skill definition for `domus` itself, allowing the AI to query the system status directly (e.g., `ask_domus` tool).
2.  **Internal Developer Docs**:
    *   Create `docs/INTERNAL.md` documenting the "why" behind the specific ZSH load order and the telemetry format.

### Execution Steps for User
1.  **Approve** this plan.
2.  **Start** with Priority 1 (Hardening the CLI).
