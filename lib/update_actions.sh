#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/logger.sh"
source "$(dirname "${BASH_SOURCE[0]}")/package_manager.sh"

ensure_package_manager


update_package() {

    local package="$1"

    log_info "Updating $package..."


    case "$PACKAGE_MANAGER" in

        apt)

            sudo apt update
            sudo apt install --only-upgrade -y "$package"
            ;;


        dnf)

            sudo dnf upgrade -y "$package"
            ;;


        pacman)

            sudo pacman -S --noconfirm "$package"
            ;;


        *)

            log_error "Unsupported package manager."
            return 1
            ;;

    esac


    log_success "$package updated."

}