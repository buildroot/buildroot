#!/usr/bin/env bats

setup() {
    bats_load_library bats-support
    bats_load_library bats-assert
}

@test "bats-assert assert_output" {
    run echo "Hello World"
    assert_output "Hello World"
}
