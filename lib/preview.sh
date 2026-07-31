#!/usr/bin/env bash

set -euo pipefail


show_install_plan() {

    echo
    echo "Installation Plan"
    echo "================="
    echo

    echo "Modules:"

    for module in "${MODULES[@]}"; do
        echo "  ✓ $module"
    done

    echo

    echo "System:"
    echo "  OS: $DISTRO"
    echo "  Package Manager: $PACKAGE_MANAGER"

    echo

}