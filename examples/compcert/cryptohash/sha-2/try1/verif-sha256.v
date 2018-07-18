Require Import VST.floyd.forward.
Require Import VST.floyd.proofauto. (* Import the Verifiable C system *) 
Require Import sha256. (* Import the AST of this C program *) 
(* The next line is "boilerplate", always required after importing an AST. *) 
Instance CompSpecs : compspecs. make_compspecs prog. Defined. 
Definition Vprog : varspecs.  mk_varspecs prog. Defined. 

(* Begin Functional spec of this program *)

(* array of round constants *)
Definition round_constants := [ 1; 2 ].

(* struct : buffer_state *)

(* right rotation function *)
Definition right_rot_spec : ident * funspec :=
  DECLARE _right_rot
    WITH x:val, ret:Z
    PRE [ _value OF tint, _count OF tint ]
      PROP ( x = Vint( Int.repr ret ) )
      LOCAL ( temp _value x )
      SEP ()
    POST [ tint ]
      PROP () LOCAL( temp ret_temp ( Vint (Int.repr ret) ) ) SEP ().

(* init buffer state function *)
Definition init_buf_state_spec : ident * funspec:=
  DECLARE _init_buf_state
    WITH x:val, ret:Z
    PRE [ _value OF tint, _count OF tint ]
      PROP ( x = Vint( Int.repr ret ) )
      LOCAL ( temp _value x )
      SEP ()
    POST [ tint ]
      PROP () LOCAL( temp ret_temp ( Vint (Int.repr ret) ) ) SEP ().

(* calc_chunk function *)
Definition calc_chunk_spec : ident * funspec:=
  DECLARE _calc_chunk
    WITH x:val, ret:Z
    PRE [ _value OF tint, _count OF tint ]
      PROP ( x = Vint( Int.repr ret ) )
      LOCAL ( temp _value x )
      SEP ()
    POST [ tint ]
      PROP () LOCAL( temp ret_temp ( Vint (Int.repr ret) ) ) SEP ().


(* calc_sha_256 function *)
Definition calc_sha_256_spec : ident * funspec:=
  DECLARE _calc_sha_256
    WITH x:val, ret:Z
    PRE [ _value OF tint, _count OF tint ]
      PROP ( x = Vint( Int.repr ret ) )
      LOCAL ( temp _value x )
      SEP ()
    POST [ tint ]
      PROP () LOCAL( temp ret_temp ( Vint (Int.repr ret) ) ) SEP ().

(* Examples *)
(*
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

Lemma body_myId: semax_body Vprog Gprog f_myId myId_spec.
Proof.
start_function.
forward.
Qed.

*)

(* Packaging the API spec all together. *)
Definition Gprog : funspecs :=
        ltac:(with_library prog [right_rot_spec; init_buf_state_spec; calc_chunk_spec; calc_sha_256_spec]).

Lemma body_right_rot: semax_body Vprog Gprog f_right_rot right_rot_spec.
Proof.
Admitted.

Lemma body_init_buf_state: semax_body Vprog Gprog f_init_buf_state init_buf_state_spec.
Proof.
Admitted.

Lemma body_calc_chunk: semax_body Vprog Gprog f_calc_chunk calc_chunk_spec.
Proof.
Admitted.

Lemma body_calc_sha_256: semax_body Vprog Gprog f_calc_sha_256 calc_sha_256_spec.
Proof.
Admitted.

Existing Instance NullExtension.Espec.

(* from verif_conc_queue.v in VST/progs *)
(*
Definition extlink := ext_link_prog prog.

Definition Espec := add_funspecs (Concurrent_Espec unit _ extlink) extlink Gprog.
Existing Instance Espec.
*)

(* Not sure how to get this to work. It still wants for a main function. *)
(* Actually, it looks like we only need the semax_body proofs for each function. *)
(*
Lemma prog_correct:
  semax_prog prog Vprog Gprog.
Proof.
prove_semax_prog.
semax_func_cons body_right_rot.
semax_func_cons body_init_buffer_state.
semax_func_cons body_calc_chunk_spec.
semax_func_cons body_calc_sha_256_spec.
semax_func_cons body_main.
Qed.
*)