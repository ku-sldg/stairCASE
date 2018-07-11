# A second, more interesting VST program

## thoughts
> I wonder, is this only valid for 'functional' specs?  
>> that is, those without i/o?

## The goal
* function call  
* conditional statements  
* while loop  

### exp1 : function call
> return a value passed through an id function.  
> Learned: with static calls like these, one needs to start the proof with a forward_call( ~ ) that takes as arguments the parameters to the function specification in question.  
>> In this case, myId_spec is `WITH` x:val and ret:Z,  
>> so I had to `forward_call( Vint(Int.repr 0), 0 )`  

### exp2 : conditional
> return a value passed through an id function, and governed by a simple conditional block.  
> Learned: when calling into an if block, use `forward_if`, which takes a post condition as an argument.  
>> `foward_if(PROP () LOCAL (...) SEP ()).`  
>> see verif_exp2.v

> `forward_if` generates a "goal" for each possible outcome.  
>> in this case, one of the conditions is not possible, because things are statically allocated.  
>> so that case is solved by `discriminate.`  

### exp3 : while loop
> not sure about the "loop invariant"  
> glynn winskyll wrote a book that talks about these.  
> possible loop invariants  

> * result is 0 and condition is 1
> * loop is either 0 or 1  

> Invariant used:
>> 0 <= loop <= 1, and a couple "temp" variables exist

### exp3 : conditional inside while loop
>
