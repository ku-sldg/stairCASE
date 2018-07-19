#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/time.h>
#include <sys/uio.h>
#include <assert.h>

// Internal helper function, not exposed to cakeml. Used by ffifoo.
// Copies string `from` into `to`, checking against length of `to`.
// Assumes `from` is null-terminated (string literals are by default).
// `to` will always be null-terminated.
void str_cpy(unsigned char *from, unsigned char *to, long toLen){
  for (long i = 0; i < (toLen - 1); i++) {
    to[i] = from[i];
    if (to[i] == '\0')
      return;
  }
  to[toLen -1] = '\0';
}

// Test ffi function. The parameters appear to be mandatory.
// The strings are null terminated. The length parameters refer to the length
// of the underlying allocated array.
// Also, while c and a have the same type here, they seem to be treated
// differently in cakeml. c is an actual string, where a is a word8array?
void ffifoo(unsigned char *c, long clen, unsigned char *a, long alen) {
  // print "foo" + input string a
  printf("foo %s\n", c);

  // copy "bar" into return string a
  str_cpy("bar", a, alen);
}

// CakeML returns here rather than back into main
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
