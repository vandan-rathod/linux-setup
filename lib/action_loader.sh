#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/logger.sh"
source "$(dirname "${BASH_SOURCE[0]}")/distro.sh"


load_action_module() {

    local action="$1"
    local module="$2"

    detect_distro

    local module_path=""

    # Try distro-specific module first
    case "$DISTRO" in

        fedora)
            module_path="../$action/fedora/$module.sh"
            ;;

        ubuntu|debian)
            module_path="../$action/ubuntu/$module.sh"
            ;;

        arch)
            module_path="../$action/arch/$module.sh"
            ;;

        *)
            log_error "Unsupported distribution."
            return 1
            ;;

    esac

    # Fallback to common module
    if [[ ! -f "$(dirname "${BASH_SOURCE[0]}")/$module_path" ]]; then
        module_path="../$action/common/$module.sh"
    fi

    if [[ -f "$(dirname "${BASH_SOURCE[0]}")/$module_path" ]]; then
        source "$(dirname "${BASH_SOURCE[0]}")/$module_path"
    else
        log_error "$action module '$module' not found."
        return 1
    fi

}