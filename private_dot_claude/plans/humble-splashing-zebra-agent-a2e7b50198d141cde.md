# Implementation Plan: sign-signal--voice-synth Layer 1 (Speech Score Engine)

**Date**: 2026-03-31
**Status**: READY FOR EXECUTION
**Target**: Complete Phase 1-9 of Dialogue Looping Tracker Sequence

---

## 0. State of the World (Audit Summary)

### What Exists
- **Root**: `package.json` (npm workspaces), `docker-compose.yml` (Postgres 16 + Redis 7 + api + web), `.env.example`, `seed.yaml`
- **apps/web**: Next.js 14 scaffold with 1 landing page, Tailwind configured, tsconfig with path aliases
- **apps/api**: FastAPI stub (`main.py`) with 2 endpoints (`/` and `/health`), CORS for localhost:3000
- **packages/db**: Prisma schema (5 models, 4 enums), `@prisma/client` dep declared
- **packages/shared**: TypeScript types (all entities + input/output shapes)
- **specs/**: Complete spec, data model, API contracts, plan, research, tasks (60 tasks, 9 phases)
- **ChatGPT transcripts**: 8 documents with bakery demo content, 4 MVP screen specs, share link model, diagnostics model

### What Does NOT Exist
- No `node_modules` anywhere (zero deps installed)
- No Prisma migrations (no `prisma/migrations/` directory)
- No `.gitignore` inside sign-signal--voice-synth (parent superproject has one but it's exclusion-based for submodules)
- No `README.md` for the project
- No `CLAUDE.md` for the project
- No Python dependency file (`requirements.txt`, `pyproject.toml`) -- the API has a `package.json` listing Python deps, which is wrong
- No Dockerfile for api or web (referenced in docker-compose but not created)
- No test files anywhere
- No application logic beyond 2 stub endpoints and 1 landing page
- Conda is NOT installed (spec says Python 3.11 via Anaconda; system has Python 3.14 from Homebrew)
- No bakery demo seed data
- No share_link model in Prisma schema (exists in ChatGPT transcripts)
- No diagnostic_report model (exists in ChatGPT transcripts)

### Critical Schema Discrepancies (Prisma vs Spec)

The existing `schema.prisma` diverges from `data-model.md` in these ways:

| Issue | schema.prisma | data-model.md | Resolution |
|-------|--------------|---------------|------------|
| PhraseEvent text field | `textContent` | `text` | Use `text` (spec), add `@map("text_content")` if needed |
| PhraseEvent index field | `phraseIndex` | `index` | Use `index` (spec) -- but `index` is reserved in some ORMs; keep `phraseIndex` but alias in API |
| VoiceProfile model field | `modelKey` | `model` | Use `model` (spec) |
| VoiceProfile name field | `displayName` | `name` | Use `name` (spec) |
| VoiceProfile settings | MISSING | `Json @default("{}")` | Add it |
| Speaker speechRate/pitchOffset | MISSING (on VoiceProfile instead) | On Speaker model | Move to Speaker per spec |
| Speaker.voiceProfileId | `@unique` | Not unique | Remove @unique (many speakers can share a voice profile) |
| Version label field | `versionLabel` | `label` | Use `label` (spec) |
| Version snapshot | Split: `rawTextSnapshot` + `phrasesSnapshot` | Single `snapshot Json` | Use single JSON snapshot (spec) |
| Enum usage | Enums declared but fields use String | Fields should use enum types | Use proper enum types |
| VoiceProfile.isDefault | MISSING | `Boolean @default(false)` | Add it |
| Missing models | - | ShareLink, DiagnosticReport | Add (from ChatGPT transcripts) |

### Structural Problem: API package.json

`apps/api/package.json` lists Python packages (fastapi, uvicorn, pydantic, etc.) as npm dependencies. This is architecturally wrong. The Python backend needs:
- `pyproject.toml` or `requirements.txt` for Python deps
- The package.json should be replaced with proper Python project config
- The npm workspace entry should likely remain for monorepo scripts (dev, build commands) but deps are Python-managed

### Environment Mismatch

- Spec says "Python 3.11 via Anaconda" but conda is not installed
- System Python is 3.14 (Homebrew)
- **Resolution**: Use `pyenv` or system Python 3.14 (FastAPI and all listed deps support 3.14). Document the change. Alternatively create a conda env if user installs miniconda.
- Node.js v25.x is available and confirmed

---

## 1. Missing Tasks (Not in tasks.md but Required)

These items are mentioned in the ChatGPT transcripts and architecture decisions but have no corresponding task in `tasks.md`:

| ID | Task | Source | Insert Before |
|----|------|--------|---------------|
| T000a | Create .gitignore for sign-signal--voice-synth | User requirement | T001 |
| T000b | Create README.md | User requirement | T001 |
| T000c | Create CLAUDE.md for the project | User requirement | T001 |
| T000d | Replace apps/api/package.json with pyproject.toml | Scaffold error | T002 |
| T000e | Create Dockerfiles for api and web | docker-compose.yml references them | T003 |
| T000f | Add ShareLink model to Prisma schema | ChatGPT transcript: $TABLE_SHARE_LINK | T005 |
| T000g | Add DiagnosticReport model to Prisma schema (stub) | ChatGPT transcript: POC Screen 03 | T005 |
| T000h | Create bakery demo seed data fixture | ChatGPT transcript: canonical demo | T010 |
| T000i | Build Screen 01 (New Scene Import) with bakery sample card | ChatGPT POC spec | T013 |
| T000j | Build Screen 02 (Parse Review) with two-column layout | ChatGPT POC spec | T013 |
| T000k | Build Screen 04 (Share View) read-only | ChatGPT POC spec | T045 |
| T000l | Implement share link generation API | ChatGPT transcript | T041 |
| T000m | Create 3 demo version presets (BASE_READ, PACE_SHIFT, HEIGHTENED_RENDER) | ChatGPT transcript | T041 |
| T000n | Fix next.config.js (uses TS import in .js file) | Scaffold error | T001 |

---

## 2. Critical Path

The critical path through the dependency graph is:

```
T000a-e (scaffold fixes) 
  -> T005 (Prisma schema fix + extend) 
    -> T006 (migrations) 
      -> T008 (API route structure) 
        -> T010 (Scene CRUD) 
          -> T011 (Speaker CRUD) 
            -> T012 (PhraseEvent CRUD) 
              -> T015 (phrase list UI) 
                -> T016 (drag-drop reorder) 
                  -> T026 (TTS abstraction) 
                    -> T027 (ElevenLabs) 
                      -> T030 (Redis caching) 
                        -> T033 (sequence audio generation) 
                          -> T035 (play/pause/stop) 
                            -> T037 (visual tracker) 
                              -> T040 (timeline UI)
```

In parallel with T026+: T007 (speaker parser) feeds T010's create-scene-with-parse flow.
In parallel with T033+: T041-T048 (versioning) can start once T010 is done.

---

## 3. Phase-by-Phase Implementation Sessions

### SESSION 1: Foundation Bootstrap
**Goal**: Fix scaffold errors, install dependencies, get Docker services running, create missing project files.
**Estimated duration**: 1 agent session
**Tasks**: T000a, T000b, T000c, T000d, T000e, T001 (complete), T002 (complete), T003 (verify), T004

#### Step 1.1: Create project-level .gitignore
```
# File: sign-signal--voice-synth/.gitignore
node_modules/
.next/
dist/
.env
.env.local
__pycache__/
*.pyc
.pytest_cache/
.ruff_cache/
.mypy_cache/
*.egg-info/
audio/
*.wav
*.mp3
.DS_Store
prisma/migrations/*.sql.bak
coverage/
```

#### Step 1.2: Create README.md
Content: project name, description from seed.yaml, tech stack, setup instructions, development commands.

#### Step 1.3: Create CLAUDE.md
Content: project architecture (monorepo with apps/web, apps/api, packages/db, packages/shared), build commands, test commands, key patterns (TTS provider ABC, Redis caching, WebSocket playback).

#### Step 1.4: Fix Python backend structure
- Delete `apps/api/package.json`
- Create `apps/api/pyproject.toml`:
  ```toml
  [project]
  name = "sign-signal-api"
  version = "0.1.0"
  requires-python = ">=3.11"
  dependencies = [
      "fastapi>=0.109.0",
      "uvicorn[standard]>=0.27.0",
      "pydantic>=2.5.3",
      "prisma>=0.13.0",
      "httpx>=0.26.0",
      "redis[hiredis]>=5.0.1",
      "python-multipart>=0.0.6",
      "websockets>=12.0",
      "elevenlabs>=1.40.0",
  ]
  
  [project.optional-dependencies]
  dev = [
      "pytest>=7.4.4",
      "pytest-asyncio>=0.23.3",
      "ruff>=0.2.0",
  ]
  ```
- Create `apps/api/requirements.txt` (generated from pyproject.toml for Docker)
- Update root `package.json` scripts to use Python commands for api:
  ```json
  "dev:api": "cd apps/api && uvicorn src.main:app --reload --port 8000"
  ```

#### Step 1.5: Create Dockerfiles
- `apps/api/Dockerfile`: Python 3.11-slim, install deps, copy src, run uvicorn
- `apps/web/Dockerfile`: Node 20-alpine, install deps, copy app, run next dev (or build+start)

#### Step 1.6: Rename next.config.js to next.config.mjs (or fix the TS import)
The file uses `import type { NextConfig }` syntax in a `.js` file. Either:
- Rename to `next.config.mjs` and use ES module syntax, or
- Convert to `next.config.js` with CommonJS

#### Step 1.7: Install dependencies
```bash
# From sign-signal--voice-synth root:
npm install

# Python deps (in apps/api):
cd apps/api
python3 -m venv .venv
source .venv/bin/activate
pip install -e ".[dev]"
```

#### Step 1.8: Start Docker services and verify
```bash
docker compose up -d postgres redis
# Wait for health checks
docker compose ps
```

#### Step 1.9: Create .env from .env.example
```bash
cp .env.example .env
```

#### Verification Criteria for Session 1:
- [ ] `npm install` succeeds without errors
- [ ] `pip install` in venv succeeds
- [ ] `docker compose up -d postgres redis` shows healthy services
- [ ] `psql postgresql://postgres:postgres@localhost:5432/sign_signal` connects
- [ ] `redis-cli ping` returns PONG
- [ ] `.gitignore` prevents node_modules, .env, __pycache__ from tracking
- [ ] README.md and CLAUDE.md exist

---

### SESSION 2: Prisma Schema, Migrations, and Shared Types
**Goal**: Fix all schema discrepancies, add missing models, run first migration, generate Prisma client, align shared types.
**Estimated duration**: 1 agent session
**Tasks**: T005, T006, T000f, T000g

#### Step 2.1: Rewrite schema.prisma
Fix all discrepancies identified in Section 0. Final schema should have:

**Models**: Scene, Speaker, PhraseEvent, VoiceProfile, Version, ShareLink, DiagnosticReport

Key changes from current schema:
- Speaker: add `speechRate Float @default(1.0)`, `pitchOffset Int @default(0)`, remove `@unique` from voiceProfileId
- PhraseEvent: enum types for loopMode/durationMode/startTrigger, add `isEmpty Boolean @default(false)`
- VoiceProfile: rename fields to match spec, add `isDefault`, `settings Json`
- Version: single `snapshot Json` field, rename `versionLabel` to `label`
- NEW ShareLink model:
  ```prisma
  model ShareLink {
    id          String    @id @default(uuid())
    versionId   String
    version     Version   @relation(fields: [versionId], references: [id])
    token       String    @unique
    expiresAt   DateTime?
    isRevoked   Boolean   @default(false)
    createdAt   DateTime  @default(now())
    @@index([token])
  }
  ```
- NEW DiagnosticReport model (stub):
  ```prisma
  model DiagnosticReport {
    id          String    @id @default(uuid())
    versionId   String
    version     Version   @relation(fields: [versionId], references: [id])
    metrics     Json
    findings    Json
    createdAt   DateTime  @default(now())
    @@index([versionId])
  }
  ```
- Version needs `shareLinks ShareLink[]` and `diagnostics DiagnosticReport[]` relations

#### Step 2.2: Update packages/shared/src/index.ts
Align TypeScript types with corrected schema:
- Fix field names (textContent -> text, phraseIndex -> index, etc.)
- Add ShareLink, DiagnosticReport interfaces
- Add PlaybackStatus, SceneWithRelations, SceneStats types per API contracts
- Add request/response types for all API endpoints

#### Step 2.3: Generate Prisma client and run migration
```bash
cd packages/db
npx prisma migrate dev --name init_layer_1
npx prisma generate
```

#### Step 2.4: Create packages/db/src/index.ts
Export the Prisma client instance for use by the API:
```typescript
import { PrismaClient } from '@prisma/client'
export const prisma = new PrismaClient()
export * from '@prisma/client'
```

#### Verification Criteria for Session 2:
- [ ] `npx prisma migrate dev` succeeds
- [ ] `npx prisma generate` succeeds
- [ ] Prisma Studio shows all 7 tables: `npx prisma studio`
- [ ] packages/shared types compile: `npm run typecheck -w @sign-signal/shared`
- [ ] All enum values match between Prisma and TypeScript

---

### SESSION 3: Speaker Parser + API Route Structure
**Goal**: Implement the speaker parsing algorithm and set up the FastAPI route structure with error handlers.
**Estimated duration**: 1 agent session
**Tasks**: T007, T008, T009

#### Step 3.1: Implement speaker parser (apps/api/src/services/parser.py)
Function signature:
```python
from dataclasses import dataclass

@dataclass
class ParsedLine:
    speaker: str | None  # None for stage directions
    text: str
    line_type: str  # "spoken" | "stage_direction"
    raw_line: str

def parse_dialogue(raw_text: str) -> list[ParsedLine]:
    """
    Parse raw dialogue text into structured lines.
    Supported patterns:
    - NAME: dialogue text
    - NAME: dialogue text  
    - [STAGE_DIRECTION] descriptive text
    - "NAME" dialogue text
    - NAME. dialogue text
    """
```

Parser rules:
- Detect speaker labels from patterns: `WORD:`, `WORD_WORD:`, uppercase words followed by colon
- Detect stage directions from `[...]` brackets
- Preserve raw text exactly
- Handle the bakery demo format perfectly
- Return list of ParsedLine with detected speakers and line types

#### Step 3.2: Create API route structure

Directory layout for `apps/api/src/`:
```
apps/api/src/
├── main.py              # FastAPI app, middleware, lifespan
├── config.py            # Settings from env vars (pydantic-settings)
├── db.py                # Prisma client initialization
├── dependencies.py      # Shared dependencies (get_db, get_redis)
├── routers/
│   ├── __init__.py
│   ├── scenes.py        # /api/scenes/* 
│   ├── speakers.py      # /api/scenes/{id}/speakers/*
│   ├── phrases.py       # /api/scenes/{id}/phrases/*
│   ├── playback.py      # /api/scenes/{id}/play/*
│   ├── versions.py      # /api/scenes/{id}/versions/*
│   ├── voices.py        # /api/voices/*
│   └── share.py         # /api/share/*
├── services/
│   ├── __init__.py
│   ├── parser.py        # Speaker parsing algorithm
│   ├── tts/
│   │   ├── __init__.py
│   │   ├── base.py      # TTSProvider ABC
│   │   ├── elevenlabs.py
│   │   ├── coqui.py
│   │   └── valle.py
│   ├── playback.py      # Playback engine
│   ├── cache.py         # Redis audio caching
│   └── versioning.py    # Version snapshot logic
├── models/
│   ├── __init__.py
│   ├── requests.py      # Pydantic request models
│   └── responses.py     # Pydantic response models
└── websockets/
    ├── __init__.py
    └── playback.py      # WebSocket for playback progress
```

#### Step 3.3: Implement error handling
```python
# apps/api/src/main.py additions:
from fastapi import Request
from fastapi.responses import JSONResponse

@app.exception_handler(404)
async def not_found(request: Request, exc):
    return JSONResponse(status_code=404, content={"error": "Not found"})

@app.exception_handler(422)  
async def validation_error(request: Request, exc):
    return JSONResponse(status_code=422, content={"error": "Validation failed", "details": str(exc)})
```

#### Step 3.4: Implement frontend API client (apps/web/src/lib/api.ts)
```typescript
const API_URL = process.env.NEXT_PUBLIC_API_URL || 'http://localhost:8000';

export const api = {
  scenes: {
    list: () => fetch(`${API_URL}/api/scenes`).then(r => r.json()),
    get: (id: string) => fetch(`${API_URL}/api/scenes/${id}`).then(r => r.json()),
    create: (data: CreateSceneInput) => fetch(`${API_URL}/api/scenes`, { method: 'POST', headers: {'Content-Type': 'application/json'}, body: JSON.stringify(data) }).then(r => r.json()),
    // ... all endpoints from contracts/api.md
  },
  // speakers, phrases, voices, versions, playback, share
};
```

#### Step 3.5: Write parser unit tests
```python
# apps/api/tests/unit/test_parser.py
def test_parse_bakery_demo():
    """Parser correctly handles the canonical bakery demo text."""
    
def test_parse_colon_format():
    """Handles NAME: text format."""
    
def test_parse_stage_directions():
    """Detects [STAGE_DIRECTION] blocks."""
    
def test_parse_empty_input():
    """Returns empty list for empty input."""
```

#### Verification Criteria for Session 3:
- [ ] `pytest apps/api/tests/unit/test_parser.py` passes
- [ ] Bakery demo text parses into exactly: 4 speakers, 8 spoken lines, 3 stage directions
- [ ] `uvicorn src.main:app --reload` starts without errors
- [ ] All router files import without errors
- [ ] Frontend API client type-checks

---

### SESSION 4: Scene CRUD + Speaker CRUD + PhraseEvent CRUD (Backend)
**Goal**: Implement all backend CRUD endpoints for the three core entities.
**Estimated duration**: 1 agent session
**Tasks**: T010, T011, T012

#### Step 4.1: Scene CRUD (apps/api/src/routers/scenes.py)

Endpoints per API contract:
- `POST /api/scenes` -- Create scene, auto-parse raw text, create speakers + phrases
- `GET /api/scenes` -- List all scenes
- `GET /api/scenes/{id}` -- Get scene with relations + stats
- `PUT /api/scenes/{id}` -- Update scene metadata
- `DELETE /api/scenes/{id}` -- Delete scene (cascades)
- `POST /api/scenes/{id}/parse` -- Re-parse raw text

The POST /api/scenes endpoint is critical: it must parse the raw text, detect speakers, create Speaker records, create PhraseEvent records with correct indices, and return the full scene with relations.

#### Step 4.2: Speaker CRUD (apps/api/src/routers/speakers.py)

- `POST /api/scenes/{id}/speakers` -- Add speaker
- `PUT /api/scenes/{id}/speakers/{speakerId}` -- Update speaker (rename, voice assignment, rate, pitch)
- `DELETE /api/scenes/{id}/speakers/{speakerId}` -- Delete speaker (nullify phrase references)

#### Step 4.3: PhraseEvent CRUD (apps/api/src/routers/phrases.py)

- `POST /api/scenes/{id}/phrases` -- Add phrase
- `PUT /api/scenes/{id}/phrases/{phraseId}` -- Update phrase (text, config fields)
- `DELETE /api/scenes/{id}/phrases/{phraseId}` -- Delete phrase (re-index remaining)
- `PUT /api/scenes/{id}/phrases/reorder` -- Reorder phrases (accept ordered ID list)
- `POST /api/scenes/{id}/phrases/{phraseId}/split` -- Split phrase at character positions
- `POST /api/scenes/{id}/phrases/merge` -- Merge multiple phrases

#### Step 4.4: Pydantic request/response models
```python
# apps/api/src/models/requests.py
class CreateSceneRequest(BaseModel):
    title: str = Field(..., min_length=1, max_length=255)
    raw_text: str = Field(..., alias="rawText")

class UpdatePhraseRequest(BaseModel):
    text: str | None = None
    speaker_id: str | None = Field(None, alias="speakerId")
    repeat_count: int | None = Field(None, alias="repeatCount", ge=0, le=100)
    stagger_ms: int | None = Field(None, alias="staggerMs", ge=0, le=10000)
    loop_mode: LoopMode | None = Field(None, alias="loopMode")
    duration_mode: DurationMode | None = Field(None, alias="durationMode")
    fixed_duration_ms: int | None = Field(None, alias="fixedDurationMs")
    start_trigger: StartTrigger | None = Field(None, alias="startTrigger")

class PhraseSplitRequest(BaseModel):
    split_points: list[int] = Field(..., alias="splitPoints")

class PhraseMergeRequest(BaseModel):
    phrase_ids: list[str] = Field(..., alias="phraseIds", min_length=2)

class PhraseReorderRequest(BaseModel):
    ordered_ids: list[str] = Field(..., alias="orderedIds")
```

#### Step 4.5: Integration tests
```python
# apps/api/tests/integration/test_scenes.py
async def test_create_scene_parses_speakers():
async def test_create_scene_with_bakery_demo():
async def test_scene_crud_lifecycle():
async def test_phrase_split():
async def test_phrase_merge():
async def test_phrase_reorder():
```

#### Verification Criteria for Session 4:
- [ ] POST /api/scenes with bakery demo text returns 4 speakers, 8 spoken phrases
- [ ] All CRUD operations work via curl/httpie
- [ ] Phrase split at character index creates correct sub-phrases
- [ ] Phrase merge combines text and preserves speaker
- [ ] Reorder updates all indices atomically
- [ ] Delete scene cascades to speakers, phrases, versions
- [ ] Integration tests pass

---

### SESSION 5: Core UI (Screens 01, 02, Scene Workspace skeleton)
**Goal**: Build the 4 MVP screens as Next.js pages with the core CRUD UI components.
**Estimated duration**: 1 agent session (may need 2)
**Tasks**: T000i, T000j, T013, T014, T015, T009 (complete)

#### Step 5.1: App Router page structure
```
apps/web/src/app/
├── page.tsx                          # Landing (existing, update with navigation)
├── scenes/
│   ├── page.tsx                      # Scene list
│   ├── new/
│   │   └── page.tsx                  # Screen 01: New Scene Import
│   ├── [id]/
│   │   ├── page.tsx                  # Screen 03: Scene Workspace
│   │   └── parse-review/
│   │       └── page.tsx              # Screen 02: Parse Review
├── share/
│   └── [token]/
│       └── page.tsx                  # Screen 04: Share View
└── layout.tsx                        # (existing, keep as-is)
```

#### Step 5.2: Screen 01 -- New Scene Import (/scenes/new)
Components:
- `SceneImportForm` -- Title field, raw text textarea, parse button
- `BakerySampleCard` -- "Load Bakery Demo" card that pre-fills form
- `FormatHints` -- Right-side panel with accepted format patterns
- Two-column layout per ChatGPT POC spec

The bakery demo text is hardcoded as a constant:
```typescript
// apps/web/src/lib/constants.ts
export const BAKERY_DEMO = {
  title: "Philip Glass Buys a Loaf of Bread — Bakery Demo",
  rawText: `[STAGE_DIRECTION] A bakery counter...
FIRST_WOMAN: Isn't that Philip Glass?
SECOND_WOMAN: I think it is.
BAKER: Can I help you, sir?
GLASS: Yes. I need a loaf of bread, please.
BAKER: Just a moment.
FIRST_WOMAN: It's time now.
SECOND_WOMAN: Yes. Let's go.
BAKER: Do you know that woman, sir?
[STAGE_DIRECTION] A bell rings.`
};
```

#### Step 5.3: Screen 02 -- Parse Review (/scenes/[id]/parse-review)
Components:
- `RawTextPanel` -- Left column: scrollable raw text
- `ParsedLinesPanel` -- Right column: parsed lines grouped by speaker
- `SpeakerChips` -- Colored chips for each detected speaker
- `RenameControl` -- Inline rename for speaker labels
- `ParseSummary` -- Bottom strip: spoken line count, speaker count, stage direction count
- Navigation: Back to import, Continue to Workspace

#### Step 5.4: Scene Workspace skeleton (/scenes/[id])
Three-pane layout (left: script editor, center: playback, right: context tabs):
- `ScriptEditor` -- Editable phrase list with speaker labels
- `PlaybackPanel` -- Transport controls (stub), progress bar (stub), current phrase highlight
- `ContextPanel` -- Tabs: Speakers, Diagnostics (stub), Versions (stub)
- `SpeakerList` -- Shows speakers with rename, voice selector (stub), preview (stub)
- `PhraseList` -- Inline-editable phrase text with phrase config fields

#### Step 5.5: Shared UI components
```
apps/web/src/components/
├── ui/
│   ├── Button.tsx
│   ├── Input.tsx
│   ├── Textarea.tsx
│   ├── Card.tsx
│   ├── Tabs.tsx
│   ├── Badge.tsx
│   └── Dialog.tsx
├── scene/
│   ├── SceneImportForm.tsx
│   ├── BakerySampleCard.tsx
│   ├── FormatHints.tsx
│   ├── RawTextPanel.tsx
│   ├── ParsedLinesPanel.tsx
│   ├── SpeakerChips.tsx
│   ├── ScriptEditor.tsx
│   ├── PhraseRow.tsx
│   └── PhraseConfigFields.tsx
├── playback/
│   ├── TransportControls.tsx
│   ├── PlaybackTimeline.tsx
│   └── PhraseHighlight.tsx
├── speakers/
│   ├── SpeakerList.tsx
│   ├── SpeakerRow.tsx
│   └── VoiceSelector.tsx
└── versions/
    ├── VersionList.tsx
    ├── VersionCompare.tsx
    └── SaveVersionDialog.tsx
```

#### Verification Criteria for Session 5:
- [ ] /scenes/new loads with bakery sample card visible
- [ ] "Load Bakery Demo" fills title and text
- [ ] "Parse Scene" calls API and redirects to parse review
- [ ] Parse review shows 4 speakers, correct line counts
- [ ] "Continue to Workspace" navigates to scene workspace
- [ ] Scene workspace three-pane layout renders correctly
- [ ] Speaker list shows speakers with rename capability
- [ ] Phrase list shows editable phrases

---

### SESSION 6: Drag-Drop, Split/Merge, Loop Config UI
**Goal**: Complete phrase manipulation and loop configuration UI.
**Estimated duration**: 1 agent session
**Tasks**: T016, T017, T018, T019, T020, T021, T022, T023, T024, T025

#### Step 6.1: Install @dnd-kit for drag-drop
```bash
npm install @dnd-kit/core @dnd-kit/sortable @dnd-kit/utilities -w @sign-signal/web
```

#### Step 6.2: Drag-drop phrase reordering
Wrap PhraseList in DndContext + SortableContext. Each PhraseRow becomes a sortable item. On reorder, call `PUT /api/scenes/{id}/phrases/reorder`.

#### Step 6.3: Phrase split UI
Add split button on PhraseRow. On click, show text with cursor positions. User clicks to set split points, confirms. Calls `POST /api/scenes/{id}/phrases/{phraseId}/split`.

#### Step 6.4: Phrase merge UI
Multi-select mode: user checks multiple adjacent phrases, clicks "Merge". Calls `POST /api/scenes/{id}/phrases/merge`.

#### Step 6.5: PhraseConfigFields component
Inline config fields on each PhraseRow (expandable):
- `repeat_count`: number input (0-100)
- `stagger_ms`: number input (0-10000) with ms label
- `loop_mode`: dropdown (FIXED / ESCALATING)
- `duration_mode`: dropdown (AUTO / FIXED_MS)
- `fixed_duration_ms`: number input (conditional on FIXED_MS)
- `start_trigger`: dropdown (IMMEDIATE / AFTER_PREVIOUS / ON_CONDUCTOR_MARK)

All call `PUT /api/scenes/{id}/phrases/{phraseId}` on change (debounced).

#### Step 6.6: Duration estimation (T024)
Backend service to estimate phrase duration:
```python
# apps/api/src/services/duration.py
def estimate_duration_ms(text: str, speech_rate: float = 1.0) -> int:
    """
    Estimate speech duration using word count heuristic.
    Average: ~150 words/minute = ~400ms per word.
    Adjust by speech_rate multiplier.
    """
    words = len(text.split())
    base_ms = words * 400
    return int(base_ms / speech_rate)
```

#### Step 6.7: Scene duration display (T025)
Sum all phrase estimated durations (accounting for repeat_count, stagger_ms) and display in workspace toolbar.

#### Verification Criteria for Session 6:
- [ ] Drag-drop reorders phrases and persists to backend
- [ ] Split creates correct sub-phrases with re-indexed positions
- [ ] Merge combines phrase texts and removes extras
- [ ] All 6 config fields render and persist on change
- [ ] Duration estimates appear next to each phrase
- [ ] Total scene duration shows in toolbar

---

### SESSION 7: TTS Provider Abstraction + ElevenLabs + Redis Caching
**Goal**: Implement the TTS provider pattern and first working provider.
**Estimated duration**: 1 agent session
**Tasks**: T026, T027, T030

#### Step 7.1: TTS Provider ABC (apps/api/src/services/tts/base.py)
```python
from abc import ABC, abstractmethod
from dataclasses import dataclass

@dataclass
class TTSResult:
    audio_bytes: bytes
    duration_ms: int
    format: str  # "wav" or "mp3"

class TTSProvider(ABC):
    @abstractmethod
    async def generate(self, text: str, voice_id: str, speech_rate: float = 1.0, pitch_offset: int = 0) -> TTSResult:
        """Generate audio for text with given voice."""
        ...
    
    @abstractmethod
    async def list_voices(self) -> list[dict]:
        """List available voices from this provider."""
        ...
    
    @abstractmethod
    async def preview_voice(self, voice_id: str, sample_text: str = "Hello, this is a voice preview.") -> TTSResult:
        """Generate preview audio for a voice."""
        ...
    
    @abstractmethod
    async def clone_voice(self, name: str, sample_url: str) -> str:
        """Clone a voice from sample audio. Returns new voice_id."""
        ...
```

#### Step 7.2: Provider factory
```python
# apps/api/src/services/tts/__init__.py
def get_tts_provider(provider: str) -> TTSProvider:
    match provider:
        case "ELEVENLABS": return ElevenLabsProvider()
        case "COQUI": return CoquiProvider()
        case "VALLE": return ValleProvider()
        case _: raise ValueError(f"Unknown provider: {provider}")
```

#### Step 7.3: ElevenLabs implementation (apps/api/src/services/tts/elevenlabs.py)
Use the `elevenlabs` Python SDK. Map voice_id to ElevenLabs voice IDs. Handle API key from config.

#### Step 7.4: Redis caching service (apps/api/src/services/cache.py)
```python
import redis.asyncio as redis
import hashlib

class AudioCache:
    def __init__(self, redis_url: str, ttl: int = 86400):  # 24h default
        self.redis = redis.from_url(redis_url)
        self.ttl = ttl
    
    def _key(self, scene_id: str, phrase_hash: str, voice_id: str) -> str:
        return f"audio:{scene_id}:{phrase_hash}:{voice_id}"
    
    def _hash_phrase(self, text: str, rate: float, pitch: int) -> str:
        content = f"{text}:{rate}:{pitch}"
        return hashlib.sha256(content.encode()).hexdigest()[:16]
    
    async def get(self, scene_id: str, text: str, voice_id: str, rate: float, pitch: int) -> bytes | None:
        key = self._key(scene_id, self._hash_phrase(text, rate, pitch), voice_id)
        return await self.redis.get(key)
    
    async def set(self, scene_id: str, text: str, voice_id: str, rate: float, pitch: int, audio: bytes):
        key = self._key(scene_id, self._hash_phrase(text, rate, pitch), voice_id)
        await self.redis.setex(key, self.ttl, audio)
    
    async def invalidate_scene(self, scene_id: str):
        pattern = f"audio:{scene_id}:*"
        async for key in self.redis.scan_iter(pattern):
            await self.redis.delete(key)
```

#### Step 7.5: Tests
- Unit test: TTSProvider ABC contract
- Unit test: Cache key generation
- Integration test: ElevenLabs generate (mocked or with test key)
- Integration test: Cache hit/miss behavior

#### Verification Criteria for Session 7:
- [ ] TTSProvider ABC has all required methods
- [ ] ElevenLabsProvider.generate() returns audio bytes (with valid API key)
- [ ] Cache stores and retrieves audio correctly
- [ ] Cache invalidation removes correct keys
- [ ] Provider factory returns correct provider by name

---

### SESSION 8: Playback Engine + WebSocket
**Goal**: Generate full sequence audio, implement WebSocket progress, transport controls.
**Estimated duration**: 1 agent session (likely the hardest session)
**Tasks**: T033, T034, T035, T036, T037, T038, T039

#### Step 8.1: Sequence audio generation (apps/api/src/services/playback.py)
```python
class PlaybackEngine:
    def __init__(self, tts_provider: TTSProvider, cache: AudioCache):
        self.tts = tts_provider
        self.cache = cache
    
    async def generate_sequence(self, scene_id: str, phrases: list[PhraseEvent], speakers: dict[str, Speaker]) -> PlaybackSequence:
        """
        Generate audio for full phrase sequence.
        Returns PlaybackSequence with timing map and combined audio.
        """
        segments = []
        current_time_ms = 0
        
        for phrase in phrases:
            speaker = speakers.get(phrase.speaker_id)
            voice_id = speaker.voice_profile_id if speaker else "default"
            
            # Check cache first
            audio = await self.cache.get(scene_id, phrase.text, voice_id, speaker.speech_rate, speaker.pitch_offset)
            if not audio:
                result = await self.tts.generate(phrase.text, voice_id, speaker.speech_rate, speaker.pitch_offset)
                audio = result.audio_bytes
                await self.cache.set(scene_id, phrase.text, voice_id, speaker.speech_rate, speaker.pitch_offset, audio)
            
            # Handle repeat_count and stagger
            for repeat in range(max(1, phrase.repeat_count)):
                segments.append(PlaybackSegment(
                    phrase_id=phrase.id,
                    phrase_index=phrase.index,
                    start_ms=current_time_ms,
                    duration_ms=phrase.estimated_duration_ms,
                    audio=audio,
                    repeat_index=repeat,
                ))
                current_time_ms += phrase.estimated_duration_ms + phrase.stagger_ms
        
        return PlaybackSequence(segments=segments, total_duration_ms=current_time_ms)
```

#### Step 8.2: WebSocket handler (apps/api/src/websockets/playback.py)
```python
from fastapi import WebSocket

class PlaybackWebSocket:
    async def handler(self, websocket: WebSocket, scene_id: str):
        await websocket.accept()
        # Send progress events during playback:
        # { "type": "phrase_start", "phraseIndex": N, "phraseId": "..." }
        # { "type": "phrase_end", "phraseIndex": N, "elapsedMs": M }
        # { "type": "playback_complete" }
```

Register in main.py:
```python
@app.websocket("/ws/playback/{scene_id}")
async def playback_ws(websocket: WebSocket, scene_id: str):
    manager = PlaybackWebSocket()
    await manager.handler(websocket, scene_id)
```

#### Step 8.3: Playback API endpoints
- `POST /api/scenes/{id}/play` -- Generate sequence audio, return audioUrl + status
- `POST /api/scenes/{id}/play/phrase/{phraseId}` -- Single phrase playback
- `POST /api/scenes/{id}/play/range` -- Range playback (startPhraseIndex, endPhraseIndex)
- `GET /api/scenes/{id}/play/status` -- Current playback state
- `POST /api/scenes/{id}/play/stop` -- Stop playback

The audio is served via a static file endpoint or streamed directly.

#### Step 8.4: Frontend playback (apps/web/src/lib/playback.ts)
```typescript
class PlaybackClient {
    private audio: HTMLAudioElement;
    private ws: WebSocket;
    
    connect(sceneId: string) {
        this.ws = new WebSocket(`ws://localhost:8000/ws/playback/${sceneId}`);
        this.ws.onmessage = (event) => {
            const data = JSON.parse(event.data);
            // Dispatch to state: phrase_start, phrase_end, playback_complete
        };
    }
    
    async play(sceneId: string) { /* POST /play, load audio, start */ }
    pause() { this.audio.pause(); }
    stop() { this.audio.pause(); this.audio.currentTime = 0; }
    seekToPhrase(index: number, timingMap: PhraseTimingMap) { /* calculate time, seek */ }
}
```

#### Step 8.5: Frontend transport + visual tracker
- `TransportControls`: play/pause/stop buttons, scene duration display
- `PlaybackTimeline`: horizontal bar with phrase segment indicators, scrubber
- `PhraseHighlight`: current phrase gets highlighted class in ScriptEditor

#### Verification Criteria for Session 8:
- [ ] POST /api/scenes/{id}/play returns audioUrl and status
- [ ] WebSocket connects and sends phrase_start/phrase_end events
- [ ] Frontend play button triggers audio playback
- [ ] Current phrase highlights during playback
- [ ] Pause/resume works
- [ ] Seek to specific phrase works
- [ ] Single phrase and range playback work

---

### SESSION 9: Versioning + Share Links
**Goal**: Implement version save/restore/compare and share link generation.
**Estimated duration**: 1 agent session
**Tasks**: T041, T042, T043, T044, T045, T046, T047, T048, T000k, T000l, T000m

#### Step 9.1: Version service (apps/api/src/services/versioning.py)
```python
class VersionService:
    async def save_version(self, scene_id: str, label: str) -> Version:
        """Snapshot entire scene state as JSON."""
        scene = await prisma.scene.find_unique(where={"id": scene_id}, include={"speakers": True, "phrases": True})
        snapshot = {
            "title": scene.title,
            "rawText": scene.raw_text,
            "speakers": [s.dict() for s in scene.speakers],
            "phrases": [p.dict() for p in scene.phrases],
        }
        return await prisma.version.create(data={"sceneId": scene_id, "label": label, "snapshot": snapshot})
    
    async def restore_version(self, version_id: str) -> Scene:
        """Replace current scene state with version snapshot."""
        # Delete current speakers/phrases, recreate from snapshot
    
    async def compare_versions(self, version_id_1: str, version_id_2: str) -> VersionComparison:
        """Generate text diff and duration delta."""
