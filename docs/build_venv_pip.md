<!--
    pythonの仮想環境を構築する手順を示す。
 -->

# pythonの仮想環境を構築する手順

下表のライブラリを使用したpythonの仮想環境の構築する手順を示します。

|項目              |ライブラリ|
|------------------|----------|
|仮想環境          |venv      |
|パッケージ        |pip       |

* 仮想環境を構築した場合のディレクトリ構造の例

    ``` none
    ~/
    └── .env           # 仮想環境を構築するディレクトリ
        └── <env-name> # 仮想環境
    ```

## はじめに

はじめに、本手順における前提を示します。

* WSLのUbuntu上に仮想環境を構築します。

* 以下の仮想環境を構築します。

    * tensorflow
    * pytorch

* 使用するデータは、Windows側の`/mnt/c/Users/<user-name>/work/data/venv_pip/`にあることとします。

## 1. データ準備

使用するデータとディレクトリ構造を以下に示します。

``` none
data/venv_pip/
├── activate.sh           # 仮想環境を有効化するスクリプト
└── .env                  # 仮想環境を構築するディレクトリ
    ├── build_venv.sh     # 単一の仮想環境を構築するスクリプト
    ├── install_python.sh # Ubuntuパッケージの更新とpythonをインストールするスクリプト
    └── setup.sh          # 複数の仮想環境を構築するスクリプト
```

### 1. pipパッケージを記述したファイルを作成する

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
├── build_venv.sh
├── install_python.sh
├── setup.sh
├── tf-gpu.txt   # tensorflowのpipパッケージ一覧のファイル
└── to-gpu.txt   #    pytorchのpipパッケージ一覧のファイル
```

### 2. [setup.sh](../data/venv_pip/.env/setup.sh)を編集する

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
        to-gpu)
            pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118
            ;;
    esac
done
```

## 2. Ubuntuパッケージの更新と仮想環境の構築

### 1. Ubuntuにデータをコピーする

``` bash
cd ~/
cp -r /mnt/c/Users/<user_name>/work/data/venv_pip/. ~/
```

### 2. pythonをインストールする

``` bash
cd ~/.env/
source install_python.sh
```

[`install_python.sh`](../data/venv_pip/.env/install_python.sh)は、下記を実行するスクリプトです。

1. Ubuntuパッケージの更新
2. pythonのインストール

### 3. `setup.sh`を実行する

実行後、必要に応じて`sudo`のパスワードを入力します。

``` bash
source setup.sh
```

[`setup.sh`](../data/venv_pip/.env/setup.sh)は、下記を実行するスクリプトです。

1. `build_venv.sh`の実行
2. 仮想環境ごとの追加処理の実行

[`build_venv.sh`](../data/venv_pip/.env/build_venv.sh)は、下記を実行するスクリプトです。

1. `venv`で仮想環境の構築
2. `pip`でpythonパッケージのインストール

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
> # souce ~/.env/build_venv.sh <仮想環境を構築するディレクトリパス> <仮想環境名> <pipパッケージ一覧のファイルパス>
> souce ~/.env/build_venv.sh ~/.env/ tf-gpu ~/.env/tf-gpu.txt
> ```
>
> **pythonパッケージのバージョン管理**
>
> ``` bash
> pip freeze > requirement.txt
> ```
