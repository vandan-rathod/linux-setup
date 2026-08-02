#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/../../lib/repair.sh"
source "$(dirname "${BASH_SOURCE[0]}")/../../lib/repair_actions.sh"
source "$(dirname "${BASH_SOURCE[0]}")/../../lib/logger.sh"


execute() {

    echo
    echo "Diagnosing Java..."
    echo

    run_diagnosis java


    case "$DOCTOR_CODE" in

        HEALTHY)

            log_success "Java is already healthy."
            ;;


        COMMAND_MISSING)

            install_package openjdk-21-jdk
            repair_verify java
            ;;


        *)

            log_error "Unknown Java issue: $DOCTOR_CODE"
            return 1
            ;;

    esac

}