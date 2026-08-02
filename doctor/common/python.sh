#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/../../lib/doctor.sh"

execute() {

    echo
    echo "Python"
    echo "------------------"

    check_command "Python" "python3"

}