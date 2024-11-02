# -------------------------------------------------------------------
# pythonの仮想環境を有効化するスクリプト
#
# コマンド:
#   source activate.sh $1
#       $1: 仮想環境名
# -------------------------------------------------------------------
#!/bin/bash

# 変数と関数をunsetする関数。
function unset_var() {
    unset dpath
    unset envname
    unset envnames
    unset val
    unset unset_var
}

# 仮想環境ディレクトリの親パス
dpath=~/.env

# 引数
envname=$1

# 構築済みの仮想環境名を取得する。
for val in $(find $dpath -name activate); do
    val=(${val//// })
    envnames+=(${val[-3]})
done

if [ ! -d $dpath/$envname ]; then
    echo '------------------------------------------------------------'
    echo '[有効化に失敗]: '$dpath/$envname
    echo '仮想環境:'
        for val in ${envnames[@]}; do
            echo '    '${val}
        done
    echo '------------------------------------------------------------'
    return 1
fi

# 仮想環境を有効化する。
for val in ${envnames[@]}; do
    if [ $envname = $val ]; then
        . $dpath/$envname/bin/activate
        echo '------------------------------------------------------------'
        echo '[有効化に成功]: '$dpath/$envname
        echo '------------------------------------------------------------'
        break
    fi
done

unset_var