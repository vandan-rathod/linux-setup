load_module() {

    local module="$1"

    detect_distro


    local base_dir
    base_dir="$(dirname "${BASH_SOURCE[0]}")/../install"


    local distro_module="$base_dir/$DISTRO/$module.sh"
    local common_module="$base_dir/common/$module.sh"


    if [ -f "$distro_module" ]; then

        MODULE_PATH="$distro_module"


    elif [ -f "$common_module" ]; then

        MODULE_PATH="$common_module"


    else

        log_error "Module '$module' not found."
        return 1

    fi


    

    source "$MODULE_PATH"

}

execute_module() {

    local module="$1"

    load_module "$module"


    local installer="install_${module}"


    if declare -f "$installer" >/dev/null; then

        "$installer"

    else

        log_error "Installer function '$installer' missing."
        return 1

    fi

}