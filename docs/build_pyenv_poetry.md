<!--
    pythonの仮想環境を構築する手順を示す。
 -->

# 開発環境の構築手順

下表のツールを使用したpythonの仮想環境の構築する手順を示します。

|管理対象          |ツール           |
| ---------------- | --------------- |
|pythonバージョン  |[pyenv][pyenv]   |
|仮想環境          |[poetry][poetry] |
|パッケージ        |同上             |

[pyenv]: https://github.com/pyenv/pyenv
[poetry]: https://python-poetry.org/docs/

## pyenvのインストールと設定

### インストール

``` bash
curl https://pyenv.run | bash
```

### 環境変数の設定

``` bash
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(pyenv init -)"' >> ~/.bashrc
source ~/.bashrc
```

### pythonのビルド依存関係パッケージのインストール

`pyenv`ではpythonをビルドするため、必要なパッケージをインストールする必要がある。

インストールするパッケージは[こちら](https://github.com/pyenv/pyenv/wiki#suggested-build-environment)

``` bash
sudo apt-get install <package-name>
```

### pythonのインストール

``` bash
pyenv install <python-version>
```

### pythonバージョンのグローバル設定

``` bash
pyenv global <python-version>
```

## poetryのインストールと設定

### インストール

``` bash
curl -sSL https://install.python-poetry.org | python3 -
```

### 環境変数の設定

``` bash
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

### タブ補完の有効化

``` bash
poetry completions bash >> ~/.bash_completion
```

### 仮想環境の構築ディレクトリの設定

`poetry`ではデフォルトで`virtualenvs.path`に指定されたディレクトリに仮想環境を構築するため、プロジェクトディレクトリに構築する設定を行います。

この設定の場合、プロジェクトディレクトリに`.venv`という仮想環境が構築されます。

``` bash
poetry config virtualenvs.in-project true
```

> [!Tip]
> **poetryの設定の確認**
>
> ``` bash
> poetry config --list
> ```

## 仮想環境(プロジェクト)の構築

``` bash
poetry new <pj-name-path>
```

### pythonバージョンのローカル設定

`<pj-name-path>/pyproject.toml`の`requires-python`のバージョンを書き換えます。

``` bash
cd <pj-name-path>
poetry env use <python-version> # 書き換えた場合のみ
```

> [!Note]
>
> `pyproject.toml`の`requires-python`に設定するバージョンは、あくまで条件であり、これを満たす限り、使用するバージョンは、`poetry env use`コマンドで設定できます。

### pythonパッケージのインストール

``` bash
# デフォルトグループの場合
poetry add <package-name>
# <group-name>グループの場合
poetry add --group <group-name> <package-name>
# devグループの場合
poetry add --dev <package-name>
```

**仮想環境の構築はここまで。**

## その他コマンドについて

### 仮想環境でのpython実行

プロジェクトに対応する仮想環境に入り、pythonが実行され、実行が終了すると仮想環境から出ます。

``` bash
poetry run python <script-name>
```

プロジェクトに対応する仮想環境に入り、pythonコマンドを直接実行できるようになります。

``` bash
poetry env activate
```

### 仮想環境のパッケージの表示

プロジェクトに対応する仮想環境のパッケージを表示できます。

``` bash
poetry show
```

### 有効な仮想環境の表示

プロジェクトに対応する仮想環境を表示できます。

``` bash
poetry env list
```

### インストール済みpythonの表示

インストール済みのpythonバージョンの一覧と現在のディレクトリの設定が表示されます。

``` bash
pyenv versions
```

`system`は`apt-get`等でインストールしたpyhtonのバージョンを指します。

``` bash
  system
* 3.12.3 (set by <pj-dir-path>/.python-version)
```
