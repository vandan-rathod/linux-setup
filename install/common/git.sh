#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/../../lib/installer.sh"


execute() {

    log_info "Installing Git tools..."

    install_packages \
        git \
        git-lfs

    if ! command -v gh >/dev/null 2>&1; then
        install_package gh
    else
        log_success "GitHub CLI already installed."
    fi

    log_success "Git setup completed."

}