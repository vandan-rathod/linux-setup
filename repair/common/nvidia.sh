#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/../../lib/repair.sh"
source "$(dirname "${BASH_SOURCE[0]}")/../../lib/repair_actions.sh"
source "$(dirname "${BASH_SOURCE[0]}")/../../lib/logger.sh"


execute() {

    echo
    echo "Diagnosing NVIDIA..."
    echo

    run_diagnosis nvidia


    case "$DOCTOR_CODE" in

        HEALTHY)

            log_success "NVIDIA driver is healthy."
            ;;


        COMMAND_MISSING)

            log_error "NVIDIA driver is missing."

            echo
            echo "NVIDIA installation is hardware and distro dependent."
            echo "Use:"
            echo "    devforge install nvidia"

            return 1
            ;;


        *)

            log_error "Unknown NVIDIA issue: $DOCTOR_CODE"
            return 1
            ;;

    esac

}