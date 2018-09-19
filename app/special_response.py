import time
import json

class specialResponse(object):

    def __init__(self, message=''):
        self.given_message = message
        self.this_message = self.message(message)
        self.response_json = self.compose_json()

    def timestamp(self):
        timestamp = int(time.time())
        return timestamp

    def message(self, message):
        if self.given_message == '':
            returned_message = 'Automation for the People'
        else:
            returned_message = self.given_message

        return returned_message

    def compose_json(self):

        body = {
            "message": self.this_message,
            "timestamp": self.timestamp()
        }

        response_raw = {
                "statusCode": 200,
                "body": json.dumps(body)
            }

        return response_raw
