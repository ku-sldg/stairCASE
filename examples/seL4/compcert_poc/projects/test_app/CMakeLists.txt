cmake_minimum_required(VERSION 3.7.2)

project(my_app)

# Define source files, libraries and include directories
file(GLOB deps src/main.c)
set(libs sel4 muslc utils sel4muslcsys sel4platsupport sel4utils sel4debug)
# Ideally, there would be a way to match every include library without specifying
# them individually, something like ../../../libs/*/include. Or even better,
# grab the CMake "include directories" associated with each library we link
# against. For now though, they must be manually listed in the "includes"
# variable here.
set(includes
    -I ../../../libs/libutils/include
    -I ../../../libs/libsel4utils/include)

# Declare executable - main.o comes from compcert, util.c will be compiled with
# the declared CMake compiler, i.e. gcc.
add_executable(test_app main.o src/util.c)
# Obj files should be linked like c obj files (which they are but CMake doesn't know that)
set_target_properties(test_app PROPERTIES LINKER_LANGUAGE C)
# Tells CMake to chill when it doesn't see main.o pre-build
set_source_files_properties(test_app PROPERTIES GENERATED TRUE)
# Custom rule to compile test_app.o using CompCert
add_custom_command(
    OUTPUT main.o
    COMMAND ccomp ${includes} -c ${deps}
    DEPENDS ${libs}
    COMMENT CompCert custom command...
    VERBATIM)
# Libraries to be built before
add_dependencies(test_app ${libs})
# Link libraries
target_link_libraries(test_app ${libs})


# Platform configuration
set(KernelArch "arm" CACHE STRING "" FORCE)
set(KernelArmSel4Arch "aarch32" CACHE STRING "" FORCE)
if(SIMULATION)
    set(KernelARMPlatform "zynq7000" CACHE STRING "" FORCE)
    ApplyCommonSimulationSettings()
    GenerateSimulateScript()
else()
    set(KernelARMPlatform "exynos5422" CACHE STRING "" FORCE)
    set(KernelMaxNumBootinfoUntypedCaps "500" CACHE STRING "" FORCE) # stops sel4 from whining about "Too many untyped regions for boot info" by doubling the default max
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
