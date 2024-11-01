# -------------------------------------------------------------------
# Ubuntu上にpythonをインストールするスクリプト
#
# 1. Ubuntuパッケージの更新
# 2. pythonのインストール
#
# コマンド:
#   source install_python.sh
#       sudoのパスワードを入力する。
# -------------------------------------------------------------------
#!/bin/bash

# Ubuntuのパッケージを更新する。
echo ------------------------------
echo Ubuntuパッケージを更新します。
echo ------------------------------
sudo apt-get update
sudo apt-get upgrade -y

# pythonをインストールする。
echo ------------------------------
echo pythonをインストールします。
echo ------------------------------
sudo apt-get install -y \
    python3 \
    python3-venv \
    python3-pip

# aliasを設定する。
#   Ubuntuにデフォルトでは、~/.bash_aliasesはないが、
#   ~/.bashrcでは、~/.bash_aliasesを呼び出すのでこれに設定する。
echo '# Set python' >> ~/.bash_aliases
echo alias python=\'python3\' >> ~/.bash_aliases
. ~/.bash_aliases
