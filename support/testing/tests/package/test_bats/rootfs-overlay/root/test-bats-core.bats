#!/usr/bin/env bats

@test "bats-core true" {
    true
}

@test "bats-core run" {
    run echo "Hello World"
    [ "$status" -eq 0 ]
    [ "$output" = "Hello World" ]
}
