cmake_minimum_required(VERSION 3.7.2)

project(test_app C)

file(GLOB deps src/*.c)
add_executable(test_app EXCLUDE_FROM_ALL ${deps})

target_link_libraries(test_app
    sel4
    muslc utils
    sel4muslcsys sel4platsupport sel4utils sel4debug)


# Platform configuration
set(KernelArch "arm" CACHE STRING "" FORCE)
set(KernelArmSel4Arch "aarch32" CACHE STRING "" FORCE)
if(SIMULATION)
    set(KernelARMPlatform "zynq7000" CACHE STRING "" FORCE)
    ApplyCommonSimulationSettings()
    GenerateSimulateScript()
else()
    set(KernelARMPlatform "exynos5422" CACHE STRING "" FORCE)
endif()

# we want to use the kernel debug putchar if it exists
set(LibSel4PlatSupportUseDebugPutChar true CACHE BOOL "" FORCE)

# hides debug information when the application halts (i.e. when our main returns)
set(LibSel4MuslcSysDebugHalt FALSE CACHE BOOL "" FORCE)

# We must build the debug kernel since we rely on seL4_DebugPutChar
# and we don't initialize a platsupport driver.
# Arguments are (release, verification)
ApplyCommonReleaseVerificationSettings(FALSE FALSE)

# Declare test_app as user entry point
DeclareRootserver(test_app)
