# --------------------------------------------------
# pythonの仮想環境を有効化するスクリプト
#
# コマンド:
#   source activate.sh $1
#       $1: 仮想環境名
# --------------------------------------------------
#!/bin/bash

# 変数と関数をunsetする関数。
function unset_var() {
    unset res
    unset dpath
    unset name
    unset arg
    unset args
    unset unset_var
}

res=0
# 仮想環境が構築されている親ディレクトリ
dpath=~/.env

# 引数を確認する。
if [ $# -eq 1 ]; then
    name=$1
else
    res=1
    echo '引数は1個指定しなければならない。'
    echo '$1: 仮想環境名'
    echo '指定された引数は'$#'個です。'
    unset_var
    return $res
fi

# 構築済みの仮想環境名を取得する。
for arg in $(find $dpath -name activate); do
    arg=(${arg//// })
    args+=(${arg[-3]})
done

# 仮想環境を有効化する。
for arg in ${args[@]}; do
    if [ $name != $arg ]; then
        res=1
    else # success
        res=0
        . $dpath/$name/bin/activate
        break
    fi
done

if [ $res -eq 0 ]; then
    echo '[有効化に成功]: '$name
else
    echo '[有効化に失敗]: '$name
    echo '仮想環境:'
    echo '    '${args[@]}
fi

unset_var