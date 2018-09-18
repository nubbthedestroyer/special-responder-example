import time


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
            returned_message = 'Its alive!!!'
        else:
            returned_message = self.given_message

        return returned_message

    def compose_json(self):
        response_raw = {
            "message": self.this_message,
            "timestamp": self.timestamp()
        }

        return response_raw
