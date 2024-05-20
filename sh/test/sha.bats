bats_load_library "bats-support"
bats_load_library "bats-assert"

@test "exit code, invoking with no arguments" {
  run ./sh/sha.bash
  [ "$status" -eq 0 ]
}

@test "output, invoking with no arguments" {
  run ./sh/sha.bash
  assert_output --partial "Usage:"
}
