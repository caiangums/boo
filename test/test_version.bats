setup() {
    load 'test_helper/common-setup'
    _common_setup
}

@test "show version if 'v' (version) command is passed" {
    run boo v
    assert_success
    assert_output --regexp "v[0-9]+\.[0-9]+\.[0-9]$"
}

@test "show version if 'version' command is passed" {
    run boo version
    assert_success
    assert_output --regexp "v[0-9]+\.[0-9]+\.[0-9]$"
}

