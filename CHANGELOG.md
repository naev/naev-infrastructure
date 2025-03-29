### Overview:
- `naev-artwork` (Used to render naev artwork.) ***DEPRECATED***
- `naev-docs` (Used for building website and docs.)
- `naev-linux-archaic` (Used for old release builds) ***DEPRECATED***
- `naev-macos` (Used to cross compile for macOS.)
- `naev-release` (Used for packaging releases)
- `naev-steamruntime` (Used for testing linux steam builds in the steamruntime (sniper) environment with extra dependencies installed.)
- `naev-windows` (Used to cross compile for Windows.)

### v1.12.3
- Update `naev-windows` to include more packages to help build Rust branch

### v1.12.2
- Update `naev-steamruntime` to build static libraries correctly and remove pre-installed OpenAL in favour of our own newer build

### v1.12.1
- Replace github-assets-uploader with the native GitHub CLI in `naev-release`

### v1.12.0
- Ensure that clang and llvm tools are available on all build containers.
- Add autoconfiguration script to preinstall the rust toolchains for local builds.

### v1.11.5
- Remove Rust and bindgen installation from `naev-steamruntime`, `naev-macos` and `naev-windows` Dockerfiles

### v1.11.4
- Added clang to `naev-docs`, `naev-release` and `naev-windows` to fix issues with bindgen
- Disabled blender2.79b builds (for now)
- Remove bindgen installation from `naev-steamruntime` Dockerfile

### v1.11.3
- Added Rust toolchain to `naev-release` and `naev-docs` and fixed bindgen on `naev-steamruntime`

### v1.11.2
- Added readline-devel to `naev-release` so that lua compiles.

### v1.11.1
- Added bindgen where necessary, and set up crosscompiling rust targets.

### v1.11.0
- 'naev-macos`, `naev-steamruntime`, `naev-release`, `naev-docs`, `naev-windows`: Added preliminary rust support.

