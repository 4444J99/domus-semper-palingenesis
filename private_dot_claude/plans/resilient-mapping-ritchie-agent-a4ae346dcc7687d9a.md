# Deep Audit: grafana/k6 PR #5770

**PR:** https://github.com/grafana/k6/pull/5770
**Author:** 4444J99 (Anthony James Padavano)
**Title:** `metrics: add Len and ForEach methods to TagSet`
**Branch:** `feature/extend-tagset-api` -> `master`
**Created:** 2026-03-28
**References:** Closes #2764

---

## 1. CONTRIBUTION GUIDELINES COMPLIANCE

Source: `CONTRIBUTING.md` in grafana/k6

### Requirements and current status:

| Requirement | Status | Notes |
|---|---|---|
| Open an issue first for features | PASS | Issue #2764 exists (opened 2022-11-10) |
| Fork + feature branch | PASS | `feature/extend-tagset-api` |
| Sign CLA | **FAIL** | CLA is NOT signed. Bot shows "not signed" twice. |
| Code style (gofmt, gofmt -s) | PASS | Lint CI check passes |
| Tests | PASS | Tests included and pass |
| Commit message usable as changelog | PASS | Clear commit message |
| Non-gendered language | PASS | No issues |

### CLA: THE BLOCKING ISSUE

The CLA assistant bot has posted TWO "not signed" notices. The `license/cla` status check is **PENDING** (not failed, not passed). This is the single biggest blocker. The PR cannot be merged until this is resolved.

**Action required:** Go to https://cla-assistant.io/grafana/k6?pullRequest=5770 and sign the CLA. If it shows "Bad credentials" (as PR #5767's author experienced), you may need to contact the maintainers.

---

## 2. CI STATUS

### Passing (47/49 relevant checks):
- **lint:** PASS
- **build:** PASS
- **build-docker:** PASS
- **check-generated-code:** PASS
- **test (all 8 E2E matrix jobs):** PASS (stable+tip x ubuntu/windows/macos/arm)
- **test-xk6 (all 8 matrix jobs):** PASS
- **test-latest (4/6 jobs):** PASS
- **test-tip (4/6 jobs):** PASS
- **TruffleHog Secret Scan:** PASS
- **Socket Security:** PASS
- **zizmor:** PASS

### Failing (2 checks):
- `test-latest (1.26.x, ubuntu-22.04)` - **FAIL**
- `test-tip (ubuntu-22.04, ubuntu-22.04)` - **FAIL**

**Root cause:** These are **Browser tests** (Chromium) that fail with `Failed to connect to the bus: Could not parse server address` and `signal: trace/breakpoint trap (core dumped)`. This is a **pre-existing infrastructure flake** on the ubuntu-22.04 runner, NOT caused by this PR. Confirmed by:
- Recent master runs also show browser test failures on the same runner
- The failures are in `internal/js/modules/k6/browser/tests/`, completely unrelated to `metrics/tags.go`
- All other ubuntu runners (ubuntu-latest, ubuntu-24.04-arm, ubuntu-arm64-large) pass

### Pending (1 check):
- `license/cla` - **PENDING** (not signed)

### Mergeable status:
- `mergeable`: MERGEABLE (no conflicts)
- `mergeStateStatus`: BLOCKED (due to pending CLA check)

---

## 3. MAINTAINER FEEDBACK - VERBATIM

### mstoykov's comment (the only maintainer review comment):
> "Thanks for the change. Can you try to use this in the actual code, not just have it as new methods."

**Author:** mstoykov (association: contributor - this is Mihail Stoykov, a core k6 maintainer and the author of the `atlas` library itself)

### How to interpret "try to use this in the actual code":

This is a request to **refactor existing k6 code** to use `ForEach` instead of raw atlas.Node walking. Specifically:

1. **`MarshalEasyJSON` in `metrics/tags.go`** (lines ~108-120 in the current master) already does the EXACT same manual atlas.Node walk that ForEach encapsulates:
   ```go
   n := (*atlas.Node)(ts)
   for !n.IsRoot() {
       prev, key, value := n.Data()
       // ... use key, value ...
       n = prev
   }
   ```
   This should be refactored to:
   ```go
   ts.ForEach(func(key, value string) {
       // ... use key, value ...
   })
   ```

