#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/../../lib/logger.sh"


install_flutter() {

    log_info "Installing Flutter on Arch..."


    if command -v flutter &>/dev/null; then
        log_success "Flutter already installed."
        return 0
    fi


    sudo pacman -S --noconfirm flutter


    log_success "Flutter installed."

}