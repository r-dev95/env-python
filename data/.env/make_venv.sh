# -------------------------------------------------------------------
# pythonの仮想環境を構築するスクリプト
#
# コマンド:
#   source make_venv.sh $1 $2 $3
#       $1: 仮想環境を構築するディレクトリパス
#       $2: 仮想環境名
#       $3: pipパッケージ一覧のファイルパス
# -------------------------------------------------------------------
#!/bin/bash

# 変数と関数をunsetする関数。
function unset_var() {
    unset dpath
    unset name
    unset fpath
    unset unset_var
}

# 引数を確認する。
if [ $# -eq 3 ]; then
    dpath=$1
    name=$2
    fpath=$3
else
    echo '引数は3個指定しなけれなならない。'
    echo '$1: 仮想環境を構築するディレクトリパス'
    echo '$2: 仮想環境名'
    echo '$3: pipパッケージ一覧のファイルパス'
    echo '指定された引数は'$#'個です。'
    return 1
fi
if [ ! -d $dpath ]; then
    echo 'ディレクトリが存在しません。'
    echo '仮想環境を構築するディレクトリパス: '$dpath
    return 1
fi
if [ -d $name ]; then
    echo '仮想環境は既に存在します。'
    echo '仮想環境名: '$name
    return 1
fi
if [ ! -f $fpath ]; then
    echo 'ファイルが存在しません。'
    echo 'pipパッケージ一覧のファイルパス: '$fpath
    return 1
fi

# 仮想環境を構築する。
echo '下記設定で仮想環境を構築します。'
echo '--------------------------------------------------'
echo '仮想環境を構築するディレクトリパス: '$dpath
echo '仮想環境名: '$name
echo 'pipパッケージ一覧のファイルパス: '$fpath
echo '--------------------------------------------------'

cd $dpath
python -m venv $name
. $dpath/$name/bin/activate
pip install -r $fpath

