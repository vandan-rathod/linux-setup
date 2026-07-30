#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/../../lib/logger.sh"


install_flutter() {

    log_info "Installing Flutter on Fedora..."


    if command -v flutter &>/dev/null; then
        log_success "Flutter already installed."
        return 0
    fi


    sudo dnf install -y snapd

    sudo ln -s /var/lib/snapd/snap /snap || true

    sudo snap install flutter --classic


    log_success "Flutter installed."

}