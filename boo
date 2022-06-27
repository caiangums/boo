#!/usr/bin/env bash

VERSION="0.0.1"

# load boo config file
BOO_DIR=""
if [ -f $HOME/.boo_dir ]; then
    BOO_DIR="`cat $HOME/.boo_dir`/"
fi

. ${BOO_DIR}helpers/parse_yaml.sh
. ${BOO_DIR}helpers/checks.sh

installed_tools=""
not_validated_tools=""
not_installed_tools=""
missing_info=""

_present_tool() {
    tool=$1
    name=$(echo -e ${tool}_name)
    command_check=$(echo -e ${tool}_command_check)

    if ! command -v ${!command_check} &> /dev/null ; then
        not_installed_tools="$not_installed_tools\n - ${!name}"

        not_present_message=$(echo -e ${tool}_message_not_present)
        if [ ! -z "${!not_present_message}" ]; then
            not_installed_tools="$not_installed_tools: ${!not_present_message}"
        fi
    else
        installed_tools="$installed_tools\n - ${!name}"
    fi

}

_build_information() {
    if [ -z "$1" ]; then
        echo -e "No config file specified!"
        usage
        exit 1
    fi

    eval $(parse_yaml $1)

    for tool in $(compgen -A variable | grep "_tag")
    do
        validate=$(echo -e ${!tool}_validate)
        if [ -z "${!validate}" ] || [ "${!validate}" == "true" ]; then
            is_missing_info ${!tool}
            if [ $? -eq 1 ]; then
                missing_info="$missing_info\n - ${tool}"
            else
                _present_tool $tool
            fi
        else
            not_validated_tools="$not_validated_tools\n - ${!tool}"

            not_validating_message=$(echo -e ${!tool}_message_not_validating)
            if [ ! -z "${!not_validating_message}" ]; then
                not_validated_tools="$not_validated_tools: ${!not_validating_message}"
            fi
        fi
    done
}

diagnose_cmd() {
    local ret=0
   
    config_file=$1
    _build_information $config_file

    if [ ! -z "$installed_tools" ]; then
        echo -e "Installed Tools:$installed_tools"
    fi

    if [ ! -z "$not_validated_tools" ]; then
        echo -e "Not Validated Tools:$not_validated_tools"
    fi

    if [ ! -z "$not_installed_tools" ]; then
        echo -e "Missing Tools:$not_installed_tools"
        ret=1
    fi

    if [ ! -z "$missing_info" ]; then
        echo -e "Missing Info on Tools:$missing_info"
        ret=1
    fi

    exit $ret
}

list_cmd() {
    local ret=0

    config_file=$1
    _build_information $config_file

    if [ ! -z "$not_validated_tools" ]; then
        echo -e "Not Validated Tools:$not_validated_tools"
    fi

    if [ ! -z "$not_installed_tools" ]; then
        echo -e "Missing Tools:$not_installed_tools"
        ret=1
    else
        echo -e "No missing Tools! :)"
    fi

    if [ ! -z "$missing_info" ]; then
        echo -e "Note: Some checks cannot be performed due some issues with config file"
        ret=1
    fi

    exit $ret
}

BOO_ASCII=`cat ${BOO_DIR}boo_ascii`

version() {
    local name=$(basename $0)
    cat <<EOF

$BOO_ASCII

$name - Environment Diagnoser v$VERSION
EOF
}


usage() {
    local name=$(basename $0)
    cat <<EOF

$BOO_ASCII

$name - Environment Diagnoser

Usage:
    $name d|diagnose <config-file>       # Diagnose the local environment
    $name l|list <config-file>           # List missing tools on local environment
    $name h|help                         # Print this info
    $name v|version                      # Display actual boo version
EOF
}

main() {
    local ret=0
    local cmd=""

    if [ -z "$1" ]; then
        echo -e "No command specified!"
        usage
        exit 1
    fi

    case "$1" in
        d|diagnose)
            cmd="diagnose_cmd"
            ;;
        l|list)
            cmd="list_cmd"
            ;;
        v|version)
            cmd="version"
            ;;
        h|help)
            cmd="usage"
            ;;
        *)
            echo -e "Unknown command: $1\n"
            usage
            exit 1
            ;;
    esac
    shift

    $cmd "$@" || ret=$?
    exit $ret
}

main "$@"
