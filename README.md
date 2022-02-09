# Naev Build Infrastructure
This repository contains Dockerfiles for all of the [Naev Project](https://github.com/naev/naev)'s CI and CD build images, and Github Actions workflows.

### Overview:
- `naev-docs` (Used for building website and docs.)
- `naev-linux-archaic` (Used for old release builds)
- `naev-linux-latest` (Used for CI, testing and soundtrack builds.)
- `naev-linux-lts` (Used for release builds. oldest targetted glibc platform)
- `naev-macos` (Used to cross compile for macOS.)
- `naev-release` (Used for packaging releases)
- `naev-steamruntime` (Used for linux steam builds in the steamruntime (soldier) environment)
- `naev-windows` (Used to cross compile for Windows.)


Publicly available images are available from the Github Package Registry [HERE](https://github.com/orgs/naev/packages?repo_name=naev-infrastructure).
These images are used by the [Naev Project](https://github.com/naev/naev) in CI and CD workflows to provide standard build environments, and limit 'moving parts'.


### Build Status:
[![Naev Infrastructure Testing](https://github.com/naev/naev-infrastructure/actions/workflows/test_docker.yml/badge.svg)](https://github.com/naev/naev-infrastructure/actions/workflows/test_docker.yml) \
[![Naev Infrastructure Deployment](https://github.com/naev/naev-infrastructure/actions/workflows/deploy_docker.yml/badge.svg)](https://github.com/naev/naev-infrastructure/actions/workflows/deploy_docker.yml)
