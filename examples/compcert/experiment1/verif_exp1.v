Require Import VST.floyd.proofauto. (* Import the Verifiable C system *) 
Require Import exp1. (* Import the AST of this C program *) 
(* The next line is "boilerplate", always required after importing an AST. *) 
Instance CompSpecs : compspecs. make_compspecs prog. Defined. 
Definition Vprog : varspecs.  mk_varspecs prog. Defined. 

(* Functional spec of this program.  *)
Definition myAdd : Z -> Z -> Z := Z.add.

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

(* Beginning of the API spec for the sumarray.c program *)
Definition exp1_spec : ident * funspec :=
 DECLARE _mySum
  WITH x:val, y:val, sh : share, sum : Z
  PRE [ _x OF tint, _y OF tint ]
          PROP  (readable_share sh;
                 0 <= sum <= Int.max_signed)
          LOCAL (temp _x x; temp _y y)
          SEP   (data_at sh (tint) (Vint (Int.repr sum)) x)
  POST [ tint ]
        PROP () LOCAL(temp ret_temp  (Vint (Int.repr (sum))))
           SEP (data_at sh (tint) (Vint (Int.repr sum)) x).


(* The precondition of "int main(void){}" always looks like this. *)
Definition main_spec :=
 DECLARE _main
  WITH gv : globals
  PRE  [] main_pre prog nil gv
  POST [ tint ]  
     PROP() 
     LOCAL (temp ret_temp (Vint (Int.repr (2+3)))) 
     SEP(TT).


(* Packaging the API spec all together. *)
Definition Gprog : funspecs :=
        ltac:(with_library prog [exp1_spec; main_spec]).


(** Proof that f_sumarray, the body of the sumarray() function,
 ** satisfies sumarray_spec, in the global context (Vprog,Gprog).
 **)
Lemma body_sumarray: semax_body Vprog Gprog f_mySum exp1_spec.
Proof.
start_function. (* Always do this at the beginning of a semax_body proof *)
(* The next two lines do forward symbolic execution through
   the first two executable statements of the function body *)
forward.
forward.
Qed.

Lemma body_main:  semax_body Vprog Gprog f_main main_spec.
Proof.
start_function.
forward.
forward.
forward_call (*  s = sumarray(four,4); *)
  (Vint (Int.repr 2), Vint (Int.repr 3) ,5).
 split3. auto. computable. repeat constructor; computable.
forward. (* return s; *)
Qed.

Existing Instance NullExtension.Espec.

Lemma prog_correct:
  semax_prog prog Vprog Gprog.
Proof.
prove_semax_prog.
semax_func_cons body_sumarray.
semax_func_cons body_main.
Qed.

