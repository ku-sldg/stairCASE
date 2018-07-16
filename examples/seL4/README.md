# SeL4 Examples

## Prerequisites

Dependencies for building sel4 and associated projects are described here: https://docs.sel4.systems/HostDependencies. You will also need to install CompCert for the compcert_poc project (for instructions, see our [CompCert wiki](https://github.com/ku-sldg/CAPTools/wiki/crossCompiling)), and the CakeML compiler for the cakeml_ffi project. Make sure both of these are in your system path. Also, make sure to download the 32 bit target version of the CakeML compiler, since we are building for armv7, a 32bit architecture. Rename it to "cake32".

## test_app

This project is intended to be a barebones application on the sel4 microkernel to serve as a starting point for larger projects and to demonstrate the basic project layout and build system of sel4. It is a simple "Hello World!" application.

## compcert_poc

This is a proof of concept of mixed CompCert/gcc compilation of a sel4 project. It is the same "Hello World!" app from test_app, but with a modified project/test_app/CMakeLists.txt to adjust the build process of our app. Everything is built with gcc as in other projects, except for main.c which is compiled with CompCert.

As of now, there are two issues with CompCert on SeL4. One, CMake has poor support for multiple compilers. You can circumvent the problem with custom commands, but this resulted in the awkward situation of having to manually add directories CompCert should search when looking for included header files. Two, CompCert works on a subset of c which the SeL4 kernel and libraries may not adhere to. Ideally this would not be an issue since we can write our userland SeL4 applications in CompCert c, and then simply link it against a bunch of gcc extended c. However, our applications must connect to SeL4 libraries through included header files, which may not always be within CompCert's subset of c.

In this specific example, util.c is compiled with gcc because it pulls in a header file which [specifies register variables](https://gcc.gnu.org/onlinedocs/gcc/Local-Register-Variables.html), a feature supported by gcc but not CompCert as far as I can tell.

## cakeml_ffi

This is a demonstration of cakeml integration into sel4, and calls from cakeml to custom functions in basis_ffi.c (no HOL tinkering required!). The functions we add to basis_ffi.c must follow a couple conventions for them to be callable from cakeml. First, they must begin with "ffi", e.g. a function `ffifoo` in basis_ffi.c is called with `#(foo)` from cakeml. Second, the c function's parameters must match ...

### Build Instructions

The following instructions apply to every project.

These projects, like other sel4 projects, uses Google's "repo" tool for managing multiple remote repositories. The manifest file (default.xml) describes each remote repository and the desired project layout, and the repo tool fetches them for us. This way, we always get the current master branch of seL4 and its libraries without adding them to our own repositories and manually updating them.

To download our remote repositories, navigate to the directory which contains "default.xml", i.e. our test_app folder. Repo expects the manifest file to be at the top level of a git repository for some reason, so create an empty git repository with `git init` and then add the manifest file: `git add default.xml; git commit`. Now when you type `repo init -u ./` followed by `repo sync`, it will find that local manifest file and download our remote repositories accordingly.

To build the application, create a folder at the top level of the project directory, i.e. "test_app/build". From the build directory, invoke the cmake initialization script with `../init-build -D CROSS_COMPILER_PREFIX=arm-linux-gnueabi-` to generate the build files (you can also try other cross compilers, e.g. arm-linux-gnueabihf-). By default, it is configured to target the ODROID-XU4 hardware. Then type "ninja" to build. The resulting image will be placed in "test_app/build/images".

Unfortunately, the ODROID is not supported by QEMU, but if you wish to build an image to emulate rather than deploy onto real hardware, you can add the flag "-D SIMULATION=TRUE" to the init-build script invocation. This image generated will be for a different ARM device that is supported by QEMU (Zynq7000), and you can run the image on QEMU with the "build/simulate" script.

## Deploying to the ODROID-XU4

See the following wiki page:
https://github.com/ku-sldg/stairCASE/wiki/Deploying-to-the-ODROID-XU4
