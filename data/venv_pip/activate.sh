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
    unset envname
    unset envnames
    unset name
    unset unset_var
}

res=0
# 仮想環境が構築されている親ディレクトリ
dpath=~/.env

# 引数
envname=$1

# 引数を確認する。
if [ ! -d $dpath ]; then
    res=1
    echo '仮想環境の親のディレクトリパス: '$dpath
    echo '$1: 必須 - 仮想環境名: '$envname
    return $res
fi

# 構築済みの仮想環境名を取得する。
for name in $(find $dpath -name activate); do
    name=(${name//// })
    envnames+=(${name[-3]})
done

# 仮想環境を有効化する。
for name in ${envnames[@]}; do
    if [ $envname != $name ]; then
        res=1
    else # success
        res=0
        . $dpath/$envname/bin/activate
        break
    fi
done

if [ $res -eq 0 ]; then
    echo '[有効化に成功]: '$envname
else
    echo '[有効化に失敗]: '$envname
    echo '仮想環境:'
        for name in ${envnames[@]}; do
            echo '    '${name}
        done
fi

unset_var