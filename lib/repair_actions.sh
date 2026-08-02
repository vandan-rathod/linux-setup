#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/logger.sh"
source "$(dirname "${BASH_SOURCE[0]}")/package_manager.sh"

restart_service() {

    local service="$1"

    log_info "Restarting $service service..."


    if ! systemctl list-unit-files | grep -q "^${service}.service"; then

        log_error "Service '$service' does not exist."

        return 1

    fi


    sudo systemctl restart "$service"


    if systemctl is-active --quiet "$service"; then

        log_success "$service service restarted."

    else

        log_error "Failed to restart $service service."

        return 1

    fi

}

install_package() {

    local package="$1"

    log_info "Installing package $package..."

    case "$PACKAGE_MANAGER" in

        apt)

            sudo apt install -y "$package"
            ;;

        dnf)

            sudo dnf install -y "$package"
            ;;

        pacman)

            sudo pacman -S --noconfirm "$package"
            ;;

        *)

            log_error "Unsupported package manager."

            return 1
            ;;

    esac


    log_success "$package installed."

}

enable_service() {

    local service="$1"

    log_info "Enabling $service service..."

    sudo systemctl enable "$service"

    sudo systemctl start "$service"


    if systemctl is-active --quiet "$service"; then

        log_success "$service service enabled and running."

    else

        log_error "Failed to enable $service service."

        return 1

    fi

}