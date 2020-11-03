# arduino-gmail-client

A simple gmail client that uses cURL requests to check for unread gmail's, the response is then used to control arduino pins. This was just something I wanted to try when I first came across gmail API and OAuth 2.0 protocols, finally got an arduino to try it :)

## How Does It Work?

The code is extremely simple if you understand OAuth 2.0, if you don't read [this article from google](https://developers.google.com/identity/protocols/oauth2). In a nutshell, to access user information from a server a client must do the following:
1. Get the authorization grant code (you'll need a consent screen setup for this)
2. Exchange the authorization code for access and refresh tokens(refresh tokens are only provided on on the first request).
3. Use the access tokens to make API calls on behalf of the user.
4. If the access token expires, use the refresh token to get another access token.

## What You'll Need To Run This Locally

You'll need to just follow [this tutorial](https://developers.google.com/identity/protocols/oauth2/web-server#top_of_page) and get get the following fields:
```
 API_KEY [created on the google developer console]
 CLIENT_ID [registered on google developer console]
 CLIENT_SECRET
 EMAIL_ID [which authorized your client, and whose access + refresh tokens you own]
 ACCESS_TOKEN
 REFRESH_TOKEN
 ```
