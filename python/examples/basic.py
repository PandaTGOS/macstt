from macstt import STT

with STT() as stt:
    stt.start()

    for event in stt:
        print(event)