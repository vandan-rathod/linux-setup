#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/../../lib/logger.sh"


install_nvidia() {

    log_info "Checking NVIDIA driver..."

    if command -v nvidia-smi &>/dev/null; then
        log_success "NVIDIA driver already installed."
        return 0
    fi


    log_info "Installing NVIDIA drivers..."

    sudo ubuntu-drivers autoinstall


    log_success "NVIDIA driver installation completed."
    log_warning "A reboot is required."

}