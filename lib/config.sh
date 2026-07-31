#!/usr/bin/env bash

set -euo pipefail


load_config() {

    local config_file="$(dirname "${BASH_SOURCE[0]}")/../configs/packages.conf"


    if [[ -f "$config_file" ]]; then

        source "$config_file"

    else

        echo "Config file not found: $config_file"
        return 1

    fi

}