### v1.4.0:
Changed the naev-ubuntu2004 and naev-ubuntu1604 names to more distro-agnostic ones (naev-linux-latest and naev-linux-lts respectively).
Changed naev-linux-lts image base to centos:7 (Additionally remove ruby and website generation tools from image.)
Add suitesparse to naev-linux-lts image (previously ommitted due to packaging issues)
Add APPIMAGE_EXTRACT_AND_RUN to ENV of all images since this is required to run any appimage in a docker container.

### v1.3.2:
Pinned the version of Meson to use in Ubuntu 16.04. 
This situation is temporary; 16.04 will stop being the base system for AppImage builds by late April. 

Refs: https://packages.ubuntu.com/source/xenial-backports/ninja-build https://docs.appimage.org/reference/best-practices.html#binaries-compiled-on-old-enough-base-system

### v1.3.1:
Added MXE packaged luajit to naev-windows image.
Returned to official Meson releases in the naev-macos image, now that a key bug-fix is released.

### v1.3.0:
This 'release' bumps our MXE Windows Cross-compile environment base image to Ubuntu 20.04.

### v1.2.3:
Add sdl2_image to naev-indows build.
Update to Steam runtime (soldier) from scout in naev-steamruntime

### v1.2.2:
Update osxcross packages: drop libxml2 in favor of the SDK one (saves ~50MB due to icudata), switch SuiteSparse_CSparse -> SuiteSparse_CXSparse, as the latter includes the necessary headers in naev-macos.

### v1.2.1:
Add physfs, SuiteSparse to macports in naev-macos.

### v1.2.0:
Set OSXCROSS_MP_INC as 1 to auto set include paths in naev-macos.
Remove luajit from macports, ENV variables in naev-macos.
Install patched meson for cross builds in naev-macos.

### v1.1.2:
This 'release' moves images over to the Github Package Registry here: <https://github.com/users/ProjectSynchro/packages?repo_name=synchros-sexy-docker-containers>
They are used in <https://github.com/naev/naev> CI and CD workflows to provide standard build environments.

### v1.1.1:
Update README.md

### v1.1.0:
Actually test docker builds.. and clean up syntax
Opt to get the newest Gemfile from... naev/naev-website instead of keeping our own.
Add initial macos Dockerfile and testing
Add MXE and WINEPREFIX env variables the right way
Add macOS 10.13 SDK (This is needed unfortunately)

### v1.0.0:
Initial Version of naev-ubuntu1604, naev-ubuntu2004, naev-steamruntime, and naev-windows images

### The story so far:
naev-linux-lts (used for appimage release builds, oldest targetted glibc platform)
naev-linux-latest (used for CI)
naev-steamruntime (Used to generate builds and for CI in the steamruntime (soldier) environment)
naev-windows (Used to cross compile Windows releases, and CI)
naev-macos (Used to cross compile macOS releases, and CI)
