#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/../../lib/logger.sh"


install_nvidia() {

    log_info "Installing NVIDIA drivers for Arch..."

    sudo pacman -S --noconfirm \
        nvidia \
        nvidia-utils


    log_success "NVIDIA driver installation completed."
    log_warning "A reboot is required."

}