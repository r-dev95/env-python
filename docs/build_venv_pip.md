<!--
    pythonの仮想環境を構築する手順を示す。
 -->

# 開発環境の構築手順

下表のツールを使用したpythonの仮想環境の構築する手順を示します。

|管理対象          |ツール        |
| ---------------- | ------------ |
|pythonバージョン  |なし          |
|仮想環境          |[venv][venv]  |
|パッケージ        |[pip][pip]    |

[venv]: https://docs.python.org/ja/3/library/venv.html
[pip]: https://pip.pypa.io/en/stable/

## 仮想環境の構築

``` bash
cd <pj-dir-path>
python -m venv <env-name>
```

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
