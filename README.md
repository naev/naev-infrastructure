# Naev Build Infrastructure
This repository contains Dockerfiles for all of the [Naev Project](https://github.com/naev/naev)'s CI and CD build images, and Github Actions workflows.

### Overview:
- `naev-artwork` (Used to render naev artwork.)
- `naev-docs` (Used for building website and docs.)
- `naev-linux-archaic` (Used for old release builds) ***DEPRECATED***
- `naev-macos` (Used to cross compile for macOS.)
- `naev-release` (Used for packaging releases)
- `naev-steamruntime` (Used for testing linux steam builds in the steamruntime (sniper) environment with extra dependencies installed.)
- `naev-windows` (Used to cross compile for Windows.)


Publicly available images are available from the Github Package Registry [HERE](https://github.com/orgs/naev/packages?repo_name=naev-infrastructure).
These images are used by the [Naev Project](https://github.com/naev/naev) in CI and CD workflows to provide standard build environments, and limit 'moving parts'.


### Build Status:
[![Naev Infrastructure Testing](https://github.com/naev/naev-infrastructure/actions/workflows/test_docker.yml/badge.svg)](https://github.com/naev/naev-infrastructure/actions/workflows/test_docker.yml) \
[![Naev Infrastructure Deployment](https://github.com/naev/naev-infrastructure/actions/workflows/deploy_docker.yml/badge.svg)](https://github.com/naev/naev-infrastructure/actions/workflows/deploy_docker.yml)
