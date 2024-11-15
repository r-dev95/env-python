# -----------------------------------------------------------------------------
# This is a script to install a poetry on Ubuntu.
#
# 1. Update a ubuntu packages.
# 2. Install poetry.
#    install path: ~/.local/share/pypoetry/
# 3. Set environment variables in poetry.
#    The official poetry procedure describes to set one of the following paths.
#       - $HOME/.local/bin (the following symbolic link exists)
#       - ~/.local/share/pypoetry/venv/bin/poetry
#    In Ubuntu, $HOME/.local/bin is set in ~/.profile.
#    Therefore, we will just call ~/.profile.
# 4. Enable tab completion for poetry.
# 5. Change the poetry cache directory.
#    (The virtual environment build directory will also change.)
#
# Command:
#   source install_poetry.sh
#   - If necessary, enter your sudo password.
# -----------------------------------------------------------------------------
#!/bin/bash

# Unset variables and functions.
function unset_var() {
    unset dpath
    unset unset_var
}

# poetry cache directory
dpath=~/.env

cd ~/

# Update a ubuntu packages.
echo '----------------------------------------------------------------------'
echo 'Update a ubuntu packages.'
echo '----------------------------------------------------------------------'
sudo apt-get update
sudo apt-get upgrade -y

# Install poetry.
echo '----------------------------------------------------------------------'
echo 'Install poetry.'
echo '----------------------------------------------------------------------'
curl -sSL https://install.python-poetry.org | python3 -

# Set environment variables in poetry.
echo '----------------------------------------------------------------------'
echo 'Set environment variables in poetry.'
echo '----------------------------------------------------------------------'
. ~/.profile

# Enable tab completion for poetry.
echo '----------------------------------------------------------------------'
echo 'Enable tab completion for poetry.'
echo '----------------------------------------------------------------------'
poetry completions bash >> ~/.bash_completion
. ~/.bash_completion

# Change the poetry cache directory.
echo '----------------------------------------------------------------------'
echo 'Change the poetry cache directory.'
echo '----------------------------------------------------------------------'
poetry config cache-dir $dpath

cd $dpath

unset_var

echo 'done.'
