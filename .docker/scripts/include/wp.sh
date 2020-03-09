#!/bin/bash

# Check if wp (wp-cli) is globally installed
function is_wp_installed () {
  if ! [ -x "$(command -v wp)" ]; then
    echo 'Error: wp is not installed.' >&2
    echo 'Please install WP-CLI (https://wp-cli.org/) before running any script.'
    exit 1
fi
}
