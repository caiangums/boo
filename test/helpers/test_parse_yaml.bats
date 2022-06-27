setup() {
    load '../test_helper/bats-support/load'
    load '../test_helper/bats-assert/load'

    # get the containing directory of this file
    # use $BATS_TEST_FILENAME instead of ${BASH_SOURCE[0]} or $0,
    # as those will point to the bats executable's location or the preprocessed file respectively
    DIR="$( cd "$( dirname "$BATS_TEST_FILENAME" )" >/dev/null 2>&1 && pwd )"
    # make executables in src/ visible to PATH
    PATH="$DIR/..:$PATH"
    . helpers/parse_yaml.sh
}

@test "parse a yaml file" {
    run parse_yaml test/mocks/test_yaml_file.yml
    assert_output $'typhon_tag="typhon"\ntyphon_name="Typhon"\ntyphon_command_check="typhon"'
}

