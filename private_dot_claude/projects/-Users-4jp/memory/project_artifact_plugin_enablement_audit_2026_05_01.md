---
name: Plugin Enablement Audit 2026-05-01
description: Evidence-based audit of 44 dormant plugins; recommended cut at 13 enables. Awaiting user decision before chezmoi settings.json.tmpl edit.
type: project
originSessionId: 0511eeb8-ef00-4d34-aebe-db225f89211d
---
# Plugin Enablement Historical Audit — 2026-05-01

**Trigger:** /skills + /doctor surfaced that 44 of 50 installed plugins were dormant. User directive: enablement must be evidence-based via historical universal review, not lane-pick.

**Method:** Explore agent (background) audited memory corpus, session history, prompt ledger (47K atoms), MCP overlap, install dates, asset weight per plugin.

## Recommended cut: 13 enables (going from 6 → 19)

### STRONG ENABLE (4) — recent active work + high-weight infrastructure
| Plugin | Mentions | Skills shipped | Why |
|---|---|---|---|
| vercel | 5 | 84 | hokage-chess landing deploy; sovereign-systems Vercel/Cloudflare; stakeholder-portal |
| figma | 8 | 43 | Maddie universe design; explicit "build like Figma designs" memory |
| stripe | 12 | 1 | Maddie universe subscriptions (Stripe vs GHL pending); hokage-chess monetization; `feature/stripe-checkout` branch |
| github | **609** | 0 | Core workflow; 50+ issues/PRs; PAT rotation; branch mgmt |

### ENABLE (4) — consistent domain match, essential stack
| Plugin | Mentions | Skills | Why |
|---|---|---|---|
| playwright | 9 | 0 | TS/Node E2E; application-pipeline (368 prompts) |
| slack | 6 | 2 | Communication channel; Jessica/Micah/Noah/Rob context |
| linear | 12 | 0 | Active in organvm-pactvm (206 prompts) |
| typescript-lsp | 0 | 0 | Primary language across 4444J99/portfolio, organvm, hokage-chess |

### LEAN ENABLE (5) — exploratory capacity / complementary
| Plugin | Mentions | Skills | Why |
|---|---|---|---|
| plugin-dev | 0 | 7 | Building plugins; tool-interaction-design (61 prompts) |
| firebase | 3 | 0 | Backend option; minor signal |
| supabase | 3 | 4 | Postgres; data-driven organvm |
| code-review | 0 | 0 | Active GitHub workflow; complements code-simplifier |
| pr-review-toolkit | 0 | 0 | Complements code-review; PR-heavy (609 GitHub mentions) |

### Below the cut (recommended SKIP — 31 plugins)
- **LEAN SKIP**: coderabbit, huggingface-skills, superpowers, posthog
- **SKIP**: sentry, asana, frontend-design, hookify, all non-TS LSPs (clangd/csharp/gopls/jdtls/kotlin/lua/php/rust/swift), pyright-lsp, firecrawl, security-guidance, gitlab, sonatype-guide, agent-sdk-dev, claude-code-setup, claude-md-management, circleback, feature-dev, learning-output-style, playground, ralph-loop

## Cut rationale

Boundary is clean: plugins below the cut have zero cross-referenced evidence in memory + session history. STRONG/ENABLE/LEAN tier maps to convergence of (a) direct mention volume, (b) explicit project memory references, (c) asset weight.

## Pending action

Edit chezmoi source `private_dot_claude/settings.json.tmpl` to add 13 plugins to `enabledPlugins`. Surface chezmoi diff before apply (autoCommit+autoPush will ship to GitHub immediately).

## Provenance

Background agent ID: aafd485789b3d5b25, ran 2026-05-01 ~12:05 EDT, duration 152s, 24 tool uses, 133K tokens.
