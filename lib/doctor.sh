#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/logger.sh"
source "$(dirname "${BASH_SOURCE[0]}")/package_manager.sh"

DOCTOR_STATUS="PASS"
DOCTOR_REASON=""
DOCTOR_CODE=""

if [[ -z "${CHECKS_PASSED+x}" ]]; then
    CHECKS_PASSED=0
fi

if [[ -z "${CHECKS_FAILED+x}" ]]; then
    CHECKS_FAILED=0
fi

has_command() {

    command -v "$1" >/dev/null 2>&1

}

has_package() {

    is_installed "$1"

}

has_service() {

    systemctl list-unit-files --type=service | grep -q "^$1.service"

}

is_service_running() {

    systemctl is-active --quiet "$1"

}

doctor_success() {

    local message="$1"

    CHECKS_PASSED=$((CHECKS_PASSED + 1))

    DOCTOR_STATUS="PASS"
    DOCTOR_REASON=""
    DOCTOR_CODE="HEALTHY"

    log_success "$message"

}

doctor_warning() {

    local module="$1"
    local message="$2"

    echo
    echo "$module"
    echo "------------------"

    log_warning "$message"

}

doctor_failure() {

    local message="$1"
    local repair="$2"
    local code="$3"

    CHECKS_FAILED=$((CHECKS_FAILED + 1))

    DOCTOR_STATUS="FAIL"
    DOCTOR_REASON="$message"
    DOCTOR_CODE="$code"

    log_error "$message"

    echo
    echo "Suggested Fix:"
    echo "    devforge repair $repair"

}

check_command() {

    local module="$1"
    local command="$2"

    if has_command "$command"; then

        doctor_success \
            "Command '$command' found."

    else

        doctor_failure \
            "Command '$command' not found." \
            "${module,,}" \
            "COMMAND_MISSING"

    fi

}

check_service() {

    local module="$1"
    local service="$2"


    if ! systemctl list-unit-files | grep -q "^${service}.service"; then

        doctor_failure \
            "Service '$service' does not exist." \
            "${module,,}" \
            "SERVICE_MISSING"

        return 1

    fi


    if systemctl is-active --quiet "$service"; then

        doctor_success \
            "Service '$service' is running."

        return 0

    fi


    if systemctl is-enabled --quiet "$service"; then

        doctor_failure \
            "Service '$service' is stopped." \
            "${module,,}" \
            "SERVICE_DOWN"

    else

        doctor_failure \
            "Service '$service' is disabled." \
            "${module,,}" \
            "SERVICE_DISABLED"

    fi

}

check_package() {

    local module="$1"
    local package="$2"

    if has_package "$package"; then

        doctor_success \
            "$module" \
            "Package '$package' is installed."

    else

        doctor_failure \
            "$module" \
            "Package '$package' is not installed."

    fi

}

get_doctor_status() {

    echo "$DOCTOR_STATUS"

}

get_doctor_reason() {

    echo "$DOCTOR_REASON"

}