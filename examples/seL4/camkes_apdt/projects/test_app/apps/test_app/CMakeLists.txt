cmake_minimum_required(VERSION 3.7.2)

project(my_app)

# Grab cakeml files (although the follow is actually written under the
# assumption there is just one file. Multiple cml files is on the todo list).
file(GLOB cml components/cakeml/src/*.cml)

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
    VERBATIM
)
add_library(cakeml cake.S)


DeclareCAmkESComponent(cakeml
    SOURCES components/cakeml/src/main.c
    LIBS camkescakeml cakeml
)

DeclareCAmkESRootserver(test_app.camkes)
