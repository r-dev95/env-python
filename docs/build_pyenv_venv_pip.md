<!--
    pythonの仮想環境を構築する手順を示す。
 -->

# 開発環境の構築手順

下表のツールを使用したpythonの仮想環境の構築する手順を示します。

|管理項目          |ツール    |参考           |
| ---------------- | -------- | ------------- |
|pythonバージョン  |pyenv     |[github][pyenv]|
|仮想環境          |venv      |[docs][venv]   |
|パッケージ        |pip       |[docs][pip]    |

[pyenv]: https://github.com/pyenv/pyenv
[venv]: https://docs.python.org/ja/3/library/venv.html
[pip]: https://pip.pypa.io/en/stable/

一般的な仮想環境の構築手順を下記に示します。

難しくない手順ですが、複数の環境を構築するためにこれらの操作を繰り返し行うのは面倒です。

本手順は、これらの操作を簡略化するためのスクリプトの使い方を示します。

``` bash
# pyenvのインストール
curl https://pyenv.run | bash

# pythonのビルド依存関係パッケージのインストール
sudo apt-get install <package-name>

# pyenvの環境変数の設定
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(pyenv init -)"' >> ~/.bashrc
source ~/.bashrc

# pythonのインストール
pyenv install <python-version>

# pythonバージョンのグローバル設定
pyenv global <python-version>

# 仮想環境の構築
cd <env-dir-path>
pyenv local <python-version> # 仮想環境で使用するpythonバージョンの設定
python -m venv <env-name>

# 仮想環境の有効化
source <env-name>/bin/activate

# pythonパッケージのインストール
pip install -r requirements.txt
```

## はじめに

### 説明のための設定

* 仮想環境とプロジェクトのディレクトリは分けて構築します。

  そのため、使用するpythonバージョンは、仮想環境とプロジェクトのディレクトリのそれぞれに設定します。

* WSLのUbuntu上に仮想環境を構築します。

