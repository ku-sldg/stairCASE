Require Import VST.floyd.forward.
Require Import VST.floyd.proofauto. (* Import the Verifiable C system *) 
Require Import sha256. (* Import the AST of this C program *) 
(* The next line is "boilerplate", always required after importing an AST. *) 
Instance CompSpecs : compspecs. make_compspecs prog. Defined. 
Definition Vprog : varspecs.  mk_varspecs prog. Defined. 

(* Begin Functional spec of this program *)

(* array of round constants *)
(*
Definition round_constants := [
	0x428a2f98; 0x71374491; 0xb5c0fbcf; 0xe9b5dba5; 0x3956c25b; 0x59f111f1; 0x923f82a4; 0xab1c5ed5;
	0xd807aa98; 0x12835b01; 0x243185be; 0x550c7dc3; 0x72be5d74; 0x80deb1fe; 0x9bdc06a7; 0xc19bf174;
	0xe49b69c1; 0xefbe4786; 0x0fc19dc6; 0x240ca1cc; 0x2de92c6f; 0x4a7484aa; 0x5cb0a9dc; 0x76f988da;
	0x983e5152; 0xa831c66d; 0xb00327c8; 0xbf597fc7; 0xc6e00bf3; 0xd5a79147; 0x06ca6351; 0x14292967;
	0x27b70a85; 0x2e1b2138; 0x4d2c6dfc; 0x53380d13; 0x650a7354; 0x766a0abb; 0x81c2c92e; 0x92722c85;
	0xa2bfe8a1; 0xa81a664b; 0xc24b8b70; 0xc76c51a3; 0xd192e819; 0xd6990624; 0xf40e3585; 0x106aa070;
	0x19a4c116; 0x1e376c08; 0x2748774c; 0x34b0bcb5; 0x391c0cb3; 0x4ed8aa4a; 0x5b9cca4f; 0x682e6ff3;
	0x748f82ee; 0x78a5636f; 0x84c87814; 0x8cc70208; 0x90befffa; 0xa4506ceb; 0xbef9a3f7; 0xc67178f2
].
*)
(* dang, coq can't deal with these hexadecimals *)
Definition round_constants := [
 1116352408; 1899447441; 3049323471; 3921009573; 961987163; 1508970993; 2453635748; 2870763221;
 3624381080; 310598401; 607225278; 1426881987; 1925078388; 2162078206; 2614888103; 3248222580;
 3835390401; 4022224774; 264347078; 604807628; 770255983; 1249150122; 1555081692; 1996064986;
 2554220882; 2821834349; 2952996808; 3210313671; 3336571891; 3584528711; 113926993; 338241895;
 666307205; 773529912; 1294757372; 1396182291; 1695183700; 1986661051; 2177026350; 2456956037;
 2730485921; 2820302411; 3259730800; 3345764771; 3516065817; 3600352804; 4094571909; 275423344;
 430227734; 506948616; 659060556; 883997877; 958139571; 1322822218; 1537002063; 1747873779;
 1955562222; 2024104815; 2227730452; 2361852424; 2428436474; 2756734187; 3204031479; 3329325298
].

(* struct : buffer_state *)
(* see vst/progs/verif_nest3.v *)
Definition t_struct_buffer_state := Tstruct _buffer_state noattr.

(* right rotation function *)
Definition right_rot_spec : ident * funspec :=
  DECLARE _right_rot
    WITH valuev:val, countv:val, countz:Z
    PRE [ _value OF tint, _count OF tint ]
      PROP ( 0 < countz < 32; countv = Vint( Int.repr countz)  )
      LOCAL ( temp _value valuev; temp _count countv )
      SEP ()
    POST [ tint ]
      PROP () LOCAL(  ) SEP ().

(* init buffer state function *)
Definition init_buf_state_spec : ident * funspec:=
  DECLARE _init_buf_state
    WITH statev:val, inputv:val, lenv:val
    PRE [ _state OF tint, _input OF tint, _len OF tint ]
      PROP (  )
      LOCAL (  )
      SEP ()
    POST [ tint ]
      PROP () LOCAL() SEP ().

(* calc_chunk function *)
Definition calc_chunk_spec : ident * funspec:=
  DECLARE _calc_chunk
    WITH chunkArrv:val, statev:val, ret:Z
    PRE [ _chunk OF tint, _state OF tint ]
      PROP (  )
      LOCAL (  )
      SEP ()
    POST [ tint ]
      PROP () LOCAL() SEP ().


(* calc_sha_256 function *)
Definition calc_sha_256_spec : ident * funspec:=
  DECLARE _calc_sha_256
    WITH hashArrv:val, inputv:val, lenv:val, ret:Z
    PRE [ _hash OF tint, _input OF tint, _len OF tint ]
      PROP (  )
      LOCAL (  )
      SEP ()
    POST [ tint ]
      PROP () LOCAL() SEP ().

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

Lemma ZisInt: forall x:Z, x = Int.Z_mod_modulus x.
Proof.
Admitted.
(* I feel like there is a legit way to do this *)
Lemma intIsInt: forall x:Z, x = Int.unsigned (Int.repr x).
Proof.
intros x.
unfold Int.unsigned. simpl.
apply ZisInt.
Qed.

Lemma body_right_rot: semax_body Vprog Gprog f_right_rot right_rot_spec.
Proof.
start_function.
forward.
- entailer!. split.
* intuition.
* intuition. unfold Int.iwordsize. unfold Int.zwordsize. unfold Int.wordsize. unfold Wordsize_32.wordsize. simpl. rewrite <- intIsInt. omega.
Qed.

Lemma body_init_buf_state: semax_body Vprog Gprog f_init_buf_state init_buf_state_spec.
Proof.
start_function.
Admitted.

Lemma body_calc_chunk: semax_body Vprog Gprog f_calc_chunk calc_chunk_spec.
Proof.
Admitted.

Lemma body_calc_sha_256: semax_body Vprog Gprog f_calc_sha_256 calc_sha_256_spec.
Proof.
Admitted.
