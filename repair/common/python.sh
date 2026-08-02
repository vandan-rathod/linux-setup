#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/../../lib/repair.sh"
source "$(dirname "${BASH_SOURCE[0]}")/../../lib/repair_actions.sh"
source "$(dirname "${BASH_SOURCE[0]}")/../../lib/logger.sh"


execute() {

    echo
    echo "Diagnosing Python..."
    echo

    run_diagnosis python


    case "$DOCTOR_CODE" in

        HEALTHY)

            log_success "Python is already healthy."
            ;;


        COMMAND_MISSING)

            install_package python3

            repair_verify python

            ;;


        *)

            log_error "Unknown Python issue: $DOCTOR_CODE"

            return 1
            ;;

    esac

}