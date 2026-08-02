#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/../../lib/repair.sh"
source "$(dirname "${BASH_SOURCE[0]}")/../../lib/logger.sh"
source "$(dirname "${BASH_SOURCE[0]}")/../../lib/repair_actions.sh"

execute() {

    echo
    echo "Diagnosing Docker..."
    echo


    run_diagnosis docker


    case "$DOCTOR_CODE" in


        HEALTHY)

            log_success "Docker is already healthy."

            ;;


        SERVICE_DOWN)

            log_info "Docker service is stopped."
            log_info "Restarting Docker..."

            restart_service docker

            repair_verify docker

            ;;

        SERVICE_DISABLED)

            log_info "Docker service is disabled."

            enable_service docker

            repair_verify docker

            ;;


        COMMAND_MISSING)

            log_info "Docker is missing."

            install_package docker

            repair_verify docker

            ;;

        SERVICE_MISSING)

            log_info "Docker service is missing."

            install_package docker

            repair_verify docker

            ;;
        *)

            log_error "Unknown Docker issue: $DOCTOR_CODE"

            return 1

            ;;


    esac

}