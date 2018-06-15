# SeL4 Examples

## Prerequisites

Dependencies for building sel4 and associated projects are described here: https://docs.sel4.systems/HostDependencies.

## test_app

This project is intended to be a barebones application on the sel4 microkernel to serve as a starting point for larger projects and to demonstrate the basic project layout and build system of sel4. It is a simple "Hello World!" application.

### Build Instructions

This project, like other sel4 projects, uses Google's "repo" tool for managing multiple remote repositories. The manifest file (default.xml) describes each remote repository and the desired project layout, and the repo tool fetches them for us. This way, we always get the current master branch of seL4 and its libraries without adding them to our own repositories and manually updating them.

To download our remote depositories, navigate to the directory which contains "default.xml", i.e. our test_app folder. Type "repo init -u ./" followed by "repo sync".

To build the application, create a folder at the top level of the project directory, i.e. "test_app/build". From the build directory, invoke the cmake initialization script with "../init-build -D CROSS_COMPILER_PREFIX=arm-linux-gnueabi-" to generate the build files (you can also try other cross compilers, e.g. arm-linux-gnueabihf-). By default, it is configured to target the ODROID-XU4 hardware. Then type "ninja" to build. The resulting image will be placed in "test_app/build/images".

Unfortunately, the ODROID is not supported by QEMU, but if you wish to build an image to emulate rather than deploy onto real hardware, you can add the flag "-D SIMULATION=TRUE" to the init-build script invocation. This image generated will be for a different ARM device that is supported by QEMU (Zynq7000), and you can run the image on QEMU with the "build/simulate" script.

## ODROID-XU4 Initial Setup

To run our seL4/application image on the ODROID, we need to put it and the bootloader onto our micro SD card. Insert the card into your card reader, then identify the device path (e.g. something like /dev/sdd). You can run "sudo fdisk -l", "lsusb", and "lsblk" to find the correct device (make sure it is the right size and that the description makes sense). Make sure you correctly identify the device path on your machine. We will be flashing the device, if you use the wrong name you could end up wiping the wrong drive. I will use "/dev/###" in my examples.

Type "sudo fdisk /dev/###". The first thing we want to do is clear out any existing partitions. Type "d" to delete a partition. Next, we need to change to a MBR/DOS style partition table if it is not already. To do this, type "o". Our bootloader will be placed very close to the beginning of the drive. If we were using a GPT partition table (as was the default on my SD card), the bootloader would end up overwriting part of the partition table, which is obviously not ideal. Next we want to create a new partition. Type "n". Type "p" for primary partition and "1" for partition number. The recommended starting location is probably fine but I used 3072. The partition should fill the rest of the SD card. Once the partition is created, type "w" to write all of that to the actual drive. Type "sudo mkfs.vfat -F 32 /dev/###1" to create a FAT32 filesystem on our new partition. Mount this partition, and copy our sel4/application image over.

Now to transfer the bootloader as well. We will use a fork of U-boot specifically for the ODROID-XU4. Type "git clone https://github.com/hardkernel/u-boot.git -b odroidxu4-v2017.05" to download. Enter the sd_fuse directory, and then type "sudo ./sd_fushing.sh /dev/###" to flash the bootloader to the SD card (it will be written to a specific location the ODROID-XU4 knows to look for, after the partition table and before the first partition).

We are done with the SD card, now we must set up the serial connection. Attach the serial cable to the ODROID UART port and your computer's USB. You will need a serial communication program such as minicom. Type "sudo minicom -s" to open the settings menu. Select "serial port setup". Change serial device to match the serial cable, it should be something like /dev/ttyUSB followed by a number. Make sure the baud rate is set to 115200 8N1 and that the Hardware Flow Control is disabled. Now exit the menu and minicom should start (if it doesn't, you can type "sudo minicom").

Now we are ready to boot on the ODROID. Insert the SD card and power it up. You should see U-boot starting up from your minicom session. U-boot will attempt to autoboot and fail because we aren't abiding by its default expectations. In your minicom session, type "setenv bootcmd 'fatload mmc 0 ${loadaddr} <sel4-image-name>; bootelf ${loadaddr}'", where <sel4-image-name> is substituted for the actual name of the sel4 image that is on the FAT partition of our SD card. Pay attention to the single quotes, they must be included so that the semicolon isn't interpreted as the end of the setenv command. Now type "saveenv" followed by "reset". The ODROID should now reset and launch the application.

## Updating the ODROID image

Thankfully, after the initial setup is out of the way, it is much easier to work on the ODROID. Every time it is powered on, it will launch straight into our seL4 application (U-boot runs the commands stored in the bootcmd environment variable automatically on startup).

To update our seL4/application image, all you need to do is mount the FAT partition of our SD card, and copy over your new image. Since the name of the application is hardcoded into U-boot's default boot command now, either make sure your new image has the same name as the previous one, or you can edit the bootcmd environment variable to look for the new image. Our automatic booting should fail when you remove the previous image, but if it doesn't, you can type enter twice as U-boot is starting up to abort the automatic boot and stay in the U-boot menu.

Since U-boot now launches our application automatically, the serial connection isn't strictly necessary. However, at the moment it is our only I/O.
