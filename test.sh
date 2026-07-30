#!/usr/bin/env bash

set -euo pipefail

source lib/installer.sh

detect_package_manager

install_packages \
    git \
    curl \
    wget