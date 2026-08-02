#!/usr/bin/env bash

set -euo pipefail


detect_os() {

    if [[ -f /etc/os-release ]]; then

        source /etc/os-release

        echo "$ID"

    else

        echo "unknown"

    fi

}


detect_architecture() {

    uname -m

}


detect_shell() {

    basename "$SHELL"

}


detect_desktop() {

    echo "${XDG_CURRENT_DESKTOP:-unknown}"

}


detect_gpu() {

    if command -v nvidia-smi >/dev/null 2>&1; then

        echo "nvidia"

    else

        echo "none"

    fi

}