(* test *)

Require Import ZArith.

Fixpoint little_endian_integer (contents: list Z) : Z :=
match contents with
| nil => Z.zero
| cons c cr => Int.or (Int.shl (little_endian_integer cr) (Int.repr 8)) c
end.

Definition big_endian_integer (contents: list int) : int :=
little_endian_integer (rev contents).

Definition LBLOCKz : Z := 16. (∗ length of a block, in 32_bit ints ∗)
Definition CBLOCKz : Z := 64. (∗ length of a block, in characters ∗)
Definition s256state := (list val ∗ (val ∗ (val ∗ (list val ∗ val))))%type.
Definition s256_h (s: s256state) := fst s.
Definition s256_Nl (s: s256state) := fst (snd s).
Definition s256_Nh (s: s256state) := fst (snd (snd s)).
Definition s256_data (s: s256state) := fst (snd (snd (snd s))).
Definition s256_num (s: s256state) := snd (snd (snd (snd s))).
Definition s256abs := list Z. (∗ SHA_256 abstract state ∗)
Definition s256a_hashed (a: s256abs) : list int :=
Zlist_to_intlist (sublist 0 ((Zlength a / CBLOCKz) ∗ CBLOCKz) a).

Definition s256a_data (a: s256abs) : list Z :=
sublist ((Zlength a / CBLOCKz) ∗ CBLOCKz) (Zlength a) a.

Definition S256abs (hashed: list int) (data: list Z) : s256abs :=
  intlist_to_Zlist hashed ++ data.

Definition s256a_regs (a: s256abs) : list int :=
hash_blocks init_registers (s256a_hashed a).

Definition s256a_len (a: s256abs) := (Zlength a ∗ 8)%Z.
Definition s256_relate (a: s256abs) (r: s256state) : Prop :=
s256_h r = map Vint (s256a_regs a)
∧ (s256_Nh r = Vint (hi_part (s256a_len a)) ∧
s256_Nl r = Vint (lo_part (s256a_len a)))
∧ sublist 0 (Zlength (s256a_data a)) (s256_data r) =
map Vint (map Int.repr (s256a_data a))
∧ Forall isbyteZ a
∧ s256_num r = Vint (Int.repr (Zlength (s256a_data a))).

Definition cVint (f: Z → int) (i: Z) := Vint (f i).
Definition t_struct_SHA256state_st := Tstruct _SHA256state_st noattr.
Definition sha256state_ (a: s256abs) (c: val) : mpred :=
EX r:s256state,
!! s256_relate a r && data_at Tsh t_struct_SHA256state_st r c.

Definition data_block {cs: compspecs} (sh: share) (contents: list Z) :=
!! Forall isbyteZ contents &&
@data_at cs sh (tarray tuchar (Zlength contents)) (map Vint (map Int.repr contents)).

Definition _ptr : ident := 81%positive.
Definition _x : ident := 82%positive.
Definition __builtin_read32_reversed_spec :=
DECLARE ___builtin_read32_reversed
WITH p: val, sh: share, contents: list int
PRE [ _ptr OF tptr tuint ]
PROP (Zlength contents ≥ 4)
LOCAL (temp _ptr p)
SEP (data_at sh (tarray tuchar 4) (map Vint contents) p)
POST [ tuint ]
PROP() LOCAL (temp ret_temp (Vint (big_endian_integer contents)))
SEP (data_at sh (tarray tuchar 4) (map Vint contents) p).

Definition __builtin_write32_reversed_spec :=
DECLARE ___builtin_write32_reversed
WITH p: val, sh: share, contents: list int
PRE [ _ptr OF tptr tuint, _x OF tuint ]
PROP (writable_share sh; Zlength contents ≥ 4)
LOCAL (temp _ptr p; temp _x (Vint(big_endian_integer contents)))
SEP (memory_block sh 4 p)
POST [ tvoid ]
PROP() LOCAL()
SEP(data_at sh (tarray tuchar 4) (map Vint contents) p).

Definition memcpy_spec := (∗ elided ∗)
Definition memset_spec := (∗ elided ∗)
Definition K_vector : val → mpred :=
data_at Tsh (tarray tuint (Zlength K256)) (map Vint K256).

