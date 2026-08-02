#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/logger.sh"
source "$(dirname "${BASH_SOURCE[0]}")/package_manager.sh"


uninstall_package() {

    local package="$1"


    log_info "Removing $package..."


    remove_package "$package"


    log_success "$package removed."

}