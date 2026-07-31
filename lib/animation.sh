#!/usr/bin/env bash

set -euo pipefail

loading_animation() {
    local message="$1"

    echo -n "$message"

    for i in {i..3}; do
        echo -n "."
        sleep 0.4
    done

    echo
}