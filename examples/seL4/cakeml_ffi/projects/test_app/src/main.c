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


extern unsigned int argc;
extern char **argv;

void main_func(void);

int main(void) {
    printf("Jumping into cakeml land...\n");
    main_func();
    //CakeML doesn't seem to ever return from its main entry point.
    printf("Back in c land.\n");
    return 0;
}
