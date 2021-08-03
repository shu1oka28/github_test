GitHubの使い方のメモ
======================
[ページ一覧](/menu.md)

研究室でGitHubの使い方がよくわからないという人が多いので、「GitHubをおもちゃにする会」を実施する。このリポジトリは、会で説明しようと思っていることをメモしたものです。
このリポジトリは、先輩に言われたことをとにかくメモしたものです。
改善点があれば、このリポジトリにPull Requestを投げるか、issueを立てるかしてください。

新たにVMを立てた！または、新しいPCを使い始める
----------------------------------------------
参考URL: https://docs.github.com/ja/github/authenticating-to-github/connecting-to-github-with-ssh

1. 既存のSSH公開鍵を探す
```
ls -al ~/.ssh
```

以下のいずれかのファイル名があれば、公開鍵である。
- id_rsa.pub
- id_ecdsa.pub
- id_ed25519.pub

2. ない場合は、SSH秘密鍵と公開鍵のペアを作成する。
```
ssh-keygen -t ed25519 -C "自分が読んだときにわかりやすいコメント"
```
いろいろ出てくるが、Enterキーを押し続ける（パスフレーズが必要な場合は設定すること）

3. 公開鍵を入手
```
cat ~/.ssh/id_ed25519.pub
```

4. GitHubにログインし、Settingsを開く
5. SSH and GPG keysをクリック
6. New SSH keyをクリック
7. Titleに自分にとってわかりやすい名前、Keyに3.で見れた中身をコピペ
8. Add SSH keyをクリック
9. Emailsをクリック
10. Primary email addressの部分に以下の表記がある。
```
*******+shu1oka28@users.noreply.github.com will be used for web-based Git operations, 
```
`数字+user_id@users.noreply.github.com`をコピーする。コピーした文字列は、GitHubでEメールアドレスとして使う。これにより、自分の本来のメールアドレスを隠すことができる。この資料では、以後、noreply.github.comで終わるメールアドレスのことを匿名用メールアドレスと呼ぶ。
11. Gitに登録する
```
git config --global user.email "匿名用メールアドレス"
git config --global user.name "GitHubのユーザID"
```

12. 余裕があったら[GPGキーの追加](/gpg.md)もやってほしい.


新たにプロジェクトに参加する
-------------------------------

1. 最初にforkして、自分のアカウントにプロジェクトをつくる。
2. `git clone (forkしたプロジェクトのURL)`
3. `git remote add upstream (fork元のプロジェクトのURL)`

普段の作業
-----------------------

1. 作業開始前にみんなの作業結果をダウンロード
```
git fetch upstream
git merge upstream/main
```
なにかエラーが出た場合は、エラーがでたファイルを開いて、おかしい部分を正しく直してください。

エラーの原因は、自分以外の人が自分と同じファイルを編集してしまったことであることが多いです。このとき、エラーが起きたファイルには、2人の編集内容が並べて書かれています。どっちを採用するかを決めて、いらない方を消すか魔改造するかしてください。

2. プログラム書いたり、作業をする。

3. 一区切りついたら、作業結果をフォークしたプロジェクトにアップロードする。
```
git commit -a -m "いい感じに編集しました！"
git push origin main
```

4. Pull Requestをつくる
5. (だれかが) Mergeする


