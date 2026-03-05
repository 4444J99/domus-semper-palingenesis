# Extension Reduction & Summoning Strategy

## Objective
Reduce context clutter by disabling non-essential extensions and establishing a "summoning" protocol where Gemini enables them on-demand.

## Core Extensions (Stay Enabled)
- git-tools
- extension-browser
- gemini-flow
- gemini-plan-commands
- system-agents

## On-Demand Extensions (To be Disabled)
- FileSearch
- agent-creator
- blog-publisher
- chrome-devtools-mcp
- code-review
- context7
- criticalthink
- doc-indexer
- document-skills
- example-skills
- gcloud
- gemini-cli-jules
- gemini-cli-prompt-library
- gemini-history-learning
- gemini-mentor
- genkit
- github
- google-workspace-inbox
- mcp-game-asset-gen
- mcp-toolbox
- mcp-toolbox-for-databases
- open-aware
- plan
- scribe
- skill-porter
- spec-flow

## Summoning Protocol
When a user task involves:
- **Cloud/GCP**: Enable `gcloud` and `gke-mcp`.
- **Media/Documents**: Enable `document-skills` or `mcp-game-asset-gen`.
- **GitHub management**: Enable `github`.
- **Learning/Mentoring**: Enable `gemini-mentor`.
- **Large refactoring**: Enable `gemini-cli-jules`.
- **Blog workflow**: Enable `blog-publisher`.
