<!--
    pythonの仮想環境を構築する手順を示す。
 -->

# 開発環境の構築手順

下表のツールを使用したpythonの仮想環境の構築する手順を示します。

|管理対象          |ツール         |
| ---------------- | ------------- |
|pythonバージョン  |[pyenv][pyenv] |
|仮想環境          |[venv][venv]   |
|パッケージ        |[pip][pip]     |

[pyenv]: https://github.com/pyenv/pyenv
[venv]: https://docs.python.org/ja/3/library/venv.html
[pip]: https://pip.pypa.io/en/stable/

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

## 仮想環境の構築

``` bash
cd <pj-dir-path>
pyenv local <python-version> # pythonバージョンのローカル設定
python -m venv <env-name>
```

> [!Note]
> **pythonバージョンのローカル設定**
>
> pythonバージョンが記載された`.python-version`が作成されます。
>
> これにより、プロジェクトのディレクトリ内でpythonを実行した際、`.python-version`のバージョンで実行できます。
>
> pythonを実行した際、カレントディレクトリに`.python-version`がない場合、上の階層を順に探索し、pythonバージョンを設定します。
> 見つからない場合は、`pyenv global`の設定が採用されます。

### 仮想環境の有効化

``` bash
source <env-name>/bin/activate
```

### pythonパッケージのインストール

``` bash
# 単体の場合
pip install <package-name>
# 複数の場合
pip install <package-name1> <package-name2> ...
# バージョン指定する場合
pip install <package-name>==<package-version>
# パッケージバージョンを保存したファイルの場合
pip install -r <file-name>.txt
```

**仮想環境の構築はここまで。**

## その他コマンドについて

### パッケージバージョンの保存

``` bash
pip freeze > <file-name>.txt
```

### 仮想環境の非有効化

``` bash
deactivate
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
