from pyfirmata import Arduino
import os, time, json

def switchLED(state):
	BOARD.digital[LED_PIN].write(state)

BOARD = Arduino('/dev/ttyACM0')
ACCESS_TOKEN = json.load(open('./access_token.json', 'r'))['access_token']
LED_PIN = 13

while True:
    response = int(os.popen(f'./getUnreadEmailCount.sh {ACCESS_TOKEN}').read())
    print(response)
    switchLED(1) if response else switchLED(0)
    time.sleep(5)
