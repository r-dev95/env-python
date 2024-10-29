# -------------------------------------------------------------------
# WSLのUbuntu上にpythonの仮想環境を構築するスクリプト
#
# 1. build_venv.shの実行
# 2. 仮想環境ごとの追加処理の実行
#
# 使用例:
#   1. pipパッケージを記載したファイルを作成する。
#      ファイル名は仮想環境名.txtとして、.env/ディレクトリに置く。
#   2. A_envnamesに仮想環境名を設定する。
#   3. 必要に応じて、case文に仮想環境ごとの処理を追加する。
#
# Note:
#   このスクリプトが呼び出す.env/build_venv.shは、
#   そのスクリプト内で使用する変数と関数のunsetを行う。
#   そのため使用する変数と関数の名前がこのスクリプトと
#   かぶらないようにするため、'A_'を頭につけている。
#
# コマンド:
#   source setup.sh
#       sudoのパスワードを入力する。
# -------------------------------------------------------------------
#!/bin/bash

# 変数と関数をunsetする関数。
function A_unset_var() {
    unset A_dpath
    unset A_envnames
    unset A_name
    unset A_unset_var
}

# 仮想環境を構築するディレクトリ
A_dpath=~/.env

# 仮想環境名の配列
# コメントアウトすれば、仮想環境を作らない。
A_envnames=(
    # tf-cpu  # tensorflow (cpu)
    tf-gpu  # tensorflow (gpu)
    # to-cpu  # pytorch (cpu)
    to-gpu  # pytorch (gpu)
    pyside  # pyside
    flet    # flet
    django  # django
)

# 仮想環境を構築する。
for A_name in ${A_envnames[@]}; do
    cd $A_dpath
    # 単一の仮想環境を構築するスクリプトを実行する。
    . build_venv.sh $A_dpath $A_name $A_dpath/$A_name.txt

    # 追加処理を行う。
    case $A_name in # 仮想環境名を設定する。
        tf-cpu)
            ;;
        tf-gpu)
            pip install tensorflow[and-cuda]
            ;;
        to-cpu)
            pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu
            ;;
        to-gpu)
            pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118
            ;;
        pyside)
            ;;
        flet)
            ;;
        django)
            ;;
    esac
done

deactivate
cd ~

A_unset_var