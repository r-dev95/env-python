# -----------------------------------------------------------------------------
# This is a script to activate a python virtual environment.
#
# Command:
#   source activate.sh $1
#       $1: Required - virtual environment name
# -----------------------------------------------------------------------------
#!/bin/bash

# Unset variables and functions.
function unset_var() {
    unset dpath
    unset envname
    unset envnames
    unset val
    unset unset_var
}

# parent directory of the virtual environment
dpath=~/.env

# command line arguments
envname=$1

# Get the name of the builded virtual environment.
for val in $(find $dpath -name activate); do
    val=(${val//// })
    envnames+=(${val[-3]})
done

if [ ! -d $dpath/$envname ]; then
    echo '----------------------------------------------------------------------'
    echo $dpath/$envname' - Activation failed.'
    echo 'virtual environment:'
        for val in ${envnames[@]}; do
            echo '  '${val}
        done
    echo '----------------------------------------------------------------------'
    return 1
fi

# Activate the virtual environment.
for val in ${envnames[@]}; do
    if [ $envname = $val ]; then
        . $dpath/$envname/bin/activate
        echo '----------------------------------------------------------------------'
        echo $dpath/$envname' - Activation successful.'
        echo '----------------------------------------------------------------------'
        break
    fi
done

unset_var