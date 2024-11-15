# -----------------------------------------------------------------------------
# This is a script to build a python virtual environment on Ubuntu.
#
# 1. Run build_venv.sh.
# 2. Run common processing.
# 3. Run additional processing for each virtual environment.
#
# Usage:
#   1. Make a file that lists the python packages.
#      Name the file <env-name>.txt and place it in the same directory as this
#      script.
#   2. Set the virtual environment name in A_envnames.
#   3. If necessary, add common processing after build_venv.sh.
#   4. If necessary, add processing for each virtual environment to the case
#      statement.
#
# Command:
#   source setup.sh
#
# Note:
#   This script calls build_venv.sh, which unsets the variables and functions
#   used in the script.
#   Therefore, the names of the variables and functions used are prefixed
#   with 'A_' so that they do not overlap with those of this script.
#
# -----------------------------------------------------------------------------
#!/bin/bash

# Unset variables and functions.
function A_unset_var() {
    unset A_dpath
    unset A_envnames
    unset A_name
    unset A_unset_var
}

# parent directory path to build the virtual environment
A_dpath=~/.env

# array of virtual environment names
# If you comment it out, the virtual environment will not be created.
A_envnames=(
    tf-gpu  # tensorflow (gpu)
    to-gpu  # pytorch (gpu)
    # pyside  # pyside
    # flet    # flet
    # django  # django
)

# Build a virtual environment.
for A_name in ${A_envnames[@]}; do
    cd $A_dpath

    # Run a script to create a single virtual environment.
    . build_venv.sh $A_dpath $A_name $A_dpath/$A_name.txt

    # Run common processing.
    pip install -r $A_dpath/docs.txt # documentation packages (sphinx, etc.)
    pip install -r $A_dpath/test.txt # test packages (ruff, mypy, pytest, etc.)

    # Run additional processing.
    case $A_name in # Set a virtual environment.
        tf-gpu)
            ;;
        to-gpu)
            pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118
            ;;
        pyside)
            ;;
        flet)
            ;;
        django)
            ;;
    esac
done

deactivate
cd ~

A_unset_var
