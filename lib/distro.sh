detect_distro() {

    if [ -n "${DISTRO:-}" ]; then
        return 0
    fi


    if [ -f /etc/fedora-release ]; then

        DISTRO="fedora"

    elif [ -f /etc/arch-release ]; then

        DISTRO="arch"

    elif [ -f /etc/debian_version ]; then

        DISTRO="ubuntu"

    else

        log_error "Unsupported Linux distribution."
        return 1

    fi



}