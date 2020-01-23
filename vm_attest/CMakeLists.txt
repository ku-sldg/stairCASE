#
# Copyright 2019, Data61
# Commonwealth Scientific and Industrial Research Organisation (CSIRO)
# ABN 41 687 119 230.
#
# This software may be distributed and modified according to the terms of
# the BSD 2-Clause license. Note that NO WARRANTY is provided.
# See "LICENSE_BSD2.txt" for details.
#
# @TAG(DATA61_BSD)
#

cmake_minimum_required(VERSION 3.8.2)

project(camkes-vm-attest C)

include(../../arm_vm_helpers.cmake)
find_package(camkes-vm-linux REQUIRED)
include(${CAMKES_VM_LINUX_HELPERS_PATH})

# Create our CPP Flags based on ARM VM config variables
set(cpp_flags "-DKERNELARMPLATFORM_EXYNOS5422")
set(rootfs_address "0x4d700000")

set(dtb_file "${CAMKES_VM_IMAGES_DIR}/${KernelARMPlatform}/linux-dtb")
set(rootfs_file "${CAMKES_VM_IMAGES_DIR}/${KernelARMPlatform}/rootfs.cpio.gz")

# Generate overlayed rootfs
AddFileToOverlayDir(
    "interfaces"
    ${CMAKE_CURRENT_SOURCE_DIR}/overlay_files/network_interfaces/interfaces
    "etc/network"
    overlay
)

AddFileToOverlayDir(
    "S90ping_test"
    ${CMAKE_CURRENT_SOURCE_DIR}/overlay_files/init_scripts/ping_test
    "etc/init.d"
    overlay
)

AddOverlayDirToRootfs(
    overlay
    ${rootfs_file}
    "buildroot"
    "rootfs_install"
    output_overlayed_rootfs_location
    rootfs_target
    GZIP
)

# Updated dtb based on generated initrd
UpdateDtbFromInitrd(
    ${dtb_file}
    ${output_overlayed_rootfs_location}
    ${rootfs_address}
    dtb_gen_target
    output_dtb_location
    DEPENDS
    rootfs_target
)

AddToFileServer("linux-dtb" "${output_dtb_location}" DEPENDS dtb_gen_target)
AddToFileServer("linux-initrd" ${output_overlayed_rootfs_location} DEPENDS rootfs_target)
AddToFileServer("linux" "${CAMKES_VM_IMAGES_DIR}/${KernelARMPlatform}/linux")

AddCamkesCPPFlag(
    cpp_flags
    CONFIG_VARS
    VmEmmc2NoDMA
    VmVUSB
    Tk1DeviceFwd
    Tk1Insecure
    VmVirtioNetVirtqueue
)

DefineCAmkESVMFileServer()

CAmkESAddImportPath(${KernelARMPlatform})

# Declare root server
DeclareCAmkESComponent(
    Flagger
    SOURCES
    components/Flagger/flagger.c
    LIBS
    virtqueue
    sel4_autoconf
)

DeclareCAmkESComponent(
    ComponentAM
    SOURCES
    components/ComponentAM/attestation_manager.c
    LIBS
    virtqueue
    sel4_autoconf
)

DeclareCAmkESComponent(
    KeyManager
    SOURCES
    components/KeyManager/key_manager.c
    LIBS
    virtqueue
    sel4_autoconf
)

DeclareCAmkESComponent(
    CakeAM
    SOURCES
    components/CakeAM/cakeam.c
    CAKEML_SOURCES
    components/CakeAM/server.cml
    LIBS
    virtqueue
    sel4_autoconf
)

DeclareCAmkESRootserver(
    vm_attest.camkes
    CPP_FLAGS
    ${cpp_flags}
    CPP_INCLUDES
    ${CMAKE_CURRENT_LIST_DIR}/../../components/VM
)
# End declare root server
