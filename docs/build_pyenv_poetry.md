<!--
    pythonの仮想環境を構築する手順を示す。
 -->

# 開発環境の構築手順

下表のツールを使用したpythonの仮想環境の構築する手順を示します。

|管理項目          |ツール    |参考           |
| ---------------- | -------- | ------------- |
|pythonバージョン  |pyenv     |[github][pyenv]|
|仮想環境          |poetry    |[docs][poetry] |
|パッケージ        |同上      |同上           |

[pyenv]: https://github.com/pyenv/pyenv
[poetry]: https://python-poetry.org/docs/

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

# poetryのインストール
curl -sSL https://install.python-poetry.org | python3 -

# poetryの環境変数の設定
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc

# poetryのタブ補完の有効化
poetry completions bash >> ~/.bash_completion

# pythonのインストール
pyenv install <python-version>

# pythonバージョンのグローバル設定
pyenv global <python-version>

# プロジェクトの構築
poetry new <project-name>

# プロジェクトとその仮想環境で使用するpythonバージョンの設定
cd <project-name>
vi pyproject.toml # [tool.poetry.dependencies]のpythonのバージョンを書き換える。
poetry env use <python-version> # 書き換えた場合のみ

# 仮想環境の構築とpythonパッケージのインストール
poetry add <package-name>                      # mainグループ(デフォルト)
poetry add --group <group-name> <package-name> # <group-name>グループ
```

## はじめに

### 説明のための設定

* 仮想環境とプロジェクトのディレクトリは分けて構築します。

  下記コマンドでプロジェクトディレクトリ内に仮想環境を構築できますが、ここでは行いません。

  ``` bash
  poetry config virtualenvs.in-project true
  ```

* WSLのUbuntu上に仮想環境を構築します。

* [tensorflow](https://www.tensorflow.org/)の仮想環境を構築します。

* 使用するデータは、Windows側の`/mnt/c/Users/<user-name>/work/data/pyenv_poetry/`にあることとします。

### 仮想環境構築後のディレクトリ構造のイメージ

``` none
~/
├── work
│   └── <project-dir-name> # プロジェクトディレクトリ
├── .local
│   └── share
│       └── pypoetry # poetryのインストールディレクトリ
├── .pyenv             # pyenvのインストールディレクトリ
└── .env               # 仮想環境の親ディレクトリ
    └── virtualenvs    # poetryの仮想環境ディレクトリ
        └── <env-name> # 仮想環境
```

## 1. データ準備

使用するデータとディレクトリ構造を以下に示します。

``` none
data/pyenv_poetry/
└── .env                  # 仮想環境の親ディレクトリ
    ├── make_project.sh   # 単一のプロジェクト(仮想環境)を作成するスクリプト
    ├── install_pyenv.sh  #  pyenvをインストールするスクリプト
    └── install_poetry.sh # poetryをインストールするスクリプト
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

また以下を`docs.txt`に記述し、`.env/`ディレクトリに置くこととします。

``` none
sphinx
sphinx-autobuild
sphinx-rtd_theme
myst-parser
```

## 2. 仮想環境の構築

### 2.1. Ubuntuにデータをコピーする

``` bash
cp -r /mnt/c/Users/<user-name>/work/data/pyenv_poetry/. ~/
```

### 2.2. `pyenv`をインストールする

実行後、必要に応じて`sudo`のパスワードを入力します。

``` bash
cd ~/.env/
source install_pyenv.sh
```

[`install_pyenv.sh`](../data/pyenv_poetry/.env/install_pyenv.sh)は、下記を実行するスクリプトです。

1. Ubuntuパッケージの更新
1. pythonのビルド依存関係パッケージのインストール
1. `pyenv`のインストール
1. `pyenv`の環境変数の設定

### 2.3. `poetry`をインストールする

実行後、必要に応じて`sudo`のパスワードを入力します。

``` bash
source install_poetry.sh
```

[`install_poetry.sh`](../data/pyenv_poetry/.env/install_poetry.sh)は、下記を実行するスクリプトです。

1. Ubuntuパッケージの更新
1. `poetry`のインストール
1. `poetry`の環境変数の設定
1. `poetry`のタブ補完の有効化
1. `poetry`のキャッシュディレクトリの変更(仮想環境の構築ディレクトリも変わる)

### 2.4. プロジェクトと仮想環境を構築する

