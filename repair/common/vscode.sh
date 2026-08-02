#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/../../lib/repair.sh"
source "$(dirname "${BASH_SOURCE[0]}")/../../lib/repair_actions.sh"
source "$(dirname "${BASH_SOURCE[0]}")/../../lib/logger.sh"


execute() {

    echo
    echo "Diagnosing VS Code..."
    echo

    run_diagnosis vscode


    case "$DOCTOR_CODE" in

        HEALTHY)

            log_success "VS Code is already healthy."
            ;;


        COMMAND_MISSING)

            install_package code
            repair_verify vscode
            ;;


        *)

            log_error "Unknown VS Code issue: $DOCTOR_CODE"
            return 1
            ;;

    esac

}