setup() {
    load 'test_helper/common-setup'
    _common_setup
}

@test "show usage if 'h' (help) command is passed" {
    run boo h
    assert_output --partial 'Environment Diagnoser'
    assert_output --partial 'Usage'
}

@test "show usage if 'help' command is passed" {
    run boo help
    assert_output --partial 'Environment Diagnoser'
    assert_output --partial 'Usage'
}

