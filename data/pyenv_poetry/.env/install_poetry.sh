# -------------------------------------------------------------------
# Ubuntu上にpoetryをインストールするスクリプト
#
# 1. Ubuntuパッケージの更新
# 2. poetryのインストール
#       ~/.local/share/pypoetryにインストールされる。
# 3. poetryの環境変数の設定
#       poetryの公式手順では、下記のどちらかのパスを設定するように記載されている。
#           - $HOME/.local/bin (下記のシンボリックリンクが存在する)
#           - ~/.local/share/pypoetry/venv/bin/poetry
#       Ubuntuでは、~/.profileで$HOME/.local/binを設定している。
#       そのため、~/.profileを呼び出すだけとする。
# 4. poetryのタブ補完の有効化
#
# コマンド:
#   source install_poetry.sh
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

# poetryをインストールする。
echo ------------------------------
echo poetryをインストールします。
echo ------------------------------
curl -sSL https://install.python-poetry.org | python3 -
# 環境変数の設定
. ~/.profile
# タブ補完の有効化
poetry completions bash >> ~/.bash_completion
. ~/.bash_completion

cd ~/.env/

unset_var