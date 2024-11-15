# -----------------------------------------------------------------------------
# This is a script to install a pyenv on Ubuntu.
#
# 1. Update a ubuntu packages.
# 2. Install python build dependency packages.
# 3. Install pyenv.
#    install path: ~/.pyenv/
# 4. Set environment variables in pyenv.
#    The official pyenv procedure describes how to set it in the following file.
#       - ~/.bashrc
#       - ~/.profile      (If the file exists)
#       - ~/.bash_profile (If the file exists)
#       - ~/.bash_login   (If the file exists)
#    Ubuntu has ~/.profile, which calls ~/.bashrc, so set it only in ~/.bashrc.
#
# Command:
#   source install_pyenv.sh
#   - If necessary, enter your sudo password.
#
# Note:
#   Do not install python with pyenv install.
#   Do not set pyenv local or pyenv global.
# -----------------------------------------------------------------------------
#!/bin/bash

# Unset variables and functions.
function unset_var() {
    unset fpath
    unset val
    unset unset_var
}

cd ~/

# Update a ubuntu packages.
echo '----------------------------------------------------------------------'
echo 'Update a ubuntu packages.'
echo '----------------------------------------------------------------------'
sudo apt-get update
sudo apt-get upgrade -y

# Install python build dependency packages.
echo '----------------------------------------------------------------------'
echo 'Install python build dependency packages.'
echo '----------------------------------------------------------------------'
sudo apt-get install -y \
    build-essential \
    libssl-dev \
    zlib1g-dev \
    libbz2-dev \
    libreadline-dev \
    libsqlite3-dev \
    curl \
    git \
    libncursesw5-dev \
    xz-utils \
    tk-dev \
    libxml2-dev \
    libxmlsec1-dev \
    libffi-dev \
    liblzma-dev

# Install pyenv.
echo '----------------------------------------------------------------------'
echo 'Install pyenv.'
echo '----------------------------------------------------------------------'
curl https://pyenv.run | bash

# Set environment variables in pyenv.
echo '----------------------------------------------------------------------'
echo 'Set environment variables in pyenv.'
echo '----------------------------------------------------------------------'
# fpath=(~/.bashrc ~/.profile)
fpath=(~/.bashrc)
for val in ${fpath[@]}; do
    echo >> $val
    echo '# Set PYENV_ROOT' >> $val
    echo 'export PYENV_ROOT="$HOME/.pyenv"' >> $val
    echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> $val
    echo 'eval "$(pyenv init -)"' >> $val
    . $val
done

cd ~/.env/

unset_var

echo 'done.'
