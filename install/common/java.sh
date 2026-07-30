#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/../lib/installer.sh"


install_java() {

    log_info "Installing Java..."

    install_packages \
        java-21-openjdk \
        java-21-openjdk-devel


    log_success "Java installed."

}