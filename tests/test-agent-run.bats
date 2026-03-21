#!/usr/bin/env bats
# Tests for agent-run — reproducible agent session harness

load 'test-helpers'

setup() {
  setup_test_env
  SCRIPT="$BATS_TEST_DIRNAME/../dot_local/bin/executable_agent-run"
  export AGENTS_LOG="$TEST_HOME/_agents/log"
  mkdir -p "$AGENTS_LOG"
}

teardown() {
  teardown_test_env
}

@test "agent-run --help shows usage" {
  run bash "$SCRIPT" --help
  [ "$status" -eq 0 ]
  [[ "$output" == *"agent-run"* ]]
  [[ "$output" == *"--agent"* ]]
  [[ "$output" == *"--prompt"* ]]
  [[ "$output" == *"--dry-run"* ]]
}

@test "agent-run -h shows usage" {
  run bash "$SCRIPT" -h
  [ "$status" -eq 0 ]
  [[ "$output" == *"agent-run"* ]]
}

@test "agent-run --dry-run creates run directory" {
  run bash "$SCRIPT" --agent claude --dry-run
  [ "$status" -eq 0 ]
  [[ "$output" == *"dry-run"* ]]

  # Verify a run directory was created
  local dirs
  dirs=$(ls "$AGENTS_LOG" | wc -l | tr -d ' ')
  [ "$dirs" -eq 1 ]
}

@test "agent-run --dry-run creates metadata.md" {
  run bash "$SCRIPT" --agent aider --dry-run
  [ "$status" -eq 0 ]

  # Find the run dir
  local run_dir
  run_dir=$(ls -d "$AGENTS_LOG"/*/ | head -1)
  [ -f "${run_dir}metadata.md" ]

  # Verify metadata content
  grep -q "agent: aider" "${run_dir}metadata.md"
}

@test "agent-run with unknown agent exits 2" {
  run bash "$SCRIPT" --agent nonexistent-agent
  [ "$status" -eq 2 ]
  [[ "$output" == *"Unknown agent"* ]]
  [[ "$output" == *"nonexistent-agent"* ]]
}

@test "agent-run --prompt copies prompt file" {
  local prompt_file="$TEST_HOME/test-prompt.md"
  echo "# Test Prompt" > "$prompt_file"

  run bash "$SCRIPT" --agent claude --prompt "$prompt_file" --dry-run
  [ "$status" -eq 0 ]

  # Find the run dir and check prompt was copied
  local run_dir
  run_dir=$(ls -d "$AGENTS_LOG"/*/ | head -1)
  [ -f "${run_dir}prompt.md" ]
  grep -q "Test Prompt" "${run_dir}prompt.md"
}

@test "agent-run without --agent shows interactive placeholder" {
  run bash "$SCRIPT" --dry-run
  [ "$status" -eq 0 ]
  [[ "$output" == *"<interactive>"* ]]
}

@test "agent-run creates timestamped directory name" {
  run bash "$SCRIPT" --agent claude --dry-run
  [ "$status" -eq 0 ]

  # Run dir name should match YYYYMMDD_HHMMSS pattern
  local dirname
  dirname=$(ls "$AGENTS_LOG" | head -1)
  [[ "$dirname" =~ ^[0-9]{8}_[0-9]{6}$ ]]
}

@test "agent-run captures git state when in git repo" {
  # Create a temporary git repo
  local git_dir="$TEST_HOME/test-repo"
  mkdir -p "$git_dir"
  (cd "$git_dir" && git init -q && git commit --allow-empty -m "init" -q)

  run bash -c "cd '$git_dir' && bash '$SCRIPT' --agent claude --dry-run"
  [ "$status" -eq 0 ]

  # Find the run dir and check git state was captured
  local run_dir
  run_dir=$(ls -d "$AGENTS_LOG"/*/ | head -1)
  grep -q "Git State" "${run_dir}metadata.md"
  grep -q "branch:" "${run_dir}metadata.md"
  grep -q "commit:" "${run_dir}metadata.md"
}
