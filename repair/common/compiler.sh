#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/../../lib/repair.sh"
source "$(dirname "${BASH_SOURCE[0]}")/../../lib/repair_actions.sh"
source "$(dirname "${BASH_SOURCE[0]}")/../../lib/logger.sh"


execute() {

    echo
    echo "Diagnosing C/C++ Compiler..."
    echo


    run_diagnosis compiler


    case "$DOCTOR_CODE" in

        HEALTHY)

            log_success "Compiler tools are already healthy."
            ;;


        COMMAND_MISSING)

            install_package build-essential

            repair_verify compiler
            ;;


        *)

            log_error "Unknown compiler issue: $DOCTOR_CODE"
            return 1
            ;;

    esac

}