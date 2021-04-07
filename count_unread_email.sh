#! /bin/bash

source "./config/env"
RESP="./data/response.json"

curl "https://gmail.googleapis.com/gmail/v1/users/$EMAIL_ID/messages?q=is:unread&key=$API_KEY"  \
    -H "Authorization: Bearer $1"   \
    -H "Accept: application/json"   \
    --compressed > "$RESP"

IS_ERR=$(grep "code" "$RESP" | cut -d":" -f2 | cut -d"," -f1)
RESULT=$(grep "resultSizeEstimate" "$RESP" | cut -d":" -f2)

if [ "$IS_ERR" ]; then
    ./refresh_access_token.sh
else
    echo "$RESULT"
fi
