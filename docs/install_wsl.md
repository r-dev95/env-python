<!--
    WSLをインストールする手順を示す。
 -->

# WSLをインストールする手順

WSL(Windows Subsystem for Linux)をインストールする手順を示します。

ここでは、WSL上にUbuntuをインストールする前提で進めます。

本手順は[Microsoftの公式手順][wsl]を参照しています。

[wsl]: https://learn.microsoft.com/ja-jp/windows/wsl/install

## 1. 準備(Windows機能の有効化)

`コントロールパネル` > `プログラムと機能` > `Windowsの機能の有効化または無効化`
の順に開いて、下記にチェックを入れます。

* Linux用Windowsサブシステム
* 仮想マシンプラットフォーム

    ![コントロールパネル](image/cnt-001.png)

    ![プログラムと機能](image/cnt-002.png)

    ![Windowsの機能](image/cnt-003.png)

## 2. WSLのインストール

1. `Windows PowerShell`を起動します。

1. WSLのサブパッケージを更新します。

    ``` powershell
    wsl --update
    ```

1. WSLのデフォルトバージョンを2に設定します。

    ``` powershell
    wsl --set-default-version 2
    ```

## 3. Ubuntuのインストール

1. Ubuntuをインストールします。

    ``` powershell
    wsl --install ubuntu
    ```

1. 初回起動時の設定を行います。

   ユーザ名、パスワードを入力してください。

    ``` powershell
    ...
    Enter new UNIX username: <ユーザ名>
    New password: <パスワード>
    Retype new password: <パスワード>
    ...
    ```

**インストール完了です。**

> [!TIP]
>
> **WSLバージョンの確認**
>
> ``` powershell
> wsl -version # -v でもOK
> ```
>
> **ディストリビューションの起動**
>
> ``` powershell
> # wsl -d <ディストリビューション名>
> wsl -d ubuntu
> ```
>
> **WSLと実行中ディストリビューションの停止**
>
> ``` powershell
> wsl --shutdown
> ```
>
> **インストール可能なディストリビューションの確認**
>
> ``` powershell
> wsl -list -online # -l -o でもOK
> ```
>
> **インストール済みのディストリビューションの確認**
>
> ``` powershell
> wsl -list -version # -l -v でもOK
> ```
>
> **インストール済みのディストリビューションの削除**
>
> ``` powershell
> # wsl --unregister <ディストリビューション名>
> wsl --unregister ubuntu
> ```
>
> **ディストリビューションのエクスポート**
>
> ``` powershell
> # wsl --export (--vhd) <ディストリビューション名> <ファイル名>
> wsl --export ubuntu ubuntu.tgz # .tgzの場合
> wsl --export --vhd ubuntu ubuntu.vhdx # .vhdxの場合
> ```
>
> **ディストリビューションのインポート**
>
> ``` powershell
> # wsl --import (--vhd) <ディストリビューション名> <インポートパス> <ファイル名>
> wsl --import ubuntu C:\Users\<user_name>\AppData\Local\Packages\ ubuntu.tgz
> wsl --import --vhd ubuntu C:\Users\<user_name>\AppData\Local\Packages\ ubuntu.vhdx
> ```
