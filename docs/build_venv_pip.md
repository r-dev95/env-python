<!--
    pythonの仮想環境を構築する手順を示す。
 -->

# pythonの仮想環境を構築する手順

下表のライブラリを使用したpythonの仮想環境の構築する手順を示します。

|管理項目          |ライブラリ|参考           |
|------------------|----------|---------------|
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
└── .env           # 仮想環境を構築するディレクトリ
    └── <env-name> # 仮想環境
```

## 1. データ準備

使用するデータとディレクトリ構造を以下に示します。

``` none
data/venv_pip/
├── activate.sh           # 仮想環境を有効化するスクリプト
└── .env                  # 仮想環境を構築するディレクトリ
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

``` bash
source build_venv.sh ~/.env tf-gpu ~/.env/tf-gpu.txt
```

`build_venv.sh`の使い方を下記に示します。

``` bash
source build_venv.sh $1 $2 $3
# 引数の説明:
# $1: 必須 - 構築する仮想環境ディレクトリの親パス
# $2: 必須 - 仮想環境名
# $3: 必須 - pythonパッケージの一覧のファイルパス
```

[`build_venv.sh`](../data/venv_pip/.env/build_venv.sh)は、下記を実行するスクリプトです。

1. `venv`で仮想環境の構築
1. `pip`でpythonパッケージのインストール

**仮想環境の構築完了です。**

> [!TIP]
> **仮想環境の有効化**
>
> ``` bash
> source ~/activate.sh <env-name>
> ```
>
> (直接、`source <env-dir-path>/bin/activate`を実行してもOKです)
>
> **pythonパッケージのバージョン管理**
>
> 仮想環境のpythonパッケージのバージョンを保存するには、下記コマンドを実行する必要があります。
>
> ``` bash
> pip freeze > <file-name>.txt
> ```
>
> また、ある仮想環境のpythonパッケージをインストールするには、下記コマンドを実行します。
>
> ``` bash
> pip install -r <file-name>.txt
> ```
