# arduino-gmail-client

A simple gmail API client that makes cURL requests to check for unread emails, and controls arduino GPIO pins. So.. when you get an email, an LED lights up!

This is a proof of concept, something I wanted to try back when I came across gmail API and OAuth 2.0 for the first time, finally got an arduino to implement it!!

### How Does It Work?

Getting the unread email count using gmail API is not a simple task, since email is a private service a client cannot get access to information without permission. 

OAuth 2.0 is a framework that lays out guidelines for this interaction, before requesting senstive information, getting consent from the user (a.k.a resource owner) is mandatory. Once obtained, the client can exchange it (consent) for temporary access tokens, which must be sent with every future API call that is requesting user data ([more info](https://developers.google.com/identity/protocols/oauth2)).

Signals are sent to the arduino board based on the response obtained from the API requests, GPIO pins are controlled using standard firmata protocol, python APIs for the same are provided by the pyFirmata library.

### How Do I Run This?

#### Set Up an API Client

To obtain your access token and refresh tokens, [follow this guide](https://developers.google.com/identity/protocols/oauth2/web-server#top_of_page).

For future reference, I obtained the authorization grant (code), by browsing:

```sh
https://accounts.google.com/o/oauth2/v2/auth?client_id=CLIENT_ID&scope=https://www.googleapis.com/auth/gmail.readonly&response_type=code&access_type=offline&redirect_uri=http://localhost
```

and exchanged the authorisation code for access tokens via a POST request to [oauth2.googleapis.com/token](https://oauth2.googleapis.com):

```sh
curl -X POST "https://oauth2.googleapis.com/token" \
    -d client_id=CLIENT_ID              \
    -d client_secret=CLIENT_SECRET      \
    -d code=CODE                        \
    -d grant_type=authorization_code    \
    -d redirect_uri=http://localhost
```

Once you're done, you should have all of the following fields:

```sh
 API_KEY [created on the google developer console]
 CLIENT_ID [registered on google developer console]
 CLIENT_SECRET
 EMAIL_ID [which authorized your client, and whose access + refresh tokens you own]
 ACCESS_TOKEN
 REFRESH_TOKEN
```

Rename the `config/template` to `config/env` and replace the first 5 fields with their respective values.

#### Required Libraries

- `pyfirmata`
- flash your arduino with the [standrard firmata](https://github.com/firmata/arduino/blob/master/examples/StandardFirmata/StandardFirmata.ino), firmata is a generic protocol for communicating with microcontrollers from software on a host computer. 

Connect an LED to the pin specified in `gpio_pin_control.py`, and run the python script to make cURL requests every 10 seconds <3
