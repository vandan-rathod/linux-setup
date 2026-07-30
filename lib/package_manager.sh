#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/distro.sh"
source "$(dirname "${BASH_SOURCE[0]}")/logger.sh"

PACKAGE_MANAGER=""

detect_package_manager() {

    detect_distro

    case "$DISTRO" in

        fedora)
            PACKAGE_MANAGER="dnf"
            ;;

        ubuntu|debian)
            PACKAGE_MANAGER="apt"
            ;;

        arch)
            PACKAGE_MANAGER="pacman"
            ;;

    esac


    log_info "Package manager: $PACKAGE_MANAGER"

}

is_installed() {

    local package="$1"

    case "$PACKAGE_MANAGER" in

        dnf)
            rpm -q "$package" &>/dev/null
            ;;

        apt)
            dpkg -s "$package" &>/dev/null
            ;;

        *)
            log_error "Unsupported package manager."
            return 1
            ;;

    esac
}

install_package() {
    local package="$1"

    if is_installed "$package"; then 
        log_success "$package is already installed."
        return 0
    fi

    log_info "Installing $package..."

    case "$PACKAGE_MANAGER" in

        dnf)
            sudo dnf install -y "$package"
            ;;
    
        apt)
            sudo apt install -y "$package"
            ;;
    
    esac

    if is_installed "$package"; then 
        log_success "$package installed successfully."

    else 
        log_error "failed to install $package."
        return 1
    fi
}

remove_package() {
    local package="$1"

    if ! is_installed "$package"; then
        log_warning "$package is not installed."
        return 0
    fi

    log_info "Removing $package..."

    sudo dnf remove -y "$package"

    log_success "$package removed."
}

update_system() {

    log_info "Updating packages..."

    case "$PACKAGE_MANAGER" in

        dnf)
            sudo dnf upgrade -y
            ;;

        apt)
            sudo apt update
            sudo apt upgrade -y
            ;;

        pacman)
            sudo pacman -Syu --noconfirm
            ;;

    esac

    log_success "System updated."

}