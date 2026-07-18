# macstt

> Native macOS Speech-to-Text for Python powered by Apple's Speech framework.

`macstt` is a modern Python library that brings Apple's native Speech Recognition framework to Python through a lightweight Swift helper process and a clean streaming API.

Rather than binding directly to native APIs, the project intentionally separates Python and platform-specific code using a language-agnostic JSON protocol. The result is a modular architecture that is easy to maintain, package, and extend.

---

# Table of Contents

- [Why macstt?](#why-macstt)
- [Quick Start](#quick-start)
- [For Users & Developers](#for-users--developers)
- [Project Highlights](#project-highlights)
- [Architecture](#architecture)
- [Engineering Decisions](#engineering-decisions)
- [Communication Protocol](#communication-protocol)
- [Repository Structure](#repository-structure)
- [Development](#development)
- [Repository Workflows](#repository-workflows)
- [Packaging & Distribution](#packaging--distribution)
- [Roadmap](#roadmap)
- [Technical Highlights](#technical-highlights)
- [License](#license)

---

# Why macstt?

Python has excellent libraries for cloud-based and cross-platform speech recognition, but there is no lightweight, well-packaged interface to Apple's native Speech framework that embraces modern Python packaging and clean software architecture.

`macstt` fills that gap by providing:

- Native macOS speech recognition
- Real-time streaming transcription
- A clean Python API
- Complete separation of Python and native code
- Automated packaging, CI/CD, and release engineering

---

# Quick Start

## Install

```bash
pip install macstt
```

## Basic usage

```python
from macstt import STT

with STT() as stt:
    stt.start()

    for event in stt:
        print(event)
```

For complete package documentation, see the documentation published on PyPI.

---

# For Users & Developers

This repository serves two audiences.

### Python users

If you simply want to use `macstt`:

- Install with `pip`
- Follow the Quick Start above
- Refer to the PyPI documentation for the complete API reference

### Developers

If you'd like to contribute or understand the implementation, the remainder of this document covers:

- software architecture
- repository organization
- development workflow
- packaging
- release engineering

---

# Project Highlights

- Native Apple Speech Recognition using the Speech framework
- Real-time streaming transcription with partial and final results
- Swift helper completely isolated from Python
- Language-agnostic JSON communication protocol
- Typed Python event model
- Modern Python packaging (PEP 517/518/621)
- Platform-specific macOS ARM64 wheels
- Automated CI, Releases, and Trusted Publishing

---

# Architecture

```
                 Python Application
                         │
                         ▼
                   macstt API
                         │
                         ▼
          JSON over stdin / stdout
                         │
                         ▼
              Swift Helper Process
                         │
                         ▼
         Apple Speech Framework (macOS)
```

| Component | Responsibility |
|-----------|----------------|
| Python Package | User-facing API |
| JSON Protocol | Cross-language communication |
| Swift Helper | Native implementation |
| Apple Speech Framework | Speech recognition |

Each layer has a single responsibility and communicates through a well-defined protocol, making the system modular, testable, and independently maintainable.

This process-based architecture avoids native Python extensions while allowing the helper to be reused by applications written in other languages.

---

# Engineering Decisions

Several architectural decisions intentionally shaped this project.

### Native code is isolated

The Swift implementation lives entirely outside Python.

There are:

- no C extensions
- no Objective-C bridge
- no direct Python bindings

This keeps both implementations independent and minimizes platform-specific complexity within the Python package.

---

### JSON as the communication layer

Python and Swift communicate exclusively through newline-delimited JSON.

Benefits include:

- language independence
- easy debugging
- loose coupling
- future extensibility

The helper could later be reused by applications written in Rust, Go, Node.js, or any language capable of spawning a process.

---

### Minimal public API

The Python package intentionally exposes only a small, high-level interface while all platform-specific complexity remains inside the native helper.

---

# Communication Protocol

The Python package and the native helper communicate through newline-delimited JSON messages over standard input and output.

Commands sent from Python:

```json
{"cmd":"start"}
```

```json
{"cmd":"stop"}
```

Example event returned by the helper:

```json
{
  "type":"speech",
  "text":"Hello world",
  "isFinal":false,
  "timestamp":1784208237.97
}
```

Using JSON as the communication layer keeps the protocol language-agnostic, human-readable, and easy to debug while allowing future implementations in other programming languages.

---

# Repository Structure

```
macstt/

├── native/
│   └── macstt-helper/       # Native Swift implementation
│
├── bindings/
│   └── python/
│       ├── macstt/          # Python package
│       ├── pyproject.toml
│       ├── setup.py
│       └── README.md        # PyPI documentation
│
├── examples/                # Example applications
│
├── tools/
│   ├── build_helper.sh
│   ├── build_package.sh
│   └── dev_setup.sh
│
├── .github/
│   └── workflows/
│       ├── ci.yml
│       └── release.yml
│
├── CHANGELOG.md
├── LICENSE
└── README.md                # Repository documentation
```

The repository is intentionally organized to separate platform-specific code, language bindings, tooling, examples, and automation, allowing each component to evolve independently.

---

# Development

Clone the repository:

```bash
git clone https://github.com/PandaTGOS/macstt.git
cd macstt
```

Create a virtual environment:

```bash
python3 -m venv .venv
source .venv/bin/activate
```

Set up the development environment:

```bash
./tools/dev_setup.sh
```

This script:

- installs build dependencies
- builds the native helper
- installs the package in editable mode

Build release artifacts:

```bash
./tools/build_package.sh
```

---

# Repository Workflows

The project uses three complementary workflows.

### Development Workflow

For local development and iteration.

```
dev_setup.sh
        │
        ▼
Build native helper
        │
        ▼
Editable installation
```

---

### Continuous Integration

Runs automatically on every push and pull request.

- Build native helper
- Build Python package
- Verify platform-specific wheel
- Smoke test the package
- Upload build artifacts

---

### Release Pipeline

Triggered by Git version tags.

- Build release artifacts
- Validate wheel metadata
- Create GitHub Release
- Upload wheel and source distribution
- Publish to PyPI using Trusted Publishing (OIDC)

---

# Packaging & Distribution

`macstt` follows modern Python packaging standards.

Release artifacts include:

- Platform-specific macOS ARM64 wheel
- Source distribution

Example wheel:

```
macstt-0.1.0-py3-none-macosx_11_0_arm64.whl
```

The native Swift helper is bundled directly into the package, requiring no compilation after installation.

---

# Roadmap

Future work includes:

- Universal macOS builds
- Async Python API
- Richer recognition metadata
- Additional speech configuration options
- Support for additional Apple frameworks

---

# Technical Highlights

This project demonstrates experience with:

- Software architecture
- Cross-language system design
- Swift development
- Native macOS frameworks
- Python package architecture
- Process-based IPC
- JSON protocol design
- Streaming APIs
- Modern Python packaging (PEP 517/518/621)
- Platform-specific wheel generation
- CI/CD with GitHub Actions
- Automated release engineering
- Semantic Versioning
- Open-source project organization

---

# License

Licensed under the MIT License.