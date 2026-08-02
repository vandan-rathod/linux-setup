#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/../../lib/repair.sh"
source "$(dirname "${BASH_SOURCE[0]}")/../../lib/repair_actions.sh"
source "$(dirname "${BASH_SOURCE[0]}")/../../lib/logger.sh"


execute() {

    echo
    echo "Diagnosing Git..."
    echo

    run_diagnosis git


    case "$DOCTOR_CODE" in

        HEALTHY)

            log_success "Git is already healthy."
            ;;


        COMMAND_MISSING)

            install_package git
            repair_verify git
            ;;


        *)

            log_error "Unknown Git issue: $DOCTOR_CODE"
            return 1
            ;;

    esac

}