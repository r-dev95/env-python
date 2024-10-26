<!--
    README
 -->

# 本リポジトリの概要

![github](https://img.shields.io/github/license/r-dev95/wsl_ubuntu_python)

![os](https://custom-icon-badges.herokuapp.com/badge/Windows-d3d3d3.svg?logo=windows)
![os](https://custom-icon-badges.herokuapp.com/badge/Ubuntu-d3d3d3.svg?logo=ubuntu)
![code](https://custom-icon-badges.herokuapp.com/badge/python-d3d3d3.svg?logo=python)

本リポジトリは、WSL上にpythonの仮想環境を構築するためのリポジトリです。

## 開発環境の構築

開発環境を構築する手順を示します。

1. [WSLをインストールする。](docs/install_wsl.md)

1. [pythonの仮想環境を構築する。](docs/install_python.md)

1. シンボリックリンクを作成する。

    ``` bash
    # ln -s <Windowsのパス> <WSLのディストリビューションのパス>
    ln -s /mnt/c/Users/<user_name>/work/ ~/work
    ```

## ライセンス

本ソフトウェアは、[MITライセンス](LICENSE)の元提供されています。
