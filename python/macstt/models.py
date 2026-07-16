from dataclasses import dataclass

@dataclass(slots=True, frozen=True)
class StatusEvent:
    type: str
    timestamp: float

@dataclass(slots=True, frozen=True)
class SpeechEvent:
    type: str
    text: str
    is_final: bool
    timestamp: float