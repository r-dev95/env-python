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
# 5. poetryのキャッシュディレクトリの変更(仮想環境の構築ディレクトリも変わる)
#
# コマンド:
#   source install_poetry.sh
#       sudoのパスワードを入力する。
# -------------------------------------------------------------------
#!/bin/bash

# 変数と関数をunsetする関数。
function unset_var() {
    unset dpath
    unset unset_var
}

# 仮想環境を構築するディレクトリパス
dpath=~/.env

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
# 環境変数を設定する
. ~/.profile
# タブ補完を有効化する
poetry completions bash >> ~/.bash_completion
. ~/.bash_completion
# 仮想環境を構築するディレクトリを変更する
poetry config cache-dir $dpath

cd $dpath

unset_var