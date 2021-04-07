#!/bin/env/python

"Arduino GPIO PIN control with pyfirmata and gmail API"

import os
import json
import time

from pyfirmata import Arduino

class PinController(object):

    def __init__(self):
        self.board = Arduino('/dev/ttyACM0')
        self.pin = 13

    def switch_led_state(self, state):
        "Controls LED State"
        self.board.digital[self.pin].write(state)

def main():
    "Main Fucntion"

    pcr = PinController()
    interval = 10

    while True:
        token = json.load(open('./data/access_token.json', 'r'))['access_token']
        res = os.popen(f'./count_unread_email.sh {token}').read()
        print('Total Unread Emails:', res)

        if res != '' and int(res):
            pcr.switch_led_state(1)
        else:
            pcr.switch_led_state(0)

        time.sleep(interval)

if __name__ == "__main__":
    main()
