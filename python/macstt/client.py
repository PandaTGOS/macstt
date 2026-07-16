import json
import subprocess
from pathlib import Path

from .protocol import decode


HELPER = (
    Path(__file__).resolve().parent
    / "helper"
    / "macstt-helper"
)

class STT:
    def __init__(self):
        self.process = subprocess.Popen(
            [str(HELPER)],
            stdin=subprocess.PIPE,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            text=True,
            bufsize=1,
        )

    def start(self):
        assert self.process.stdin

        self.process.stdin.write('{"cmd":"start"}\n')
        self.process.stdin.flush()

    def stop(self):
        assert self.process.stdin

        self.process.stdin.write('{"cmd":"stop"}\n')
        self.process.stdin.flush()

    def events(self):
        assert self.process.stdout

        for line in self.process.stdout:

            line = line.strip()

            if not line:
                continue

            yield decode(json.loads(line))

    def __iter__(self):
        return self.events()

    def close(self):
        self.process.terminate()
        self.process.wait()