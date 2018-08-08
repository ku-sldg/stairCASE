Require Import VST.floyd.forward.
Require Import VST.floyd.proofauto. (* Import the Verifiable C system *) 
Require Import exp0. (* Import the AST of this C program *) 
(* The next line is "boilerplate", always required after importing an AST. *) 
Instance CompSpecs : compspecs. make_compspecs prog. Defined. 
Definition Vprog : varspecs.  mk_varspecs prog. Defined.

Check Z.
Print nat.
Print Z.
Print positive.
Check xH.
Check (xO xH).
Check (xO (xO xH)).
Check (xI (xO xH)).

Definition one := Zpos xH.
Definition two := Zpos (xO xH).
Definition four := Zpos (xO (xO xH)).
Definition five := Zpos (xI (xO xH)).

Example Ztest : five - four = one.
Proof. reflexivity. Qed.

(* What in God's name? *)
(* where is 3? *)

Definition seven := Zpos (xI (xI xH)).

Definition three := Zpos (xI xH).

Definition eight := Zpos (xO (xO (xO xH))).
Print eight.

(* so it's backwards binary? *)
(* i think it's called little endian *)
(* these are signed, little endian binary numbers *)

Definition nine := Zpos ( xI (xO (xO xH))).
Print nine.

(* nailed it *)

(* Well, I hate to admit it, but I'm not sure this is usable. *)

(* Functional spec of this program *)
Fixpoint fac (a:Z) : Z :=
  match a with
  | 0 => 1
  | Z.S a' => a * (fac a')
  end.


Definition myId_spec : ident * funspec :=
  DECLARE _myId
    WITH x:val, ret:Z
    PRE [ _x OF tint ]
      PROP ( x = Vint( Int.repr ret ) )
      LOCAL ( temp _x x )
      SEP ()
    POST [ tint ]
      PROP () LOCAL( temp ret_temp ( Vint (Int.repr ret) ) ) SEP ().

(* The precondition of "int main(void){}" always looks like this. *)
Definition main_spec :=
 DECLARE _main
  WITH gv : globals
  PRE  [] main_pre prog nil gv
  POST [ tint ]  
     PROP() 
     LOCAL () 
     SEP(TT).

(* Packaging the API spec all together. *)
Definition Gprog : funspecs :=
        ltac:(with_library prog [myId_spec; main_spec]).

Lemma body_myId: semax_body Vprog Gprog f_myId myId_spec.
Proof.
start_function.
forward.
Qed.

Lemma body_main:  semax_body Vprog Gprog f_main main_spec.
Proof.
start_function.
repeat forward.
(* start the WHILE *)
hint.
forward_while ( EX loop : Z, PROP ( 0<= loop <= 1 ) LOCAL ( temp _result (Vint(Int.repr 0)); temp _loop (Vint(Int.repr loop)) ) SEP (  ) ).
- entailer.  Exists 1. entailer!. 
- entailer!.
- forward_if ( PROP () LOCAL (temp _result (Vint(Int.repr 0)); temp _loop (Vint(Int.repr 0)) ) SEP () ).
* forward. entailer!.
* forward. entailer!.
* entailer!. Exists 0. entailer!. 
(* call into the id function, as before *)
- forward_call ( Vint(Int.repr 0), 0 ). forward; entailer!.
Qed.

Existing Instance NullExtension.Espec.

Lemma prog_correct:
  semax_prog prog Vprog Gprog.
Proof.
prove_semax_prog.
semax_func_cons body_myId.
semax_func_cons body_main.
Qed.

