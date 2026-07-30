#!/usr/bin/env bash

#============================
# DevForge Color Definitions
#============================

# Prevent loading twice
if [[ -n "${DEVFORGE_COLORS_LOADED:-}" ]]; then
    return
fi

DEVFORGE_COLORS_LOADED=1


readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[0;34m'
readonly CYAN='\033[0;36m'
readonly MAGENTA='\033[0;35m'
readonly WHITE='\033[1;37m'
readonly RESET='\033[0m'
