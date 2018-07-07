/*Copyright (c) 2004 The OpenSSL
 * Project. All rights reserved according to the OpenSSL license.
 */
extern unsigned int __builtin_read32_reversed(const unsigned int * ptr);
extern void __builtin_write32_reversed(unsigned int * ptr, unsigned int x);
#include <stddef.h>
#include <string.h> /* for memcpy, memset */
#define HOST_c2l(c,l) \
    (l=(unsigned long)(__builtin_read32_reversed (((unsigned int *)c))),c+=4,l)
#define HOST_l2c(l,c) \
    (__builtin_write32_reversed (((unsigned int *)(c)),l),c+=4,l)
#define SHA_LONG unsigned int
#define SHA_LBLOCK 16
#define SHA_CBLOCK (SHA_LBLOCK*4)
/* SHA treats input data as a contiguous array of 32 bit wide big-endian
** values. */
#define SHA_LAST_BLOCK (SHA_CBLOCK-8)
#define SHA_DIGEST_LENGTH 20
#define SHA256_DIGEST_LENGTH 32
typedef struct SHA256state_st {
    SHA_LONG h[8];
    SHA_LONG Nl,Nh;
    unsigned char data[SHA_CBLOCK];
    unsigned int num;
} SHA256_CTX;

#define MD32_REG_T long
#define ROTATE(a,n) (((a)<<(n))|(((a)&0xffffffff)>>(32-(n))))

static const SHA_LONG K256[64] = {
    0x428a2f98UL,0x71374491UL, ... ... 0xbef9a3f7UL,0xc67178f2UL };
/* FIPS specification refers to right rotations, while our ROTATE macro is left
** one.
 * This is why you might notice that rotation coefficients differ from those
 * observed in FIPS document by 32-N...
 */
#define Sigma0(x)
(ROTATE((x),30) ^ ROTATE((x),19) ^ ROTATE((x),10))
#define Sigma1(x)
(ROTATE((x),26) ^ ROTATE((x),21) ^ ROTATE((x),7))
#define sigma0(x)
(ROTATE((x),25) ^ ROTATE((x),14) ^ ((x)>>3))
#define sigma1(x)
(ROTATE((x),15) ^ ROTATE((x),13) ^ ((x)>>10))
#define Ch(x,y,z) (((x) & (y)) ^ ((~(x)) & (z)))
#define Maj(x,y,z) (((x) & (y)) ^ ((x) & (z)) ^ ((y) & (z)))