### v1.10.6
- `naev-macos`: Disable hacks and workaround upstream OSXCross issue. (https://github.com/tpoechtrager/osxcross/pull/428)
- `naev-steamruntime`: Build our own static ffmpeg binary to avoid broken dependencies.
- `naev-windows`: Use our own build UCRT packages based on upstream sources for UCRT builds on Windows.

### v1.10.5
- Remove ruby and bundler from `naev-docs` in favour of using Github Actions bundled tool.

### v1.10.4
- Add ffmpeg, luarocks, luacheck, and mutagen module to `naev-steamruntime`

### v1.10.3
- It's naev-steamruntime that needs the Meson bump.

### v1.10.2
- Require modern Meson for naev-linux as well; install C++ compiler for Windows.

### v1.10.1
- Checkout `upcoming` branch of naev-website when building naev-docs

### v1.10.0
- Bump minimum macOS version for arm64 to 12.0, due to issues with gettext packaging.

### v1.9.1
- Update OpenBLAS to v0.3.26 in `naev-windows`.
- Add rcodesign to `naev-macos` and `naev-release`.
   - This is useful for signing macos binaries as well as app bundles. This is required for ARM64 and universal builds to work.

### v1.9.0
- `naev-macos`: Update SDK, merge aarch64 and x86_64 images.
   - Pass $BUILD_ARCH when starting this image to configure the correct macports packages.
   - "aarch64" or "x86_64" are valid, otherwise it will default to x86_64 by default (docker run -e BUILD_ARCH=aarch64 naev-macos)
- Drop the concept of multiple arcitectures when building and tagging images.

### v1.8.2
- Fix missing header for dlfcn (dlfcn.h) in `naev-windows`
- Add Fedora packaged mingw64-physfs package to `naev-windows`
### v1.8.1
- Fix `naev-macos` aarch64 build image.
- Bump Ruby to stable version 3.2.2 in `naev-docs`.
- Fix missing yaml header for `naev-docs`.

### v1.8.0
- Remove deprecated images `naev-linux-lts` and `naev-linux-latest`
- Remove unused image `naev-steamruntime`
- Re-enable DevManual builds

### v1.7.3
- Compile enet, physfs, libunibreak from source for `naev-steamruntime`.
   -  This is because the packages for physfs, libunibreak are too old to build Naev with.
   -  Debian's libenet-dev package doesn't include static libraries which are needed to ship Steam builds.

### v1.7.2
- Add `file` to `naev-release`.
   -  This is apparently the one utility that we do not have that appimagetool (A self contained tool) needs.

### v1.7.1
- Fix static libraries by installing compiled libs to the `/usr` prefix instead of `/usr/local`
   - This may cause issues, but we need static libraries to show up in Meson.

### v1.7
- Add `naev-steamfrankenruntime`
   - This is Valve's 'scout' runtime with Python 3.6, OpenBLAS, libenet, physfs, libunibreak compiled from source, and a 'new-ish' version of git installed.
- Update `naev-steamruntime` to 'sniper' runtime.
   -  In the future this will be the image used to build binaries for Steam, as the `soldier` runtime is not a supported environment on Steam.
- Deprecate `naev-linux-archaic`, `naev-linux-latest`, `naev-linux-lts` in favour of `naev-steamruntime`, and `naev-steamfrankenruntime`.
   - This sees `naev-steamruntime` replacing `naev-linux-latest` and `naev-steamfrankenruntime` replacing `naev-linux-archaic` and `naev-linux-lts`.

### v1.6.8
- Stop using `rawhide` tag in favour of `latest` for naev-linux-latest.
   - This is just bound to cause random build failures when Fedora rebases, and issues like that can persist for days.
- Pin Ruby to v3.1.3. This makes sense for repoducable builds, and for stability.

### v1.6.7
- That last one was more like version 6.6.6. Try again.

### v1.6.6
- Clean up macOS Meson tweaks; fill gaps in enet packages. Give up on naev-macos unless macports gets v1.3.x.

### v1.6.5
- Document why mingw64-dlfcn is... interesting.

### v1.6.4
- Document why mingw64-physfs is a horrible idea.

### v1.6.3
- Add the enet library (used in a friendly fork). For Windows, add mingw64-dlfcn and mingw64-physfs.

### v1.6.2
- Do the v1.6.1 change without bungling naev-macos/Dockerfile.amd64.

### v1.6.1
- Added texinfo to the build images, accidentally needed to build libbfd for CI.

### v1.6
- Added `naev-artwork` image, rocking some ImageMagick, GraphicsMagick, Blender 2.79b.

### v1.5.14
- Bump the Meson version on naev-macos to a pre-release, due to a bug cross-compiling with link-time optimization enabled.

### v1.5.13
- Add LaTeX packages for generating the devmanual PDF for `naev-docs`.
- Change to Fedora packaged ldoc for `naev-docs`.
   - More or less the same size footprint, and there should be less maintenance involved.

### v1.5.12
- Move to the `ffmpeg-free` package in favour of the `ffmpeg` package provided by RPMFusion in `naev-linux-latest`,
   - As a side-benefit, this package should be less prone to breakages as it is maintained by the Fedora Project.

### v1.5.11
- Update OpenBLAS to 0.3.20 for `naev-windows`.
- Add `dmg` tool for compressing DMGs for `naev-macos`.

### v1.5.10
- Fix osxcross-macports script file validation for `naev-macos`.
- Remove binutils from macports package list (not used or needed) for `naev-macos`.
- Add luajit from macports (is actively maintained.) for `naev-macos`.

### v1.5.9
- Update EndPoint repository URL for `naev-linux-lts`.
- Bump Ruby to 3.1 series.
- Bump nanoc to `4.12.5`as https://github.com/nanoc/nanoc/pull/1566 is now merged.
- Pull in package updates.
- Use RPMFusion for ffmpeg for the sake of maintenance.

### v1.5.8
- Rollback nanoc `4.12.4` to `4.12.3` in `naev-docs` to avoid an issue with parsing YAML in Ruby.
   - See: https://github.com/nanoc/nanoc/commit/b3755eca87b4372c8755dfc170f38653fb15a710#commitcomment-64201618

### v1.5.7
- Add genisoimage to `naev-macos` image for generating DMG images.

### v1.5.6
- Add pcre2 to `naev-steamruntime`, requires 'steamruntime' meson option to be set to true.

### v1.5.5
- Add pcre2 to `naev-linux-latest`, `naev-linux-lts`, `naev-macos`, and `naev-windows` images.
- Add aarch64 version of `naev-macos` image for building Apple Silicon binaries. Tags will have the suffix of *-aarch64.

### v1.5.4
- Replace gh with github-asset-uploader in `naev-release`.

### v1.5.3
- Slim down `naev-linux-lts` image considerably.
- Slim down `naev-windows` image by ~5x.
- Shrink `naev-steamruntime` slightly.
- Add luacheck to `naev-linux-latest`.

### v1.5.2
- Slim down `naev-macos` image considerably. (Changed image base to `fedora-minimal`).
- Slim down `naev-docs` image considerably.
- Add GitHub CLI client, and Meson to `naev-release`.

### v1.5.1
2nd time's the charm!
- Added xz to `naev-docs` since our dist is xz'ed.

### v1.5.0
- Changed image base of `naev-linux-latest` to `fedora-minimal`, and slimmed down image considerably.
- Added `naev-docs` and `naev-release` images for building the website and documentation, as well as for packaging releases.

### v1.4.17
- I said "Added PyYAML", CentOS 7...

### v1.4.16
- Added PyYAML, because Pythons should be able to ingest that.

### v1.4.15
- Beware the Idea of... OK, never mind, the key benefit is having the "luacheck" linter in at least one image, which lets us make it a CI step.

### v1.4.14
- I am 14 and this is naev-infrastructure. Add libunibreak where available. Temporarily pin naev-linux-latest to Fedora 34 due to https://github.com/moby/moby/issues/42680.

### v1.4.13
- Make it go up to 13 (we should probably find out a nicer way to do this...). Add libwebp for use with a custom build of `SDL2_image`.

### v1.4.12
- Make it go up to 12. Add ENV Var for determining what image we are running with scripts.

### v1.4.11
- Make it go up to 11. Trim the naev-windows blas changes.

### v1.4.10
- Add rsync to naev-linux-latest and lts images. Add OpenBLAS.

### v1.4.9
- Added more SuiteSparse libraries to `naev-macos`.
- Added additional website build dependencies.
- Give up on libwebp in steamruntime.

### v1.4.8
- Add glpk library to non-"ancient" images.

### v1.4.7
- Added `naev-linux-archaic` image used for building *very* old Naev releases. Added webp to steamruntime too.

### v1.4.6
- Add webp library to non-"ancient" images.

### v1.4.5
- Added [SteamCMD](https://developer.valvesoftware.com/wiki/SteamCMD) and [itch.io butler](https://itch.io/docs/butler/) to `naev-linux-latest` and ``naev-linux-lts`` images. (Available on PATH)

### v1.4.4
- Set `APPIMAGE_EXTRACT_AND_RUN` to 1 in the `naev-steamruntime` image.

### v1.4.3
- Install mesa-libGLU-devel on the `naev-linux-latest` and `naev-linux-lts` images.

### v1.4.2:
- Revert adding MXE packaged luajit to `naev-windows` image.

### v1.4.1:
- Ensure a repository for Git 2.x is included in the `naev-linux-lts` image.

### v1.4.0:
- Changed the `naev-ubuntu2004` and `naev-ubuntu1604` names to more distro-agnostic ones (`naev-linux-latest` and `naev-linux-lts` respectively).
- Changed `naev-linux-latest` image base to fedora:rawhide.
- Changed `naev-linux-lts` image base to centos:7 (Additionally remove ruby and website generation tools from image.)
- Add suitesparse to `naev-linux-lts` image (previously ommitted due to packaging issues).
- Add `APPIMAGE_EXTRACT_AND_RUN` to ENV of all images since this is required to run any appimage in a docker container.

### v1.3.2:
- Pinned the version of Meson to use in Ubuntu 16.04.
- This situation is temporary; 16.04 will stop being the base system for AppImage builds by late April.
   - Refs: https://packages.ubuntu.com/source/xenial-backports/ninja-build https://docs.appimage.org/reference/best-practices.html#binaries-compiled-on-old-enough-base-system

### v1.3.1:
- Added MXE packaged luajit to `naev-windows` image.
- Returned to official Meson releases in the `naev-macos` image, now that a key bug-fix is released.

### v1.3.0:
- This 'release' bumps our MXE Windows Cross-compile environment base image to Ubuntu 20.04.

### v1.2.3:
- Add `sdl2_image` to `naev-windows` build.
- Update to Steam runtime (soldier) from scout in `naev-steamruntime`

### v1.2.2:
- Update osxcross packages: drop libxml2 in favor of the SDK one (saves ~50MB due to icudata), switch `SuiteSparse_CSparse` -> `SuiteSparse_CXSparse`, as the latter includes the necessary headers in `naev-macos`.

### v1.2.1:
- Add physfs, SuiteSparse to macports in `naev-macos`.

### v1.2.0:
- Set `OSXCROSS_MP_INC` as 1 to auto set include paths in `naev-macos`.
- Remove luajit from macports, ENV variables in `naev-macos`.
- Install patched meson for cross builds in `naev-macos`.

### v1.1.2:
- This 'release' moves images over to the Github Package Registry.
- They are used in the [Naev Project](https://github.com/naev/naev)'s CI and CD workflows to provide standard build environments.

### v1.1.1:
- Update README.md.

### v1.1.0:
- Actually test docker builds.. and clean up syntax.
- Opt to get the newest Gemfile from... naev/naev-website instead of keeping our own.
- Add initial macos Dockerfile and testing.
- Add MXE and WINEPREFIX env variables the right way.
- Add macOS 10.13 SDK (This is needed unfortunately).

### v1.0.0:
- Initial Version of `naev-ubuntu1604`, `naev-ubuntu2004`, `naev-steamruntime`, and `naev-windows` images.
