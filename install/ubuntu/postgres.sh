#!/usrs/bin/env bash

set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/../../lib/logger.sh"

install_postgres() {
    log_info "Installing PostgreSQL on Ubuntu..."

    if command -v psql &>/dev/null;
    then
        log_success "PostgreSQL already installed."
        return 0
    fi

    sudo apt update

    sudo apt install -y \
    postgresql\
    postgresql-contrib

    sudo systemctl enable postgresql
    sudo systemctl start postgresql

    log_success "PostgreSQL installed."    
}