void sha256_block_data_order (SHA256_CTX *ctx, const void *in) {
    unsigned MD32_REG_T a,b,c,d,e,f,g,h, s0,s1,T1,T2,t;
    SHA_LONG
    X[16],l,Ki;
    A:27
    int i;
    const unsigned char *data=in;
    a = ctx->h[0];
    e = ctx->h[4];
    b = ctx->h[1];
    f = ctx->h[5];
    c = ctx->h[2];
    g = ctx->h[6];
    d = ctx->h[3];
    h = ctx->h[7];
    for (i=0;i<16;i++) {
        HOST_c2l(data,l); X[i] = l;
        Ki=K256[i];
        T1 = l + h + Sigma1(e) + Ch(e,f,g) + Ki;
        T2 = Sigma0(a) + Maj(a,b,c);
        h = g;
        g = f;
        f = e;
        e = d + T1;
        d = c;
        c = b;
        b = a;
        a = T1 + T2;
    }
    for (;i<64;i++) {
        s0 = X[(i+1)&0x0f];
        s0 = sigma0(s0);
        s1 = X[(i+14)&0x0f];
        s1 = sigma1(s1);
        T1 = X[i&0xf];
        t = X[(i+9)&0xf];
        T1 += s0 + s1 + t;
        X[i&0xf] = T1;
        Ki=K256[i];
        T1 += h + Sigma1(e) + Ch(e,f,g) + Ki;
        T2 = Sigma0(a) + Maj(a,b,c);
        h = g;
        g = f;
        f = e;
        e = d + T1;
        d = c;
        c = b;
        b = a;
        a = T1 + T2;
    }
    t=ctx->h[0]; ctx->h[0]=t+a;
    t=ctx->h[1]; ctx->h[1]=t+b;
    t=ctx->h[2]; ctx->h[2]=t+c;
    t=ctx->h[3]; ctx->h[3]=t+d;
    t=ctx->h[4]; ctx->h[4]=t+e;
    t=ctx->h[5]; ctx->h[5]=t+f;
    t=ctx->h[6]; ctx->h[6]=t+g;
    t=ctx->h[7]; ctx->h[7]=t+h;
    return;
}
void SHA256_Init (SHA256_CTX *c) {
    c->h[0]=0x6a09e667UL; c->h[1]=0xbb67ae85UL;
    c->h[2]=0x3c6ef372UL; c->h[3]=0xa54ff53aUL;
    c->h[4]=0x510e527fUL; c->h[5]=0x9b05688cUL;
    c->h[6]=0x1f83d9abUL; c->h[7]=0x5be0cd19UL;
    c->Nl=0;
    c->Nh=0;
    c->num=0;
    return;
}
void SHA256_addlength(SHA256_CTX *c, size_t len) {
    SHA_LONG l, cNl,cNh;
    cNl=c->Nl; cNh=c->Nh;
    l=(cNl+(((SHA_LONG)len)<<3))&0xffffffffUL;
    if (l < cNl) /* overflow */
    {cNh ++;}
    cNh += (len>>29);
    c->Nl=l; c->Nh=cNh;
    return;
}
void SHA256_Update (SHA256_CTX *c, const void *data_, size_t len) {
    const unsigned char *data=data_;
    unsigned char *p;
    size_t n, fragment;
    SHA256_addlength(c, len);
    n = c->num;
    p=c->data;
    if (n != 0)
    {
        fragment = SHA_CBLOCK-n;
        if (len >= fragment) {
            memcpy (p+n,data,fragment);
            sha256_block_data_order (c,p);
            data += fragment;
            len -= fragment;
            memset (p,0,SHA_CBLOCK); /* keep it zeroed */
        }
        else {
            memcpy (p+n,data,len);
            c->num = n+(unsigned int)len;
            return;
        }
    }
    while (len >= SHA_CBLOCK) {
        sha256_block_data_order (c,data);
        data += SHA_CBLOCK;
        len -= SHA_CBLOCK;
    }
    c->num=len;
    if (len != 0) {
        memcpy (p,data,len);
    }
    return;
}
void SHA256_Final (unsigned char *md, SHA256_CTX *c)
{
    unsigned char *p = c->data;
    size_t n = c->num;
    SHA_LONG cNl,cNh;
    p[n] = 0x80; /* there is always room for one */
    n++;
    if (n > (SHA_CBLOCK-8)) {
        memset (p+n,0,SHA_CBLOCK-n);
        n=0;
        sha256_block_data_order (c,p);
    }
    memset (p+n,0,SHA_CBLOCK-8-n);
    p += SHA_CBLOCK-8;
    cNh=c->Nh; (void)HOST_l2c(cNh,p);
    cNl=c->Nl; (void)HOST_l2c(cNl,p);
    p -= SHA_CBLOCK;
    sha256_block_data_order (c,p);
    c->num=0;
    memset (p,0,SHA_CBLOCK);
    {
        unsigned long ll;
        unsigned int xn;
        for (xn=0;xn<SHA256_DIGEST_LENGTH/4;xn++)
        {
            ll=(c)->h[xn]; HOST_l2c(ll,md);
        }
    }
    return;
}
void SHA256(const unsigned char *d,
        size_t n, unsigned char *md) {
    SHA256_CTX c;
    SHA256_Init(&c);
    SHA256_Update(&c,d,n);
    SHA256_Final(md,&c);
    return;
}


