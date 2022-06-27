setup() {
    load '../test_helper/bats-support/load'
    load '../test_helper/bats-assert/load'

    # get the containing directory of this file
    # use $BATS_TEST_FILENAME instead of ${BASH_SOURCE[0]} or $0,
    # as those will point to the bats executable's location or the preprocessed file respectively
    DIR="$( cd "$( dirname "$BATS_TEST_FILENAME" )" >/dev/null 2>&1 && pwd )"
    # make executables in src/ visible to PATH
    PATH="$DIR/..:$PATH"
    . helpers/checks.sh
}

@test "is_missing_info: check failure when no param is passed" {
    run is_missing_info 
    assert_failure
}

@test "is_missing_info: check for failure on 'missingtool' present without local 'name' and 'command_check' definition" {
    tool="missingtool"
    run is_missing_info $tool
    assert_failure
}

@test "is_missing_info: check for success on 'missingtool' with local 'name' but not 'command_check' definition" {
    tool="missingtool"
    missingtool_command_check="missingtool_command_check"
    run is_missing_info $tool
    assert_failure
}

@test "is_missing_info: check for success on 'missingtool' with local 'command_check' but not 'name' definition" {
    tool="missingtool"
    missingtool_name="missingtool_name"
    run is_missing_info $tool
    assert_failure
}

@test "is_missing_info: check for success on 'presenttool' with local 'name' and 'command_check' definition" {
    tool="presenttool"
    presenttool_name="presenttool_name"
    presenttool_command_check="presenttool_command_check"
    run is_missing_info $tool
    assert_success
}
