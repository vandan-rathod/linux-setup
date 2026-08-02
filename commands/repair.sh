#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

source "$SCRIPT_DIR/lib/logger.sh"
source "$SCRIPT_DIR/lib/action_loader.sh"

echo
echo "Running DevForge Repair..."
echo

MODULES=("$@")

TOTAL=${#MODULES[@]}
CURRENT=0

for module in "${MODULES[@]}"; do

    CURRENT=$((CURRENT + 1))

    MODULE_NAME="${module^}"

    echo
    echo "[$CURRENT/$TOTAL] Repairing $MODULE_NAME"

    load_action_module repair "$module"

    if declare -f execute >/dev/null; then

        execute

        unset -f execute

    else

        log_error "Repair module '$module' doesn't export execute()."
        exit 1

    fi

done

log_success "Repair completed."

repair_module() {

    local module="$1"

    run_diagnosis "$module"

    echo "$DOCTOR_CODE"

}