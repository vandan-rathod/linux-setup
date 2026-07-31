#!/usr/bin/env bash

set -euo pipefail

source "(dirname "${BASH_SOURCE[0]}")/../../lib/logger.sh"

install_postgres() {
    log_info "Installing PostgreSQL on fedora..."

    if command -v psql &>/dev/null;
    then
        log_success "PostgreSQL already installed."
        return 0
    fi

    sudo dnf install -y postgresql postgresql-server

    sudo postgresql-setup --initdb || true

    sudo systemctl enable postgresql
    sudo systemctl start postgresql

    log_success "PostgreSQL installed."
}