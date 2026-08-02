#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/../../lib/repair.sh"
source "$(dirname "${BASH_SOURCE[0]}")/../../lib/repair_actions.sh"
source "$(dirname "${BASH_SOURCE[0]}")/../../lib/logger.sh"


execute() {

    echo
    echo "Diagnosing PostgreSQL..."
    echo

    run_diagnosis postgres


    case "$DOCTOR_CODE" in

        HEALTHY)

            log_success "PostgreSQL is already healthy."
            ;;


        SERVICE_DOWN)

            restart_service postgresql
            repair_verify postgres
            ;;


        SERVICE_DISABLED)

            enable_service postgresql
            repair_verify postgres
            ;;


        COMMAND_MISSING)

            install_package postgresql-client
            repair_verify postgres
            ;;


        *)

            log_error "Unknown PostgreSQL issue: $DOCTOR_CODE"
            return 1
            ;;

    esac

}