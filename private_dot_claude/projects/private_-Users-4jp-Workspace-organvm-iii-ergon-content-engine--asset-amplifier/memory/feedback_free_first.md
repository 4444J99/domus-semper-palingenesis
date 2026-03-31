---
name: Free-first provider doctrine
description: Always start with free/open-source AI providers for testing. 7 providers wired — Ollama, Groq, Gemini, Cerebras, Cloudflare, Anthropic, OpenAI
type: feedback
---

User mandates free open-source APIs first, always. Paid APIs are optional upgrades, never defaults.

**Why:** One-person operation. Testing and trial must cost $0. The system must work before money is spent. Scott validated the pitch deck without any AI costs being incurred.

**How to apply:** The provider layer at `packages/config/src/providers.ts` auto-resolves: Ollama (local free) → Groq/Gemini/Cerebras/Cloudflare (cloud free) → Anthropic/OpenAI (paid). Never hardcode a paid provider. Always check if Ollama is running first. The Settings UI at `/settings` lets users add keys when ready to upgrade. All providers implement `LLMProvider`, `EmbeddingProvider`, or `TranscriptionProvider` interfaces.
