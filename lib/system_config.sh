#!/usr/bin/env bash

set -euo pipefail

SYSTEM_CONFIG="configs/system.conf"


load_system_config() {

    if [[ ! -f "$SYSTEM_CONFIG" ]]; then

        echo "System configuration missing."
        return 1

    fi


    source "$SYSTEM_CONFIG"

}