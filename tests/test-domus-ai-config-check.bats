#!/usr/bin/env bats
# Tests for domus-ai-config-check

load 'test-helpers'

SCRIPT="${BATS_TEST_DIRNAME}/../dot_local/bin/executable_domus-ai-config-check"

setup() {
  setup_test_env
  MOCK_REPO="$TEST_HOME/repo"
  mkdir -p "$MOCK_REPO/private_dot_claude"
  mkdir -p "$MOCK_REPO/dot_local/share/private_gemini"
  mkdir -p "$MOCK_REPO/dot_config/ai-instructions/cursor-rules"
}

teardown() {
  teardown_test_env
}

# Helper: create a consumer template with the given includes
create_consumer() {
  local path="$1"
  shift
  local content="# Test template\n"
  for fragment in "$@"; do
    content+="{{- \$var := include \"dot_config/ai-context/${fragment}.md.tmpl\" }}\n"
  done
  printf '%b' "$content" > "$MOCK_REPO/$path"
}

@test "passes when all consumers have all fragments" {
  create_consumer "private_dot_claude/CLAUDE.md.tmpl" system-info code-style plan-discipline
  create_consumer "dot_local/share/private_gemini/GEMINI.md.tmpl" system-info code-style plan-discipline
  create_consumer "AGENTS.md.tmpl" system-info code-style plan-discipline
  create_consumer "dot_config/ai-instructions/copilot-instructions.md.tmpl" system-info code-style plan-discipline
  create_consumer "dot_config/ai-instructions/cursor-rules/core.mdc.tmpl" system-info code-style plan-discipline

  run bash "$SCRIPT" "$MOCK_REPO"
  [ "$status" -eq 0 ]
  [[ "$output" == *"All consumers at full parity"* ]]
}

@test "fails when a consumer is missing a fragment" {
  create_consumer "private_dot_claude/CLAUDE.md.tmpl" system-info code-style plan-discipline
  create_consumer "dot_local/share/private_gemini/GEMINI.md.tmpl" system-info code-style plan-discipline
  create_consumer "AGENTS.md.tmpl" system-info code-style plan-discipline
  create_consumer "dot_config/ai-instructions/copilot-instructions.md.tmpl" system-info code-style
  # Copilot missing plan-discipline
  create_consumer "dot_config/ai-instructions/cursor-rules/core.mdc.tmpl" system-info code-style plan-discipline

  run bash "$SCRIPT" "$MOCK_REPO"
  [ "$status" -eq 1 ]
  [[ "$output" == *"missing fragment"* ]]
}

@test "fails when consumer template file is missing" {
  create_consumer "private_dot_claude/CLAUDE.md.tmpl" system-info code-style plan-discipline
  create_consumer "dot_local/share/private_gemini/GEMINI.md.tmpl" system-info code-style plan-discipline
  # AGENTS.md.tmpl not created at all
  create_consumer "dot_config/ai-instructions/copilot-instructions.md.tmpl" system-info code-style plan-discipline
  create_consumer "dot_config/ai-instructions/cursor-rules/core.mdc.tmpl" system-info code-style plan-discipline

  run bash "$SCRIPT" "$MOCK_REPO"
  [ "$status" -eq 1 ]
}

@test "outputs table header with consumer names" {
  create_consumer "private_dot_claude/CLAUDE.md.tmpl" system-info code-style plan-discipline
  create_consumer "dot_local/share/private_gemini/GEMINI.md.tmpl" system-info code-style plan-discipline
  create_consumer "AGENTS.md.tmpl" system-info code-style plan-discipline
  create_consumer "dot_config/ai-instructions/copilot-instructions.md.tmpl" system-info code-style plan-discipline
  create_consumer "dot_config/ai-instructions/cursor-rules/core.mdc.tmpl" system-info code-style plan-discipline

  run bash "$SCRIPT" "$MOCK_REPO"
  [[ "$output" == *"Claude"* ]]
  [[ "$output" == *"Gemini"* ]]
  [[ "$output" == *"Copilot"* ]]
  [[ "$output" == *"Cursor"* ]]
}
