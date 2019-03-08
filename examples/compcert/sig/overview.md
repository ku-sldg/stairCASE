# Signature Algorithms
### What's the idea?
> We want to choose an algorithm for signing evidence.
>> What's signing?

## What's in a name?
> Formally, a *digital signature scheme* is a triple of *probabilistic polynomial time algorithms.*
>> Whoa whoa whoa, what's a probable polyphony alimony?

> A probabalistic polynomial time algorithm is one that a turing machine would issue a correct answer for *most of the time,* allowing for the fact that it makes some decisions based on coin tosses.
>> Neato... wait! Are you saying our FORMAL algorithms are *PROBABALISTIC?*

### I'm sorry, this isn't stats class.

> Not exactly! I'm saying that an adversary with a PPT-turing machine can only hope to make guesses at how to break our signature. Furthermore, we can engineer our signature to ensure the adversary has *virtually* no chance of success.
>> How do you mean, virtually?

> Well, basically, if we choose numbers *sufficiently high,* we can ensure that the adversary's chance of guessing them randomly  is *arbitrarily low.*
>> That sounds like a delta-epsilon proof.

>You got it.

## What's in a name? director's cut
> Okay, there are three algorithms:  

> * Key_Generator: nat -> (public key, private key)
> * Signing: (private key, message) -> tag
> * Verifying: (public key, message, tag) -> bool

> and that's all!

>> sounds like mumbo jumbo to me

> What's not *transparently clear?*
>> Let's start with the tag and the bool. What are those?

> The tag is effectively "the signature." If you think of the private key like your identity, and the message as a written letter for post, then the tag is a lot like your signature at the bottom of the paper. The only difference is that the signature changes drastically based on the content of the letter, but it's still provably your signature!
>> Whoa, that's cool. What about the bool?

> Ah, the final bool answers the question "Was this probably signed by the person whose name appears in the signature?"
>> There's the "probably" thing again!

> Don't worry, for this system to be called correct, the verification step must be guaranteed to accept a good signature.
>> So, it could be correct if it accepted some bad signatures?

> Yes! But we call the system secure if that happens with negligble probability, as with the epsilon-delta idea earlier.
>> Oooh, okay I see. Are there many of these systems?

## Who makes this stuff?
> Actually, there are many:  

> * RSA
> * DSA
> * ECDSA
> * ElGamal
> * Rabin
> * BLS
> * Undeniable signatures
> * Aggregate signatures
> * "Sigs with efficient protocols"

> There are a few, at least!
>> What's an undeniable signature?

> They involve more communication between sender and receiver, such that the sender only allows certain recipients to verify the signature, AND once verified, the signer can't change their mind to say "that's not my signature!"
>> That seems neat. What's an aggregate signature?

> An aggregate signature is a way of accumulating signatures from n-many parties, such that you have one signature that says "n-many parties signed this letter."
>> Oh, that also seems neat. And the "efficient protocols" bit?

> These systems efficiently implement two protocols in addition to everything else. One protocol computes a digital signature in a "secure two-party computation." The other proves knowledge of a digital signature in a "zero-knowledge" protocol.
>> Holy jargon, batman! What are those things?

> What things?
>> Don't play coy with me.

> Sorry! *Secure two-party computation* describes a system where two parties compute the single value of a function *jointly,* while neither knows the inputs of the other!
>> Gosh, that's non-trivial!

> Right! A *zero-knowledge protocol* or *zero-knowledge proof* is one where a party can prove to another party that they know a certain value X without conveying *any* information other than *that they know X.*
>> Wow, that's also non-trivial!

> Pretty cool, huh?
>> Sure! Well, simon says we need an implementation in c, right?

> Right, so let's c what we have available.
>> I'll allow it.

> Thanks, here's what we've got:

> * RSA -> openssl
> * DSA -> openssl
> * ECDSA -> openssl as "ec", SUPERCOP as "ref"
> * ~~ElGamal~~
> * ~~Rabin~~
> * BLS -> github user "herumi"
> * Undeniable signatures
> * Aggregate signatures
> * "Sigs with efficient protocols"

> So there's a few options, but I don't really like any of them.
>> What? Why not?

## No great options...
> Well, openssl is enormous. It would be like driving in a nail with a railroad spike-driving machine.
>> It would work, though. How about the SUPERCOP one?

> It could be good! It admits that the implementation is slow, though.
>> What about, uh, herumi?

> That's just one person. I don't trust herumi any further than I can throw herumi.
>> Yeah, same. Okay, so then what's the plan?

## The plan
> I suppose we should examine our options between RSA, DSA, and ECDSA... and we should also be conscious of implementation size and speed, as well as... provability?
>> That seems wise. What do you mean about provability?

> Well, surely none of these have a Coq proof about them, or are proven in VST, for example. We should look at how many developers eyes have seen them, and we can afford to run a battery of our own tests if we'd like.
>> Okay, that's not exactly formal, but we'll see what happens. Then what?

> Then if we choose an openssl implementation, I'll try to pare it down so that the footprint on disk isn't a zillion megabytes or whatever.
>> That seems reasonable. Is that all?

> Well, if I can't get the size to be... sufficiently small, I could pursue the idea of implementing a proven implementation on my own.  
>> Don't tell me you forgot that SHA-2 implementation in VST.

> Yeah, that's not really something I want to do, although it was really impressive.
>> Agreed. So how do we pick between RSA, DSA, and ECDSA?

> Great question.

## Whose line is it anyway?
> Let's first look at DSA and ECDSA. Notice how DSA is a substring of ECDSA.
>> Oh!

> So I think ECDSA is an expansion pack for DSA.
>> What's it add, new maps?

> 
