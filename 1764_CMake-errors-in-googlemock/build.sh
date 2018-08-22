#!/bin/bash

main() {
    cd "$(dirname "$(readlink -f "$0")")" || {
        error_exit "Failed to cd to script directory."
    }

    git clean -dffx

    cd ./build || {
        error_exit "Failed to cd to build directory."
    }

    cmake -DCMAKE_INSTALL_PREFIX=install \
          .. || {
        error_exit "cmake generation failed."
    }

    cmake --build . --config Debug || {
        error_exit "cmake build failed."
    }

    cmake --build . --config Debug --target install || {
        error_exit "Failed to install."
    }
}

error_exit() {
    echo
    echo "Error: $@"
    echo "----------------------------------------------------------------------"
    echo
    exit 1
}

main "$@"
exit 0
