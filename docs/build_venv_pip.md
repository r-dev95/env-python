<!--
    pythonの仮想環境を構築する手順を示す。
 -->

# 開発環境の構築手順

下表のツールを使用したpythonの仮想環境の構築する手順を示します。

|管理項目          |ツール    |参考           |
| ---------------- | -------- | ------------- |
|pythonバージョン  |なし      |               |
|仮想環境          |venv      |[docs][venv]   |
|パッケージ        |pip       |[docs][pip]    |

[venv]: https://docs.python.org/ja/3/library/venv.html
[pip]: https://pip.pypa.io/en/stable/

一般的な仮想環境の構築手順を下記に示します。

難しくない手順ですが、複数の環境を構築するためにこれらの操作を繰り返し行うのは面倒です。

本手順は、これらの操作を簡略化するためのスクリプトの使い方を示します。

``` bash
# 仮想環境の構築
cd <env-dir-path>
python -m venv <env-name>

# 仮想環境の有効化
source <env-name>/bin/activate

# pythonパッケージのインストール
pip install -r requirements.txt
```

## はじめに

### 説明のための設定

* WSLのUbuntu上に仮想環境を構築します。

* [tensorflow](https://www.tensorflow.org/)の仮想環境を構築します。

* 使用するデータは、`/mnt/c/Users/<user-name>/work/data/venv_pip/`にあることとします。

### 仮想環境構築後のディレクトリ構造のイメージ

``` none
~
└── .env           # 仮想環境の親ディレクトリ
    └── <env-name> # 仮想環境
```

## 1. データ準備

使用するデータとディレクトリ構造を以下に示します。

``` none
data/venv_pip/
├── activate.sh           # 仮想環境を有効化するスクリプト
└── .env                  # 仮想環境の親ディレクトリ
    ├── build_venv.sh     # 単一の仮想環境を構築するスクリプト
    └── install_python.sh # pythonをインストールするスクリプト
```

### pythonパッケージを記述したファイルを作成する

ここでは、以下を`tf-gpu.txt`に記述し、`.env/`ディレクトリに置くこととします。

``` none
matplotlib
pandas==2.2.3 # バージョンを指定したい場合
scikit-learn
scikit-image
tensorflow[and-cuda]
```

## 2. 仮想環境の構築

### 2.1. Ubuntuにデータをコピーする

``` bash
cp -r /mnt/c/Users/<user-name>/work/data/venv_pip/. ~/
```

### 2.2. pythonをインストールする

実行後、必要に応じて`sudo`のパスワードを入力します。

``` bash
cd ~/.env/
source install_python.sh
```

[`install_python.sh`](../data/venv_pip/.env/install_python.sh)は、下記を実行するスクリプトです。

1. Ubuntuパッケージの更新
1. `apt-get`でpythonのインストール

### 2.3. 仮想環境を構築する

複数の仮想環境をまとめて構築したい場合、[複数の仮想環境の構築](#複数の仮想環境の構築)を参照してください。

``` bash
source build_venv.sh ~/.env tf-gpu ~/.env/tf-gpu.txt
```

`build_venv.sh`の使い方を下記に示します。

``` bash
source build_venv.sh $1 $2 $3
# 引数の説明:
# $1: 必須 - 仮想環境の親ディレクトリパス
# $2: 必須 - 仮想環境名
# $3: 必須 - pythonパッケージ一覧のファイルパス
```

[`build_venv.sh`](../data/venv_pip/.env/build_venv.sh)は、下記を実行するスクリプトです。

1. `venv`で仮想環境の構築
1. `pip`でpythonパッケージのインストール

**仮想環境の構築完了です。**

## 複数の仮想環境の構築

インストールするパッケージを記述した`<env-name>.txt`が、`.env/`ディレクトリに置かれている前提で説明します。

### 1. `setup.sh`を編集する

#### 1.1. `A_envnames`に仮想環境名を設定する

``` bash
# An array of virtual environment names.
# If you comment it out, the virtual environment will not be created.
A_envnames=(
    tf-gpu  # tensorflow (gpu)
    to-gpu  # pytorch (gpu)
    # pyside  # pyside
    # flet    # flet
    # django  # django
)
```

#### 1.2. 共通パッケージのインストールを設定する

ドキュメントやテスト用のパッケージをプロジェクト間で共通のものを使用する場合、`build_venv.sh`より後に設定します。(`pip install`の部分)

`<env-name>.txt`にすべてのパッケージを記述する場合、必要ありません。

``` bash
# Build a virtual environment.
for A_name in ${A_envnames[@]}; do
    cd $A_dpath

    # Run a script to create a single virtual environment.
    . build_venv.sh $A_dpath $A_name $A_dpath/$A_name.txt

    # Run common processing.
    pip install -r $A_dpath/docs.txt # documentation packages (sphinx, etc.)
    pip install -r $A_dpath/test.txt # test packages (ruff, mypy, pytest, etc.)
```

#### 1.3. 仮想環境ごとの追加処理を設定する

仮想環境ごとに追加で処理が必要な場合、`case`文の中に設定します。

``` bash
# Build a virtual environment.
for A_name in ${A_envnames[@]}; do

    ...

    # Run additional processing.
    case $A_name in # Set a virtual environment.
        tf-gpu)
            ;;
        to-gpu)
            pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118
            ;;

    ...
```

### 2. `setup.sh`を実行する

``` bash
source setup.sh
```

[`setup.sh`](../data/venv_pip/.env/setup.sh)は、下記を実行するスクリプトです。

1. `build_venv.sh`の実行
1. 共通処理の実行 (設定した場合)
1. 追加処理の実行 (設定した場合)

**複数の仮想環境の構築完了です。**

## 仮想環境の有効化

``` bash
source ~/activate.sh <env-name>
```

(`source <env-dir-path>/bin/activate`を直接、実行してもOKです)

## `pip`について

### パッケージバージョンの保存

``` bash
pip freeze > <file-name>.txt
```

### 保存したパッケージバージョンのインストール

``` bash
pip install -r <file-name>.txt
```
