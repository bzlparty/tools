bats_load_library "bats-support"
bats_load_library "bats-assert"

@test "exit code, invoking with no arguments" {
  run ./git/tag.sh
  [ "$status" -eq 0 ]
}

@test "output, invoking with no arguments" {
  run ./git/tag.sh
  assert_output --partial "Synopsis:"
}
