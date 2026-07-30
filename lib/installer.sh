#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/package_manager.sh"


install_packages() {

    for package in "$@"
    do
        install_package "$package"
    done

}