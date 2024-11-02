# -------------------------------------------------------------------
# プロジェクトと仮想環境を構築するスクリプト
#
# 1. pyenvでpythonのインストール(既に存在する場合はスキップ)
# 2. poetryでプロジェクトの作成
# 3. poetryでpythonパッケージのインストール(自動で仮想環境も構築される)
#
# コマンド:
#   source make_project.sh $1 $2 $3 $4 $5
#       $1: 必須 - プロジェクトディレクトリの親パス
#       $2: 必須 - プロジェクト名
#       $3: 必須 - pythonパッケージ一覧のファイルパス
#                  複数指定する場合、スペースで区切り全体をクォーテーションで囲む。
#       $4: 必須 - poetry add --groupのグループ(デフォルトはmain)
#                  複数指定する場合、スペースで区切り全体をクォーテーションで囲む。
#                  pythonパッケージ一覧ファイルに対応するように同じ数だけ指定する。
#       $5: 必須 - pythonバージョン
# -------------------------------------------------------------------
#!/bin/bash

# 変数と関数をunsetする関数。
function unset_var() {
    unset dpath
    unset name
    unset fpath
    unset fpaths
    unset group
    unset groups
    unset python_ver
    unset old_python_ver
    unset val
    unset cnt
    unset unset_var
}

# 引数
dpath=$1
name=$2
fpath=$3
for val in ${fpath[@]}; do
    fpaths+=($val)
done
group=$4
for val in ${group[@]}; do
    groups+=($val)
done
python_ver=$5

# 引数を確認する。
if [ ! -d $dpath ]; then
    echo '------------------------------------------------------------'
    echo 'ディレクトリが存在しません。'
    echo '------------------------------------------------------------'
    echo '$1: 必須 - プロジェクトディレクトリの親パス: '$dpath
    echo '------------------------------------------------------------'
    unset_var
    return 1
fi
if [ -d $dpath/$name ]; then
    echo '------------------------------------------------------------'
    echo '既にディレクトリが存在します。'
    echo '------------------------------------------------------------'
    echo '$2: 必須 - プロジェクト名: '$name
    echo '------------------------------------------------------------'
    unset_var
    return 1
fi
for val in ${fpaths[@]}; do
    if [ ! -f $val ]; then
        echo '------------------------------------------------------------'
        echo 'ファイルが存在しません。'
        echo '------------------------------------------------------------'
        echo '$3: 必須 - pythonパッケージ一覧のファイルパス: '$val
        echo '           複数指定する場合、スペースで区切り全体をクォーテーションで囲む。'
        echo '------------------------------------------------------------'
        unset_var
        return 1
    fi
done
if [ ${#fpaths[@]} -ne ${#groups[@]} ]; then
    echo '------------------------------------------------------------'
    echo '下記の引数の数が一致しません。'
    echo '------------------------------------------------------------'
    echo '$3: 必須 - pythonパッケージ一覧のファイルパス: '${#fpaths[@]}個, ${fpaths[@]}
    echo '           複数指定する場合、スペースで区切り全体をクォーテーションで囲む。'
    echo '$4: 必須 - poetry add --groupのグループ(デフォルトはmain): '${#groups[@]}個, ${groups[@]}
    echo '           複数指定する場合、スペースで区切り全体をクォーテーションで囲む。'
    echo '           pythonパッケージ一覧ファイルに対応するように同じ数だけ指定する。'
    echo '------------------------------------------------------------'
    unset_var
    return 1
fi

echo '------------------------------------------------------------'
echo '下記設定でプロジェクトと仮想環境を構築します。'
echo '------------------------------------------------------------'
echo 'プロジェクトディレクトリの親パス: '$dpath
echo 'プロジェクト名: '$name
echo 'pythonパッケージ一覧のファイルパス: '${fpaths[@]}
echo 'poetry add --groupのグループ: '${groups[@]}
echo 'pythonバージョン: '$python_ver
echo '------------------------------------------------------------'

# pythonをインストールする。
pyenv install -s $python_ver

# 一時的にグローバルのpythonバージョンを変更する。
old_python_ver=`pyenv global 2>/dev/null`
if [ $old_python_ver = 'system' ]; then
    old_python_ver=$python_ver
fi
pyenv global $python_ver

# プロジェクトを作成する。
cd $dpath
poetry new $name

# pythonパッケージをインストールする。
cd $name
cnt=0
for val in ${fpaths[@]}; do
    while read line; do
        poetry add $line --group ${groups[$cnt]}
    done < $val
    cnt=`expr $cnt + 1`
done

# グローバルのpythonバージョンを元に戻す。
pyenv global $old_python_ver

unset_var