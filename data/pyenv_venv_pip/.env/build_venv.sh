# -------------------------------------------------------------------
# pythonの仮想環境を構築するスクリプト
#
# 1. pyenvでpythonのインストール
# 2. pyenvでpythonバージョンの設定
# 3. venvで仮想環境の構築
# 4. pipでpythonパッケージのインストール
#
# コマンド:
#   source build_venv.sh $1 $2 $3 $4
#       $1: 必須 - 構築する仮想環境ディレクトリの親パス
#       $2: 必須 - 仮想環境名
#       $3: 必須 - pythonパッケージ一覧のファイルパス
#       $4: 必須 - pythonバージョン
# -------------------------------------------------------------------
#!/bin/bash

# 変数と関数をunsetする関数。
function unset_var() {
    unset dpath
    unset name
    unset fpath
    unset python_ver
    unset unset_var
}

# 引数
dpath=$1
name=$2
fpath=$3
python_ver=$4

# 引数を確認する。
if [ ! -d $dpath ]; then
    echo 'ディレクトリが存在しません。'
    echo '$1: 必須 - 構築する仮想環境ディレクトリの親パス: '$dpath
    return 1
fi
if [ -d $name ]; then
    echo '仮想環境は既に存在します。'
    echo '$2: 必須 - 仮想環境名: '$name
    return 1
fi
if [ ! -f $fpath ]; then
    echo 'ファイルが存在しません。'
    echo '$3: 必須 - pythonパッケージ一覧のファイルパス: '$fpath
    return 1
fi

# 仮想環境を構築する。
echo '--------------------------------------------------'
echo '下記設定で仮想環境を構築します。'
echo '--------------------------------------------------'
echo 'pythonバージョン: '$python_ver
echo '構築する仮想環境ディレクトリの親パス: '$dpath
echo '仮想環境名: '$name
echo 'pythonパッケージ一覧のファイルパス: '$fpath
echo '--------------------------------------------------'

cd $dpath
pyenv install -s $python_ver
pyenv local $python_ver
python -m venv $name
. $dpath/$name/bin/activate
pip install --upgrade pip
pip install -r $fpath

