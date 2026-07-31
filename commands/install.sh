#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

source "$SCRIPT_DIR/lib/logger.sh"
source "$SCRIPT_DIR/lib/distro.sh"
source "$SCRIPT_DIR/lib/module_manager.sh"

echo

echo "Installing Development Environment..."
echo

source "$SCRIPT_DIR/lib/profile_manager.sh"


if [[ "${1:-}" == "--profile" ]]; then

    load_profile "$2"

else

    MODULES=("$@")

    source "$SCRIPT_DIR/lib/confirm.sh"
    source "$SCRIPT_DIR/lib/preview.sh"


    show_install_plan


    confirm_action "Proceed with installation?"

fi

TOTAL=${#MODULES[@]}
CURRENT=0

source "$SCRIPT_DIR/lib/confirm.sh"

confirm_installation

for module in "${MODULES[@]}"; do

    CURRENT=$((CURRENT+1))

    echo
    echo "[$CURRENT/$TOTAL] Installing $module"

    load_module "$module"

    installer="install_${module}"

    "$installer"

done

log_success "Requested module installed successfully!"
