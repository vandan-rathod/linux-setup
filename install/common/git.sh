#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/../lib/installer.sh"


install_git() {

    log_info "Installing Git tools..."


    install_packages \
        git \
        git-lfs


    if command -v gh &>/dev/null
    then
        log_success "GitHub CLI already installed."
    else
        install_package gh
    fi


    log_success "Git setup completed."

}