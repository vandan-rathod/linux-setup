#!/usr/bin/env bash

set -euo pipefail

source "(dirname "${BASH_SOURCE[0]}")/../../lib/logger.sh"

install_postgres() {
    log_info "Installing PostgreSQL on Arch..."

    if command -v psql &>/dev/null;
    then
        log_success "PostgreSQL already installed."
        return 0
    fi

    sudo pacman -S --noconfirm postgresql

    log_success "PostgreSQl installed."
}