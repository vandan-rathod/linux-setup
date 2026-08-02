#!/usr/bin/env bash

set -euo pipefail


SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"


source "$SCRIPT_DIR/lib/logger.sh"
source "$SCRIPT_DIR/lib/confirm.sh"
source "$SCRIPT_DIR/lib/uninstall_actions.sh"


module="${1:-}"


if [[ -z "$module" ]]; then

    log_error "Usage: devforge uninstall <module>"
    exit 1

fi


echo
echo "Uninstall Plan"
echo "=============="
echo
echo "Module:"
echo "  $module"
echo


if confirm_action "Continue with uninstall?"; then

    uninstall_package "$module"

else

    log_info "Uninstall cancelled."

fi