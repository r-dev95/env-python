# -------------------------------------------------------------------
# Ubuntu上にasdfをインストールするスクリプト
#
# 1. Ubuntuパッケージの更新
# 2. asdfの依存関係とpythonのビルド依存関係パッケージのインストール
#       asdfの公式手順では、pythonのビルド依存関係パッケージのインストールは、
#       特に指定されていません。
#       しかしpythonインストール時にエラーになるため、インストールします。
#       インストールするパッケージはpyenvと同様です。
# 3. asdfのインストール
#       ~/.asdfにインストールされる。
# 4. asdfの環境変数の設定
#       Ubuntuには~/.bashrc以外にも~/.profileがあるが、その中で、
#       ~/.bashrcを呼び出すので、~/.bashrcにのみ設定する。
# 5. asdfのタブ補完の有効化
# 6. asdfのpythonプラグインのインストール
#
# Note:
#   asdf installでpythonのインストールはしない。
#   asdf localやasdf globalの設定もしない。
#
# コマンド:
#   source install_asdf.sh
#       sudoのパスワードを入力する。
# -------------------------------------------------------------------
#!/bin/bash

# Ubuntuのパッケージを更新する。
echo ------------------------------------------------------------
echo Ubuntuパッケージを更新します。
echo ------------------------------------------------------------
sudo apt-get update
sudo apt-get upgrade -y

# asdfの依存関係パッケージをインストールする。
echo ------------------------------------------------------------
echo asdfの依存関係とpythonのビルド依存関係パッケージをインストールします。
echo ------------------------------------------------------------
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

# asdfをインストールする。
echo ------------------------------------------------------------
echo asdfをインストールします。
echo ------------------------------------------------------------
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.1

# 環境変数の設定
echo ------------------------------------------------------------
echo asdfの環境変数を設定します。
echo ------------------------------------------------------------
echo >> ~/.bashrc
echo '# Set asdf' >> ~/.bashrc
echo . "$HOME/.asdf/asdf.sh" >> ~/.bashrc
. ~/.bashrc

# タブ補完を有効化する
echo ------------------------------------------------------------
echo asdfのタブ補完を有効化します。
echo ------------------------------------------------------------
echo . "$HOME/.asdf/completions/asdf.bash" >> ~/.bashrc
. ~/.bashrc

# pythonプラグインをインストールする
echo ------------------------------------------------------------
echo asdfのpythonプラグインをインストールします。
echo ------------------------------------------------------------
asdf plugin-list-all | grep python # 確認
asdf plugin-add python

echo 'done.'
