Require Import VST.floyd.forward.
Require Import VST.floyd.proofauto. (* Import the Verifiable C system *) 
Require Import exp2. (* Import the AST of this C program *) 
(* The next line is "boilerplate", always required after importing an AST. *) 
Instance CompSpecs : compspecs. make_compspecs prog. Defined. 
Definition Vprog : varspecs.  mk_varspecs prog. Defined. 

(* The precondition of "int main(void){}" always looks like this. *)

(* Functional spec of this program *)
Definition myId (a:Z) : Z := a.

Definition myId_spec : ident * funspec :=
  DECLARE _myId
    WITH x:val, ret:Z
    PRE [ _x OF tint ]
      PROP ( x = Vint( Int.repr ret ) )
      LOCAL ( temp _x x )
      SEP ()
    POST [ tint ]
      PROP () LOCAL( temp ret_temp ( Vint (Int.repr ret) ) ) SEP ().

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
forward. forward. deadvars!.
(* start the IF, declaring the result as a temp value *)
forward_if ( PROP () LOCAL (temp _result (Vint(Int.repr 1))) SEP () ).
(* case: 1 returns 1, as expected *)
forward; entailer!.
(* case: 1 returns 0, which is impossible *)
discriminate.
(* call into the id function, as before *)
forward_call ( Vint(Int.repr 1), 1 ).
forward; entailer!.
Qed.

Existing Instance NullExtension.Espec.

Lemma prog_correct:
  semax_prog prog Vprog Gprog.
Proof.
prove_semax_prog.
semax_func_cons body_myId.
semax_func_cons body_main.
Qed.

Check prog_correct.

