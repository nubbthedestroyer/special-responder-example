from special_response import specialResponse


def handler(event, context):
    try:
        custom_message = event['custom_message']
        response_init = specialResponse(custom_message)
    except KeyError:
        response_init = specialResponse()
        pass

    return response_init.response_json
