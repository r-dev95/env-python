<!--
    pythonの仮想環境を構築する手順を示す。
 -->

# pythonの仮想環境を構築する手順

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
└── .env               # 仮想環境を構築するディレクトリ
    └── virtualenvs    # poetryの仮想環境ディレクトリ
        └── <env-name> # 仮想環境
```

## 1. データ準備

使用するデータとディレクトリ構造を以下に示します。

``` none
data/pyenv_poetry/
└── .env                  # 仮想環境を構築するディレクトリ
    ├── poetry_add.sh     # 単一の仮想環境を構築するスクリプト
    ├── install_pyenv.sh  #  pyenvをインストールするスクリプト
    └── install_poetry.sh # poetryをインストールするスクリプト
```

### pythonパッケージを記述したファイルを作成する

ここでは、以下を`tf-gpu.txt`に記述し、`.env/`ディレクトリに置くこととします。

`pip`インストールの際の`requirements.txt`とは異なり、バージョンは指定しません。

``` none
matplotlib
pandas
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

``` bash
cd ~/.env
source make_project.sh ~/work tf-gpu "~/.env/tf-gpu.txt ~/.env/docs.txt" "main docs" <python-version>
```

`make_project.sh`の使い方を下記に示します。

``` bash
source make_project.sh $1 $2 $3 $4 $5
# 引数の説明:
# $1: 必須 - プロジェクトディレクトリの親パス
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

> [!TIP]
> **仮想環境の有効化**
>
> ``` bash
> source ~/activate.sh <env-name>
> ```
>
> (直接、`source <env-dir-path>/bin/activate`を実行してもOKです)
>
> **`pyenv`でローカルのpythonバージョンの設定**
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
>
> **`pyenv`でインストールされているpythonの表示**
>
> ``` bash
> pyenv versions
> ```
>
> ``` bash
> # 出力の例
>   system
> * 3.12.3 (set by <project_dir>/.python-version)
> ```
>
> インストール済みのpythonバージョンの一覧と現在のディレクトリの設定が表示されます。
>
> `system`は`apt-get`等でインストールしたpyhtonのバージョンを指します。
>
> また`pyenv`でインストールしたpythonは、`~/.pyenv/versions/`にあります。
>
> **`poetry`の仮想環境でのコマンド実行**
>
> 下記コマンドを実行すると、プロジェクトに対応する仮想環境に入り、pythonが実行され、実行が終了すると仮想環境から出ます。
>
> ``` bash
> poetry run python <script-name>
> ```
>
> 下記コマンドを実行すると、プロジェクトに対応する仮想環境に入ります。
>
> ``` bash
> poetry shell
> ```
>
> **`poetry`仮想環境のパッケージの表示**
>
> プロジェクトディレクトリ内で下記コマンドを実行すると、プロジェクトに対応する仮想環境のパッケージを表示できます。
>
> ``` bash
> poetry show
> ```
>
> **有効な`poetry`仮想環境の表示**
>
> プロジェクトディレクトリ内で下記コマンドを実行すると、プロジェクトに対応する仮想環境を表示できます。
>
> ``` bash
> poetry env list
> ```
>
> **使用するpythonバージョンの設定**
>
> プロジェクトディレクトリに作成された`pyproject.toml`の`python = "..."`の部分を編集し、下記コマンドを実行します。
>
> ``` bash
> poetry env use <python-version>
> ```
>
> `pyproject.toml`の`python = "..."`に設定するバージョンは、あくまで条件であり、これを満たす限り、使用するバージョンは、`poetry env use`コマンドで設定できます。
