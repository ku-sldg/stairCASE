## dependencies
### coq 8.8
> opam install coq.8.8.0  
### vst 2.2 and compcert 3.3
> http://vst.cs.princeton.edu/download/  
> for vst, can just `make`, or else `less BUILD_ORGANIZATION` for verbose instructions.  
> for compcert, need only build clightgen  
>> `./configure -clightgen x86_32-linux; make`  
>> (or what have you for your OS)


## aliases (for convenience)
> alias ccoqide='coqide `cat /path/to/vst/_CoqProject-export` ' $1  
> alias ccoqc='coqc `cat /path/to/vst/_CoqProject-export` ' $1  
> alias clightgen /path/to/compcert/clightgen -normalize ' $1  

## reference manual
> http://vst.cs.princeton.edu/download/VC.pdf
