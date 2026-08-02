#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

source "$SCRIPT_DIR/lib/logger.sh"
source "$SCRIPT_DIR/lib/distro.sh"
source "$SCRIPT_DIR/lib/action_loader.sh"
source "$SCRIPT_DIR/lib/profile_manager.sh"
source "$SCRIPT_DIR/lib/doctor.sh"

echo "Running DevForge Doctor..."
echo
echo "Analyzing development environment..."

source "$SCRIPT_DIR/lib/profile_manager.sh"

if [[ "${1:-}" == "--profile" ]]; then

    load_profile "$2"

else

    if [[ $# -eq 0 ]]; then

        source "$SCRIPT_DIR/configs/modules.conf"

        MODULES=("${DOCTOR_MODULES[@]}")

    else

        MODULES=("$@")

    fi

fi

TOTAL=${#MODULES[@]}
CURRENT=0

for module in "${MODULES[@]}"; do

    CURRENT=$((CURRENT+1))

    MODULE_NAME="${module^}"

    echo
    echo "[$CURRENT/$TOTAL] Checking $MODULE_NAME"
    load_action_module doctor "$module"

    if declare -f execute >/dev/null; then

        execute

        unset -f execute

    else

        log_error "Doctor module '$module' doesn't export execute()."
        exit 1

    fi

done

echo
echo "===================="
echo "Doctor Summary"
echo "===================="
echo

echo "Checks Passed: $CHECKS_PASSED"
echo "Checks Failed: $CHECKS_FAILED"

echo

if [[ "$CHECKS_FAILED" -eq 0 ]]; then

    log_success "System is healthy."

else

    log_warning "Some issues require attention."

fi