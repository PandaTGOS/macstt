# Changelog

All notable changes to this project will be documented in this file.

The project follows [Semantic Versioning](https://semver.org/).

---

## [0.1.0] - 2026-07-19

Initial public release.

### Added

#### Native Speech Recognition

- Native macOS speech recognition powered by Apple's Speech framework
- Dedicated Swift helper executable
- On-device streaming transcription
- Start and stop recognition controls

#### Python API

- High-level `STT` interface
- Context manager support
- Iterator-based streaming API
- Typed event model
- Automatic helper process management

#### Communication Protocol

- Line-delimited JSON protocol between Python and Swift
- Language-agnostic architecture
- Streaming partial and final recognition events

#### Packaging

- Modern `pyproject.toml` package configuration
- Bundled native helper executable
- Platform-specific macOS ARM64 wheels
- Source distribution (sdist)
- Editable installation for development

#### Development Tooling

- Reproducible native build scripts
- One-command development environment setup
- Automated package build tooling
- GitHub Actions continuous integration
- Automated GitHub Release workflow
- Trusted packaging configuration

#### Project Structure

- Separation of native and Python components
- Repository organized for long-term maintainability
- MIT License
- Versioned releases
- Documentation