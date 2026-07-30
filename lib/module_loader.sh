#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/logger.sh"
source "$(dirname "${BASH_SOURCE[0]}")/distro.sh"


load_module() {

    local module="$1"

    detect_distro


    case "$DISTRO" in

        fedora)
            MODULE_PATH="../install/fedora/$module.sh"
            ;;

        ubuntu|debian)
            MODULE_PATH="../install/ubuntu/$module.sh"
            ;;

        arch)
            MODULE_PATH="../install/arch/$module.sh"
            ;;

        *)
            log_error "Unsupported distribution."
            return 1
            ;;

    esac


    if [ -f "$(dirname "${BASH_SOURCE[0]}")/$MODULE_PATH" ]; then
        
        source "$(dirname "${BASH_SOURCE[0]}")/$MODULE_PATH"

    else

        log_error "Module $module not found for $DISTRO."
        return 1

    fi

}
