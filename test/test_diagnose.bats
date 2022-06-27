setup() {
    load 'test_helper/common-setup'
    _common_setup
}

@test "show usage if 'd' (diagnose) command is passed without config file" {
    run boo d
    assert_failure
    assert_output --partial 'No config file specified!'
}

@test "show usage if 'diagnose' command is passed without config file" {
    run boo diagnose
    assert_failure
    assert_output --partial 'No config file specified!'
}

@test "read check_one_tool.yml config file, run the command and validates one installed tool" {
    run boo d test/mocks/check_one_tool.yml
    assert_success
    refute_output --partial 'Missing Tools:'
    assert_output $'Installed Tools:\n - One Tool'
}

@test "read check_one_missing_tool.yml config file, run the command and validates one missing tool" {
    run boo d test/mocks/check_one_missing_tool.yml
    assert_failure
    refute_output --partial 'Installed Tools:'
    assert_output $'Missing Tools:\n - Missing Tool'
}

@test "read check_two_tools.yml config file, run the command and validates two installed tools" {
    run boo d test/mocks/check_two_tools.yml
    assert_success
    refute_output --partial 'Missing Tools:'
    assert_output $'Installed Tools:\n - One Tool\n - Second Tool'
}

@test "read check_two_present_one_missing_tool.yml config file, run the command and validates two installed tools and one missing" {
    run boo d test/mocks/check_two_present_one_missing_tool.yml
    assert_failure
    assert_output $'Installed Tools:\n - One Tool\n - Second Tool\nMissing Tools:\n - Missing Tool'
}

@test "read check_malformed_tools.yml config file, run the command and inform about the malformed tool" {
    run boo d test/mocks/check_malformed_tools.yml
    assert_failure
    assert_output $'Missing Info on Tools:\n - edon\n - meow\n - typhon'
}

@test "read check_validate_two_and_not_validate_two_tools.yml config file, run the command and validate tools based on flag" {
    run boo d test/mocks/check_validate_two_and_not_validate_two_tools.yml
    assert_success
    assert_output $'Installed Tools:\n - Validate Empty Tool - validate field is empty (default: true)\n - Validate True Tool - validate field is true\nNot Validated Tools:\n - notvalidatetool\n - notvalidatewithmessagetool: Not Validating Message.'
}

