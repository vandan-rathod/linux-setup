#!usr/bin/env bash

set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/colors.sh"

LOG_FILE="logs/DevForge.log"

mkdir -p logs
touch "$LOG_FILE"

timestamp() {
    date "+%Y-%m-%d %H:%M:%S"
}

log_info() {
    echo -e "${BLUE}[INFO]${RESET} $1"
    echo "[INFO] $(timestamp) $1">>"$LOG_FILE"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${RESET} $1"
    echo "[SUCCESS] $(timestamp) $1">>"$LOG_FILE"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${RESET} $1"
    echo "[WARNING] $(timestamp) $1" >> "$LOG_FILE"
}

log_error() {
    echo -e "${RED}[ERROR]${RESET} $1"
    echo "[ERROR] $(timestamp) $1" >> "$LOG_FILE"
}