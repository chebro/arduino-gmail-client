#! /bin/sh
CLIENT_ID=<YOUR_CLIENT_ID>
CLIENT_SECRET=<YOUR_CLIENT_SECRET>
GRANT_TYPE=refresh_token
REFRESH_TOKEN=<YOUR_REFRESH_TOKEN>

curl -X POST "https://www.googleapis.com/oauth2/v4/token?client_id=$CLIENT_ID&client_secret=$CLIENT_SECRET&grant_type=$GRANT_TYPE&refresh_token=$REFRESH_TOKEN" > access_token.json

ACCESS_TOKEN=$(cat access_token.json| grep "access_token" | cut --delimiter ":" --fields=2 | cut --delimiter "," --fields=1 | cut --delimiter '"' --fields=2)

./getUnreadEmailCount.sh $ACCESS_TOKEN