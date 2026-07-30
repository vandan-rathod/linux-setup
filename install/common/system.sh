#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/../../lib/installer.sh"
source "$(dirname "${BASH_SOURCE[0]}")/../../lib/config.sh"
source "$(dirname "${BASH_SOURCE[0]}")/../../lib/package_manager.sh"


install_system() {

    load_config

    log_info "Updating system..."

    update_system


    log_info "Installing base packages..."

    install_packages "${SYSTEM_PACKAGES[@]}"


    log_success "System setup completed."

}