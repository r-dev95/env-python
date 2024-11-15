<!--
    README
 -->

# Python Development Environment

[![license](https://img.shields.io/github/license/r-dev95/env-python)](./LICENSE)

![Windows](https://custom-icon-badges.herokuapp.com/badge/Windows-blue.svg?labelColor=d3d3d3&logo=windows)
![Ubuntu](https://custom-icon-badges.herokuapp.com/badge/Ubuntu-dd4814.svg?labelColor=d3d3d3&logo=ubuntu)
[![Python](https://img.shields.io/badge/Python-3776AB.svg?labelColor=d3d3d3&logo=python)](https://github.com/python)
[![Poetry](https://img.shields.io/endpoint?url=https://python-poetry.org/badge/v0.json)](https://python-poetry.org/)

本リポジトリは、pythonの開発環境を構築するためのリポジトリです。

通常、pythonではプロジェクトごとに仮想環境を構築し、パッケージを管理します。

またプロジェクトによっては、異なる複数のpythonバージョンで開発することもあります。

一般的に、安定した品質の高い開発を行うには、下記のようなことが開発環境には求められます。

* 操作がシンプルであること
* 動作が高速であること
* パッケージの依存関係の解決能力が高いこと
* 開発環境の再現性が高いこと

しかし、プロジェクトの特性によって重視する要素は異なります。

そのため環境構築に使用するツールのパターンをいくつか準備しているので、プロジェクトにあったものを選択してください。

## 使用ツール

環境構築に使用しているツールについて、その用途とメリット、デメリットを簡単に示します。

### [pip](https://pip.pypa.io/en/stable/)

* **用途**
  * パッケージの管理
* **メリット**
  * python標準のパッケージ管理ツールで操作がシンプルで学習コストが低い
* **デメリット**
  * 依存関係の解決能力が低い
  * パッケージのバージョンは手動で固定する必要がある

### [venv](https://docs.python.org/ja/3/library/venv.html)

* **用途**
  * 仮想環境の管理
* **メリット**
  * python標準の仮想環境管理ツールで操作がシンプルで学習コストが低い
* **デメリット**
  * 依存関係を管理する機能(バージョン固定やロックファイル)がない
  * 仮想環境は手動で有効化する必要がある

### [poetry](https://python-poetry.org/docs/)

* **用途**
  * パッケージの管理
  * 仮想環境の管理
* **メリット**
  * 依存関係の解決能力が高い
  * 仮想環境や設定ファイル、ロックファイルが自動で作成され、再現性が高い
  * 容易にパッケージを公開できる
* **デメリット**
  * 他のツール(pip等)と完全に互換性があるわけではない
  * 多機能ゆえ、学習コストがやや高い

### [pyenv](https://github.com/pyenv/pyenv)

* **用途**
  * pythonバージョンの管理
* **メリット**
  * グローバル設定とプロジェクトごとのローカル設定を使い分けられる
  * システムのpythonと独立して管理できる
* **デメリット**
  * pythonはソースコードからコンパイルされるため時間がかかる可能性がある
  * Windowsのネイティブ環境のサポートが限定的である

### [asdf](https://asdf-vm.com/)

* **用途**
  * pythonバージョンの管理(python以外の言語やツールも管理可能)
* **メリット**
  * グローバル設定とプロジェクトごとのローカル設定を使い分けられる
  * システムのpythonと独立して管理できる
  * python以外の言語やツールも管理できる
* **デメリット**
  * pythonはソースコードからコンパイルされるため時間がかかる可能性がある

### [uv](https://docs.astral.sh/uv/)

**coming soon...**

## 開発環境の構築

WSLのUbuntu上に構築する体で説明しているため、必要に応じて、WSLもインストールしてください。

### 1. WSLをインストールする

* [Microsoft公式手順](https://learn.microsoft.com/ja-jp/windows/wsl/install)

### 2. pythonの仮想環境を構築する

* [venv+pip](docs/build_venv_pip.md)で仮想環境の構築
  * 標準的な機能で環境を構築したい方
  * pythonバージョンの管理の必要がない方

* [pyenv+venv+pip](docs/build_pyenv_venv_pip.md)で仮想環境の構築
  * 標準的な機能で環境を構築したい方
  * pythonバージョンを管理したい方

* [pyenv+poetry](docs/build_pyenv_poetry.md)で仮想環境の構築
  * pythonバージョンを管理したい方
  * 依存関係の管理を重視したい方
  * パッケージを公開したい方

* [asdf+poetry](docs/build_asdf_poetry.md)で仮想環境の構築
  * python以外の言語やツールのバージョンも管理したい方
  * 依存関係の管理を重視したい方
  * パッケージを公開したい方

### 3. シンボリックリンクを作成する

Windows側にプロジェクトディレクトリがある方は、WindowsとWSLのディレクトリ間でシンボリックリンクを作成するとよいでしょう。

``` bash
ln -s <windows-dir-path> <wsl-dir-path>
```

|アクセス      |パス                                      |
| ------------ | ---------------------------------------- |
|WSLからWindows|Cドライブの場合、`/mnt/c/`                |
|WindowsからWSL|エクスプローラーの場合、`\\wsl$`          |
|同上          |ターミナルの場合、`\\wsl.localhost\Ubuntu`|

## ライセンス

本リポジトリは、[MITライセンス](LICENSE)に基づいてライセンスされています。
