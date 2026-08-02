#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/../../lib/doctor.sh"

execute() {

    echo
    echo "NVIDIA"
    echo "------------------"

    check_command "NVIDIA Driver" "nvidia-smi"

}