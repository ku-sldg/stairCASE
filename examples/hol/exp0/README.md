# An introduction to HOL4
> see test.sml  
> see the paper `Guide to HOL4 interaction and basic proofs` by Magnus O. Myreen  

## input methods
> they're strange  
> here's a list, good luck  

`Let M-h refer to the key digraph alt+h`  
+ M-h 3 => start hol (1), open hol buffer (2), use config (3)  
+ M-h M-r => **R**un the selected region  
+ M-h g => Add the selected **G**oal  
+ M-h p => **P**rint the current goal  
+ M-h e => **E**mploy the selected Tactic  
+ M-h d => **D**rop the goal on top of the stack  

> with these, you should be able to get through test.sml

## notation
> it's really not so bad  
>> there's some boiler plate stuff at the beginning and end of every file, but I guess that's the price to pay for getting to use emacs  

> inside the \`backticks\` can be found the language for expressing logic, I think.  
>> ! is the universal quantifier (for all)  
>> ==> is the implication arrow  

> anything *worth your time* is a val  
>> every val is a definition, which is something that can be saved.  
>> sometimes we do a `val _ =`, because we don't care to give the thing a name, like in the case of creating a new Datatype.  

## notes on usage
> to use the Run command, highlight the entire region  
> to use the Goal command, place cursor in the \`backticks\`  
> to employ a tactic, either highlight the tactic or place the cursor at the end of the line in which the tactic resides  
> you can Print goal and Drop goal from anywhere, but if the goal stack is empty, you might get an error, which is no prob.  
>> the hol buffer is cluttered. That is, too much is printed in a space too little, it's not easy to differentiate when a new message begins. They all just kinda bleed into each other.  