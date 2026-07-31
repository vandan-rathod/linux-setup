#!/usr/bin/env bash

confirm_installation() {

    echo
    echo "Installation requires approval."
    echo

    read -rp "Continue? [y/N]: " answer


    case "$answer" in

        y|Y)
            return 0
            ;;

        *)
            echo "Installation cancelled."
            exit 0
            ;;

    esac

}