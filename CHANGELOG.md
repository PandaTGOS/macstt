# Changelog

All notable changes to this project will be documented in this file.

The project follows [Semantic Versioning](https://semver.org/).

---

## [0.1.0] - 2026-07-17

### Added

- Native macOS speech recognition helper using Apple's Speech framework
- Python client library for controlling the helper
- Streaming JSON protocol between Swift and Python
- Typed Python event models
- Context manager support (`with STT() as stt`)
- Automatic helper build during editable installation
- Native helper bundled into the Python package
- GitHub repository structure for long-term maintainability

### Internal

- Refactored project into native, bindings, examples and tools directories
- Added version management
- Added MIT license
- Added project metadata and editable installation support
