#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/../../lib/doctor.sh"

execute() {

    echo
    echo "Flutter"
    echo "------------------"

    check_command "Flutter" "flutter"

}