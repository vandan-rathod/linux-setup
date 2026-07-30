#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/../../lib/logger.sh"


install_vscode() {

    log_info "Installing VS Code on Arch..."


    if command -v code &>/dev/null; then
        log_success "VS Code already installed."
        return 0
    fi


    sudo pacman -S --noconfirm code


    log_success "VS Code installed."

}