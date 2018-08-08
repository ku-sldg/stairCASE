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

### exp4 : conditional inside while loop
> that was easy enough.  
> something I'm curious about are the post-conditions one is supposed to supply to `forward_if` and `forward_while`.  
> In particular, it almost seems like I can assert whatever I want in the `LOCAL` section.  
>> so I wonder, what exactly am I verifying?  
>> when I claim that result=0, is that checked? or is it a guarantee I... promise?  

### exp4.1 : assert a false result value
> In the loop (and seperately the conditional) invariant, I changed the assertion to result=1.  
> The previously completed proof failed catastrophically, which is reassuring.  

### exp5 : for loop
> for simple for loops (ie, those with integer upper bounds), use `forward_for_simple_bound N inv`.  
> the statement of the invariant is key here.  
>> the proof is perhaps impossible without a sufficiently strong invariant.  

> at the end of the `forward_for...` call, there is a `%assert` that I don't understand.  
>> the tactic executes with or without it...  
>> the proof is successful with or without it...  
>> ...i guess i'll keep it there...

## final remarks
> This sort of verification is surprisingly not that difficult,  
>> but dang the proofs are nearly opaque.  
>> Although, let's be honest, machine proofs are in general opaque.  
>> Not needing to understand the process is kind of the selling point.  

> I think an effective proofing strategy here is to develop code and proof side-by-side.  
>> In these experiments, I developed the final little program in many iterations.  
>> That way, I was never terribly overwhelmed.  
>>> I also learned a fair amount about how the system works.  

> Conversely, I think writing a big algorithm and *then* attempting to prove it is suicide.  
>> sure I'm a novice, but dang I don't recommend that to anyone.  