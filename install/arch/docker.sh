#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/../../lib/logger.sh"


install_docker() {

    log_info "Installing Docker on Arch..."


    if command -v docker &>/dev/null; then
        log_success "Docker already installed."
        return 0
    fi


    sudo pacman -S --noconfirm docker docker-compose


    sudo systemctl enable docker
    sudo systemctl start docker


    sudo usermod -aG docker "$USER"


    log_success "Docker installed successfully."
    log_warning "Logout/login required for Docker group changes."

}