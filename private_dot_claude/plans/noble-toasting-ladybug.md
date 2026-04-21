# Zeitgeist Carrier Wave — Research Dispatch Plan

**Date:** 2026-04-21
**Slug:** `2026-04-21-zeitgeist-carrier-wave-dispatch`

## Context

Anthony articulated a foundational thesis: the medium that speaks to the most people shifts across eras (rock → cinema → TV → internet → fragmentation). His life trajectory — writer at 10, across books, screenplays, music, film, systems — mirrors the macro-cultural shift. ORGANVM is, in part, infrastructure for the hypothesis that systems/architecture may be the next carrier wave.

This thesis needs research, essays, a formal thesis document, and a dissertation-length work. It is not a side project — it is the intellectual foundation for why ORGANVM exists.

**The operations gap:** Gemini, Codex, OpenCode, and Perplexity are paid for but idle. Research and writing is exactly where they should earn their keep. Claude handles architecture and cross-verification. Everything else dispatches.

## Existing Infrastructure (already built, not being used)

| Asset | Location | Status |
|-------|----------|--------|
| Essay pipeline (Python automation) | `~/Workspace/organvm/essay-pipeline/` | Built, has drafter/validator/indexer |
| 16 published essays | `~/Workspace/organvm/public-process/essays/` | Live |
| Essay publishing SOP | `~/Workspace/organvm/praxis-perpetua/standards/SOP--essay-publishing-and-distribution.md` | Active |
| Conversation-to-content SOP | `~/Workspace/organvm/praxis-perpetua/standards/SOP--conversation-to-content-pipeline.md` | Active |
| Research synthesis skill | `~/Workspace/organvm/a-i--skills/skills/knowledge/research-synthesis-workflow/` | Available |
| Creative writing skill | `~/Workspace/organvm/a-i--skills/skills/creative/creative-writing-craft/` | Available |
| Source evaluation skill | `~/Workspace/organvm/a-i--skills/skills/knowledge/source-evaluation-bibliography/` | Available |
| Narratological lenses | `~/Workspace/organvm/narratological-algorithmic-lenses/` | Built |
| Cognitive archaeology tribunal | `~/Workspace/organvm/cognitive-archaelogy-tribunal/` | Built |
| Knowledge graph builder | `~/Workspace/organvm/a-i--skills/skills/knowledge/knowledge-graph-builder/` | Available |
| Multi-agent workforce planner | `~/Workspace/organvm/a-i--skills/skills/tools/multi-agent-workforce-planner/` | Available |

**What does NOT exist yet:** No media theory research. No Bowie/McLuhan/Benjamin sources gathered. No thesis outline. No annotated bibliography. Zero existing work on the carrier wave argument itself.

## The Thesis (working statement)

> The dominant medium of cultural influence shifts across eras — from music (1960s-70s) to cinema (1980s-90s) to television (2000s) to internet (2010s) — each concentrating collective attention into a channel through which creators could reach the zeitgeist. The current era is defined by the fragmentation of that channel: no single medium now carries the cultural voltage that rock or cinema once did. The next carrier wave is not a medium but a system — recursive infrastructure that operates across every fragmented channel simultaneously.

## Agent Fleet Dispatch — Who Does What

### Gemini (research velocity + drafting)
**Cognitive class:** tactical/content  
**Strengths:** web research, summarization, long-document processing, draft generation  

Assigned work:
1. **Literature survey** — find, read, and summarize key texts on medium theory, attention economics, cultural influence shifting across media eras
2. **Source annotation** — for each source, produce: key argument, relevant quotes, connection to thesis, counter-arguments
3. **Biographical research** — Bowie interviews (especially 1999 BBC Paxman, early rock interviews), Tarantino/Rodriguez interviews, McLuhan media appearances
4. **Essay drafts** — first drafts of exploratory essays, working from thesis outline and source annotations
5. **Historical data** — concert attendance trends, album sales trajectories, box office data, TV viewership peaks, internet adoption curves — the empirical evidence for medium-shift

### Perplexity (source discovery + fact verification)
**Cognitive class:** tactical/research  
**Strengths:** web search, citation finding, fact-checking  

Assigned work:
1. **Source discovery** — find academic papers, books, essays on medium theory not in the obvious canon
2. **Fact verification** — confirm dates, quotes, attributions (especially Bowie interview provenance)
3. **Contemporary evidence** — current data on attention fragmentation, platform economics, audience behavior
4. **Counter-thesis research** — find the strongest arguments against the carrier wave hypothesis

### Codex (structured assembly + pipeline code)
**Cognitive class:** mechanical  
**Strengths:** code scaffolding, structured data, template generation  

Assigned work:
1. **Annotated bibliography scaffold** — structured YAML/JSON for all sources with metadata, tags, relevance scores
2. **Essay pipeline extensions** — if the existing `essay-pipeline/` needs new modules for thesis-grade work (chapter assembly, citation management, cross-reference generation)
3. **Thesis template** — document structure scaffolding (LaTeX or Markdown) for the full dissertation
4. **Data visualization** — charts/graphs for the empirical evidence (medium adoption curves, attention data)

