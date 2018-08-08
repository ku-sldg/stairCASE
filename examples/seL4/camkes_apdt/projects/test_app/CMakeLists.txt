# Platform configuration
set(KernelArch "arm" CACHE STRING "" FORCE)
set(KernelArmSel4Arch "aarch32" CACHE STRING "" FORCE)

# This is taken from the cakeml vm demo. Don't know why it makes things work ¯\_(ツ)_/¯
set(CapDLLoaderMaxObjects 16384 CACHE STRING "" FORCE)
set(KernelRootCNodeSizeBits 15 CACHE STRING "" FORCE)

if(SIMULATION)
    set(KernelARMPlatform "zynq7000" CACHE STRING "" FORCE)
    ApplyCommonSimulationSettings() # This actually only does stuff for the x86 platform, but I'm leaving it in in case that changes
    GenerateSimulateScript()
else()
    set(KernelARMPlatform "exynos5422" CACHE STRING "" FORCE)
    set(KernelMaxNumBootinfoUntypedCaps 500 CACHE STRING "" FORCE) # stops sel4 from whining about "Too many untyped regions for boot info" by doubling the default max
endif()

# We must build the debug kernel since we rely on seL4_DebugPutChar
# and we don't initialize a platsupport driver.
# Arguments are (release, verification)
ApplyCommonReleaseVerificationSettings(FALSE FALSE)

add_subdirectory(apps/test_app)
