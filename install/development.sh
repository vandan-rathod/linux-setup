#!/usr/bin/env bash

set -euo pipefail

source "($dirname "${BASH_SOURCE[0]}")/../lib/installer.sh"
source "($dirname "${BASH_SOURCE[0]}")/../lib/config.sh"

install_development() {
    load_config
    log_info "Installing development tools..."
    install_packages "${SYSTEM_PACKAGES[@]}"
    log_success "Development tools completed."
}