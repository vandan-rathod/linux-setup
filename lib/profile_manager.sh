#!/usr/bin/env bash

set -euo pipefail


source "$(dirname "${BASH_SOURCE[0]}")/logger.sh"


load_profile() {

    local profile="$1"


    source "$(dirname "${BASH_SOURCE[0]}")/../configs/profiles.conf"


    local variable="PROFILE_${profile}"


    if declare -p "$variable" &>/dev/null; then

        eval "MODULES=(\"\${${variable}[@]}\")"

    else

        log_error "Profile '$profile' not found."
        return 1

    fi

}