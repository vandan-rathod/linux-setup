#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/logger.sh"

check_root() {
    if [[ $EUID -eq 0 ]]; then
        log_error "Do not run DevForge as root."
        exit 1
    fi
}

check_sudo() {
    if ! sudo -v; then
        log_error "Sudo privileges are required."
        exit 1
    fi

    log_success "Sudo authentication successful."
}

check_internet() {
    if ping -c 1 google.com &>/dev/null; then
        log_success "Internet connection available."
    else
        log_error "No internet connection."
        exit 1
    fi
}

check_dnf() {
    if command -v dnf &>/dev/null; then
        log_success "DNF package manager detected."
    else
        log_error "DNF is not installed."
        exit 1
    fi
}