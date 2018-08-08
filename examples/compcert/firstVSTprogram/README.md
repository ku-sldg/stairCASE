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
> can't conclude the final proof, for some raisin.  

## Take 2
> Let's do something even *simpler* than before.  
> Must we literally have a main function?  
>> Yes.  

## Take 3
> Let's just literally only return 0.  
> Okay, even with a dead simple program, I can't complete the "prog correct" proof.  
> Fine, then let's just reverse engineer a working example.  
> I'll pull parts out until it breaks.  

## Take 4 : progs/sum_array
> Ah ha!  
> In replicate the steps for this file, I encountered a new error.  
> After doing a `clightgen $1; ccoqc $1`, the verif proofs did *not* work.  
> I suspect this has to do with my version of clightgen.  
> That is, I think my compcert version is so different from that used in the vst examples that mine breaks the toolchain.  
> So, what version should I have, instead?  

## Retreat, regroup
> Alright, so compcert is fine and dandy.  
> However, a new vst compatible with the compcert I have was released in late June.  
> Get that built and ready, and then we'll try again.  

## Take 5 (aka take 3, subtake 2)
> Can we get this "return 0" program verified?  
> Well, the update didn't help  
> I've determined the sumarray.v and sumarray.vo files I produce are different than those included in vst.  
> Thus, my `clightgen -normalize` command does *not* produce the intended output.  

## Try rebuild clightgen, compare differences
> `diff` returns dozens of lines of differences.  
> However, it works!  
> See exp3 for the working copy.  





