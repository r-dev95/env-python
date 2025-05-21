<!--
    README
 -->

# Python Development Environment

[![license](https://img.shields.io/github/license/r-dev95/env-python)](./LICENSE)

![Windows](https://custom-icon-badges.herokuapp.com/badge/Windows-blue.svg?labelColor=d3d3d3&logo=windows)
![Ubuntu](https://custom-icon-badges.herokuapp.com/badge/Ubuntu-dd4814.svg?labelColor=d3d3d3&logo=ubuntu)
[![Python](https://img.shields.io/badge/Python-3776AB.svg?labelColor=d3d3d3&logo=python)](https://github.com/python)
[![Poetry](https://img.shields.io/endpoint?url=https://python-poetry.org/badge/v0.json)](https://python-poetry.org/)

本リポジトリは、pythonの開発環境を構築する手順を示します。

## 開発環境の構築

### [venv+pip](docs/build_venv_pip.md)で仮想環境の構築

* 標準的な機能で環境を構築したい方
* pythonバージョンの管理の必要がない方

### [pyenv+venv+pip](docs/build_pyenv_venv_pip.md)で仮想環境の構築

* 標準的な機能で環境を構築したい方
* pythonバージョンを管理したい方

### [pyenv+poetry](docs/build_pyenv_poetry.md)で仮想環境の構築

* pythonバージョンを管理したい方
* 依存関係の管理を重視したい方
* パッケージを公開したい方

### [asdf+poetry](docs/build_asdf_poetry.md)で仮想環境の構築

* python以外の言語やツールのバージョンも管理したい方
* 依存関係の管理を重視したい方
* パッケージを公開したい方

> [!Note]
> WSLのUbuntu上に構築する体で説明しているため、必要に応じて、WSLもインストールしてください。
>
> * [Microsoft公式手順](https://learn.microsoft.com/ja-jp/windows/wsl/install)
> * シンボリックリンクの作成
>
>   Windows側にプロジェクトディレクトリがある方は、WindowsとWSLのディレクトリ間でシンボリックリンクを作成するとよいでしょう。
>
>   ``` bash
>   ln -s <windows-dir-path> <wsl-dir-path>
>   ```
>
>   |アクセス      |パス                                      |
>   | ------------ | ---------------------------------------- |
>   |WSLからWindows|Cドライブの場合、`/mnt/c/`                |
>   |WindowsからWSL|エクスプローラーの場合、`\\wsl$`          |
>   |同上          |ターミナルの場合、`\\wsl.localhost\Ubuntu`|

## ライセンス

本リポジトリは、[MITライセンス](LICENSE)に基づいてライセンスされています。
