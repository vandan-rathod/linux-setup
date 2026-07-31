#!/usr/bin/env bash

set -euo pipefail


show_menu() {

    echo
    echo "========================="
    echo "        DevForge"
    echo "========================="
    echo

    echo "1) Full Development Setup"
    echo "2) Mobile Development"
    echo "3) Backend Development"
    echo "4) AI Development"
    echo "5) Custom Installation"
    echo "6) List Modules"
    echo "7) List Profiles"
    echo "8) Exit"

    echo

}


handle_menu() {

    while true; do

        show_menu

        read -rp "Select option: " choice


        case "$choice" in

            1)
                "$SCRIPT_DIR/devforge" install --profile full
                ;;


            2)
                "$SCRIPT_DIR/devforge" install --profile mobile
                ;;


            3)
                "$SCRIPT_DIR/devforge" install --profile backend
                ;;


            4)
                "$SCRIPT_DIR/devforge" install --profile ai
                ;;


            5)
                echo
                read -rp "Enter modules: " modules

                "$SCRIPT_DIR/devforge" install $modules
                ;;


            6)
                "$SCRIPT_DIR/devforge" modules
                ;;


            7)
                "$SCRIPT_DIR/devforge" profiles
                ;;


            8)
                echo "Goodbye."
                exit 0
                ;;


            *)
                echo "Invalid option."
                ;;

        esac

    done

}