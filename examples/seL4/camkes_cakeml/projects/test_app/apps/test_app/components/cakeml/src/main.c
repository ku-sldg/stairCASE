#include <camkes.h>
#include <stdio.h>

extern unsigned int argc;
extern char **argv;

void cml_entry(void);

int run(void) {
    cml_entry();
    return 0;
}
