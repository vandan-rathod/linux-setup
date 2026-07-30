#!/usr/bin/env bash

set -euo pipefail

load_config() {
    source "$(dirname "${BASH_SOURCCE[0]}")/../config/packages.conf"
}