2. **Any other places in k6's own codebase** that call `ts.Map()` solely to iterate over tags (where a map allocation is unnecessary) should be converted to use `ForEach` instead.

This is a standard open-source maintainer pattern: "don't just add API surface area; prove it's useful by using it to improve existing code." The PR currently adds new methods but doesn't demonstrate their value by refactoring existing code to use them.

**This is the highest-priority code change needed** (after signing the CLA).

---

## 4. COMPETING PR: #5767

PR #5767 (`feat(metrics): add Len() and Iterate() to TagSet`) by `mail2sudheerobbu-oss` was:
- Opened March 27 (one day BEFORE #5770)
- Named the method `Iterate` instead of `ForEach`
- Had one approval from @szkiba ("LGTM")
- **CLOSED on April 8** by maintainer @inancgumus with the comment: "We've decided to close this PR. We'll continue with the other PR."

This means the k6 maintainers have **explicitly chosen PR #5770 over #5767**. The `ForEach` naming won. This is a positive signal - the maintainers want to proceed with YOUR PR.

However, #5767 had already received an approval and addressed linter issues. The bar is now higher: #5770 needs to be at least as good as #5767 AND address mstoykov's additional request to use ForEach in actual code.

---

## 5. CODE QUALITY REVIEW

### Diff analysis (`metrics/tags.go` changes):

#### `Len()` method:
```go
func (ts *TagSet) Len() int {
    return ((*atlas.Node)(ts)).Len()
}
```
- **Correctness:** PASS. Delegates to `atlas.Node.Len()`, which recursively counts `prev.Len() + 1`. Handles overwrites correctly because `AddLink`/`add()` restructures the chain when a key is overwritten (same key at same level replaces rather than appending).
- **Nil safety:** The `atlas.Node` methods don't check for nil. However, `TagSet` instances are always created from `Registry.RootTagSet()` which returns a non-nil root node, and all operations (`With`, `Without`, `WithTagsFromMap`) preserve non-nil. So nil is not a realistic concern in practice, consistent with how other TagSet methods (Contains, IsEmpty, Map) also don't nil-check.
- **Go conventions:** PASS. Clean one-liner, consistent with the existing `IsEmpty()`, `Contains()`, `Get()` pattern.

#### `ForEach()` method:
```go
func (ts *TagSet) ForEach(fn func(key, value string)) {
    n := (*atlas.Node)(ts)
    for !n.IsRoot() {
        prev, key, value := n.Data()
        fn(key, value)
        n = prev
    }
}
```
- **Correctness:** PASS. Walks the atlas.Node chain from current node back to root, calling `fn` for each key-value pair. This is the same pattern used in `MarshalEasyJSON`.
- **Edge cases:**
  - Empty TagSet (root node): `n.IsRoot()` is true immediately, no callback invoked. CORRECT.
  - Overwritten keys: Only the final value appears because `AddLink`/`add()` restructures. CORRECT.
  - Deleted keys: `Without` calls `DeleteKey` which reconstructs without the key. CORRECT.
- **Concurrent access:** The atlas.Node structure is immutable once created (prev and linkKey are documented as immutable). `ForEach` only reads. Thread-safe. PASS.
- **Go conventions:** PASS. The method name `ForEach` is used by the Go community (e.g., `sync.Map.Range` could be named ForEach). The issue #2764 suggested `Iterate`, but `ForEach` is more descriptive of the callback pattern. `Range` would be the most Go-idiomatic name (matching `sync.Map.Range`), but `ForEach` is acceptable and the maintainers chose it over `Iterate`.

#### Doc comments on `Map()`:
```go
// Note: this method allocates a new map on every call. When you only need to
// iterate over the tags (e.g. to convert them to another format), prefer
// ForEach for better memory efficiency.
```
- **Quality:** PASS. This is exactly what issue #2764 requested: "it seems like it with to mention that `Map` itself is not memory efficient so extension developers can learn it earlier."
- **Go convention note:** The existing `Map()` had no doc comment. The PR adds one with a `Note:` section. This is fine.

### Tests (`metrics/tags_test.go` changes):

#### `TestTagSetLen`:
- Tests empty (root), 1 tag, 2 tags, overwritten key
- The overwrite test (`root.With("a","1").With("a","2")`) is the critical edge case -- GOOD.
- Uses `t.Parallel()` -- GOOD.

#### `TestTagSetForEach`:
- `empty` subtest: verifies no callbacks on root -- GOOD.
- `collects all pairs`: builds tags, collects via ForEach into a map, asserts equality with `Map()` -- GOOD.
- `matches Map output`: uses `With`, `WithTagsFromMap` (with overwrite), and `Without` -- comprehensive. Asserts ForEach and Map produce identical results -- GOOD.
- Uses `t.Parallel()` -- GOOD.

#### `BenchmarkTagSetIteration`:
- Benchmarks Map vs ForEach with 10 tags -- GOOD.
- `b.ReportAllocs()` -- GOOD (issue #2764 explicitly asked for benchmarks).
- Includes realistic `Map_to_labels` vs `ForEach_to_labels` scenario -- GOOD.
- Uses `range b.N` syntax (Go 1.22+) -- k6 requires Go from go.mod, should be fine.
- Results show ~88x speedup for raw iteration, ~8x for realistic label building. Strong case.

### ISSUES FOUND:

1. **CRITICAL: mstoykov's request not addressed.** ForEach is not used in actual code. `MarshalEasyJSON` still does manual atlas.Node walking. This will likely block merge.

2. **MINOR: Method naming.** The issue #2764's suggested solution used `Iterate`. The competing PR #5767 also used `Iterate`. This PR uses `ForEach`. The maintainers seem to prefer `ForEach` (they closed #5767 in favor of this PR), but it's worth noting. `Range` would be most Go-idiomatic (matching `sync.Map`), but `ForEach` has been implicitly accepted.

3. **MINOR: ForEach could short-circuit with early return.** The current signature `func(key, value string)` doesn't support stopping iteration early. A `func(key, value string) bool` signature (return false to stop) is more flexible and matches `sync.Map.Range`. However, this is a design choice and the maintainers haven't requested it. The issue's suggested solution also used `func(key, value string)`.

4. **MINOR: Benchmark uses `range b.N` (Go 1.22+ syntax).** This should be fine for k6 (which targets 1.22+), but verify against go.mod.

---

## 6. RELATED ISSUES/PRs SUMMARY

| Reference | Status | Relationship |
|---|---|---|
| Issue #2764 "Extend the metrics.TagSet API" | OPEN | The issue this PR closes. Labeled: good first issue, ux, feature, xk6 |
| PR #5767 (mail2sudheerobbu-oss) | CLOSED (Apr 8) | Competing PR, closed in favor of #5770 |
| xk6-output-prometheus-remote PR #55 | CLOSED | Original discussion where the need was identified |
| a-organvm issue #41 | OPEN | Internal tracking issue (ours) |

---

## 7. ACTION ITEMS (Priority Order)

### Must-Do Before Merge:

1. **Sign the CLA.** Go to https://cla-assistant.io/grafana/k6?pullRequest=5770. This is a hard blocker. If the CLA assistant has issues, comment on the PR asking a maintainer to re-check.

2. **Address mstoykov's feedback: use ForEach in actual code.** Refactor `MarshalEasyJSON` in `metrics/tags.go` to use `ts.ForEach()` instead of manual atlas.Node walking. This is the minimum. If there are other places in the k6 codebase where `.Map()` is used just to iterate, converting those too would strengthen the PR.

### Should-Do:

3. **Consider if `Range` is a better name** than `ForEach` (matching `sync.Map.Range`). The maintainers may or may not care, but it's worth being prepared if asked.

4. **Consider adding `bool` return to the callback** for early termination (matching `sync.Map.Range` pattern). Again, only if asked.

### Nice-to-Have:

5. **Add a comment on the PR** acknowledging the browser test failures are pre-existing (PR #5767's author already did this analysis, and it would show due diligence).

---

## 8. RISK ASSESSMENT

| Risk | Level | Notes |
|---|---|---|
| CLA not signed | HIGH | Hard blocker. Must be resolved. |
| mstoykov's request unaddressed | HIGH | Likely blocks merge. Easy fix. |
| Code correctness | LOW | Implementation is sound. Tests are comprehensive. |
| Browser test failures | NONE | Pre-existing flake, unrelated to PR. |
| Merge conflicts | LOW | Currently mergeable, but PR is 16 days old. |
| Competing PRs | RESOLVED | #5767 was closed in favor of #5770. |
