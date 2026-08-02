#!/usr/bin/env bash

set -euo pipefail


SYSTEM_CONFIG="configs/system.conf"


source "$(dirname "${BASH_SOURCE[0]}")/system_config.sh"


initialize_devforge() {


    if [[ -f "$SYSTEM_CONFIG" ]]; then

        return 0

    fi


    echo
    echo "First DevForge setup..."
    echo

    create_system_conf


    echo
    echo "System configuration created."
    echo

}