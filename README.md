# macstt

Native macOS Speech-to-Text for Python using Apple's Speech framework.

`macstt` provides a lightweight Python interface to Apple's native on-device Speech Recognition framework by running a small Swift helper process and communicating over a simple JSON protocol.

The goal of the project is to expose macOS speech recognition to Python with a clean API while keeping the native implementation completely isolated from Python.

---

## Features

* Native macOS Speech Recognition
* On-device speech recognition
* Streaming partial transcription results
* JSON-based communication protocol
* Typed Python event models
* Context manager API
* Automatic native helper build during development
* Bundled native helper executable
* Minimal architecture with no unnecessary abstractions

---

## Architecture

```
Python
    │
    ▼
macstt
    │
    ▼
JSON over stdin/stdout
    │
    ▼
Swift helper executable
    │
    ▼
Apple Speech Framework
```

The Python package never calls Apple's Speech framework directly.

Instead, a small native Swift executable owns all platform-specific logic and communicates with Python using newline-delimited JSON messages.

This separation keeps both sides simple, testable and independently maintainable.

---

## Repository Structure

```
macstt/

├── native/
│   └── macstt-helper/
│
├── bindings/
│   └── python/
│       ├── macstt/
│       ├── pyproject.toml
│       └── setup.py
│
├── examples/
│   └── python/
│
├── tools/
│
├── README.md
├── CHANGELOG.md
└── LICENSE
```

---

## Requirements

* macOS
* Python 3.10+
* Xcode (development only)
* Apple Speech Framework

---

## Development Setup

Clone the repository

```bash
git clone https://github.com/<your-username>/macstt.git
cd macstt
```

Create a virtual environment

```bash
python3 -m venv .venv
source .venv/bin/activate
```

Install the package

```bash
cd bindings/python

pip install -e .
```

During installation the native helper is automatically:

* compiled in Release mode
* copied into the package
* bundled for local development

---

## Quick Start

```python
from macstt import STT

with STT() as stt:

    stt.start()

    for event in stt:
        print(event)
```

Example output

```text
StatusEvent(type='started', timestamp=...)

SpeechEvent(
    type='speech',
    text='Hello world',
    is_final=False,
    timestamp=...
)
```

---

## Event Types

### StatusEvent

```python
StatusEvent(
    type="started",
    timestamp=...
)
```

or

```python
StatusEvent(
    type="stopped",
    timestamp=...
)
```

---

### SpeechEvent

```python
SpeechEvent(
    type="speech",
    text="Hello world",
    is_final=False,
    timestamp=...
)
```

---

## Native Protocol

Commands sent to the helper

```json
{"cmd":"start"}
```

```json
{"cmd":"stop"}
```

Events returned

```json
{
  "type":"speech",
  "text":"Hello world",
  "isFinal":false,
  "timestamp":1784208237.97
}
```

---

## Design Goals

This project intentionally focuses on:

* keeping the Python API small
* keeping the Swift helper independent
* minimizing code and abstractions
* using native macOS APIs instead of third-party speech engines
* communicating through a simple language-agnostic JSON protocol

---

## Current Status

Current capabilities include:

* Streaming speech recognition
* Start / stop control
* Typed Python events
* Automatic helper build for development
* Continuous Integration
* Editable package installation

Planned work includes:

* Prebuilt macOS wheels
* PyPI publishing
* Automated release pipeline
* Expanded documentation
* Additional speech-related libraries in the future

---

## License

MIT License.
