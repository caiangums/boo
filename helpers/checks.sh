#!/usr/bin/env bash

is_missing_info() {
    tool=$1
    if [ -z "$tool" ]; then
        return 1
    fi

    name=$(echo "${tool}_name")
    command_check=$(echo "${tool}_command_check")

    if [ -z "${!name}" ] || [ -z "${!command_check}" ]; then
        return 1
    fi

    return 0
}

