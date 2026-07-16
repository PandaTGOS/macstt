from macstt import STT

with STT() as stt:
    stt.start()
    try:
        for event in stt:
            print(event)
            
    except KeyboardInterrupt:
        print("\nStopping...")