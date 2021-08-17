GitHub API
======================

Secrets
--------------

### CREATE&UPDATE GitHub Secretsの作成・更新
#### 準備（インストール）
1. GitHubで鍵を作る
2. 以下を実行
```
apt install python3-pip
pip3 install -r requirements.txt
```
#### 実行
1. public_keyの取得

```
curl -u username:token -H "accept: application/vnd.github.v3+json" https://api.github.com/repos/shu1oka28/github_test/actions/secrets/public-key
```

2. secretを暗号化
```
python3 encrypt.py public_key string
```
上記のpublic_keyに1で取得した鍵、stringに暗号化する文字列を入れる

3. 送る
```
curl -u username:token -X PUT -H "accept application/vnd.github.v3+json" https://api.github.com/repos/shu1oka28/github_test/actions/secrets/secrets_name -d '{"encrypted_value":"encrypted_value", "key_id": "key_id"}'
```
上記のsecrets_nameにsecretsの名前、encrypted_valueに2で暗号化した値、key_idに1.で取得したkey_idを入れる。

### DELETE
```
curl -u username:token -X DELETE -H "accept: application/vnd.github.v3+json" https://api.github.com/repos/shu1oka28/github_test/actions/secrets/secrets_name
```
