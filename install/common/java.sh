#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/../../lib/package_manager.sh"
source "$(dirname "${BASH_SOURCE[0]}")/../../lib/distro.sh"
source "$(dirname "${BASH_SOURCE[0]}")/../../lib/logger.sh"


install_java() {

    detect_distro

    log_info "Installing Java..."


    case "$DISTRO" in

        fedora)

            install_package java-21-openjdk-devel

            ;;


        ubuntu|debian)

            install_package openjdk-21-jdk

            ;;


        arch)

            install_package jdk21-openjdk

            ;;


        *)

            log_error "Unsupported distro for Java."
            return 1

            ;;

    esac


    log_success "Java setup completed."

}