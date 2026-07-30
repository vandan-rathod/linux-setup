#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/logger.sh"


detect_distro() {

    if [ -f /etc/fedora-release ]; then
        DISTRO="fedora"

    elif [ -f /etc/ubuntu-release ] || grep -qi ubuntu /etc/os-release; then
        DISTRO="ubuntu"

    elif grep -qi debian /etc/os-release; then
        DISTRO="debian"

    elif [ -f /etc/arch-release ]; then
        DISTRO="arch"

    else
        log_error "Unsupported Linux distribution."
        exit 1
    fi


    log_info "Detected distro: $DISTRO"

}