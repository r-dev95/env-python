<!--
    README
 -->

# 本リポジトリの概要

![github](https://img.shields.io/github/license/r-dev95/wsl_ubuntu_python)

![os](https://custom-icon-badges.herokuapp.com/badge/Windows-d3d3d3.svg?logo=windows)
![os](https://custom-icon-badges.herokuapp.com/badge/Ubuntu-d3d3d3.svg?logo=ubuntu)
![code](https://custom-icon-badges.herokuapp.com/badge/python-d3d3d3.svg?logo=python)
![code](https://custom-icon-badges.herokuapp.com/badge/poetry-d3d3d3.svg?logo=poetry)

本リポジトリは、pythonの開発環境を構築するためのリポジトリです。

## 使用ツール

環境構築に使用しているツールについて、その用途とメリット、デメリットを下記に示します。

### pip

* **用途**
  * パッケージの管理
* **メリット**
  * python標準のパッケージ管理ツールで操作がシンプルで学習コストが低い
* **デメリット**
  * 依存関係の解決能力が低い
  * パッケージのバージョンは手動で固定する必要がある

### venv

* **用途**
  * 仮想環境の管理
* **メリット**
  * python標準の仮想環境管理ツールで操作がシンプルで学習コストが低い
* **デメリット**
  * 依存関係を管理する機能(バージョン固定やロックファイル)がない
  * 仮想環境は手動で有効化する必要がある

### pyenv

* **用途**
  * pythonバージョンの管理
* **メリット**
  * グローバル設定とプロジェクトごとのローカル設定を使い分けられる
  * システムのpythonと独立して管理できる
* **デメリット**
  * pythonはソースコードからコンパイルされるため時間がかかる可能性がある
  * Windowsのネイティブ環境のサポートが限定的である

### poetry

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

## 開発環境の構築

WSLのUbuntu上に構築する体で説明しているため、WSLのインストール方法も記載しています。

### 1. [WSLをインストールする](docs/install_wsl.md)

### 2. pythonの仮想環境を構築する

* **pythonバージョンの管理の必要がなく、標準的な機能で環境を構築したい方向け**
  * [venv+pip](docs/build_venv_pip.md)で仮想環境の構築

* **pythonバージョンを管理しつつ、標準的な機能で環境を構築したい方向け**
  * [pyenv+venv+pip](docs/build_pyenv_venv_pip.md)で仮想環境の構築

* **依存関係の管理を重視したり、パッケージを公開したい方向け**
  * [pyenv+poetry](docs/build_pyenv_poetry.md)で仮想環境の構築

> [!TIP]
>
> **シンボリックリンクを作成する**
>
> Windows側にプロジェクトディレクトリがある方は、WindowsとWSLのディレクトリ間でシンボリックリンクを作成するとよいでしょう。
>
> ``` bash
> ln -s <windows-dir-path> <wsl-dir-path>
> ```
>
> |アクセス      |パス                                      |
> | ------------ | ---------------------------------------- |
> |WSLからWindows|Cドライブの場合、`/mnt/c/`                |
> |WindowsからWSL|エクスプローラーの場合、`\\wsl$`          |
> |同上          |ターミナルの場合、`\\wsl.localhost\Ubuntu`|

## ライセンス

本ソフトウェアは、[MITライセンス](LICENSE)の元提供されています。
