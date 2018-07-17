cmake_minimum_required(VERSION 3.7.2)

project(my_app)

# Define source files, libraries
file(GLOB cfiles src/*.c)
file(GLOB cml src/*.cml)
set(libs sel4 muslc utils sel4muslcsys sel4platsupport sel4utils sel4debug)

# Declare executable
add_executable(test_app cake.S ${cfiles})
# Tells CMake to chill when it doesn't see cake.S pre-build
set_source_files_properties(cake.S PROPERTIES GENERATED TRUE)
# Custom rule to compile cake.S using the CakeML compiler
add_custom_command(
    OUTPUT cake.S
    # Increasing the heap/stack size usually breaks things :(
    # The data61 VM demo includes flag --exclude-prelude=true, but it doesn't
    # seem to make a difference either way here.
    COMMAND cake32 --heap_size=50 --stack_size=50 < ${cml} > cake.S
    # This is where we actually crawl through the assembly, and replace all
    # instances of "cdecl(main)" with "cdecl(cml_entry)" to change the name
    # of the entry point.
    COMMAND sed -i "s/cdecl(main)/cdecl(cml_entry)/g" "cake.S"
    DEPENDS ${libs}
    VERBATIM)
# Libraries to be built before
add_dependencies(test_app ${libs})
# Link libraries
target_link_libraries(test_app ${libs})


# Platform configuration
set(KernelArch "arm" CACHE STRING "" FORCE)
set(KernelArmSel4Arch "aarch32" CACHE STRING "" FORCE)

# This is taken from the cakeml vm demo. Don't know why it makes things work ¯\_(ツ)_/¯
set(KernelRootCNodeSizeBits 15 CACHE STRING "" FORCE)

if(SIMULATION)
    set(KernelARMPlatform "zynq7000" CACHE STRING "" FORCE)
    ApplyCommonSimulationSettings() # This actually only does stuff for the x86 platform, but I'm leaving it in in case that changes
    GenerateSimulateScript()
else()
    set(KernelARMPlatform "exynos5422" CACHE STRING "" FORCE)
    set(KernelMaxNumBootinfoUntypedCaps 500 CACHE STRING "" FORCE) # stops sel4 from whining about "Too many untyped regions for boot info" by doubling the default max
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
