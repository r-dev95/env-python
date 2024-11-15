# -----------------------------------------------------------------------------
# This is a script to build a project and virtual environment.
#
# 1. Install python with asdf. (If already there, skip)
# 2. Make a project with poetry.
# 3. Install a python packages eith poetry.
#    (The virtual environment is automatically created.)
#
# Command:
#   source make_project.sh $1 $2 $3 $4 $5
#       $1: Required - parent directory of the project
#       $2: Required - project name
#       $3: Required - file path containing python package
#                      When specifying multiple values, separate them with
#                      spaces and enclose the whole set in quotation marks.
#       $4: Required - group for poetry add --group (Default is main)
#                      When specifying multiple values, separate them with
#                      spaces and enclose the whole set in quotation marks.
#       $5: Required - python version
# -----------------------------------------------------------------------------
#!/bin/bash

# Unset variables and functions.
function unset_var() {
    unset dpath
    unset name
    unset fpath
    unset fpaths
    unset group
    unset groups
    unset python_ver
    unset old_python_ver
    unset val
    unset cnt
    unset unset_var
}

# command line arguments
dpath=$1
name=$2
fpath=$3
for val in ${fpath[@]}; do
    fpaths+=($val)
done
group=$4
for val in ${group[@]}; do
    groups+=($val)
done
python_ver=$5

# Check an arguments.
if [ ! -d $dpath ]; then
    echo '----------------------------------------------------------------------'
    echo 'Directory does not exist.'
    echo '----------------------------------------------------------------------'
    echo '$1: Required - parent directory of the project: '$dpath
    echo '----------------------------------------------------------------------'
    unset_var
    return 1
fi
if [ -d $dpath/$name ]; then
    echo '----------------------------------------------------------------------'
    echo 'The project already exists.'
    echo '----------------------------------------------------------------------'
    echo '$2: Required - project name: '$name
    echo '----------------------------------------------------------------------'
    unset_var
    return 1
fi
for val in ${fpaths[@]}; do
    if [ ! -f $val ]; then
        echo '----------------------------------------------------------------------'
        echo 'File does not exist.'
        echo '----------------------------------------------------------------------'
        echo '$3: Required - file path containing python package: '$val
        echo '  When specifying multiple values, separate them with'
        echo '  spaces and enclose the whole set in quotation marks.'
        echo '----------------------------------------------------------------------'
        unset_var
        return 1
    fi
done
if [ ${#fpaths[@]} -ne ${#groups[@]} ]; then
    echo '----------------------------------------------------------------------'
    echo 'The number of arguments below does not match.'
    echo '----------------------------------------------------------------------'
    echo '$3: Required - file path containing python package: '${#fpaths[@]}個, ${fpaths[@]}
    echo '  When specifying multiple values, separate them with'
    echo '  spaces and enclose the whole set in quotation marks.'
    echo '$4: Required - group for poetry add --group (Default is main): '${#groups[@]}個, ${groups[@]}
    echo '  When specifying multiple values, separate them with'
    echo '  spaces and enclose the whole set in quotation marks.'
    echo '----------------------------------------------------------------------'
    unset_var
    return 1
fi

echo '----------------------------------------------------------------------'
echo 'Build a project and virtual environment with the following settings:'
echo '----------------------------------------------------------------------'
echo 'parent directory of the project: '$dpath
echo 'project name: '$name
echo 'file path containing python package: '${fpaths[@]}
echo 'group for poetry add --group: '${groups[@]}
echo 'install python version: '$python_ver
echo '----------------------------------------------------------------------'

# Install python with asdf. (If already there, skip)
asdf install -s $python_ver

# Temporarily change the global python version.
fpath_global_ver=~/.tool-versions
res=0
if [ -f $fpath_global_ver ]; then
    while read line; do
        for val in ${line[@]}; do
            if [ ${val[0]} = 'python' ]; then
                res=1
                old_python_ver=${line//python /}
                break
            fi
        done
        if [ $res -eq 1 ]; then break; fi
    done < $fpath_global_ver
    if [ $res -eq 0 ]; then
        old_python_ver=$python_ver
    fi
else
    old_python_ver=$python_ver
fi
asdf global python $python_ver

# Make a project.
cd $dpath
poetry new $name

# Install a python packages eith poetry.
cd $name
cnt=0
for val in ${fpaths[@]}; do
    while read line; do
        poetry add $line --group ${groups[$cnt]}
    done < $val
    cnt=`expr $cnt + 1`
done

# Revert the global python version.
asdf global python $old_python_ver

unset_var
