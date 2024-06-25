#!/usr/bin/env bash

Describe 'hello.sh'
  # TODO: Include runfiles properly
  Include examples/shell/hello.sh
  It 'says hello'
    When call hello ShellSpec
    The output should equal 'Hello ShellSpec!'
  End
End
