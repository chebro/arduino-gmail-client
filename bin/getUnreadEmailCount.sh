#! /bin/bash
source ./config/.env

curl "https://gmail.googleapis.com/gmail/v1/users/$EMAIL_ID/messages?q=is:unread&key=$API_KEY" \
--header "Authorization: Bearer $1" --header 'Accept: application/json' \
--compressed > ./bin/data/response.json

ERROR_CODE=$(cat ./bin/data/response.json | grep "code" | cut --delimiter ":" --fields=2 | cut --delimiter "," --fields=1)
RESULT=$(cat ./bin/data/response.json | grep "resultSizeEstimate" | cut --delimiter ":" --fields=2)

if [ $ERROR_CODE ]; then
    ./bin/refreshAccessToken.sh
else
    echo $RESULT
fi