Definition sha256_block_data_order_spec :=
DECLARE _sha256_block_data_order
WITH hashed: list int, b: list int, ctx : val, data: val, sh: share, kv : val
PRE [ _ctx OF tptr t_struct_SHA256state_st, _ in OF tptr tvoid ]
PROP(Zlength b = LBLOCKz; (LBLOCKz | Zlength hashed); readable_share sh)
LOCAL (temp _ctx ctx; temp _ in data; gvar _K256 kv)
SEP (field_at Tsh t_struct_SHA256state_st [StructField _h]
(map Vint (hash_blocks init_registers hashed)) ctx;
data_block sh (intlist_to_Zlist b) data;
K_vector kv)
POST [ tvoid ]
PROP() LOCAL()
SEP(field_at Tsh t_struct_SHA256state_st [StructField _h]
(map Vint (hash_blocks init_registers (hashed++b))) ctx;
data_block sh (intlist_to_Zlist b) data;
K_vector kv).

Definition SHA256_addlength_spec :=
DECLARE _SHA256_addlength
WITH len : Z, c: val, n: Z
PRE [ _c OF tptr t_struct_SHA256state_st , _len OF tuint ]
PROP ( 0 <= n+len∗8 < two_p 64; 0 <= len <= Int.max_unsigned; 0 <= n)
LOCAL (temp _len (Vint (Int.repr len)); temp _c c)
SEP (field_at Tsh t_struct_SHA256state_st [StructField _Nl] (Vint (lo_part n)) c;
field_at Tsh t_struct_SHA256state_st [StructField _Nh] (Vint (hi_part n)) c)
POST [ tvoid ]
PROP() LOCAL()
SEP (field_at Tsh t_struct_SHA256state_st [StructField _Nl] (Vint (lo_part (n+len∗8))) c;
field_at Tsh t_struct_SHA256state_st [StructField _Nh] (Vint (hi_part (n+len∗8))) c).

Definition SHA256_Init_spec :=
DECLARE _SHA256_Init
WITH c : val
PRE [ _c OF tptr t_struct_SHA256state_st ]
PROP () LOCAL (temp _c c)
SEP(data_at_ Tsh t_struct_SHA256state_st c)
POST [ tvoid ]
PROP() LOCAL() SEP(sha256state_ nil c).

Definition SHA256_Update_spec :=
DECLARE _SHA256_Update
WITH a: s256abs, data: list Z, c : val, d: val, sh: share, len : Z, kv : val
PRE [ _c OF tptr t_struct_SHA256state_st, _data_ OF tptr tvoid, _len OF tuint ]
PROP (readable_share sh; len <= Zlength data; 0 <= len <= Int.max_unsigned;
(s256a_len a + len ∗ 8 < two_p 64)%Z)
LOCAL (temp _c c; temp _data_ d; temp _len (Vint (Int.repr len)); gvar _K256 kv)
SEP(K_vector kv; sha256state_ a c; data_block sh data d)
POST [ tvoid ]
PROP () LOCAL ()
SEP(K_vector kv;
sha256state_ (a ++ sublist 0 len data) c;
data_block sh data d).

Definition SHA256_Final _spec :=
DECLARE _SHA256_Final
WITH a: s256abs, md: val, c : val, shmd: share, kv : val
PRE [ _md OF tptr tuchar, _c OF tptr t_struct_SHA256state_st ]
PROP (writable_share shmd)
LOCAL (temp _md md; temp _c c; gvar _K256 kv)
SEP(K_vector kv; sha256state_ a c; memory_block shmd 32 md)
POST [ tvoid ]
PROP () LOCAL ()
SEP(K_vector kv; data_at_ Tsh t_struct_SHA256state_st c;
data_block shmd (SHA_256 a) md).

Definition SHA256_spec :=
DECLARE _SHA256
WITH d: val, len: Z, dsh: share, msh: share, data: list Z, md: val, kv : val
PRE [ _d OF tptr tuchar, _n OF tuint, _md OF tptr tuchar ]
PROP (readable_share dsh; writable_share msh; Zlength data ∗ 8 < two_p 64;
Zlength data <= Int.max_unsigned)
LOCAL (temp _d d; temp _n (Vint (Int.repr (Zlength data)));
temp _md md; gvar _K256 kv)
SEP(K_vector kv; data_block dsh data d; memory_block msh 32 md)
POST [ tvoid ]
PROP () LOCAL ()
SEP(K_vector kv; data_block dsh data d; data_block msh (SHA_256 data) md).
