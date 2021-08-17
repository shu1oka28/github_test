secret_artifact
================

secret.txtをgithubのリポジトリのsecretsに入れ、secretsの内容をGitHub ActionsでArtifactに入れる
Publicリポジトリで機密情報をActionsに送ることができることがわかった。

```
sudo apt install python3-pip
pip3 install -r requirements.txt
./run.sh user_id token
```
user_idはユーザID
tokenは個人用のアクセストークンを入れる
