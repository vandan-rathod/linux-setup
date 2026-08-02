#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/../../lib/doctor.sh"

execute() {

    echo
    echo "PostgreSQL"
    echo "------------------"


    check_command "PostgreSQL" "psql"


    if has_service postgresql; then

        if is_service_running postgresql; then

            log_success "PostgreSQL service is running."

        else

            log_warning "PostgreSQL service exists but is stopped."

        fi


    else

        log_warning "PostgreSQL service does not exist."

    fi

}