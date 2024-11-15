# -----------------------------------------------------------------------------
# This is a script to build a python virtual environment.
#
# 1. Install python with pyenv. (If already there, skip)
# 2. Set the local python version with pyenv.
# 3. Build a virtual environment with venv.
# 4. Install a pyhon packages with pip.
#
# Command:
#   source build_venv.sh $1 $2 $3 $4
#       $1: Required - parent directory of the virtual environment
#       $2: Required - virtual environment name
#       $3: Required - file path containing python package
#       $4: Required - python version
# -----------------------------------------------------------------------------
#!/bin/bash

# Unset variables and functions.
function unset_var() {
    unset dpath
    unset name
    unset fpath
    unset python_ver
    unset unset_var
}

# command line arguments
dpath=$1
name=$2
fpath=$3
python_ver=$4

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
echo 'install python version: '$python_ver
echo '----------------------------------------------------------------------'

# Install python with pyenv.
pyenv install -s $python_ver

# Set the local python version with pyenv.
pyenv local $python_ver

# Build a virtual environment with venv.
python -m venv $name

# Install a pyhon packages with pip.
. $dpath/$name/bin/activate
pip install --upgrade pip
pip install -r $fpath

unset_var
