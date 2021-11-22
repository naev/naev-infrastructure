# Naev Build Infrastructure
This repository contains Dockerfiles for all of the [Naev Project](https://github.com/naev/naev)'s CI and CD build images.

### Overview:
- `naev-docs` (Used for building website and docs.)
- `naev-linux-archaic` (Used for old release builds)
- `naev-linux-latest` (Used for CI, and testing. near-upstream platform)
- `naev-linux-lts` (Used for appimage, and release builds. oldest targetted glibc platform)
- `naev-macos` (Used to cross compile macOS releases, and CI)
- `naev-release` (Used for packaging releases)
- `naev-steamruntime` (Used to generate builds and for CI in the steamruntime (soldier) environment)
- `naev-windows` (Used to cross compile Windows releases, and CI)


Images are available from the Github Package Registry [HERE](https://github.com/ProjectSynchro?tab=packages).
These images are used by the [Naev Project](https://github.com/naev/naev) in CI and CD workflows to provide standard build environments, and limit 'moving parts'.


### Build Status:
[![Naev Infrastructure Testing](https://github.com/naev/naev-infrastructure/actions/workflows/test_docker.yml/badge.svg)](https://github.com/naev/naev-infrastructure/actions/workflows/test_docker.yml)