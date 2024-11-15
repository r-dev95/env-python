# -----------------------------------------------------------------------------
# This is a script to install a python on Ubuntu.
#
# 1. Update a ubuntu packages.
# 2. Install python.
# 3. Set a alias.
#    By default, Ubuntu does not have ~/.bash_aliases,
#    but ~/.bashrc calls ~/.bash_aliases, so set it there.
#
# Command:
#   source install_python.sh
#   - If necessary, enter your sudo password.
# -----------------------------------------------------------------------------
#!/bin/bash

# Update a ubuntu packages.
echo '----------------------------------------------------------------------'
echo 'Update a ubuntu packages.'
echo '----------------------------------------------------------------------'
sudo apt-get update
sudo apt-get upgrade -y

# Install python.
echo '----------------------------------------------------------------------'
echo 'Install python.'
echo '----------------------------------------------------------------------'
sudo apt-get install -y \
    python3 \
    python3-venv \
    python3-pip

# Set a alias.
echo '----------------------------------------------------------------------'
echo 'Set a alias.'
echo '----------------------------------------------------------------------'
echo '# Set python' >> ~/.bash_aliases
echo alias python=\'python3\' >> ~/.bash_aliases
. ~/.bash_aliases

echo done.
