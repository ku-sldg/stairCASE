# tiny program via VST
## the program
>instantiate 2 ints  
>sum them  
>return sum  
>> see exp1.c

## Procedure
1. `cd compcert && make clightgen`  
> if you're me, you might need to make clean; ./configure x86_64-linux; make -j 3; sudo make install; make clightgen
2. `clightgen -normalize exp1.c`  
> This creates a file exp1.v that is an AST of th C program, expressed in Coq.
3. `emacs exp1.v`  
> "gosh, that's dense"  
4. `touch verif_exp1.v`  
> "we'll deal with that later"
5. create the .vo file(s)  
> we need one for every C file  
> `ccoqc exp1.v`  
>> *remark:* ccoqc is an alias for  
>> coqc 'cat path/to/vst/_CoqProject-export' $1,  
>> where the ' are backticks.
7. `ccoqide verif_exp1.v`  
> *remark:* ccoqide is an alias for  
> coqide 'cat path/to/vst/.loadpath-export' $1,  
> where the ' are backticks.
8. include exp1.vo  
> `Require Import exp1.`  
9. Perform verifcations over exp1.v.  
> see `verif_exp1.v`  


