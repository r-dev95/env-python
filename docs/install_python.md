<!--
    pythonの仮想環境を構築する手順を示す。
 -->

# pythonの仮想環境を構築する手順

pythonの仮想環境を構築する手順を示します。

ここでは、WSLのUbuntu上に以下の仮想環境を構築する前提で進めます。

* tensorflow
* pytorch

また、使用するデータが`/mnt/c/Users/<user_name>/work/data/`にあることとします。

## 1. データ準備

使用するデータとディレクトリ構造を以下に示します。

``` none
wsl_ubuntu_python/data/
├── activate.sh # 仮想環境を有効化するスクリプト
├── setup.sh    # Ubuntuパッケージの更新と複数の仮想環境を構築するスクリプト
└── .env        # 仮想環境を構築するディレクトリ
    └── make_venv.sh # 単一の仮想環境を構築するスクリプト
```

1. pipパッケージを記述したファイルを作成します。

    ファイル名は`<仮想環境名>.txt`として、`.env`ディレクトリに置いてください。

    ここでは、`tf-gpu.txt`と`to-gpu.txt`に以下を記述するとします。

    ``` none
    matplotlib
    pandas==2.2.3 # バージョンを指定したい場合
    scikit-learn
    scikit-image
    ```

    `.env`ディレクトリは以下のようになっていれば、OKです。

    ``` none
    .env
    ├── make_venv.sh
    ├── tf-gpu.txt   # tensorflowのpipパッケージ一覧のファイル
    └── to-gpu.txt   #    pytorchのpipパッケージ一覧のファイル
    ```

1. [setup.sh](../data/setup.sh)を編集します。

    下記のように`A_envnames`に仮想環境名を設定します。

    ``` bash
    # 仮想環境名の配列
    # コメントアウトすれば、仮想環境を作らない。
    A_envnames=(
        # tf-cpu  # tensorflow (cpu)
        tf-gpu  # tensorflow (gpu)
        to-gpu  # pytorch (gpu)
    )
    ```

    仮想環境ごとに他に処理を追加したい場合、case文の箇所に追加してください。

    ``` bash
    for A_name in ${A_envnames[@]}; do
        # 単一の仮想環境を構築するスクリプトを実行する。
        . make_venv.sh $A_dpath $A_name $A_dpath/$A_name.txt

        # 追加処理を行う。
        case $A_name in # 仮想環境名を設定する。
            tf-cpu)
                ;;
            tf-gpu)
                pip install tensorflow[and-cuda]
                ;;
            to-gpu)
                pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118
                ;;
        esac
    done
    ```

## 2. Ubuntuパッケージの更新と仮想環境の構築

1. Ubuntuにデータをコピーします。

    ``` bash
    cd ~/
    cp -r /mnt/c/Users/<user_name>/work/data/. ~/
    ```

1. `setup.sh`を実行します。

    実行後、必要に応じて`sudo`のパスワードを入力します。

    ``` bash
    source setup.sh
    ```

**仮想環境の構築完了です。**

> [!TIP]
> **仮想環境の有効化**
>
> ``` bash
> # source ~/activate.sh <仮想環境名>
> source ~/activate.sh tf-gpu
> ```
>
> (直接、`<仮想環境のパス>/bin/activate`を実行してもよいがパスの指定が面倒なため)
>
> **単一の仮想環境の構築**
>
> ``` bash
> # souce ~/.env/make_venv.sh <仮想環境を構築するディレクトリパス> <仮想環境名> <pipパッケージ一覧のファイルパス>
> souce ~/.env/make_venv.sh ~/.env/ <env_name> ~/.env/<env_name>.txt
> ```