```

#### Step 9.2: Version API endpoints
- `GET /api/scenes/{id}/versions` -- List version history
- `POST /api/scenes/{id}/versions` -- Save version with label
- `POST /api/scenes/{id}/versions/{versionId}/restore` -- Restore version
- `GET /api/scenes/{id}/versions/compare?v1={id}&v2={id}` -- Compare versions

#### Step 9.3: Share link API
- `POST /api/scenes/{id}/versions/{versionId}/share-links` -- Create share link (generates token)
- `GET /api/share/{token}` -- Resolve share link to version data

#### Step 9.4: Version UI components
- `VersionList` in right-pane Versions tab: list with timestamps, labels, restore/compare/share actions
- `SaveVersionDialog`: modal with label input
- `VersionCompare`: side-by-side diff with text changes highlighted, duration delta

#### Step 9.5: Screen 04 -- Share View (/share/[token])
- Clean centered layout per ChatGPT spec
- Read-only: scene title, version label, audio player, script text with speaker labels
- No editing affordance
- Optional collapsible diagnostics summary

#### Step 9.6: Bakery demo presets (T000m)
Seed script that creates the 3 demo versions:
- VERSION_A__BASE_READ: default parse, standard pace
- VERSION_B__PACE_SHIFT: faster pace, shorter pauses
- VERSION_C__HEIGHTENED_RENDER: different voice assignments, stronger contrast

#### Verification Criteria for Session 9:
- [ ] Save version creates snapshot with full scene state
- [ ] Restore version replaces current state correctly
- [ ] Version comparison shows text diff and duration delta
- [ ] Share link generates unique token
- [ ] /share/{token} renders read-only view
- [ ] No editing affordance on share view
- [ ] Bakery demo has 3 pre-loaded versions

---

### SESSION 10: Voice Controls + Secondary TTS Providers
**Goal**: Voice selection UI, speech rate/pitch controls, Coqui/VALL-E stubs.
**Estimated duration**: 1 agent session
**Tasks**: T028, T029, T031, T032, T049, T050, T051, T052, T053

#### Step 10.1: Voice endpoints
- `GET /api/voices` -- List all voice profiles
- `POST /api/voices` -- Create voice profile
- `POST /api/voices/{id}/preview` -- Preview voice (returns audio)
- `POST /api/voices/{id}/clone` -- Clone voice from sample URL

#### Step 10.2: Voice selection UI
- `VoiceSelector` component in SpeakerRow: dropdown of available voices
- `VoicePreview` button: play short audio sample
- Voice assignment persists to Speaker.voiceProfileId

#### Step 10.3: Speech rate/pitch controls
- `SpeechRateSlider`: 0.5-2.0 range, on Speaker model
- `PitchOffsetSlider`: -12 to +12 semitones, on Speaker model
- Both persist via PUT /api/scenes/{id}/speakers/{speakerId}

#### Step 10.4: Coqui TTS provider (stub)
```python
class CoquiProvider(TTSProvider):
    """Open-source TTS using Coqui. Requires local model."""
    # Implementation depends on coqui-tts package availability
    # For Layer 1: stub that returns placeholder audio or raises NotConfiguredError
