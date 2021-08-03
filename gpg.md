GPG Keyの追加
================
[Readmeに戻る](/README.md)

GPG Keyの追加方法を説明する。
GPG Keyの追加はしなくても使える。急いでいるならやらなくていい。
ただ、GPGで署名すると、GitHubでVerifiedと表示されてかっこいい。
あと、Commitを本人が行ったという安心感がある。
なので、ぜひがんばってほしい。

参考URL: https://docs.github.com/ja/github/authenticating-to-github/managing-commit-signature-verification

gpgコマンドのインストールは終わっているという前提で進める。
また、メールアドレスは、GitHubに登録しているものか、[README](/README.md)で取得した匿名用メールアドレスを使用する

1. GPGキーペアを作る

```
gpg --full-generate-key
```
上記を実行すると、鍵生成が始まる。入出力例を以下に示す。
```
gpg (GnuPG) 2.2.12; Copyright (C) 2018 Free Software Foundation, Inc.
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.

ご希望の鍵の種類を選択してください:
   (1) RSA と RSA (デフォルト)
   (2) DSA と Elgamal
   (3) DSA (署名のみ)
   (4) RSA (署名のみ)
あなたの選択は? 1
RSA 鍵は 1024 から 4096 ビットの長さで可能です。
鍵長は? (3072) 4096
要求された鍵長は4096ビット
鍵の有効期限を指定してください。
         0 = 鍵は無期限
      <n>  = 鍵は n 日間で期限切れ
      <n>w = 鍵は n 週間で期限切れ
      <n>m = 鍵は n か月間で期限切れ
      <n>y = 鍵は n 年間で期限切れ
鍵の有効期間は? (0)0
鍵は無期限です
これで正しいですか? (y/N) y

GnuPGはあなたの鍵を識別するためにユーザIDを構成する必要があります。

本名: (GitHubのユーザID）
電子メール・アドレス: (GitHubのメールアドレス（noreply.github.comのやつ））
コメント: comment
次のユーザIDを選択しました:
    "user_id (comment) <*******+shu1oka28@users.noreply.github.com>"

名前(N)、コメント(C)、電子メール(E)の変更、またはOK(O)か終了(Q)? O
```

このあとパスフレーズを設定する画面が表示されます。

2. 公開鍵を入手する

```
gpg --list-secret-keys --keyid-format=long
```
上記を実行すると以下のような出力がでる
```
/home/ichioka/.gnupg/pubring.kbx
--------------------------------
sec   rsa4096/123456789ABCDEF 2021-08-03 [SC]
      ***************************************
uid                 [  究極  ] shu1oka28 (comment) <********+shu1oka28@users.noreply.github.com>
ssb   rsa4096/********** 2021-08-03 [E]

```
上記の結果からGPGキーIDは、123456789ABCDEFであることがわかる。


公開鍵を入手する
```
gpg --armor --export 123456789ABCDEF
```
このあとの手順では、この結果をコピーして、GitHubに登録する。

3. GitHubにログインして、Settingsを開く

4. SSH and GPG Keysをクリック

5. New GPG Keyをクリック

6. Keyにコピーした公開鍵を貼りつける

7. Add GPG Keyをクリック

8. GitにGPG署名キーを設定する(123456789ABCDEFは、GPGキーIDに置き換える）

```
git config --global user.signingkey 123456789ABCDEF
git config --global commit.gpgsign true
```

おわり

おつかれさまでした！
