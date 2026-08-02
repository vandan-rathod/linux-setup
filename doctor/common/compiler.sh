#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/../../lib/doctor.sh"


execute() {

    echo
    echo "C/C++ Compiler"
    echo "------------------"


    check_command "GCC" "gcc"

    check_command "G++" "g++"

}