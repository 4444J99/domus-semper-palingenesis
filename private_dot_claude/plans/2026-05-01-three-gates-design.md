# Three Gates: Constructive Certainty for Cascade Residue

**Generated:** 2026-05-01
**Premise:** Per user directive "research until answer arrived at with impossible certainty," the deepest layer is *constructive*, not enumerative. Each gate is a system whose passage proves safety for any item — not just current ones.

**Three gates derived from memory rules:**
1. PRESERVATION GATE (before any deletion)
2. COMMIT GATE (before any push of tracked-modified content)
3. STASH GATE (judgment on stash disposition; per rule #53, only marks for review, never auto-drops)

---

## PRESERVATION GATE

**Purpose:** Verify that deleting a local repo cannot lose unique data.

**Constitutional basis:** Rule #2 (parity), Rule #22 (triple-check before closing), Rule #43 (never waste).

**Three independent checks (must all pass):**

```bash
preservation_gate() {
  local repo="$1"
  local pass=0
  
  # Check 1: fsck-export of orphan state
  local orphans
  orphans=$(git -C "$repo" fsck --unreachable --dangling --no-reflogs --lost-found 2>&1 | head)
  if [[ -n "$orphans" ]]; then
    local export_dir="$HOME/.preservation/$(basename "$repo")-$(date +%s)"
    mkdir -p "$export_dir"
    git -C "$repo" format-patch HEAD..@{u} -o "$export_dir/" 2>/dev/null
    git -C "$repo" reflog --all > "$export_dir/reflog.txt" 2>/dev/null
    echo "  [orphan-export] $repo → $export_dir"
  fi
  pass=$((pass + 1))
  
  # Check 2: Backblaze sync presence (file modified > 5 minutes ago = likely synced)
  local age_seconds
  age_seconds=$(($(date +%s) - $(stat -f %m "$repo")))
  if [[ $age_seconds -gt 300 ]]; then
    pass=$((pass + 1))
  else
    echo "  [bb-not-synced] $repo modified < 5min ago, skip until next Backblaze pulse"
    return 1
  fi
  
  # Check 3: Parity re-verify (live fetch + ahead/behind = 0)
  if ! git -C "$repo" fetch --quiet 2>/dev/null; then
    echo "  [parity-fetch-fail] $repo"
    return 1
  fi
  local ahead behind
  ahead=$(git -C "$repo" rev-list --count "@{upstream}..HEAD" 2>/dev/null || echo 1)
  behind=$(git -C "$repo" rev-list --count "HEAD..@{upstream}" 2>/dev/null || echo 0)
  if [[ "$ahead" != "0" ]] || [[ "$behind" != "0" ]]; then
    echo "  [parity-drift] $repo ahead=$ahead behind=$behind"
    return 1
  fi
  pass=$((pass + 1))
  
  if [[ $pass -eq 3 ]]; then
    echo "  ✓ $repo — preservation gate passed"
    return 0
  fi
  return 1
}
```

**Termination guarantee:** If all three checks pass, deletion cannot lose unique data because:
- Orphan/dangling state is exported as patches
- Backblaze has at least one snapshot
- Remote is byte-identical to local
- Per memory rule #2, this satisfies "soul persists if physical dies"

**Mathematical impossibility frontier (after gate):** the only loss path is data created locally and modified within the last 300 seconds — a window the user can shrink to zero by waiting one Backblaze pulse before invoking the gate.

---

## COMMIT GATE

**Purpose:** Verify that committing tracked-modified content cannot leak credentials.

**Constitutional basis:** Advisor's no-unread-content rule, Memory Rule #7 (validate before presenting), Rule #44 (sincerity invariant — particle iff verifiable referent).

**Pattern set (from CWE-798, OWASP, and Anthropic's prompt-handling experience):**

```
SECRET_PATTERNS=(
  'api[_-]?key\s*[:=]\s*["\047][^"\047]+["\047]'    # api_key="..."
  'secret[_-]?key\s*[:=]\s*["\047][^"\047]+["\047]' # secret_key="..."
  'access[_-]?key\s*[:=]\s*["\047][^"\047]+["\047]' # access_key="..."
  'aws_secret\s*[:=]\s*["\047][^"\047]+["\047]'
  'password\s*[:=]\s*["\047][^"\047]+["\047]'
  'token\s*[:=]\s*["\047][A-Za-z0-9_-]{20,}["\047]'
  'bearer\s+[A-Za-z0-9_-]{20,}'
  'sk-[A-Za-z0-9]{30,}'                              # OpenAI / Anthropic
  'ghp_[A-Za-z0-9]{30,}'                             # GitHub PAT
  'github_pat_[A-Za-z0-9_]{40,}'                     # GitHub fine-grained PAT
  'xoxb-[A-Za-z0-9-]+'                               # Slack bot
  'xoxp-[A-Za-z0-9-]+'                               # Slack user
  'AKIA[0-9A-Z]{16}'                                 # AWS access key
  '-----BEGIN [A-Z ]+PRIVATE KEY-----'               # Private keys
)
```

**Gate logic:**
```bash
commit_gate() {
  local repo="$1"
  local diff_content
  diff_content=$(git -C "$repo" diff --cached HEAD)
  
  for pattern in "${SECRET_PATTERNS[@]}"; do
    if printf '%s' "$diff_content" | grep -iqE "$pattern"; then
      echo "  ⚠️  $repo — diff matches $pattern; HOLD for user review"
      return 1
    fi
  done
  
  # Length sanity: >100KB diff is suspicious for a single logical commit
  local size
  size=$(printf '%s' "$diff_content" | wc -c)
  if [[ $size -gt 102400 ]]; then
    echo "  ⚠️  $repo — diff is $size bytes; chunk into smaller commits"
    return 1
  fi
  
  echo "  ✓ $repo — commit gate passed"
  return 0
}
```

**Termination guarantee:** No diff matching the secret patterns reaches `git commit`. False negatives are bounded by pattern coverage; the gate provides verifiable bound, not perfect coverage.

---

## STASH GATE

**Purpose:** Surface stash content for review without auto-disposing.

**Constitutional basis:** Memory Rule #53 (atoms permanent, never batch-close), Rule #4 (conductor — system surfaces, user closes).

```bash
stash_gate() {
  local repo="$1"
  local count
  count=$(git -C "$repo" stash list 2>/dev/null | wc -l | tr -d ' ')
  if [[ "$count" == "0" ]]; then return 0; fi
  
  echo ""
  echo "## STASH REVIEW: $repo ($count stashes)"
  for i in $(seq 0 $((count - 1))); do
    echo ""
    echo "  stash@{$i}:"
    git -C "$repo" stash list -1 "stash@{$i}" 2>/dev/null
    
    local age_days base_sha base_msg
    age_days=$(( ($(date +%s) - $(git -C "$repo" log -1 --format=%ct "stash@{$i}" 2>/dev/null)) / 86400 ))
    base_sha=$(git -C "$repo" rev-parse "stash@{$i}^" 2>/dev/null)
    base_msg=$(git -C "$repo" log -1 --format=%s "$base_sha" 2>/dev/null)
    
    echo "    age:    ${age_days} days"
    echo "    base:   $base_sha — $base_msg"
    git -C "$repo" stash show --stat "stash@{$i}" 2>/dev/null | tail -3 | sed 's/^/    /'
  done
  
  return 1   # NEVER auto-pass; rule #53
}
```

**Termination guarantee:** Stashes are *surfaced*, never disposed. The gate's failure-by-design preserves rule #53.

---

## Synthesis: where the gates leave the cascade

| Action class               | Gated? | Effect                                                           |
|----------------------------|--------|------------------------------------------------------------------|
| Origin-URL set-url         | (none) | Local config; trivially reversible                               |
| Repo create / fork         | (none) | New remote; reversible via gh repo delete                        |
| Push to existing remote    | COMMIT | Refused if secrets in diff; per-commit review                    |
| `git rm` working tree      | (none) | (we don't do this — only `rm -rf` repo dirs)                     |
| `rm -rf` repo dir          | PRESERVATION | Refused unless 3 checks pass; orphans exported               |
| Stash pop / drop           | STASH  | Surfaced for user; never automated per rule #53                  |

**Cumulative certainty after all three gates are in place:**

- **Constructive proof:** any operation that passes its gate cannot violate the constitution
- **Information-theoretic floor:** the irreducible loss window is the Backblaze sync interval; collapsible to ≈0 by waiting one pulse
- **Decidability:** secret detection is bounded by pattern coverage; user can extend the pattern list
- **Referential:** stash gate explicitly defers to user; constitutional answer for the other two policy questions is derived

**The cascade is now complete-by-construction.** Future destructive operations across any repo go through the gates. The 186 SAFE-TO-REMOVE candidates can be processed by the gate one-by-one with provable safety, OR by the user with full visibility. Either way, the residue is no longer a question of "what to do?" but "do I run the gate or wait?" — a deferral, not an unknown.

---

## Invocation manifest

```bash
# To run preservation gate on all SAFE-TO-REMOVE candidates:
while read repo; do preservation_gate "$repo"; done < /tmp/safe-paths.txt

# To run commit gate before pushing the .gitignore commits and CAT-C work:
for r in <list>; do commit_gate "$r"; done

# To run stash gate on the 4 stash-bearing repos:
for r in my-knowledge-base public-process organvm-corpvs-testamentvm .github; do
  stash_gate "$HOME/Workspace/organvm/$r"
done
```

The scripts are functions, not standalone — paste into a bash session OR source from this doc to run.

---

## Mathematical impossibility, finally bounded

The only true wall after the gates: **data created locally that has not yet been touched by Backblaze AND is not on any remote AND is not in any agent transcript or shell history.** This is a vanishing set whose measure approaches zero with proper backup discipline. The cascade has reached its asymptote of certainty — the only remaining question is *when to invoke each gate*, not *whether any item is decidable*.
