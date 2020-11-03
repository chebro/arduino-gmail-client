# arduino-gmail-client

A simple gmail client that makes cURL requests using gmail API to check for unread emails, the response is then used to control arduino pins. So if you connect and LED to the right pins, it will light up everytime you recieve an email. 

This was just something I wanted to try when I first stumbled up gmail API and OAuth 2.0 protocols, finally got an arduino to implement it.

### How Does It Work?

The code is extremely simple if you understand OAuth 2.0, if you don't read [this article from google](https://developers.google.com/identity/protocols/oauth2). In a nutshell, to access information from a user aka resource owner, a client must do the following:
1. Get the authorization grant from the resource owner (via a [consent screen](https://developers.google.com/identity/protocols/oauth2/web-server#userconsentprompt)).
2. In exchange to the grant, you recieve an authorisation code. 
3. Exchange the authorization code for access and refresh tokens from the authorization server.
4. Use the access tokens to make API calls on behalf of the user.
5. If the access token expires, use the refresh token to request another access token.

Note: Refresh tokens are only provided on the first request. The IETF documentation on the OAuth 2.0 framework can be found [here](https://tools.ietf.org/html/rfc6749).

### What You'll Need To Run This Locally

##### Setting Up the API Client

You'll need to just follow [this tutorial](https://developers.google.com/identity/protocols/oauth2/web-server#top_of_page) and get the following fields:
```
 API_KEY [created on the google developer console]
 CLIENT_ID [registered on google developer console]
 CLIENT_SECRET
 EMAIL_ID [which authorized your client, and whose access + refresh tokens you own]
 ACCESS_TOKEN
 REFRESH_TOKEN
 ```
You'll only need to do this once because the once you have one access token and the refresh token, you are set. Follow the remaining setps:

1. Rename the `config/template` to `config/.env` and replace the first 5 fields with their respective values. 
2. Move `data/access_token.json` to `/bin/data/access_token.json` and replace the `<YOUR_ACCESS_TOKEN>` field with the respective value.

##### Required Libraries

You'll need the following libraries the `pyfirmata` python library to communicate with the arduino board, and you'll need to flash your arduino with the [standrard firmata](https://github.com/firmata/arduino/blob/master/examples/StandardFirmata/StandardFirmata.ino), firmata is a generic protocol for communicating with microcontrollers from software on a host computer. And you're all set! 

Connect an LED in the pins mentioned in `gmailLEDControl.py` and run `python gmailLEDControl.py` to start making cURL requests every 2 seconds.
