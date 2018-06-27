Require Import VST.floyd.forward.
Require Import VST.floyd.proofauto. (* Import the Verifiable C system *) 
Require Import exp1. (* Import the AST of this C program *) 
(* The next line is "boilerplate", always required after importing an AST. *) 
Instance CompSpecs : compspecs. make_compspecs prog. Defined. 
Definition Vprog : varspecs.  mk_varspecs prog. Defined. 

(* Functional spec of this program.  *)

Definition myId (a:Z) : Z := a.

Definition myAdd : Z -> Z := myId.

(*
Lemma assoc : forall a b c : Z, (a+(b+c)) = (a+b+c).
Proof.
  intuition.
Qed.

Lemma hasIdent : forall a : Z, a+0=a /\ 0+a=a.
Proof.
  intuition.
Qed.

Lemma hasInverse: forall a:Z, exists b:Z, a+b=0.
Proof.
  intros a.
  exists (0-a).
  intuition.
Qed.
*)

(* Beginning of the API spec for the sumarray.c program *)
Definition myId_spec : ident * funspec :=
 DECLARE _myId
  WITH x:val, ret : Z
  PRE [ _x OF tint ]
          PROP  ( x = Vint (Int.repr ret) )
          LOCAL (temp _x x)
          SEP   ()
  POST [ tint ]
        PROP () LOCAL(temp ret_temp  (Vint (Int.repr (ret))))
           SEP ().


(* The precondition of "int main(void){}" always looks like this. *)
Definition main_spec :=
 DECLARE _main
  WITH gv : globals
  PRE  [] main_pre prog nil gv
  POST [ tint ]  
     PROP() 
     LOCAL (temp ret_temp (Vint (Int.repr (2)))) 
     SEP(TT).

(* Packaging the API spec all together. *)
Definition Gprog : funspecs :=
        ltac:(with_library prog [myId_spec; main_spec]).

Lemma body_myId: semax_body Vprog Gprog f_myId myId_spec.
Proof.
start_function. (* Always do this at the beginning of a semax_body proof *)
forward.
Qed.

Lemma body_main:  semax_body Vprog Gprog f_main main_spec.
Proof.
start_function.
forward.
forward_call (* provide a witness to the WITH clause of exp1_spec *)
  (Vint (Int.repr 2), 2).
forward.
Qed.

Existing Instance NullExtension.Espec.

Locate semax_func.

Lemma prog_correct:
  semax_prog prog Vprog Gprog.
Proof.
prove_semax_prog.
semax_func_main body_myId.
semax_func_cons body_main.
Qed.

Check prog_correct.

