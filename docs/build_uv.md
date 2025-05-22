<!--
    pythonの仮想環境を構築する手順を示す。
 -->

# 開発環境の構築手順

下表のツールを使用したpythonの仮想環境の構築する手順を示します。

|管理対象          |ツール   |
| ---------------- | ------- |
|pythonバージョン  |[uv][uv] |
|仮想環境          |同上     |
|パッケージ        |同上     |

[uv]: https://docs.astral.sh/uv/

## uvのインストールと設定

### インストール

``` bash
curl -LsSf https://astral.sh/uv/install.sh | sh
```

### タブ補完の設定

``` bash
echo 'eval "$(uv generate-shell-completion bash)"' >> ~/.bashrc
echo 'eval "$(uvx --generate-shell-completion bash)"' >> ~/.bashrc
source ~/.bashrc
```

### pythonのインストール

``` bash
uv python install <python-version>
```

## 仮想環境(プロジェクト)の構築

``` bash
uv init <pj-name-path>
```

### pythonバージョンのローカル設定

`<pj-name-path>/pyproject.toml`の`requires-python`のバージョンを書き換えます。

``` bash
cd <pj-name-path>
uv python pin <python-version> # 書き換えた場合のみ
```

> [!Note]
>
> `pyproject.toml`の`requires-python`に設定するバージョンは、あくまで条件であり、これを満たす限り、使用するバージョンは、`uv python pin`コマンドで設定できます。

### pythonパッケージのインストール

``` bash
# デフォルトグループの場合
uv add <package-name>
# <group-name>グループの場合
uv add --group <group-name> <package-name>
# devグループの場合
uv add --dev <package-name>
```

**仮想環境の構築はここまで。**

## その他コマンドについて

### 仮想環境でのpython実行

プロジェクトに対応する仮想環境に入り、pythonが実行され、実行が終了すると仮想環境から出ます。

``` bash
uv run python <script-name>
```

プロジェクトに対応する仮想環境に入り、pythonコマンドを直接実行できるようになります。

``` bash
source .venv/bin/activate
```

### 仮想環境のパッケージの表示

プロジェクトに対応する仮想環境のパッケージを表示できます。

``` bash
uv pip list
```

### 利用可能またはインストール済みpythonの表示

利用可能またはインストール済みのpythonバージョンの一覧が表示されます。

``` bash
uv python list
```

``` bash
cpython-3.14.0a7-linux-x86_64-gnu                 <download available>
cpython-3.14.0a7+freethreaded-linux-x86_64-gnu    <download available>
cpython-3.13.3-linux-x86_64-gnu                   <download available>
cpython-3.13.3+freethreaded-linux-x86_64-gnu      <download available>
cpython-3.12.10-linux-x86_64-gnu                  <download available>
cpython-3.12.3-linux-x86_64-gnu                   /usr/bin/python3.12
cpython-3.12.3-linux-x86_64-gnu                   /usr/bin/python3 -> python3.12
cpython-3.11.12-linux-x86_64-gnu                  <download available>
cpython-3.10.17-linux-x86_64-gnu                  <download available>
cpython-3.9.22-linux-x86_64-gnu                   <download available>
cpython-3.8.20-linux-x86_64-gnu                   <download available>
pypy-3.11.11-linux-x86_64-gnu                     <download available>
pypy-3.10.16-linux-x86_64-gnu                     <download available>
pypy-3.9.19-linux-x86_64-gnu                      <download available>
pypy-3.8.16-linux-x86_64-gnu                      <download available>
graalpy-3.11.0-linux-x86_64-gnu                   <download available>
graalpy-3.10.0-linux-x86_64-gnu                   <download available>
graalpy-3.8.5-linux-x86_64-gnu                    <download available>
```
