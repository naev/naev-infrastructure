### v1.4.0:
Changed the naev-ubuntu2004 and naev-ubuntu1604 names to more distro-agnostic ones (naev-linux-latest and naev-linux-lts respectively).

### v1.3.1:
Added MXE packaged luajit to naev-windows image.
Returned to official Meson releases in the naev-macos image, now that a key bug-fix is released.

### v1.3.0 (Long gap, can't fully remember what we did in between):
This 'release' bumps our MXE Windows Cross-compile environment base image to Ubuntu 20.04.

### v1.1.2:
This 'release' moves images over to the Github Package Registry here: <https://github.com/users/ProjectSynchro/packages?repo_name=synchros-sexy-docker-containers>
They are used in <https://github.com/naev/naev> CI and CD workflows to provide standard build environments.

### The story so far:
naev-linux-lts (used for appimage release builds, oldest targetted glibc platform)
naev-linux-latest (used for CI)
naev-steamruntime (Used to generate builds and for CI in the steamruntime (soldier) environment)
naev-windows (Used to cross compile Windows releases, and CI)
naev-macos (Used to cross compile macOS releases, and CI)
