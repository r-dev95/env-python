# --------------------------------------------------
# pythonの仮想環境を有効化するスクリプト
#
# コマンド:
#   source activate.sh $1 $2
#       $1: 必須 - 仮想環境名
#       $2:      - pythonのバージョン
# --------------------------------------------------
#!/bin/bash

# 変数と関数をunsetする関数。
function unset_var() {
    unset res
    unset dpath_py
    unset python_ver
    unset dpath
    unset envname
    unset envnames
    unset dpath_env
    unset name
    unset version
    unset versions
    unset unset_var
}

res=0
# pythonのインストールディレクトリパス
dpath_py=~/.pyenv/versions/*
# pythonのデフォルトバージョン
python_ver=3.12.3
# 仮想環境が構築されている親ディレクトリパス
dpath=~/.env/python

# 引数
envname=$1
if [ $# -eq 2 ]; then
    python_ver=$2
fi
dpath_env=$dpath$python_ver

# 引数を確認する。
if [ ! -d $dpath_env ]; then
    res=1
    echo 'pythonのバージョンが'$python_ver'のディレクトリが存在しません。'
    echo '仮想環境の親のディレクトリパス: '$dpath_env
    echo '$1: 必須 - 仮想環境名: '$envname
    echo '$2:      - pythonのバージョン: '$python_ver
    return $res
fi

# 構築済みの仮想環境のpythonのバージョンを取得する。
for name in $(find $dpath_py -maxdepth 0 -type d); do
    name=(${name//// })
    versions+=(${name[-1]})
done

# 構築済みの仮想環境名を取得する。
for name in $(find $dpath_env -name activate); do
    name=(${name//// })
    envnames+=(${name[-3]})
done

# 仮想環境を有効化する。
for name in ${envnames[@]}; do
    if [ $envname != $name ]; then
        res=1
    else # success
        res=0
        . $dpath_env/$envname/bin/activate
        break
    fi
done

if [ $res -eq 0 ]; then
    echo '[有効化に成功]: '$envname
else
    echo '[有効化に失敗]: '$envname
    for version in ${versions[@]}; do
        unset envnames
        # 構築済みの仮想環境名を取得する。
        dpath_env=$dpath$version
        for name in $(find $dpath_env -name activate); do
            name=(${name//// })
            envnames+=(${name[-3]})
        done
        echo 'pythonのバージョン: '$version
        echo '仮想環境:'
        for name in ${envnames[@]}; do
            echo '    '${name}
        done
    done
fi

unset_var