# recursion

## goal
> verify the factorial function  

## exp0
> I choose to define factorial over the nats.  
> ... which means I gotta switch the theory to nats...  

### a revelation
> integers in coq are not signed natural numbers for some reason.  
> apparently they are setoids.  
> what the heck is that supposed to mean?  

### definition  
> A setoid is a set equipped with an equivalence relation.  

### remark  
> wow i don't like these integers even a little bit.  

### conclusion
> Z in coq (what I've been calling the integers) are not signed nats.  
> there is certainly an equivalence relations, so Z is indeed a setoid.  
> these integers are, in reality, signed little-endian binary numbers.  
>> that is, uh, here are examples  

>> * let O be 0 and I be 1  
>> * OI = 2  
>> * OOOI = 8  

>> oh yeah, except that 1 is literally its own symbol, so 9 looks like  
>> IOO1 = 9  

> and hence I've decided that these are no good  
> I don't know why they aren't just signed nats  
> pretty sure that would be an easy monad thing to do.  