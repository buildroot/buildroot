#!/usr/bin/env bats

setup() {
    bats_load_library bats-support
    bats_load_library bats-file
}

@test "bats-file assert_exists" {
    assert_exists /root/test-bats-file.bats
}
