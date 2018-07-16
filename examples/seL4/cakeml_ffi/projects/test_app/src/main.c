/*
 * Copyright 2017, Data61
 * Commonwealth Scientific and Industrial Research Organisation (CSIRO)
 * ABN 41 687 119 230.
 *
 * This software may be distributed and modified according to the terms of
 * the BSD 2-Clause license. Note that NO WARRANTY is provided.
 * See "LICENSE_BSD2.txt" for details.
 *
 * @TAG(DATA61_BSD)
 */


#include <stdio.h>

#include <utils/zf_log.h>
#include <sel4utils/sel4_zf_logif.h>


//extern unsigned int argc;
//extern char **argv;

void cml_entry(void);

int main(void) {
    printf("Jumping into cakeml land...\n");
    // CakeMl is compiled with an entry point named "main" in the assembly.
    // Obviously this would conflict with our main function here. Therefore,
    // when we compile our cakeml, we cut and paste its "main" entry point
    // with our own name. In this case, we use "cml_entry" as the name.
    // See test_app/CMakeLists.txt
    cml_entry();
    // CakeML doesn't ever return from its main entry point.
    // Instead, it calls cml_exit in basis_ffi.c
    printf("Back in c land. This code is not reachable.\n");
    return 0;
}
