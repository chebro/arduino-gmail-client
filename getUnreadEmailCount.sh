#! /bin/sh
API_KEY=<YOUR_API_KEY>
EMAIL_ID=<YOUR_GMAIL_WITH_ACCESS_TOKEN>

curl "https://gmail.googleapis.com/gmail/v1/users/$EMAIL_ID/messages?q=is:unread&key=$API_KEY" \
--header "Authorization: Bearer $1" --header 'Accept: application/json' \
--compressed > response.json

ERROR_CODE=$(cat response.json | grep "code" | cut --delimiter ":" --fields=2 | cut --delimiter "," --fields=1)
RESULT=$(cat response.json | grep "resultSizeEstimate" | cut --delimiter ":" --fields=2)

if [ $ERROR_CODE ]; then
    ./refreshAccessToken.sh
else
    echo $RESULT
fi