```

#### Step 10.5: VALL-E provider (stub)
Similar stub pattern. These become real in later layers.

#### Verification Criteria for Session 10:
- [ ] Voice list endpoint returns available voices
- [ ] Voice selector shows voices per provider
- [ ] Voice preview plays sample audio
- [ ] Speech rate slider changes playback speed
- [ ] Pitch offset changes voice pitch
- [ ] Coqui/VALL-E providers raise clear errors when not configured

---

### SESSION 11: Polish, Performance, Error Handling
**Goal**: Loading states, empty states, error handling, performance for 100+ phrases.
**Estimated duration**: 1 agent session
**Tasks**: T054, T055, T056, T057, T058, T059, T060

#### Step 11.1: Performance optimization (T054)
- Virtualize phrase list for 100+ phrases (react-window or similar)
- Lazy load phrase config fields (only expand on click)
- Debounce API calls on inline edits (300ms)
- Paginate scene list

#### Step 11.2: Loading states (T055)
- Skeleton loaders for scene workspace initial load
- Spinner on parse action
- "Rendering..." feedback during TTS generation
- Optimistic updates for drag-drop reorder

#### Step 11.3: Empty states (T056)
- Scene with no phrases: "Parse your dialogue or add phrases manually"
- Scene list empty: "Create your first scene"
- No speakers: "Add speakers to your scene"

#### Step 11.4: Cache invalidation (T057)
When phrase text changes, invalidate cached audio for that phrase. When voice config changes, invalidate all cached audio for that speaker.

#### Step 11.5: TTS fallback (T058)
If primary TTS provider fails, try next in chain: ElevenLabs -> Coqui -> VALL-E. Show error with retry button if all fail.

#### Step 11.6: Stats display (T059)
- Speaker count and phrase count in scene toolbar
- Per-speaker line count in speaker list

#### Step 11.7: Unassigned phrase marking (T060)
- Visual indicator (warning badge) on phrases with no speaker assigned
- Filter to show only unassigned phrases

#### Step 11.8: Bakery demo seed data (T000h)
Create a seed script/command that populates the database with the bakery demo scene, 4 speakers, all phrases, and 3 demo versions.

```bash
# Run seed:
cd apps/api && python -m src.seed
```

#### Verification Criteria for Session 11:
- [ ] 100-phrase scene loads and scrolls smoothly
- [ ] All API calls show loading states
- [ ] Empty states display for all empty collections
- [ ] Text edit triggers cache invalidation
- [ ] TTS failure shows error with retry
- [ ] Stats accurate for bakery demo
- [ ] Unassigned phrases marked visually
- [ ] Seed script creates bakery demo successfully

---

## 4. Parallelization Map

Within each session, independent tasks can be parallelized across agent threads:

| Session | Parallelizable groups |
|---------|----------------------|
| Session 1 | .gitignore + README + CLAUDE.md (parallel) then deps install |
| Session 2 | Schema rewrite + shared types update (parallel) then migration |
| Session 3 | Parser (Python) + API structure (Python) + Frontend client (TS) -- all parallel |
| Session 4 | Scene CRUD + Speaker CRUD + Phrase CRUD -- sequential (Speaker depends on Scene) |
| Session 5 | Screen 01 + Screen 02 + UI components -- partially parallel |
| Session 6 | Drag-drop + Split/Merge + Config fields -- all parallel after base PhraseList |
| Session 7 | TTS ABC + ElevenLabs + Cache -- sequential (ElevenLabs needs ABC, Cache needs provider) |
| Session 8 | Sequence gen + WebSocket + Transport UI -- sequential (WebSocket needs sequence gen) |
| Session 9 | Version service + Share links + Version UI -- partially parallel |
| Session 10 | Voice endpoints + Voice UI + Coqui + VALL-E -- partially parallel |
| Session 11 | All polish tasks are independent and fully parallelizable |

---

## 5. Dependency Graph (Corrected + Extended)

```
SESSION 1 (scaffold)
    |
