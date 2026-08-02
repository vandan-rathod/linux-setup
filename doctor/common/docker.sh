#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/../../lib/doctor.sh"


execute() {

    echo
    echo "Docker"
    echo "------------------"


    if has_command docker; then

        doctor_success "Docker Command"

    else

        doctor_failure \
            "Docker" \
            "Docker command is missing." \
            "COMMAND_MISSING"

        return

    fi


    if has_service docker; then

        if is_service_running docker; then

            log_success "Docker service is running."

        else

            log_warning "Docker service exists but is stopped."

        fi

    else

        log_warning "Docker service does not exist."

    fi

}