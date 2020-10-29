#! /bin/bash
source ./config/.env

curl -X POST "https://www.googleapis.com/oauth2/v4/token?client_id=$CLIENT_ID&client_secret=$CLIENT_SECRET&grant_type=$GRANT_TYPE&refresh_token=$REFRESH_TOKEN" > ./bin/data/access_token.json

ACCESS_TOKEN=$(cat ./bin/data/access_token.json| grep "access_token" | cut --delimiter ":" --fields=2 | cut --delimiter "," --fields=1 | cut --delimiter '"' --fields=2)

./bin/getUnreadEmailCount.sh $ACCESS_TOKEN