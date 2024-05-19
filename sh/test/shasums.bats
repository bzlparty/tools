bats_load_library "bats-support"
bats_load_library "bats-assert"

@test "exit code, invoking with no arguments" {
  run ./sh/shasums.bash
  [ "$status" -eq 0 ]
}

@test "output, invoking with no arguments" {
  run ./sh/shasums.bash
  assert_output --partial "Usage:"
}