* pythonバージョンは`3.12.3`で、[tensorflow](https://www.tensorflow.org/)の仮想環境を構築します。

* 使用するデータは、`/mnt/c/Users/<user-name>/work/data/pyenv_venv_pip/`にあることとします。

### 仮想環境構築後のディレクトリ構造のイメージ

``` none
~/
├── .pyenv         # pyenvのインストールディレクトリ
└── .env           # 仮想環境の親ディレクトリ
    └── <env-name> # 仮想環境
```

## 1. データ準備

使用するデータとディレクトリ構造を以下に示します。

``` none
data/pyenv_venv_pip/
├── activate.sh          # 仮想環境を有効化するスクリプト
└── .env                 # 仮想環境の親ディレクトリ
    ├── build_venv.sh    # 単一の仮想環境を構築するスクリプト
    └── install_pyenv.sh # pyenvをインストールするスクリプト
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
cp -r /mnt/c/Users/<user-name>/work/data/pyenv_venv_pip/. ~/
```

### 2.2. `pyenv`をインストールする

実行後、必要に応じて`sudo`のパスワードを入力します。

``` bash
cd ~/.env/
source install_pyenv.sh
```

[`install_pyenv.sh`](../data/pyenv_venv_pip/.env/install_pyenv.sh)は、下記を実行するスクリプトです。

1. Ubuntuパッケージの更新
1. pythonのビルド依存関係パッケージのインストール
1. `pyenv`のインストール
1. `pyenv`の環境変数の設定

### 2.3. 仮想環境を構築する

複数の仮想環境をまとめて構築したい場合、[複数の仮想環境の構築](#複数の仮想環境の構築)を参照してください。

``` bash
source build_venv.sh ~/.env tf-gpu ~/.env/tf-gpu.txt 3.12.3
```

`build_venv.sh`の使い方を下記に示します。

``` bash
source build_venv.sh $1 $2 $3 $4
# 引数の説明:
# $1: 必須 - 仮想環境の親ディレクトリパス
# $2: 必須 - 仮想環境名
# $3: 必須 - pythonパッケージ一覧のファイルパス
# $4: 必須 - pythonバージョン
```

[`build_venv.sh`](../data/pyenv_venv_pip/.env/build_venv.sh)は、下記を実行するスクリプトです。

1. `pyenv`でpythonのインストール
1. `pyenv`でpythonバージョンのローカル設定
1. `venv`で仮想環境の構築
1. `pip`でpythonパッケージのインストール

### 2.4. グローバルなpythonバージョンを設定する

``` bash
pyenv global <python-version>
```

> [!IMPORTANT]
> 本手順では、仮想環境とプロジェクトのディレクトリを分けているため、プロジェクトのディレクトリで使用するpythonバージョンを設定する必要があります。
>
> 下記コマンドを実行すると、pythonバージョンが記載された`.python-version`が作成されます。
>
> ``` bash
> cd <project-dir-path>
> pyenv local <python-version>
> ```
>
> これにより、プロジェクトのディレクトリ内でpythonを実行した際、`.python-version`のバージョンで実行できます。
>
> pythonを実行した際、カレントディレクトリに`.python-version`がない場合、上の階層を順に探索し、pythonバージョンを設定します。
> 見つからない場合は、`pyenv global`の設定が採用されます。

**仮想環境の構築完了です。**

## 複数の仮想環境の構築

インストールするパッケージを記述した`<env-name>.txt`が、`.env/`ディレクトリに置かれている前提で説明します。

### 1. `setup.sh`を編集する

#### 1.1. `A_python_ver`にインストールするpythonバージョンを設定する

``` bash
# python version
A_python_ver=3.12.3
```

#### 1.2. `A_envnames`に仮想環境名を設定する

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

#### 1.3. 共通パッケージのインストールを設定する

ドキュメントやテスト用のパッケージをプロジェクト間で共通のものを使用する場合、`build_venv.sh`より後に設定します。(`pip install`の部分)

`<env-name>.txt`にすべてのパッケージを記述する場合、必要ありません。

``` bash
# Build a virtual environment.
for A_name in ${A_envnames[@]}; do
    cd $A_dpath

    # Run a script to create a single virtual environment.
    . build_venv.sh $A_dpath $A_name $A_dpath/$A_name.txt $A_python_ver

    # Run common processing.
    pip install -r $A_dpath/docs.txt # documentation packages (sphinx, etc.)
    pip install -r $A_dpath/test.txt # test packages (ruff, mypy, pytest, etc.)
```

#### 1.4. 仮想環境ごとの追加処理を設定する

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

[`setup.sh`](../data/pyenv_venv_pip/.env/setup.sh)は、下記を実行するスクリプトです。

1. `build_venv.sh`の実行
1. 共通処理の実行 (設定した場合)
1. 追加処理の実行 (設定した場合)

[グローバルなpythonバージョンを設定する](#24-グローバルなpythonバージョンを設定する)に進んでください。

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

## `pyenv`について

### インストール済みpythonの表示

``` bash
pyenv versions
```

インストール済みのpythonバージョンの一覧と現在のディレクトリの設定が表示されます。
`system`は`apt-get`等でインストールしたpyhtonのバージョンを指します。
また`pyenv`でインストールしたpythonは、`~/.pyenv/versions/`にあります。

``` bash
  system
* 3.12.3 (set by <project_dir>/.python-version)
```

### ローカルpythonバージョンの設定

下記コマンドを実行すると、pythonバージョンが記載された`.python-version`が作成されます。

``` bash
cd <project-dir-path>
pyenv local <python-version>
```

これにより、プロジェクトのディレクトリ内でpythonを実行した際、`.python-version`のバージョンで実行できます。
pythonを実行した際、カレントディレクトリに`.python-version`がない場合、上の階層を順に探索し、pythonバージョンを設定します。
見つからない場合は、`pyenv global`の設定が採用されます。
