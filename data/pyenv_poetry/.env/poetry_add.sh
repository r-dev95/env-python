# -------------------------------------------------------------------
# poetryでpythonパッケージをインストールするスクリプト
#
# コマンド:
#   source build_venv.sh $1 $2 $3
#       $1: 必須 - プロジェクトのディレクトリパス
#       $2: 必須 - pythonパッケージ一覧のファイルパス
#       $3:      - poetry addのグループ(デフォルトはmain)
# -------------------------------------------------------------------
#!/bin/bash

# 変数と関数をunsetする関数。
function unset_var() {
    unset dpath
    unset fpath
    unset group
    unset unset_var
}

# 引数
dpath=$1
fpath=$2
group=$3
if [ -z "$group" ]; then
    group=main # poetry addのグループ(デフォルト)
fi

# 引数を確認する。
if [ ! -d $dpath ]; then
    echo 'ディレクトリが存在しません。'
    echo '$1: 必須 - プロジェクトのディレクトリパス: '$dpath
    return 1
fi
if [ ! -f $fpath ]; then
    echo 'ファイルが存在しません。'
    echo '$2: 必須 - pythonパッケージ一覧のファイルパス: '$fpath
    return 1
fi

# プロジェクトと仮想環境を構築する。
echo '下記設定でプロジェクトと仮想環境を構築します。'
echo '--------------------------------------------------'
echo 'プロジェクトのディレクトリ: '$dpath
echo 'pythonパッケージ一覧のファイルパス: '$fpath
echo 'poetry addのグループ: '$group
echo '--------------------------------------------------'

cd $dpath
while read line; do
    poetry add $line --group $group
done < $fpath
