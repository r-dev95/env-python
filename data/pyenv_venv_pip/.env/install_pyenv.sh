# -------------------------------------------------------------------
# Ubuntu上にpyenvをインストールするスクリプト
#
# 1. Ubuntuパッケージの更新
# 2. pythonのビルド依存関係のパッケージのインストール
# 3. pyenvのインストール
# 4. pyenvの環境変数の設定
#
# Note:
#   pyenv installでpythonのインストールはしない。
#   pyenv localやpyenv globalの設定もしない。
#
# コマンド:
#   source install_pyenv.sh
#       sudoのパスワードを入力する。
# -------------------------------------------------------------------
#!/bin/bash

# 変数と関数をunsetする関数。
function unset_var() {
    unset fpath
    unset name
    unset unset_var
}

cd ~/

# Ubuntuのパッケージを更新する。
echo ------------------------------
echo Ubuntuパッケージを更新します。
echo ------------------------------
sudo apt-get update
sudo apt-get upgrade -y

# pythonのビルド依存関係のパッケージをインストールする。
echo ------------------------------
echo pythonのビルド依存関係の
echo パッケージをインストールします。
echo ------------------------------
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

# pyenvをインストールする。
echo ------------------------------
echo pyenvをインストールします。
echo ------------------------------
curl https://pyenv.run | bash
# 環境変数の設定
#   pyenvの公式の手順には、
#   ~/.bashrcと下記がある場合は設定するよう記載されている。
#       - ~/.profile
#       - ~/.bash_profile
#       - ~/.bash_login
#   Ubuntuには~/.profileがあるが、
#   ~/.profileは、~/.bashrcを呼び出すので~/.bashrcにのみ設定する。
# fpath=(~/.bashrc ~/.profile)
fpath=(~/.bashrc)
for name in ${fpath[@]}; do
    echo >> $name
    echo '# Set PYENV_ROOT' >> $name
    echo 'export PYENV_ROOT="$HOME/.pyenv"' >> $name
    echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> $name
    echo 'eval "$(pyenv init -)"' >> $name
    . $name
done

cd ~/.env/

unset_var