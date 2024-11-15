# -----------------------------------------------------------------------------
# This is a script to build a python virtual environment.
#
# 1. Build a virtual environment with venv.
# 2. Install a pyhon packages with pip.
#
# Command:
#   source build_venv.sh $1 $2 $3
#       $1: Required - parent directory of the virtual environment
#       $2: Required - virtual environment name
#       $3: Required - file path containing python package
# -----------------------------------------------------------------------------
#!/bin/bash

# Unset variables and functions.
function unset_var() {
    unset dpath
    unset name
    unset fpath
    unset unset_var
}

# command line arguments
dpath=$1
name=$2
fpath=$3

# Check an arguments.
if [ ! -d $dpath ]; then
    echo '----------------------------------------------------------------------'
    echo 'Directory does not exist.'
    echo '----------------------------------------------------------------------'
    echo '$1: Required - parent directory of the virtual environment: '$dpath
    echo '----------------------------------------------------------------------'
    return 1
fi
if [ -d $name ]; then
    echo '----------------------------------------------------------------------'
    echo 'The virtual environment already exists.'
    echo '----------------------------------------------------------------------'
    echo '$2: Required - virtual environment name: '$name
    echo '----------------------------------------------------------------------'
    return 1
fi
if [ ! -f $fpath ]; then
    echo '----------------------------------------------------------------------'
    echo 'File does not exist.'
    echo '----------------------------------------------------------------------'
    echo '$3: Required - file path containing python package: '$fpath
    echo '----------------------------------------------------------------------'
    return 1
fi

echo '----------------------------------------------------------------------'
echo 'Build a virtual environment with the following settings:'
echo '----------------------------------------------------------------------'
echo 'parent directory of the virtual environment: '$dpath
echo 'virtual environment name: '$name
echo 'file path containing python package: '$fpath
echo '----------------------------------------------------------------------'

# Build a virtual environment with venv.
python -m venv $name

# Install a pyhon packages with pip.
. $dpath/$name/bin/activate
pip install -r $fpath

unset_var
