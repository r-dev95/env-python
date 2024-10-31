<!--
    pythonの仮想環境を構築する手順を示す。
 -->

# pythonの仮想環境を構築する手順

下表のライブラリを使用したpythonの仮想環境の構築する手順を示します。

|管理項目          |ライブラリ|
|------------------|----------|
|pythonバージョン  |pyenv     |
|仮想環境          |venv      |
|パッケージ        |pip       |

本手順は、下記に示すような一般的な仮想環境構築の手順で複数の仮想環境を同時に構築するための手順となります。

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

* 本手順でpythonバージョンが`3.12.3`の仮想環境を構築した場合のディレクトリ構造の例

    ``` none
    ~/
    ├── .pyenv             # pyenvのインストールディレクトリ
    └── .env               # 仮想環境を構築するディレクトリ
        └── python3.12.3   # pythonバージョン3.12.3の仮想環境ディレクトリ
            └── <env-name> # pythonバージョン3.12.3に対応する仮想環境
    ```

## はじめに

はじめに、本手順における前提を示します。

* 仮想環境とプロジェクトのディレクトリは分けて構築します。

  そのため、使用するpythonバージョンは、仮想環境とプロジェクトのディレクトリのそれぞれに設定します。

* WSLのUbuntu上に仮想環境を構築します。

* pythonバージョンは`3.12.3`で、以下の仮想環境を構築します。

    * tensorflow
    * pytorch

* 使用するデータは、Windows側の`/mnt/c/Users/<user-name>/work/data/pyenv_venv_pip/`にあることとします。

## 1. データ準備

使用するデータとディレクトリ構造を以下に示します。

``` none
data/pyenv_venv_pip/
├── activate.sh          # 仮想環境を有効化するスクリプト
└── .env                 # 仮想環境を構築するディレクトリ
    ├── build_venv.sh    # 単一の仮想環境を構築するスクリプト
    ├── install_pyenv.sh # pyenvをインストールするスクリプト
    ├── setup.sh         # 複数の仮想環境を構築するスクリプト
    └── python3.12.3     # pythonバージョン3.12.3の仮想環境ディレクトリ
```

### 1. pythonパッケージを記述したファイルを作成する

ファイル名は`<env-name>.txt`として、`.env/python3.12.3/`ディレクトリに置いてください。

ここでは、`tf-gpu.txt`と`to-gpu.txt`に以下を記述するとします。

``` none
matplotlib
pandas==2.2.3 # バージョンを指定したい場合
scikit-learn
scikit-image
```

`.env/python3.12.3/`ディレクトリは、以下のようになっていればOKです。

``` none
.env
├── build_venv.sh
├── install_pyenv.sh
├── setup.sh
└── python3.12.3
    ├── tf-gpu.txt   # tensorflowのpythonパッケージ一覧のファイル
    └── to-gpu.txt   #    pytorchのpythonパッケージ一覧のファイル
```

### 2. [setup.sh](../data/pyenv_venv_pip/.env/setup.sh)を編集する

* `A_python_ver`にpythonバージョンを設定します。

    ``` bash
    # pythonバージョン
    A_python_ver=3.12.3
    ```

* `A_envnames`に仮想環境名を設定します。

    ``` bash
    # 仮想環境名の配列
    # コメントアウトすれば、仮想環境を作らない。
    A_envnames=(
        # tf-cpu  # tensorflow (cpu)
        tf-gpu  # tensorflow (gpu)
        to-gpu  # pytorch (gpu)
    )
    ```

* 仮想環境ごとに他に処理を追加したい場合、case文の箇所に追加します。

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

## 2. 仮想環境の構築

### 1. Ubuntuにデータをコピーする

``` bash
cp -r /mnt/c/Users/<user-name>/work/data/pyenv_venv_pip/. ~/
```

### 2. `pyenv`をインストールする

実行後、必要に応じて`sudo`のパスワードを入力します。

``` bash
cd ~/.env/
source install_pyenv.sh
```

`pyenv`の詳細は[公式の手順](https://github.com/pyenv/pyenv)を参照してください。

[`install_pyenv.sh`](../data/pyenv_venv_pip/.env/install_pyenv.sh)は、下記を実行するスクリプトです。

1. Ubuntuパッケージの更新
2. pythonのビルド依存関係パッケージのインストール
3. `pyenv`のインストール
4. `pyenv`の環境変数の設定

### 3. `setup.sh`を実行する

実行後、必要に応じて`sudo`のパスワードを入力します。

``` bash
source setup.sh
```

[`setup.sh`](../data/pyenv_venv_pip/.env/setup.sh)は、下記を実行するスクリプトです。

1. `build_venv.sh`の実行
2. 仮想環境ごとの追加処理の実行

[`build_venv.sh`](../data/pyenv_venv_pip/.env/build_venv.sh)は、下記を実行するスクリプトです。

1. `pyenv`でpythonのインストール
2. `pyenv`でpythonバージョンの設定
3. `venv`で仮想環境の構築
4. `pip`でpythonパッケージのインストール

**仮想環境の構築完了です。**

> [!IMPORTANT]
>
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
>
> 見つからない場合は、`pyenv global`の設定が採用されます。
> 本手順では、`global`は設定していないため、`pyenv global <python-version>`で設定してください。

> [!TIP]
> **仮想環境の有効化**
>
> ``` bash
> source ~/activate.sh <env-name>
> ```
>
> (直接、`source <env-dir-path>/bin/activate`を実行してもOKです)
>
> **単一の仮想環境の構築**
>
> ``` bash
> souce ~/.env/build_venv.sh ~/.env/ <env-name> ~/.env/<env-name>.txt
> ```
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
>
> **`pyenv`でインストールされているpythonの表示**
>
> ``` bash
> pyenv versions
> ```
>
> 出力の例
>
> ``` bash
>   system
> * 3.12.3 (set by <project_dir>/.python-version)
> ```
>
> インストール済みのpythonバージョンの一覧と現在のディレクトリの設定が表示されます。
>
> `system`は`apt-get`等でインストールしたpyhtonのバージョンを指します。
>
> また`pyenv`でインストールしたpythonは、`.pyenv/versions/`にあります。
