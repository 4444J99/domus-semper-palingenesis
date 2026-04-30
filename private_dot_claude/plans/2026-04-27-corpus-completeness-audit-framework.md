# Plan: Corpus Completeness Audit Framework Research

**Date**: 2026-04-27  
**Status**: Research (Theoretical Specification Complete)  
**Mode**: Study/Assemble/Test/Research  

---

## Research Origin

User exported a Cursor chat (`cursor_prompt_structure_and_intrinsic_v.md`) auditing prompt engineering, temporal comparison, and completeness methodology. Request was "all above" - meaning full scope across Workspace.

---

## What Was Researched

### A. Universe Definition
- **Scope**: `/Users/4jp/Workspace/` with known exclusions (.git, node_modules, vendor, dist, build, .cache, __pycache__)
- **Extensions**: `.md`, `.txt`, `.rst`, `.tex`, `.adoc`
- **Exclusions**: `.archive/`, `intake/`, mirrored distributions

### B. Detection Queries Built
- File counting (multiple methods for truncation detection)
- Category globs (LAW, GOVERNANCE, SPEC, CLAUDE.md, AGENTS.md, SKILL.md)
- Cross-reference inventories

### C. Cross-References
- LAW files: ~3 found
- GOVERNANCE files: ~18 found
- SPEC files: ~53 found
- CLAUDE.md: ~100+ found
- AGENTS.md: ~100+ found
- SKILL.md: ~833 found
- Writing files (total): ~74,963 (with .txt + .md)

### D. Implemented vs Aspirational
- **Implemented**: Extraction/registry/governance pipelines
- **Aspirational**: Mode B (Invention) - full synthesis engines

---

## The Theoretical Specification Produced

**Output**: `/Users/4jp/Workspace/organvm/research-atlas/docs/technical/AUDIT_FRAMEWORK_SPEC.md`

**Contents**:
1. PART I: Ontological Foundation (what completeness means)
2. PART II: Threat Model (8 families, 30+ failure modes)
3. PART III: Success Modes (4 evidence standards)
4. PART IV: Full Loop - Omega Alpha to Omega (6 phases)
5. PART V: Ideal Form (canonical package structure)
6. PART VI: Failure Recovery (escape valves)
7. PART VII: Theoretical Extensions (continuous, federated, crypto)
8. PART VIII: Appendices (quick reference, commands, questionnaires)

---

## Key Findings

### Current State
| Category | Confidence | Evidence |
|----------|------------|----------|
| Rules/Governance | ~70% | Partial enumeration |
| Configuration | ~60% | Broad but imprecise |
| Skills | ~85% | High coverage |
| Writing | ~40% | Glob count only |

### Gaps Identified
1. No comprehensive enumeration with hashes
2. No canonical source markers
3. No invariant testing (for governance consistency)
4. No adversarial testing (threat model not applied)
5. No self-reference containment

---

## Execution Path (Future)

To move from theoretical spec to executed audit:

### Phase 1: Pre-Audit (REQUIRES USER INPUT)
- [ ] Declare universe boundaries
- [ ] Define canonical authority
- [ ] Set confidence threshold

### Phase 2: Discovery
- [ ] Run multiple method counts
- [ ] Detect truncation variance
- [ ] Flag anomalies

### Phase 3: Enumeration
- [ ] Generate SHA-256 manifest
- [ ] Deduplicate by hash
- [ ] Mark canonical authority

### Phase 4: Invariant Testing
- [ ] Test declared constraints
- [ ] Report violations
- [ ] Fix or document

### Phase 5: Adversarial Testing
- [ ] Run all 8 threat family probes
- [ ] Document detections
- [ ] Update threat model

### Phase 6: Delivery
- [ ] Produce audit package
- [ ] Sign-off mechanism
- [ ] Next audit plan

---

## Plan Metadata

- **Created**: 2026-04-27
- **Version**: 1.0
- **Confidence**: 100% (theoretical spec complete)
- **Next**: User directs execution phase

---

**END PLAN**