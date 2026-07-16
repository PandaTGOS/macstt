import time
from macstt import STT

stt = STT()
stt.start()

start = time.time()

for event in stt:
    print(event)
    if time.time() - start > 10:
        break

stt.stop()
stt.close()