#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/../lib/logger.sh"


install_rpmfusion() {

    log_info "Checking RPM Fusion repositories..."

    if rpm -q rpmfusion-free-release &>/dev/null &&
       rpm -q rpmfusion-nonfree-release &>/dev/null
    then
        log_success "RPM Fusion already enabled."
        return 0
    fi


    log_info "Installing RPM Fusion..."

    sudo dnf install -y \
    https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
    https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm


    log_success "RPM Fusion enabled."

}