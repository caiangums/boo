setup() {
    load 'test_helper/common-setup'
    _common_setup
}

@test "can run boo and check for no command specified" {
    run boo
    assert_failure
    assert_output --partial 'No command specified!'
}

@test "show usage if no command is passed" {
    run boo
    assert_failure
    assert_output --partial 'No command specified!'
    assert_output --partial 'boo - Environment Diagnoser'
}