SESSION 2 (schema + migration)
    |
    +-- SESSION 3 (parser + API structure + frontend client)
    |       |
    |       +-- SESSION 4 (CRUD backend)
    |       |       |
    |       |       +-- SESSION 5 (UI screens)
    |       |       |       |
    |       |       |       +-- SESSION 6 (drag-drop + config UI)
    |       |       |               |
    |       |       |               +-- SESSION 11 (polish)
    |       |       |
    |       |       +-- SESSION 9 (versioning + share -- can start after Session 4)
    |       |
    |       +-- SESSION 7 (TTS -- can start after Session 3)
    |               |
    |               +-- SESSION 8 (playback -- needs TTS)
    |                       |
    |                       +-- SESSION 10 (voice controls -- needs playback)
```

**Critical parallel opportunity**: Sessions 7 and 5 can run simultaneously after Session 4. One agent works on TTS backend while another works on UI.

---

## 6. Risk Register

| Risk | Probability | Impact | Mitigation |
|------|-------------|--------|------------|
| Python 3.14 incompatibility with coqui-tts | Medium | High | Use 3.11 venv via pyenv or accept 3.14 and skip coqui initially |
| ElevenLabs API key not available | High | Medium | Implement mock TTS provider for development |
| 16GB RAM constraint with Docker + Node + Python + TTS | Medium | Medium | Run postgres+redis in Docker, api+web natively |
| Prisma + Python client compatibility | Low | High | Use prisma-client-py (well-maintained for FastAPI) |
| next.config.js import type syntax | High | Low | Rename to .mjs or rewrite as CommonJS |
| WebSocket complexity for playback | Medium | Medium | Start with polling fallback, add WebSocket after basic playback works |

---

## 7. Commands Quick Reference

```bash
# Start infrastructure
cd /Users/4jp/Workspace/organvm-iii-ergon/sign-signal--voice-synth
docker compose up -d postgres redis

