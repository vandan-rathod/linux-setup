#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/../../lib/repair.sh"
source "$(dirname "${BASH_SOURCE[0]}")/../../lib/repair_actions.sh"
source "$(dirname "${BASH_SOURCE[0]}")/../../lib/logger.sh"


execute() {

    echo
    echo "Diagnosing Flutter..."
    echo

    run_diagnosis flutter


    case "$DOCTOR_CODE" in

        HEALTHY)

            log_success "Flutter is already healthy."
            ;;


        COMMAND_MISSING)

            install_package flutter
            repair_verify flutter
            ;;


        *)

            log_error "Unknown Flutter issue: $DOCTOR_CODE"
            return 1
            ;;

    esac

}
