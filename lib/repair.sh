#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/doctor.sh"
source "$(dirname "${BASH_SOURCE[0]}")/logger.sh"
source "$(dirname "${BASH_SOURCE[0]}")/action_loader.sh"

run_diagnosis() {

    local module="$1"

    load_action_module doctor "$module"

    if declare -f execute >/dev/null; then

        execute

        unset -f execute

    else

        log_error "Doctor module '$module' missing."
        return 1

    fi

}


repair_status() {

    echo "$DOCTOR_STATUS"

}


repair_code() {

    echo "$DOCTOR_CODE"

}

repair_verify() {

    local module="$1"

    echo
    echo "Verifying repair..."
    echo


    run_diagnosis "$module"


    if [[ "$DOCTOR_CODE" == "HEALTHY" ]]; then

        log_success "$module repair completed successfully."

    else

        log_error "$module repair failed."

        return 1

    fi

}