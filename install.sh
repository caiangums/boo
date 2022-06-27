#!/usr/bin/env bash

# boo install script

# variables 
EXTRACT_DIR=$(mktemp -d /tmp/boo.XXXXX)
EXTRACT_DIR="$HOME/code/boo"
BOO_DIR="/usr/local/boo"
BOO_CONFIG_FILE="$HOME/.boo_dir"
BOO_SYMLINK="/usr/local/bin/boo"

remove_previous_config_file() {
    if [ -f $BOO_CONFIG_FILE ]; then
        rm $BOO_CONFIG_FILE
    fi
}

remove_install_dir() {
    if [ -d $BOO_DIR ]; then
        rm -rf $BOO_DIR
    fi
}

if [ "$1" != "uninstall" ]; then
    echo -e "Downloading and extracting boo..."
        curl -L https://api.github.com/repos/caiangums/boo/tarball/latest-release | tar -xzp -C $EXTRACT_DIR --strip-components=1
    echo -e "Installing boo..."
    remove_install_dir
    cp -r $EXTRACT_DIR $BOO_DIR
    remove_previous_config_file
    echo "$BOO_DIR" > $BOO_CONFIG_FILE
    ln -s $BOO_DIR/boo $BOO_SYMLINK
else
    echo -e "Uninstalling boo..."
    rm $BOO_SYMLINK
    remove_previous_config_file
    remove_install_dir
fi
echo -e "Cleaning up..."
    rm -rf $EXTRACT_DIR
echo -e "All done."
