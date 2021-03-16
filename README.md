# Naev Build Infrastructure
This repository contains Dockerfiles for all of the [Naev Project](https://github.com/naev/naev)'s CI and CD build images.

### Overview:
`naev-linux-lts` (Used for appimage, and release builds. oldest targetted glibc platform)
`naev-linux-latest` (Used for CI, and testing. near-upstream platform)
`naev-steamruntime` (Used to generate builds and for CI in the steamruntime (soldier) environment)
`naev-windows` (Used to cross compile Windows releases, and CI)
`naev-macos` (Used to cross compile macOS releases, and CI)

Images are available from the Github Package Registry (soon)
These images are used by the [Naev Project](https://github.com/naev/naev) in CI and CD workflows to provide standard build environments, and limit 'moving parts'.