複数の仮想環境をまとめて構築したい場合、[複数の仮想環境の構築](#複数の仮想環境の構築)を参照してください。

``` bash
cd ~/.env
source make_project.sh ~/work tf-gpu "~/.env/tf-gpu.txt ~/.env/docs.txt" "main docs" <python-version>
```

`make_project.sh`の使い方を下記に示します。

``` bash
source make_project.sh $1 $2 $3 $4 $5
# 引数の説明:
# $1: 必須 - プロジェクトの親ディレクトリパス
# $2: 必須 - プロジェクト名
# $3: 必須 - pythonパッケージ一覧のファイルパス
#            複数指定する場合、スペースで区切り全体をクォーテーションで囲む。
# $4: 必須 - poetry add --groupのグループ(デフォルトはmain)
#            複数指定する場合、スペースで区切り全体をクォーテーションで囲む。
#            pythonパッケージ一覧ファイルに対応するように同じ数だけ指定する。
# $5: 必須 - pythonバージョン
```

[`make_project.sh`](../data/pyenv_poetry/.env/make_project.sh)は、下記を実行するスクリプトです。

1. `pyenv`でpythonのインストール(既に存在する場合はスキップ)
1. `poetry`でプロジェクトの作成
1. `poetry`でpythonパッケージのインストール(自動で仮想環境も構築される)

**仮想環境の構築完了です。**

## 複数の仮想環境の構築

インストールするパッケージを記述した`<env-name>.txt`が、`.env/`ディレクトリに置かれている前提で説明します。

### 1. `setup.sh`を編集する

#### 1.1. `A_python_ver`にpythonバージョンを設定する

``` bash
# python version
A_python_ver=3.12.3
```

#### 1.2. `A_dpath`に仮想環境の親ディレクトリを設定する

[`poetry`をインストールする](#23-poetryをインストールする)で設定した`poetry`のキャッシュディレクトリを設定する。

``` bash
# parent directory path to build the virtual environment
A_dpath=~/.env
```

#### 1.3. `A_dpath_pj`にプロジェクトの親ディレクトリを設定する

``` bash
# parent directory path to build the project
A_dpath_pj=~/work
```

#### 1.4. `A_envnames`に仮想環境名を設定する

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

#### 1.5. `make_project.sh`の引数を設定する

`make_project.sh`については、[プロジェクトと仮想環境を構築する](#24-プロジェクトと仮想環境を構築する)を参照してください。

``` bash
# Build a virtual environment.
for A_name in ${A_envnames[@]}; do
    cd $A_dpath

    # Run a script to create a single virtual environment.
    . make_project.sh $A_dpath_pj $A_name "$A_dpath/$A_name.txt $A_dpath/docs.txt" "main docs" $A_python_ver
```

#### 1.6. 仮想環境ごとの追加処理を設定する

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
            poetry source add --priority=explicit pytorch-cu118 https://download.pytorch.org/whl/cu118
            poetry add torch torchvision torchaudio --source pytorch-cu118
            ;;

    ...
```

### 2. `setup.sh`を実行する

``` bash
source setup.sh
```

[`setup.sh`](../data/pyenv_poetry/.env/setup.sh)は、下記を実行するスクリプトです。

1. `make_project.sh`の実行
1. 追加処理の実行 (設定した場合)

**複数の仮想環境の構築完了です。**

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

## `poetry`について

### 仮想環境でのコマンド実行

下記コマンドを実行すると、プロジェクトに対応する仮想環境に入り、pythonが実行され、実行が終了すると仮想環境から出ます。

``` bash
poetry run python <script-name>
```

下記コマンドを実行すると、プロジェクトに対応する仮想環境に入ります。

``` bash
poetry shell
```

### 仮想環境のパッケージの表示

プロジェクトディレクトリ内で下記コマンドを実行すると、プロジェクトに対応する仮想環境のパッケージを表示できます。

``` bash
poetry show
```

### 有効な仮想環境の表示

プロジェクトディレクトリ内で下記コマンドを実行すると、プロジェクトに対応する仮想環境を表示できます。

``` bash
poetry env list
```

### 使用するpythonバージョンの設定

プロジェクトディレクトリに作成された`pyproject.toml`の`python = "..."`の部分を編集し、下記コマンドを実行します。

``` bash
poetry env use <python-version>
```

`pyproject.toml`の`python = "..."`に設定するバージョンは、あくまで条件であり、これを満たす限り、使用するバージョンは、`poetry env use`コマンドで設定できます。