# Install Node deps
npm install

# Install Python deps
cd apps/api && python3 -m venv .venv && source .venv/bin/activate && pip install -e ".[dev]"

# Run Prisma migration
cd packages/db && npx prisma migrate dev --name init_layer_1

# Start development
npm run dev  # runs web + api concurrently

# Run tests
cd apps/api && pytest
cd apps/web && npm test

# Seed bakery demo
cd apps/api && python -m src.seed
```

---

## 8. Files Requiring Modification vs New Files

### Files to MODIFY (existing scaffold)
1. `packages/db/prisma/schema.prisma` -- Fix discrepancies, add ShareLink/DiagnosticReport
2. `packages/shared/src/index.ts` -- Align types with corrected schema
3. `apps/api/src/main.py` -- Add routers, middleware, WebSocket, lifespan
4. `apps/web/src/app/page.tsx` -- Update landing page navigation
5. `apps/web/src/app/layout.tsx` -- May need minor layout updates
6. `apps/web/next.config.js` -- Fix import syntax (rename to .mjs or rewrite)
7. `package.json` (root) -- Update scripts for Python api
8. `docker-compose.yml` -- May need adjustments once Dockerfiles exist
9. `.env.example` -- Add any missing vars

### Files to CREATE (new)
- `.gitignore`, `README.md`, `CLAUDE.md`
- `apps/api/pyproject.toml`, `apps/api/requirements.txt`
- `apps/api/Dockerfile`, `apps/web/Dockerfile`
- `packages/db/src/index.ts`
- All files under `apps/api/src/routers/`, `apps/api/src/services/`, `apps/api/src/models/`, `apps/api/src/websockets/`
- `apps/api/src/config.py`, `apps/api/src/db.py`, `apps/api/src/dependencies.py`
- `apps/api/src/seed.py`
- All test files under `apps/api/tests/`
- All files under `apps/web/src/components/`
- All page files under `apps/web/src/app/scenes/`, `apps/web/src/app/share/`
- `apps/web/src/lib/api.ts`, `apps/web/src/lib/playback.ts`, `apps/web/src/lib/constants.ts`
