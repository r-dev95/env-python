# -----------------------------------------------------------------------------
# This is a script to install a asdf on Ubuntu.
#
# 1. Update a ubuntu packages.
# 2. Install asdf dependency packages and python build dependency packages.
#    The official asdf procedure does not specify the installation of
#    python build dependency packages. However, since an error occurs
#    when installing python, we will install them. The packages to be
#    installed are the same as pyenv.
# 3. Install asdf.
#    install path: ~/.asdf/
# 3. Set environment variables in asdf.
#    Ubuntu has ~/.profile, which calls ~/.bashrc, so set it only in ~/.bashrc.
# 4. Enable tab completion for asdf.
# 5. Install the asdf python plugin.
#
# Note:
#   Do not install python with asdf install.
#   Do not set asdf local or asdf global.
#
# Command:
#   source install_asdf.sh
#   - If necessary, enter your sudo password.
# -----------------------------------------------------------------------------
#!/bin/bash

# Update a ubuntu packages.
echo '----------------------------------------------------------------------'
echo 'Update a ubuntu packages.'
echo '----------------------------------------------------------------------'
sudo apt-get update
sudo apt-get upgrade -y

# Install asdf dependency packages and python build dependency packages.
echo '----------------------------------------------------------------------'
echo 'Install asdf dependency packages and python build dependency packages.'
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

# Install asdf.
echo '----------------------------------------------------------------------'
echo 'Install asdf.'
echo '----------------------------------------------------------------------'
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.1

# Set environment variables in asdf.
echo '----------------------------------------------------------------------'
echo 'Set environment variables in asdf.'
echo '----------------------------------------------------------------------'
echo >> ~/.bashrc
echo '# Set asdf' >> ~/.bashrc
echo . "$HOME/.asdf/asdf.sh" >> ~/.bashrc
. ~/.bashrc

# Enable tab completion for asdf.
echo '----------------------------------------------------------------------'
echo 'Enable tab completion for asdf.'
echo '----------------------------------------------------------------------'
echo . "$HOME/.asdf/completions/asdf.bash" >> ~/.bashrc
. ~/.bashrc

# Install the asdf python plugin.
echo '----------------------------------------------------------------------'
echo 'Install the asdf python plugin.'
echo '----------------------------------------------------------------------'
asdf plugin-list-all | grep python # check
asdf plugin-add python

echo 'done.'
