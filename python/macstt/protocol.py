from .models import SpeechEvent
from .models import StatusEvent


def decode(message: dict):
    if message["type"] == "speech":
        return SpeechEvent(
            type=message["type"],
            text=message["text"],
            is_final=message["isFinal"],
            timestamp=message["timestamp"],
        )

    return StatusEvent(
        type=message["type"],
        timestamp=message["timestamp"],
    )