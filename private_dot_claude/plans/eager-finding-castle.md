# Fix Job Posting Date Accuracy — Eliminate Stale Listings

## Context

The freshness filter in `source_jobs.py` is operating on proxy data, not real posting dates. For Greenhouse (the majority of our sources — Coinbase, Toast, Airtable, etc.), the code uses `updated_at` instead of `first_published`. A Coinbase job posted **January 23** but edited **March 29** passes as "1 day old." The 72-hour freshness filter (`FRESH_ONLY_MAX_HOURS`) is meaningless when operating on update timestamps.

**Verified against live APIs:**
- Greenhouse: has `first_published` field (e.g., `2026-01-23T09:03:55-05:00`) alongside `updated_at` (`2026-03-29T22:26:56-04:00`). Currently using `updated_at` only.
- Ashby: has `publishedAt` field. Code looks for `publishedDate` (wrong name), misses it, falls back to `updatedAt`.
- Lever: uses `createdAt` — already correct (true creation date).
- SmartRecruiters: uses `releasedDate` — likely correct.
- Workable: uses `published_on` — likely correct.

**Impact:** All 19 active qualified job entries were sourced 2026-03-30. We cannot confirm any of them are actually fresh postings. The pipeline's precision-over-volume strategy depends on applying to recent openings where the applicant pool is small.

## Changes

### 1. Greenhouse: use `first_published` instead of `updated_at`

**File:** `scripts/source_jobs.py`, `fetch_greenhouse_jobs()` (~line 347)

```python
# Before:
raw_date = job.get("updated_at", "")
posting_date = raw_date[:10] if raw_date else None

# After:
raw_date = job.get("first_published") or job.get("updated_at", "")
posting_date = raw_date[:10] if raw_date else None
```

`first_published` is available on both list and detail endpoints (verified). Falls back to `updated_at` if `first_published` is missing (defensive).

### 2. Ashby: fix field name `publishedDate` → `publishedAt`

**File:** `scripts/source_jobs.py`, `fetch_ashby_jobs()` (~line 456)

```python
# Before:
raw_date = job.get("publishedDate") or job.get("updatedAt", "")

# After:
raw_date = job.get("publishedAt") or job.get("updatedAt", "")
```

The API returns `publishedAt` (verified). The code used the wrong field name and was silently falling through to `updatedAt` every time.

### 3. Add `date_confidence` field to pipeline entries

**File:** `scripts/source_jobs.py`, `create_pipeline_entry()` (~line 818-822)

Add a `date_confidence` field to the timeline section so downstream consumers know whether the date is trustworthy:

```python
"timeline": {
    "researched": today,
    "posting_date": job.get("posting_date"),
    "date_source": job.get("date_source", "unknown"),  # NEW
    "date_added": today,
    "discovered": datetime.now(UTC).isoformat(),
},
```

Each fetcher will set `date_source` on the job dict:
- Greenhouse: `"first_published"` (or `"updated_at_fallback"` if `first_published` missing)
- Lever: `"created_at"`
- Ashby: `"published_at"` (or `"updated_at_fallback"`)
- SmartRecruiters: `"released_date"`
- Workable: `"published_on"`
- JobSpy: `"jobspy_date_posted"`

### 4. Reject null-date jobs from freshness filter

**File:** `scripts/source_jobs.py`, `filter_by_freshness()` (~line 729-745)

Currently: "Jobs with no posting_date are treated as fresh (benefit of the doubt)."

Change to: Jobs with no posting_date are treated as **stale** (no benefit of the doubt). If we can't verify freshness, we don't risk applying to a months-old listing.

```python
# Before:
if hours is not None and hours > max_hours:
    skipped.append(job)
else:
    fresh.append(job)

# After:
if hours is None:
    skipped.append(job)  # No date = not trusted
elif hours > max_hours:
    skipped.append(job)
else:
    fresh.append(job)
```

### 5. Tests

**File:** `tests/test_source_jobs.py`

Add tests for:
- `test_greenhouse_uses_first_published` — mock API response with both `first_published` and `updated_at`, verify `posting_date` uses `first_published`
- `test_greenhouse_falls_back_to_updated_at` — mock API response without `first_published`, verify fallback
- `test_ashby_uses_published_at` — mock API response with `publishedAt`, verify correct extraction
- `test_filter_freshness_rejects_null_date` — verify jobs without `posting_date` are filtered out
- `test_filter_freshness_passes_recent` — verify jobs within window pass
- `test_filter_freshness_rejects_old` — verify jobs outside window are rejected
- `test_date_source_set_per_portal` — verify each fetcher sets `date_source`

## Files Modified

| File | Change |
|------|--------|
| `scripts/source_jobs.py` | Fix Greenhouse date field, fix Ashby field name, add `date_source`, reject null dates |
| `tests/test_source_jobs.py` | 7 new tests for date accuracy |

## Verification

1. Run the fixed freshness tests: `.venv/bin/python -m pytest tests/test_source_jobs.py -v`
2. Dry-run against live APIs to see the date delta:
   ```bash
   source .venv/bin/activate && python scripts/source_jobs.py --fetch --dry-run 2>&1 | head -40
   ```
   Verify that posting dates now show actual first-published dates (many will be weeks/months old and get filtered).
3. Run full test suite: `.venv/bin/python -m pytest tests/ -q -k "not test_wiring_rubric"`
4. Check that existing pipeline entries are unaffected (this only changes future sourcing behavior)
