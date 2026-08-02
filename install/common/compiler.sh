#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/../../lib/package_manager.sh"
source "$(dirname "${BASH_SOURCE[0]}")/../../lib/logger.sh"


install_compiler() {

    log_info "Installing C/C++ development tools..."

    case "$PACKAGE_MANAGER" in

        apt)

            sudo apt install -y build-essential
            ;;

        dnf)

            sudo dnf group install -y "Development Tools"
            ;;

        pacman)

            sudo pacman -S --noconfirm base-devel
            ;;

        *)

            log_error "Unsupported package manager."
            return 1
            ;;

    esac


    log_success "Compiler tools installed."

}