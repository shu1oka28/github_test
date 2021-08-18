#/usr/bin/bash
KEYS=`curl -u $1:$2 -H "accept: application/vnd.github.v3+json" https://api.github.com/repos/shu1oka28/github_test/actions/secrets/public-key`
PUBLIC_KEY=`echo $KEYS|jq '.key'`
PUBLIC_KEYID=`echo $KEYS|jq '.key_id'`

ENCRYPTED=`python3 encrypt.py $PUBLIC_KEY secret_sample.txt`
BODY="{\"encrypted_value\": \"${ENCRYPTED}\", \"key_id\": ${PUBLIC_KEYID}}"
curl -u $1:$2 -X PUT -H "accept: application/vnd.github.v3+json" https://api.github.com/repos/shu1oka28/github_test/actions/secrets/secret_file -d "${BODY}" 
WORKFLOWS=`curl -u $1:$2 -H "accept: application/vnd.github.v3+json" https://api.github.com/repos/shu1oka28/github_test/actions/workflows`
WORKFLOW_ID=`echo $WORKFLOWS|jq '.workflows[]| select(.path == ".github/workflows/case_secret_artifact.yml").id'` 
WORKFLOW_NODEID=`echo $WORKFLOWS|jq '.workflows[]| select(.path == ".github/workflows/case_secret_artifact.yml").node_id'` 
curl -u $1:$2 -X POST -H "accept: application/vnd.github.v3+json" https://api.github.com/repos/shu1oka28/github_test/actions/workflows/$WORKFLOW_ID/dispatches -d '{"ref":"main"}' 

flag=true
while $flag
do
sleep 5
ARTIFACTS=`curl -u $1:$2 -H "accept: application/vnd.github.v3+json" https://api.github.com/repos/shu1oka28/github_test/actions/artifacts|jq '.total_count'`
if [ "$ARTIFACTS" -ne 0 ];then
	ARTIFACTS=`curl -u $1:$2 -H "accept: application/vnd.github.v3+json" https://api.github.com/repos/shu1oka28/github_test/actions/artifacts|jq '.artifacts[]|select(.name=="result").archive_download_url'`
	echo $ARTIFACTS
	if [ -n "$ARTIFACTS" ];then
		flag=false
	fi
fi
done
ARTIFACTS=`curl -u $1:$2 -H "accept: application/vnd.github.v3+json" https://api.github.com/repos/shu1oka28/github_test/actions/artifacts|jq '.artifacts[]|select("name"=="result").archive_download_url[0]'`

curl -u $1:$2 -X DELETE -H "accept: application/vnd.github.v3+json" https://api.github.com/repos/shu1oka28/github_test/actions/secrets/secret_file

