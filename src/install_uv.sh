# -----------------------------------------------------------------------------
# This is a script to install a uv on Ubuntu.
#
# 1. Update a ubuntu packages.
# 3. Install uv.
#    install path: ~/.local/bin/
# 4. Enable tab completion for uv and uvx.
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

# Install uv.
echo '----------------------------------------------------------------------'
echo 'Install uv.'
echo '----------------------------------------------------------------------'
curl -LsSf https://astral.sh/uv/install.sh | sh

# Enable tab completion for uv and uvx.
echo '----------------------------------------------------------------------'
echo 'Enable tab completion for uv and uvx.'
echo '----------------------------------------------------------------------'
echo >> ~/.bashrc
echo '# Set uv and uvx' >> ~/.bashrc
echo 'eval "$(uv generate-shell-completion bash)"' >> ~/.bashrc
echo 'eval "$(uvx --generate-shell-completion bash)"' >> ~/.bashrc
. ~/.bashrc

echo 'done.