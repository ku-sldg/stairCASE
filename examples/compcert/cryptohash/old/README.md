# SHA256 in VST
## Andrew Appel did this
> for versions 1.2 and 1.6, I think  
> however, vst is currently on version 2.2  
> so that's no good.  

## sha256.c
### what it is
> the c code from Appel's paper on the subject  
>  `Second Edition: Verification of a Cryptographic Primitive: SHA-256`  
> 7 Jan 2016  

### where it stands
> the file currently does not compile.  
> it's literally punctation errors  
>> i'm not sure what's wrong  

## sha256.v
### what it is
> the coq code from Appel's paper, as above.  

### where it stands
> it's also no good, out of the box
> the copy/paste from the pdf goofed up some formatting
>> :%s/-/_ in vim will fix one such goof

