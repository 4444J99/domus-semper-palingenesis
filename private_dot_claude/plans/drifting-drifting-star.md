# Plan: First Interview Conversion — Grafana Staff AI Engineer

## Context

On 2026-03-31, Ryan McKellips (Recruiter, Grafana Labs) sent an interview invitation for the **Staff AI Engineer, People Technology | NASA | Remote** position. This is the pipeline's **first positive conversion to interview stage** — a milestone that activates tooling never before exercised in production.

**Problem:** This role has no pipeline entry. It was applied to outside the pipeline (directly on Greenhouse). The 16 Grafana entries in `closed/research/` are all different roles. We need to retroactively create the pipeline entry, record the full conversion chain, and prepare for the interview.

**Outcome:** Entry exists, conversion logged, contact logged, status at `interview`, interview prep generated, scheduling link opened in browser.

## Execution Sequence

### Step 1: Create Pipeline Entry
Create `pipeline/submitted/grafana-labs-staff-ai-engineer-people-technology-nasa-remote.yaml` with:
- `id: grafana-labs-staff-ai-engineer-people-technology-nasa-remote`
- `status: interview` (entering at current state — it's already past submitted/acknowledged)
- `track: job`
- `target.organization: Grafana Labs`
- `target.portal: greenhouse`
- `target.application_url`: find from Greenhouse job boards (search for the posting)
- `target.location: Remote (NASA team)`
- `target.location_class: us-remote` (confirm from posting)
- `fit.identity_position: platform-orchestrator` or `independent-engineer` (determine from role)
- `timeline.submitted`: approximate date (check email history for original application confirmation)
- `timeline.acknowledged: '2026-03-31'`
- `timeline.interview: '2026-04-01'` (today — when we're actioning it)

Reference: Use existing submitted entry YAML shape (e.g. `anthropic-engineering-editorial-lead.yaml`) and `_schema.yaml` for field structure.

### Step 2: Search Gmail for Original Application
Search Gmail for Grafana application confirmation to find:
- Exact submission date → `timeline.submitted`
- Application URL / job ID
- Any prior correspondence

### Step 3: Log Ryan McKellips as Contact
Run: `python scripts/crm.py --add --name "Ryan McKellips" --org "Grafana Labs" --role "Recruiter" --channel linkedin`
Then link to entry: `python scripts/crm.py --link --name "Ryan McKellips" --entry grafana-labs-staff-ai-engineer-people-technology-nasa-remote`

### Step 4: Log Conversion Event
Append to `signals/conversion-log.yaml` with the standard schema:
```yaml
- id: grafana-labs-staff-ai-engineer-people-technology-nasa-remote
  submitted: '<date from Step 2>'
  track: job
  identity_position: <determined>
  blocks_used: []  # applied outside pipeline
  variant_id: null
  channel: direct
  portal: greenhouse
  resume_variant: null  # unknown — applied outside pipeline
  cover_letter_present: false  # unknown
  custom_answers: true  # Greenhouse always has questions
  follow_up_count: 0
  outcome: null
  outcome_stage: null
  response_date: '2026-03-31'
  time_to_response_days: <calculated from submission date>
  feedback: null
```

### Step 5: Log Signal Action
Use `log_signal_action.py` or manually append to `signals/signal-actions.yaml`:
- Signal: first interview conversion
- Action: advance to interview, schedule screen

### Step 6: Advance Entry (already at interview via creation, but log the audit trail)
Run: `python scripts/advance.py --id grafana-labs-staff-ai-engineer-people-technology-nasa-remote --to interview`
(May need to handle the fact that entry was created at `interview` — if advance.py complains, the audit log from Step 5 covers it.)

### Step 7: Generate Interview Prep
Run: `python scripts/interview_prep.py --target grafana-labs-staff-ai-engineer-people-technology-nasa-remote`
This produces: `pipeline/submissions/grafana-labs-staff-ai-engineer-people-technology-nasa-remote-interview-prep.md`

### Step 8: Schedule the Call
Open the scheduling link from the email in Chrome browser using `mcp__claude-in-chrome__navigate`.

### Step 9: Save Memory
Log this milestone as a project memory — first interview conversion, date, role, pipeline gap identified (applied outside pipeline), lessons learned.

## Critical Files
- `pipeline/submitted/grafana-labs-staff-ai-engineer-people-technology-nasa-remote.yaml` (CREATE)
- `signals/contacts.yaml` (MODIFY — add Ryan McKellips)
- `signals/conversion-log.yaml` (MODIFY — append entry)
- `signals/signal-actions.yaml` (MODIFY — append audit entry)
- `pipeline/submissions/` (CREATE — interview prep doc)
- `scripts/crm.py` — contact management
- `scripts/interview_prep.py` — prep doc generator
- `scripts/advance.py` — status advancement with audit logging
- `scripts/log_signal_action.py` — signal audit trail
- `scripts/check_outcomes.py` — outcome recording (for reference)
- `pipeline/_schema.yaml` — entry field reference

## Verification
1. `python scripts/validate.py` — schema validation passes with new entry
2. `python scripts/interview_prep.py --target grafana-labs-staff-ai-engineer-people-technology-nasa-remote` — prep doc generates
3. `python scripts/crm.py --org "Grafana Labs"` — Ryan McKellips appears
4. `python scripts/standup.py` — new entry shows in interview section
5. `grep grafana signals/conversion-log.yaml` — conversion logged
6. `pytest tests/ -v -k "not synthetic"` — no regressions
