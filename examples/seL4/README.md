# SeL4 Examples

## Prerequisites

Dependencies for building sel4 and associated projects are described here: https://docs.sel4.systems/HostDependencies.

## test_app

This project is intended to be a barebones application on the sel4 microkernel to serve as a starting point for larger projects and to demonstrate the basic project layout and build system of sel4. It is a simple "Hello World!" application.

### Build Instructions

This project, like other sel4 projects, uses Google's "repo" tool for managing multiple remote repositories. The manifest file (default.xml) describes each remote repository and the desired project layout, and the repo tool fetches them for us. This way, we always get the current master branch of seL4 and its libraries without adding them to our own repositories and manually updating them.

To download our remote repositories, navigate to the directory which contains "default.xml", i.e. our test_app folder. Repo expects the manifest file to be at the top level of a git repository for some reason, so create an empty git repository with `git init` and then add the manifest file: `git add default.xml; git commit`. Now when you type `repo init -u ./` followed by `repo sync`, it will find that local manifest file and download our remote repositories accordingly.

To build the application, create a folder at the top level of the project directory, i.e. "test_app/build". From the build directory, invoke the cmake initialization script with `../init-build -D CROSS_COMPILER_PREFIX=arm-linux-gnueabi-` to generate the build files (you can also try other cross compilers, e.g. arm-linux-gnueabihf-). By default, it is configured to target the ODROID-XU4 hardware. Then type "ninja" to build. The resulting image will be placed in "test_app/build/images".

Unfortunately, the ODROID is not supported by QEMU, but if you wish to build an image to emulate rather than deploy onto real hardware, you can add the flag "-D SIMULATION=TRUE" to the init-build script invocation. This image generated will be for a different ARM device that is supported by QEMU (Zynq7000), and you can run the image on QEMU with the "build/simulate" script.

## Deploying to the ODROID-XU4

See the following wiki page: 
https://github.com/ku-sldg/stairCASE/wiki/Deploying-to-the-ODROID-XU4
