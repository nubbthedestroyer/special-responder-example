import unittest
from special_response import specialResponse


class TestOutputs(unittest.TestCase):

    def test_init(self):
        respinit = specialResponse()

    def test_custom_message_logic(self):

        custom_message_text = 'custom message text'

        resp2 = specialResponse()
        resp3 = specialResponse(custom_message_text)

        self.assertEqual(resp2.response_json['message'], 'Its alive!!!',
                         'Custom message logic returned an unexpected value when no custom message given')
        self.assertEqual(resp3.response_json['message'], custom_message_text,
                         'Custom message logic did not return the expected and supplied value.')

    def test_timestamp_no_milliseconds(self):
        resp = specialResponse()
        self.assertNotIn('.', str(resp.response_json['timestamp']),
                         'Timestamp being returned includes a period, indicating its includes milliseconds.')


if __name__ == '__main__':
    unittest.main()
