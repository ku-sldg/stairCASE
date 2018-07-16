#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/time.h>
#include <sys/uio.h>
#include <assert.h>
#include <stdio.h>

// Test ffi function. The parameters appear to be mandatory.
// While we are given the length for our char arrays, they also appear to be
// null terminated, judging by the success of printf.
// Also, while c and a have the same type here, they seem to be treated
// differently in cakeml. c is an actual string, where a is a word8array?
void ffifoo(unsigned char *c, long clen, unsigned char *a, long alen) {
  printf("foo %s\n", c);
}

void cml_exit(int arg) {
  printf("Cakeml finished, now in cml_exit subroutine in basis_ffi.c\n");
  exit(arg);
}

// Functions below are stubs for the standard FFI functions that CakeML expects to exist.
// None of them are used.
void ffiget_arg_count(unsigned char *c, long clen, unsigned char *a, long alen) {
  printf("not supported");
}

void ffiget_arg_length(unsigned char *c, long clen, unsigned char *a, long alen) {
  printf("not supported");
}

void ffiget_arg(unsigned char *c, long clen, unsigned char *a, long alen) {
  printf("not supported");
}

void ffiopen_in (unsigned char *c, long clen, unsigned char *a, long alen) {
  printf("not supported");
}

void ffiopen_out (unsigned char *c, long clen, unsigned char *a, long alen) {
  printf("not supported");
}

void ffiread (unsigned char *c, long clen, unsigned char *a, long alen) {
  printf("not supported");
}

void ffiwrite (unsigned char *c, long clen, unsigned char *a, long alen) {
  printf("not supported");
}

void fficlose (unsigned char *c, long clen, unsigned char *a, long alen) {
  printf("not supported");
}
