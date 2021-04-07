#! /bin/bash

source "./config/env"

curl -X POST                                        \
    "https://www.googleapis.com/oauth2/v4/token?"   \
    -d client_id="$CLIENT_ID"                       \
    -d client_secret="$CLIENT_SECRET"               \
    -d grant_type="$GRANT_TYPE"                     \
    -d refresh_token="$REFRESH_TOKEN" > ./data/access_token.json

