#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

source "$SCRIPT_DIR/lib/logger.sh"
source "$SCRIPT_DIR/lib/distro.sh"
source "$SCRIPT_DIR/lib/action_loader.sh"

echo

echo "Installing Development Environment..."
echo

source "$SCRIPT_DIR/lib/profile_manager.sh"


if [[ "${1:-}" == "--profile" ]]; then

    load_profile "$2"

else

    MODULES=("$@")

fi

source "$SCRIPT_DIR/lib/preview.sh"

show_install_plan

source "$SCRIPT_DIR/lib/confirm.sh"

confirm_installation "Proceed with installation?"

TOTAL=${#MODULES[@]}
CURRENT=0

for module in "${MODULES[@]}"; do

    CURRENT=$((CURRENT+1))

    echo
    echo "[$CURRENT/$TOTAL] Installing $module"

    load_action_module install "$module"

    if declare -f execute >/dev/null; then

        execute

        unset -f execute

    else

        log_error "Module '$module' doesn't export execute()."
        exit 1

    fi

done

log_success "Installation completed successfully!"