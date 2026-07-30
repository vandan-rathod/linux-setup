#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/../../lib/logger.sh"


install_vscode() {

    log_info "Installing VS Code on Fedora..."


    if command -v code &>/dev/null; then
        log_success "VS Code already installed."
        return 0
    fi


    sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc


    sudo sh -c 'echo -e "[code]
name=Visual Studio Code
baseurl=https://packages.microsoft.com/yumrepos/vscode
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'


    sudo dnf install -y code


    log_success "VS Code installed."

}