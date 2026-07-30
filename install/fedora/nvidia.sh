#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/../../lib/logger.sh"
source "$(dirname "${BASH_SOURCE[0]}")/../../lib/installer.sh"


install_nvidia() {

    log_info "Installing NVIDIA drivers for Fedora..."

    if ! command -v dnf &>/dev/null; then
        log_error "DNF not found. This module is Fedora only."
        return 1
    fi


    log_info "Enabling RPM Fusion NVIDIA repository..."

    sudo dnf install -y \
    https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
    https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm


    log_info "Installing NVIDIA driver..."

    sudo dnf install -y \
        akmod-nvidia \
        xorg-x11-drv-nvidia-cuda


    log_info "Updating kernel modules..."

    sudo akmods --force


    log_success "NVIDIA driver installation completed."
    log_warning "A reboot is required."

}