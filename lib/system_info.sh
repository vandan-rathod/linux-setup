#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/distro.sh"
source "$(dirname "${BASH_SOURCE[0]}")/package_manager.sh"


show_system_info() {

    detect_distro
    ensure_package_manager


    echo
    echo "System Information"
    echo "------------------"

    echo "OS: $DISTRO"
    echo "Package Manager: $PACKAGE_MANAGER"

    echo

}