#/usr/bin/bash
KEYS=`curl -u $1:$2 -H "accept: application/vnd.github.v3+json" https://api.github.com/repos/shu1oka28/github_test/actions/secrets/public-key`
PUBLIC_KEY=`echo $KEYS|jq '.key'`
PUBLIC_KEYID=`echo $KEYS|jq '.key_id'`

ENCRYPTED=`python3 encrypt.py $PUBLIC_KEY secret_sample.txt`
BODY="{\"encrypted_value\": \"${ENCRYPTED}\", \"key_id\": ${PUBLIC_KEYID}}"
curl -u $1:$2 -X PUT -H "accept: application/vnd.github.v3+json" https://api.github.com/repos/shu1oka28/github_test/actions/secrets/secret_file -d "${BODY}" 
WORKFLOW_ID=`curl -u $1:$2 -H "accept: application/vnd.github.v3+json" https://api.github.com/repos/shu1oka28/github_test/actions/workflows|jq '.workflows[]| select(.path == ".github/workflows/case_secret_artifact.yml").id'` 
curl -u $1:$2 -X POST -H "accept: application/vnd.github.v3+json" https://api.github.com/repos/shu1oka28/github_test/actions/workflows/$WORKFLOW_ID/dispatches -d '{"ref":"main"}' 
sleep 60
curl -u $1:$2 -X DELETE -H "accept: application/vnd.github.v3+json" https://api.github.com/repos/shu1oka28/github_test/actions/secrets/secret_file

