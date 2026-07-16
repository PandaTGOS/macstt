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
        if not HELPER.exists():
            raise FileNotFoundError(
                f"macstt helper not found:\n{HELPER}"
            )

        self._process = subprocess.Popen(
            [str(HELPER)],
            stdin=subprocess.PIPE,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            text=True,
            bufsize=1,
        )

        self._closed = False


    def _stdin(self):
        if self._closed or self._process.stdin is None:
            raise RuntimeError("STT has been closed.")
        
        return self._process.stdin
    

    def start(self):
        stdin = self._stdin()

        stdin.write('{"cmd":"start"}\n')
        stdin.flush()


    def stop(self):
        if self._closed:
            return

        stdin = self._stdin()

        stdin.write('{"cmd":"stop"}\n')
        stdin.flush()


    def events(self):
        if self._process.stdout is None:
            return

        try:
            for line in self._process.stdout:
                line = line.strip()
                if line:
                    yield decode(json.loads(line))
        
        finally:
            self.close()


    def __iter__(self):
        return self.events()


    def close(self):
        if self._closed:
            return

        self._closed = True

        try:
            if self._process.stdin:
                self._process.stdin.close()

            self._process.wait(timeout=1)

        except subprocess.TimeoutExpired:
            self._process.terminate()
            self._process.wait()


    def __enter__(self):
        return self

    def __exit__(self, exc_type, exc, tb):
        self.close()
        return False