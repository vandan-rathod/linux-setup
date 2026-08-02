#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/../../lib/doctor.sh"

execute() {

    echo
    echo "VS Code"
    echo "------------------"

    check_command "VS Code" "code"

}