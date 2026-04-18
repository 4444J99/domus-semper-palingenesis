# Plan: Remove Unused GKE MCP Extension from VS Code

## Context

VS Code shows `Error: exec: "go": executable file not found in $PATH.` for the GKE MCP server extension. Go exists at `/opt/homebrew/bin/go` but is only used by contrib forks (k6-contrib, dapr-dapr, etc.) — all flagged for removal in IRF-CND-020. No original Go code in the workspace. GKE MCP extension is unused.

## Step 1: Uninstall GKE MCP extension

In VS Code MCP Store panel → Google Kubernetes Engine (OSS) → right-click → Uninstall. Or if it's a marketplace extension, uninstall via Extensions panel.

This is a VS Code UI action — cannot be done from CLI in this context.

## Step 2 (optional): Consider uninstalling Go

If no other tool depends on Go after the contrib forks are archived (IRF-CND-020), `brew uninstall go` reclaims ~500MB.

## The 10 Problems

The "Problems: 10" in the screenshot are markdown lint warnings from `academic-rigor-placement.md` (shown as "9+" in the tab). These are editor-level diagnostics, not MCP errors. No action needed unless you want to clean up that file.

## Verification

- GKE error disappears from MCP panel
- Problems count may drop if the markdown file is closed
