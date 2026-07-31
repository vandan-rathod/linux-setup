#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/distro.sh"
source "$(dirname "${BASH_SOURCE[0]}")/logger.sh"


PACKAGE_MANAGER=""


detect_package_manager() {

    if [ -n "$PACKAGE_MANAGER" ]; then
        return 0
    fi


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

        *)
            log_error "Unsupported distribution: $DISTRO"
            return 1
            ;;

    esac



}


ensure_package_manager() {

    if [ -z "$PACKAGE_MANAGER" ]; then
        detect_package_manager
    fi

}


is_installed() {

    ensure_package_manager

    local package="$1"


    case "$PACKAGE_MANAGER" in

        dnf)
            rpm -q "$package" &>/dev/null
            ;;

        apt)
            dpkg -s "$package" &>/dev/null
            ;;

        pacman)
            pacman -Q "$package" &>/dev/null
            ;;

        *)
            log_error "Unsupported package manager: $PACKAGE_MANAGER"
            return 1
            ;;

    esac

}


install_package() {

    ensure_package_manager


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

        pacman)
            sudo pacman -S --noconfirm "$package"
            ;;

        *)
            log_error "Unsupported package manager: $PACKAGE_MANAGER"
            return 1
            ;;

    esac


    if is_installed "$package"; then

        log_success "$package installed successfully."

    else

        log_error "Failed to install $package."
        return 1

    fi

}


remove_package() {

    ensure_package_manager


    local package="$1"


    if ! is_installed "$package"; then

        log_warning "$package is not installed."
        return 0

    fi


    log_info "Removing $package..."


    case "$PACKAGE_MANAGER" in

        dnf)
            sudo dnf remove -y "$package"
            ;;

        apt)
            sudo apt remove -y "$package"
            ;;

        pacman)
            sudo pacman -R --noconfirm "$package"
            ;;

        *)
            log_error "Unsupported package manager: $PACKAGE_MANAGER"
            return 1
            ;;

    esac


    log_success "$package removed."

}


update_system() {

    ensure_package_manager


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

        *)
            log_error "Unsupported package manager: $PACKAGE_MANAGER"
            return 1
            ;;

    esac


    log_success "System updated."

}