#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

source "$SCRIPT_DIR/lib/logger.sh"
source "$SCRIPT_DIR/lib/update_actions.sh"
source "$SCRIPT_DIR/lib/confirm.sh"


module="${1:-}"


if [[ -z "$module" ]]; then

    log_error "Usage: devforge update <module>"

    exit 1

fi


echo
echo "Update Plan"
echo "==========="
echo
echo "Module:"
echo "  $module"
echo


if confirm_action "Continue with update?"; then

    update_package "$module"

else

    log_info "Update cancelled."

fi