### OpenCode (well-scoped infrastructure)
**Cognitive class:** mechanical  
**Strengths:** focused repo-level code changes  

Assigned work:
1. **Knowledge graph integration** — wire the bibliography and source annotations into the knowledge-graph-builder skill
2. **Research index** — build a queryable index of all gathered research for cross-referencing during writing
3. **Pipeline testing** — ensure essay-pipeline handles thesis-length documents, chapter ordering, citation chains

### Claude (architecture + cross-verification)
**Cognitive class:** strategic  
**Strengths:** argument design, structural coherence, quality gates  

Reserved work:
1. **Thesis architecture** — chapter structure, argument flow, the shape of the dissertation
2. **Cross-verification** — review all agent output for accuracy, coherence, alignment with the thesis
3. **Structural editing** — reorganize and sharpen drafts after Gemini produces them
4. **Synthesis** — the moments where multiple research threads need to be woven into a single argument
5. **Voice governance** — ensure all published writing meets the voice constitution

## Research Phases

### Phase 0: Foundation (immediate)
- [ ] Create a research repo (or designate an existing one) for the carrier wave thesis
- [ ] Build the initial reading list from the thinkers identified in memory (McLuhan, Benjamin, Postman, Kittler, Manovich, Debord, Bowie, Tarantino, Wu, Odell, Srnicek, Bratton)
- [ ] Create handoff envelopes for Gemini (literature survey) and Perplexity (source discovery)

### Phase 1: Literature Review (Gemini + Perplexity)
- [ ] Gemini: survey and annotate the canonical texts
- [ ] Perplexity: discover non-obvious sources, academic papers, counter-arguments
- [ ] Codex: build the annotated bibliography scaffold
- [ ] Claude: review and organize the bibliography, identify gaps

### Phase 2: Argument Architecture (Claude)
- [ ] Design the thesis structure — chapters, argument sequence, evidence mapping
- [ ] Map each source to its role in the argument
- [ ] Identify the autobiographical thread placement (personal trajectory as evidence)
- [ ] Write the thesis outline as a plan artifact

### Phase 3: Exploratory Essays (Gemini + Claude)
- [ ] Write 4-6 essays that become proto-chapters:
  - The Bowie thesis (rock as zeitgeist access)
  - The filmmaker-as-rock-star moment (Tarantino/Rodriguez/90s indie)
  - McLuhan revisited (the medium is the message → the system is the message)
  - The fragmentation (why you can't fill a theater anymore)
  - The personal trajectory (writer → filmmaker → system builder)
  - The hypothesis (systems as the next carrier wave)
- [ ] Gemini drafts, Claude edits, publish through essay-pipeline

### Phase 4: Thesis Assembly (all agents)
- [ ] Codex: assemble chapter scaffolding from essays + research
- [ ] Gemini: expand sections, fill evidentiary gaps
- [ ] Claude: structural editing, argument coherence, voice
- [ ] OpenCode: citation management, cross-references, index generation

### Phase 5: Dissertation (Claude + Gemini)
- [ ] Expand thesis to dissertation length with full scholarly apparatus
- [ ] Gemini: additional research passes for depth
- [ ] Claude: final structural and argumentative review

## Dispatch Mechanics — How to Actually Do This

The dispatch protocol (`conductor_fleet_dispatch` → `conductor_fleet_guardrailed_handoff`) generates envelopes for each agent. For this project:

1. **Each phase produces handoff envelopes** — markdown documents that brief the target agent with full context, constraints, expected output format, and quality gates
2. **Return-to-Claude verification** — every agent's output gets cross-verified before it feeds the next phase
3. **The research repo** is the shared artifact — all agents commit to it, Claude verifies

### Immediate next action
Create the first handoff envelopes:
- **Gemini envelope:** "Survey these 12 thinkers. For each: summarize their core argument about media/culture, extract 3-5 key quotes, rate relevance to the carrier wave thesis on 1-5, identify counter-arguments. Output as structured markdown."
- **Perplexity envelope:** "Find academic papers published 2015-2026 on: attention fragmentation, medium theory post-internet, platform as cultural form, systems as medium. For each: title, author, year, abstract summary, URL. Minimum 20 sources."

## Verification

- [ ] Research repo exists with initial reading list
- [ ] First Gemini handoff envelope generated and dispatched
- [ ] First Perplexity query dispatched
- [ ] Codex bibliography scaffold committed
- [ ] At least one essay drafted and in pipeline within 2 weeks

## Critical Files to Modify/Create

| File | Action |
|------|--------|
| New research repo or designated existing repo | Create/designate |
| Handoff envelopes for Gemini, Perplexity, Codex | Create |
| `~/Workspace/organvm/essay-pipeline/` | Verify handles thesis-grade work |
| Research synthesis skill | Activate for this project |
| Memory: `project_zeitgeist_thesis.md` | Already created (2026-04-21) |
