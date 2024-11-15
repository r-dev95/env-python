# -----------------------------------------------------------------------------
# This is a script to build a project and python virtual environment on Ubuntu.
#
# 1. Run make_project.sh.
# 2. Run additional processing for each virtual environment.
#
# Usage:
#   1. Make a file that lists the python packages.
#      Name the file <env-name>.txt and place it in the same directory as this
#      script.
#   2. Set the python version in A_python_ver.
#   3. Set the parent directory path to build the virtual environment in A_dpath.
#      A_dpath is same to poetry cache directory.
#   4. Set parent directory path to build the project in A_dpath_pj.
#   5. Set the virtual environment name in A_envnames.
#   6. If necessary, add processing for each virtual environment to the case
#      statement.
#
# Command:
#   source setup.sh
#
# Note:
#   This script calls make_project.sh, which unsets the variables and functions
#   used in the script.
#   Therefore, the names of the variables and functions used are prefixed
#   with 'A_' so that they do not overlap with those of this script.
#
# -----------------------------------------------------------------------------
#!/bin/bash

# Unset variables and functions.
function A_unset_var() {
    unset A_python_ver
    unset A_dpath
    unset A_dpath_pj
    unset A_envnames
    unset A_name
    unset A_unset_var
}

# python version
A_python_ver=3.12.3
# parent directory path to build the virtual environment
A_dpath=~/.env
# parent directory path to build the project
A_dpath_pj=~/work

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
    . make_project.sh $A_dpath_pj $A_name "$A_dpath/$A_name.txt $A_dpath/docs.txt $A_dpath/test.txt" "main docs test" $A_python_ver

    # Run additional processing.
    case $A_name in # Set a virtual environment.
        tf-gpu)
            ;;
        to-gpu)
            poetry source add --priority=explicit pytorch-cu118 https://download.pytorch.org/whl/cu118
            poetry add torch torchvision torchaudio --source pytorch-cu118
            ;;
        pyside)
            ;;
        flet)
            ;;
        django)
            ;;
    esac
done

cd ~

A_unset_var
