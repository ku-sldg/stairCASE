From Coq Require Import String List ZArith.
From compcert Require Import Coqlib Integers Floats AST Ctypes Cop Clight Clightdefs.
Local Open Scope Z_scope.

Definition ___builtin_ais_annot : ident := 7%positive.
Definition ___builtin_annot : ident := 14%positive.
Definition ___builtin_annot_intval : ident := 15%positive.
Definition ___builtin_bswap : ident := 8%positive.
Definition ___builtin_bswap16 : ident := 10%positive.
Definition ___builtin_bswap32 : ident := 9%positive.
Definition ___builtin_bswap64 : ident := 40%positive.
Definition ___builtin_clz : ident := 41%positive.
Definition ___builtin_clzl : ident := 42%positive.
Definition ___builtin_clzll : ident := 43%positive.
Definition ___builtin_ctz : ident := 44%positive.
Definition ___builtin_ctzl : ident := 45%positive.
Definition ___builtin_ctzll : ident := 46%positive.
Definition ___builtin_debug : ident := 58%positive.
Definition ___builtin_fabs : ident := 11%positive.
Definition ___builtin_fmadd : ident := 49%positive.
Definition ___builtin_fmax : ident := 47%positive.
Definition ___builtin_fmin : ident := 48%positive.
Definition ___builtin_fmsub : ident := 50%positive.
Definition ___builtin_fnmadd : ident := 51%positive.
Definition ___builtin_fnmsub : ident := 52%positive.
Definition ___builtin_fsqrt : ident := 12%positive.
Definition ___builtin_membar : ident := 16%positive.
Definition ___builtin_memcpy_aligned : ident := 13%positive.
Definition ___builtin_nop : ident := 57%positive.
Definition ___builtin_read16_reversed : ident := 53%positive.
Definition ___builtin_read32_reversed : ident := 54%positive.
Definition ___builtin_va_arg : ident := 18%positive.
Definition ___builtin_va_copy : ident := 19%positive.
Definition ___builtin_va_end : ident := 20%positive.
Definition ___builtin_va_start : ident := 17%positive.
Definition ___builtin_write16_reversed : ident := 55%positive.
Definition ___builtin_write32_reversed : ident := 56%positive.
Definition ___compcert_i64_dtos : ident := 25%positive.
Definition ___compcert_i64_dtou : ident := 26%positive.
Definition ___compcert_i64_sar : ident := 37%positive.
Definition ___compcert_i64_sdiv : ident := 31%positive.
Definition ___compcert_i64_shl : ident := 35%positive.
Definition ___compcert_i64_shr : ident := 36%positive.
Definition ___compcert_i64_smod : ident := 33%positive.
Definition ___compcert_i64_smulh : ident := 38%positive.
Definition ___compcert_i64_stod : ident := 27%positive.
Definition ___compcert_i64_stof : ident := 29%positive.
Definition ___compcert_i64_udiv : ident := 32%positive.
Definition ___compcert_i64_umod : ident := 34%positive.
Definition ___compcert_i64_umulh : ident := 39%positive.
Definition ___compcert_i64_utod : ident := 28%positive.
Definition ___compcert_i64_utof : ident := 30%positive.
Definition ___compcert_va_composite : ident := 24%positive.
Definition ___compcert_va_float64 : ident := 23%positive.
Definition ___compcert_va_int32 : ident := 21%positive.
Definition ___compcert_va_int64 : ident := 22%positive.
Definition _ah : ident := 76%positive.
Definition _buffer_state : ident := 6%positive.
Definition _calc_chunk : ident := 72%positive.
Definition _calc_sha_256 : ident := 86%positive.
Definition _ch : ident := 81%positive.
Definition _chunk : ident := 68%positive.
Definition _count : ident := 63%positive.
Definition _h : ident := 74%positive.
Definition _hash : ident := 73%positive.
Definition _i : ident := 71%positive.
Definition _init_buf_state : ident := 67%positive.
Definition _input : ident := 66%positive.
Definition _j : ident := 75%positive.
Definition _k : ident := 61%positive.
Definition _left : ident := 70%positive.
Definition _len : ident := 2%positive.
Definition _main : ident := 87%positive.
Definition _maj : ident := 84%positive.
Definition _memcpy : ident := 59%positive.
Definition _memset : ident := 60%positive.
Definition _p : ident := 1%positive.
Definition _right_rot : ident := 64%positive.
Definition _s0 : ident := 78%positive.
Definition _s0__1 : ident := 83%positive.
Definition _s1 : ident := 79%positive.
Definition _s1__1 : ident := 80%positive.
Definition _single_one_delivered : ident := 4%positive.
Definition _space_in_chunk : ident := 69%positive.
Definition _state : ident := 65%positive.
Definition _temp1 : ident := 82%positive.
Definition _temp2 : ident := 85%positive.
Definition _total_len : ident := 3%positive.
Definition _total_len_delivered : ident := 5%positive.
Definition _value : ident := 62%positive.
Definition _w : ident := 77%positive.
Definition _t'1 : ident := 88%positive.
Definition _t'10 : ident := 97%positive.
Definition _t'11 : ident := 98%positive.
Definition _t'12 : ident := 99%positive.
Definition _t'13 : ident := 100%positive.
Definition _t'14 : ident := 101%positive.
Definition _t'15 : ident := 102%positive.
Definition _t'16 : ident := 103%positive.
Definition _t'17 : ident := 104%positive.
Definition _t'18 : ident := 105%positive.
Definition _t'19 : ident := 106%positive.
Definition _t'2 : ident := 89%positive.
Definition _t'20 : ident := 107%positive.
Definition _t'21 : ident := 108%positive.
Definition _t'22 : ident := 109%positive.
Definition _t'23 : ident := 110%positive.
Definition _t'24 : ident := 111%positive.
Definition _t'25 : ident := 112%positive.
Definition _t'26 : ident := 113%positive.
Definition _t'27 : ident := 114%positive.
Definition _t'28 : ident := 115%positive.
Definition _t'29 : ident := 116%positive.
Definition _t'3 : ident := 90%positive.
Definition _t'30 : ident := 117%positive.
Definition _t'31 : ident := 118%positive.
Definition _t'32 : ident := 119%positive.
Definition _t'33 : ident := 120%positive.
Definition _t'34 : ident := 121%positive.
Definition _t'35 : ident := 122%positive.
Definition _t'36 : ident := 123%positive.
Definition _t'37 : ident := 124%positive.
Definition _t'38 : ident := 125%positive.
Definition _t'39 : ident := 126%positive.
Definition _t'4 : ident := 91%positive.
Definition _t'40 : ident := 127%positive.
Definition _t'41 : ident := 128%positive.
Definition _t'42 : ident := 129%positive.
Definition _t'43 : ident := 130%positive.
Definition _t'44 : ident := 131%positive.
Definition _t'45 : ident := 132%positive.
Definition _t'46 : ident := 133%positive.
Definition _t'47 : ident := 134%positive.
Definition _t'48 : ident := 135%positive.
Definition _t'49 : ident := 136%positive.
Definition _t'5 : ident := 92%positive.
Definition _t'50 : ident := 137%positive.
Definition _t'51 : ident := 138%positive.
Definition _t'52 : ident := 139%positive.
Definition _t'53 : ident := 140%positive.
Definition _t'54 : ident := 141%positive.
Definition _t'55 : ident := 142%positive.
Definition _t'56 : ident := 143%positive.
Definition _t'57 : ident := 144%positive.
Definition _t'58 : ident := 145%positive.
Definition _t'59 : ident := 146%positive.
Definition _t'6 : ident := 93%positive.
Definition _t'60 : ident := 147%positive.
Definition _t'7 : ident := 94%positive.
Definition _t'8 : ident := 95%positive.
Definition _t'9 : ident := 96%positive.

Definition v_k := {|
  gvar_info := (tarray tuint 64);
  gvar_init := (Init_int32 (Int.repr 1116352408) ::
                Init_int32 (Int.repr 1899447441) ::
                Init_int32 (Int.repr (-1245643825)) ::
                Init_int32 (Int.repr (-373957723)) ::
                Init_int32 (Int.repr 961987163) ::
                Init_int32 (Int.repr 1508970993) ::
                Init_int32 (Int.repr (-1841331548)) ::
                Init_int32 (Int.repr (-1424204075)) ::
                Init_int32 (Int.repr (-670586216)) ::
                Init_int32 (Int.repr 310598401) ::
                Init_int32 (Int.repr 607225278) ::
                Init_int32 (Int.repr 1426881987) ::
                Init_int32 (Int.repr 1925078388) ::
                Init_int32 (Int.repr (-2132889090)) ::
                Init_int32 (Int.repr (-1680079193)) ::
                Init_int32 (Int.repr (-1046744716)) ::
                Init_int32 (Int.repr (-459576895)) ::
                Init_int32 (Int.repr (-272742522)) ::
                Init_int32 (Int.repr 264347078) ::
                Init_int32 (Int.repr 604807628) ::
                Init_int32 (Int.repr 770255983) ::
                Init_int32 (Int.repr 1249150122) ::
                Init_int32 (Int.repr 1555081692) ::
                Init_int32 (Int.repr 1996064986) ::
                Init_int32 (Int.repr (-1740746414)) ::
                Init_int32 (Int.repr (-1473132947)) ::
                Init_int32 (Int.repr (-1341970488)) ::
                Init_int32 (Int.repr (-1084653625)) ::
                Init_int32 (Int.repr (-958395405)) ::
                Init_int32 (Int.repr (-710438585)) ::
                Init_int32 (Int.repr 113926993) ::
                Init_int32 (Int.repr 338241895) ::
                Init_int32 (Int.repr 666307205) ::
                Init_int32 (Int.repr 773529912) ::
                Init_int32 (Int.repr 1294757372) ::
                Init_int32 (Int.repr 1396182291) ::
                Init_int32 (Int.repr 1695183700) ::
                Init_int32 (Int.repr 1986661051) ::
                Init_int32 (Int.repr (-2117940946)) ::
                Init_int32 (Int.repr (-1838011259)) ::
                Init_int32 (Int.repr (-1564481375)) ::
                Init_int32 (Int.repr (-1474664885)) ::
                Init_int32 (Int.repr (-1035236496)) ::
                Init_int32 (Int.repr (-949202525)) ::
                Init_int32 (Int.repr (-778901479)) ::
                Init_int32 (Int.repr (-694614492)) ::
                Init_int32 (Int.repr (-200395387)) ::
                Init_int32 (Int.repr 275423344) ::
                Init_int32 (Int.repr 430227734) ::
                Init_int32 (Int.repr 506948616) ::
                Init_int32 (Int.repr 659060556) ::
                Init_int32 (Int.repr 883997877) ::
                Init_int32 (Int.repr 958139571) ::
                Init_int32 (Int.repr 1322822218) ::
                Init_int32 (Int.repr 1537002063) ::
                Init_int32 (Int.repr 1747873779) ::
                Init_int32 (Int.repr 1955562222) ::
                Init_int32 (Int.repr 2024104815) ::
                Init_int32 (Int.repr (-2067236844)) ::
                Init_int32 (Int.repr (-1933114872)) ::
                Init_int32 (Int.repr (-1866530822)) ::
                Init_int32 (Int.repr (-1538233109)) ::
                Init_int32 (Int.repr (-1090935817)) ::
                Init_int32 (Int.repr (-965641998)) :: nil);
  gvar_readonly := true;
  gvar_volatile := false
|}.

Definition f_right_rot := {|
  fn_return := tuint;
  fn_callconv := cc_default;
  fn_params := ((_value, tuint) :: (_count, tuint) :: nil);
  fn_vars := nil;
  fn_temps := nil;
  fn_body :=
(Sreturn (Some (Ebinop Oor
                 (Ebinop Oshr (Etempvar _value tuint) (Etempvar _count tuint)
                   tuint)
                 (Ebinop Oshl (Etempvar _value tuint)
                   (Ebinop Osub (Econst_int (Int.repr 32) tint)
                     (Etempvar _count tuint) tuint) tuint) tuint)))
|}.

Definition f_init_buf_state := {|
  fn_return := tvoid;
  fn_callconv := cc_default;
  fn_params := ((_state, (tptr (Tstruct _buffer_state noattr))) ::
                (_input, (tptr tvoid)) :: (_len, tuint) :: nil);
  fn_vars := nil;
  fn_temps := nil;
  fn_body :=
(Ssequence
  (Sassign
    (Efield
      (Ederef (Etempvar _state (tptr (Tstruct _buffer_state noattr)))
        (Tstruct _buffer_state noattr)) _p (tptr tuchar))
    (Etempvar _input (tptr tvoid)))
  (Ssequence
    (Sassign
      (Efield
        (Ederef (Etempvar _state (tptr (Tstruct _buffer_state noattr)))
          (Tstruct _buffer_state noattr)) _len tuint) (Etempvar _len tuint))
    (Ssequence
      (Sassign
        (Efield
          (Ederef (Etempvar _state (tptr (Tstruct _buffer_state noattr)))
            (Tstruct _buffer_state noattr)) _total_len tuint)
        (Etempvar _len tuint))
      (Ssequence
        (Sassign
          (Efield
            (Ederef (Etempvar _state (tptr (Tstruct _buffer_state noattr)))
              (Tstruct _buffer_state noattr)) _single_one_delivered tint)
          (Econst_int (Int.repr 0) tint))
        (Sassign
          (Efield
            (Ederef (Etempvar _state (tptr (Tstruct _buffer_state noattr)))
              (Tstruct _buffer_state noattr)) _total_len_delivered tint)
          (Econst_int (Int.repr 0) tint))))))
|}.

Definition f_calc_chunk := {|
  fn_return := tint;
  fn_callconv := cc_default;
  fn_params := ((_chunk, (tptr tuchar)) ::
                (_state, (tptr (Tstruct _buffer_state noattr))) :: nil);
  fn_vars := nil;
  fn_temps := ((_space_in_chunk, tuint) :: (_left, tuint) :: (_len, tuint) ::
               (_i, tint) :: (_t'1, (tptr tuchar)) :: (_t'13, tint) ::
               (_t'12, (tptr tuchar)) :: (_t'11, (tptr tuchar)) ::
               (_t'10, tuint) :: (_t'9, tuint) :: (_t'8, tuint) ::
               (_t'7, (tptr tuchar)) :: (_t'6, tuint) :: (_t'5, tuint) ::
               (_t'4, tuint) :: (_t'3, (tptr tuchar)) :: (_t'2, tint) :: nil);
  fn_body :=
(Ssequence
  (Ssequence
    (Sset _t'13
      (Efield
        (Ederef (Etempvar _state (tptr (Tstruct _buffer_state noattr)))
          (Tstruct _buffer_state noattr)) _total_len_delivered tint))
    (Sifthenelse (Etempvar _t'13 tint)
      (Sreturn (Some (Econst_int (Int.repr 0) tint)))
      Sskip))
  (Ssequence
    (Ssequence
      (Sset _t'9
        (Efield
          (Ederef (Etempvar _state (tptr (Tstruct _buffer_state noattr)))
            (Tstruct _buffer_state noattr)) _len tuint))
      (Sifthenelse (Ebinop Oge (Etempvar _t'9 tuint)
                     (Econst_int (Int.repr 64) tint) tint)
        (Ssequence
          (Ssequence
            (Sset _t'12
              (Efield
                (Ederef
                  (Etempvar _state (tptr (Tstruct _buffer_state noattr)))
                  (Tstruct _buffer_state noattr)) _p (tptr tuchar)))
            (Scall None
              (Evar _memcpy (Tfunction
                              (Tcons (tptr tvoid)
                                (Tcons (tptr tvoid) (Tcons tuint Tnil)))
                              (tptr tvoid) cc_default))
              ((Etempvar _chunk (tptr tuchar)) ::
               (Etempvar _t'12 (tptr tuchar)) ::
               (Econst_int (Int.repr 64) tint) :: nil)))
          (Ssequence
            (Ssequence
              (Sset _t'11
                (Efield
                  (Ederef
                    (Etempvar _state (tptr (Tstruct _buffer_state noattr)))
                    (Tstruct _buffer_state noattr)) _p (tptr tuchar)))
              (Sassign
                (Efield
                  (Ederef
                    (Etempvar _state (tptr (Tstruct _buffer_state noattr)))
                    (Tstruct _buffer_state noattr)) _p (tptr tuchar))
                (Ebinop Oadd (Etempvar _t'11 (tptr tuchar))
                  (Econst_int (Int.repr 64) tint) (tptr tuchar))))
            (Ssequence
              (Ssequence
                (Sset _t'10
                  (Efield
                    (Ederef
                      (Etempvar _state (tptr (Tstruct _buffer_state noattr)))
                      (Tstruct _buffer_state noattr)) _len tuint))
                (Sassign
                  (Efield
                    (Ederef
                      (Etempvar _state (tptr (Tstruct _buffer_state noattr)))
                      (Tstruct _buffer_state noattr)) _len tuint)
                  (Ebinop Osub (Etempvar _t'10 tuint)
                    (Econst_int (Int.repr 64) tint) tuint)))
              (Sreturn (Some (Econst_int (Int.repr 1) tint))))))
        Sskip))
    (Ssequence
      (Ssequence
        (Sset _t'7
          (Efield
            (Ederef (Etempvar _state (tptr (Tstruct _buffer_state noattr)))
              (Tstruct _buffer_state noattr)) _p (tptr tuchar)))
        (Ssequence
          (Sset _t'8
            (Efield
              (Ederef (Etempvar _state (tptr (Tstruct _buffer_state noattr)))
                (Tstruct _buffer_state noattr)) _len tuint))
          (Scall None
            (Evar _memcpy (Tfunction
                            (Tcons (tptr tvoid)
                              (Tcons (tptr tvoid) (Tcons tuint Tnil)))
                            (tptr tvoid) cc_default))
            ((Etempvar _chunk (tptr tuchar)) ::
             (Etempvar _t'7 (tptr tuchar)) :: (Etempvar _t'8 tuint) :: nil))))
      (Ssequence
        (Ssequence
          (Sset _t'6
            (Efield
              (Ederef (Etempvar _state (tptr (Tstruct _buffer_state noattr)))
                (Tstruct _buffer_state noattr)) _len tuint))
          (Sset _chunk
            (Ebinop Oadd (Etempvar _chunk (tptr tuchar))
              (Etempvar _t'6 tuint) (tptr tuchar))))
        (Ssequence
          (Ssequence
            (Sset _t'5
              (Efield
                (Ederef
                  (Etempvar _state (tptr (Tstruct _buffer_state noattr)))
                  (Tstruct _buffer_state noattr)) _len tuint))
            (Sset _space_in_chunk
              (Ebinop Osub (Econst_int (Int.repr 64) tint)
                (Etempvar _t'5 tuint) tuint)))
          (Ssequence
            (Ssequence
              (Sset _t'3
                (Efield
                  (Ederef
                    (Etempvar _state (tptr (Tstruct _buffer_state noattr)))
                    (Tstruct _buffer_state noattr)) _p (tptr tuchar)))
              (Ssequence
                (Sset _t'4
                  (Efield
                    (Ederef
                      (Etempvar _state (tptr (Tstruct _buffer_state noattr)))
                      (Tstruct _buffer_state noattr)) _len tuint))
                (Sassign
                  (Efield
                    (Ederef
                      (Etempvar _state (tptr (Tstruct _buffer_state noattr)))
                      (Tstruct _buffer_state noattr)) _p (tptr tuchar))
                  (Ebinop Oadd (Etempvar _t'3 (tptr tuchar))
                    (Etempvar _t'4 tuint) (tptr tuchar)))))
            (Ssequence
              (Sassign
                (Efield
                  (Ederef
                    (Etempvar _state (tptr (Tstruct _buffer_state noattr)))
                    (Tstruct _buffer_state noattr)) _len tuint)
                (Econst_int (Int.repr 0) tint))
              (Ssequence
                (Ssequence
                  (Sset _t'2
                    (Efield
                      (Ederef
                        (Etempvar _state (tptr (Tstruct _buffer_state noattr)))
                        (Tstruct _buffer_state noattr)) _single_one_delivered
                      tint))
                  (Sifthenelse (Eunop Onotbool (Etempvar _t'2 tint) tint)
                    (Ssequence
                      (Ssequence
                        (Ssequence
                          (Sset _t'1 (Etempvar _chunk (tptr tuchar)))
                          (Sset _chunk
                            (Ebinop Oadd (Etempvar _t'1 (tptr tuchar))
                              (Econst_int (Int.repr 1) tint) (tptr tuchar))))
                        (Sassign
                          (Ederef (Etempvar _t'1 (tptr tuchar)) tuchar)
                          (Econst_int (Int.repr 128) tint)))
                      (Ssequence
                        (Sset _space_in_chunk
                          (Ebinop Osub (Etempvar _space_in_chunk tuint)
                            (Econst_int (Int.repr 1) tint) tuint))
                        (Sassign
                          (Efield
                            (Ederef
                              (Etempvar _state (tptr (Tstruct _buffer_state noattr)))
                              (Tstruct _buffer_state noattr))
                            _single_one_delivered tint)
                          (Econst_int (Int.repr 1) tint))))
                    Sskip))
                (Ssequence
                  (Sifthenelse (Ebinop Oge (Etempvar _space_in_chunk tuint)
                                 (Econst_int (Int.repr 8) tint) tint)
                    (Ssequence
                      (Sset _left
                        (Ebinop Osub (Etempvar _space_in_chunk tuint)
                          (Econst_int (Int.repr 8) tint) tuint))
                      (Ssequence
                        (Sset _len
                          (Efield
                            (Ederef
                              (Etempvar _state (tptr (Tstruct _buffer_state noattr)))
                              (Tstruct _buffer_state noattr)) _total_len
                            tuint))
                        (Ssequence
                          (Scall None
                            (Evar _memset (Tfunction
                                            (Tcons (tptr tvoid)
                                              (Tcons tint (Tcons tuint Tnil)))
                                            (tptr tvoid) cc_default))
                            ((Etempvar _chunk (tptr tuchar)) ::
                             (Econst_int (Int.repr 0) tint) ::
                             (Etempvar _left tuint) :: nil))
                          (Ssequence
                            (Sset _chunk
                              (Ebinop Oadd (Etempvar _chunk (tptr tuchar))
                                (Etempvar _left tuint) (tptr tuchar)))
                            (Ssequence
                              (Sassign
                                (Ederef
                                  (Ebinop Oadd
                                    (Etempvar _chunk (tptr tuchar))
                                    (Econst_int (Int.repr 7) tint)
                                    (tptr tuchar)) tuchar)
                                (Ecast
                                  (Ebinop Oshl (Etempvar _len tuint)
                                    (Econst_int (Int.repr 3) tint) tuint)
                                  tuchar))
                              (Ssequence
                                (Sset _len
                                  (Ebinop Oshr (Etempvar _len tuint)
                                    (Econst_int (Int.repr 5) tint) tuint))
                                (Ssequence
                                  (Ssequence
                                    (Sset _i (Econst_int (Int.repr 6) tint))
                                    (Sloop
                                      (Ssequence
                                        (Sifthenelse (Ebinop Oge
                                                       (Etempvar _i tint)
                                                       (Econst_int (Int.repr 0) tint)
                                                       tint)
                                          Sskip
                                          Sbreak)
                                        (Ssequence
                                          (Sassign
                                            (Ederef
                                              (Ebinop Oadd
                                                (Etempvar _chunk (tptr tuchar))
                                                (Etempvar _i tint)
                                                (tptr tuchar)) tuchar)
                                            (Ecast (Etempvar _len tuint)
                                              tuchar))
                                          (Sset _len
                                            (Ebinop Oshr
                                              (Etempvar _len tuint)
                                              (Econst_int (Int.repr 8) tint)
                                              tuint))))
                                      (Sset _i
                                        (Ebinop Osub (Etempvar _i tint)
                                          (Econst_int (Int.repr 1) tint)
                                          tint))))
                                  (Sassign
                                    (Efield
                                      (Ederef
                                        (Etempvar _state (tptr (Tstruct _buffer_state noattr)))
                                        (Tstruct _buffer_state noattr))
                                      _total_len_delivered tint)
                                    (Econst_int (Int.repr 1) tint)))))))))
                    (Scall None
                      (Evar _memset (Tfunction
                                      (Tcons (tptr tvoid)
                                        (Tcons tint (Tcons tuint Tnil)))
                                      (tptr tvoid) cc_default))
                      ((Etempvar _chunk (tptr tuchar)) ::
                       (Econst_int (Int.repr 0) tint) ::
                       (Etempvar _space_in_chunk tuint) :: nil)))
                  (Sreturn (Some (Econst_int (Int.repr 1) tint))))))))))))
|}.

Definition f_calc_sha_256 := {|
  fn_return := tvoid;
  fn_callconv := cc_default;
  fn_params := ((_hash, (tptr tuchar)) :: (_input, (tptr tvoid)) ::
                (_len, tuint) :: nil);
  fn_vars := ((_h, (tarray tuint 8)) :: (_chunk, (tarray tuchar 64)) ::
              (_state, (Tstruct _buffer_state noattr)) ::
              (_ah, (tarray tuint 8)) :: (_w, (tarray tuint 64)) :: nil);
  fn_temps := ((_i, tint) :: (_j, tint) :: (_p, (tptr tuchar)) ::
               (_s0, tuint) :: (_s1, tuint) :: (_s1__1, tuint) ::
               (_ch, tuint) :: (_temp1, tuint) :: (_s0__1, tuint) ::
               (_maj, tuint) :: (_temp2, tuint) :: (_t'15, tint) ::
               (_t'14, tint) :: (_t'13, tint) :: (_t'12, tint) ::
               (_t'11, tuint) :: (_t'10, tuint) :: (_t'9, tuint) ::
               (_t'8, tuint) :: (_t'7, tuint) :: (_t'6, tuint) ::
               (_t'5, tuint) :: (_t'4, tuint) :: (_t'3, tuint) ::
               (_t'2, tuint) :: (_t'1, tint) :: (_t'60, tuchar) ::
               (_t'59, tuchar) :: (_t'58, tuchar) :: (_t'57, tuchar) ::
               (_t'56, tuint) :: (_t'55, tuint) :: (_t'54, tuint) ::
               (_t'53, tuint) :: (_t'52, tuint) :: (_t'51, tuint) ::
               (_t'50, tuint) :: (_t'49, tuint) :: (_t'48, tuint) ::
               (_t'47, tuint) :: (_t'46, tuint) :: (_t'45, tuint) ::
               (_t'44, tuint) :: (_t'43, tuint) :: (_t'42, tuint) ::
               (_t'41, tuint) :: (_t'40, tuint) :: (_t'39, tuint) ::
               (_t'38, tuint) :: (_t'37, tuint) :: (_t'36, tuint) ::
               (_t'35, tuint) :: (_t'34, tuint) :: (_t'33, tuint) ::
               (_t'32, tuint) :: (_t'31, tuint) :: (_t'30, tuint) ::
               (_t'29, tuint) :: (_t'28, tuint) :: (_t'27, tuint) ::
               (_t'26, tuint) :: (_t'25, tuint) :: (_t'24, tuint) ::
               (_t'23, tuint) :: (_t'22, tuint) :: (_t'21, tuint) ::
               (_t'20, tuint) :: (_t'19, tuint) :: (_t'18, tuint) ::
               (_t'17, tuint) :: (_t'16, tuint) :: nil);
  fn_body :=
(Ssequence
  (Sassign
    (Ederef
      (Ebinop Oadd (Evar _h (tarray tuint 8)) (Econst_int (Int.repr 0) tint)
        (tptr tuint)) tuint) (Econst_int (Int.repr 1779033703) tint))
  (Ssequence
    (Sassign
      (Ederef
        (Ebinop Oadd (Evar _h (tarray tuint 8))
          (Econst_int (Int.repr 1) tint) (tptr tuint)) tuint)
      (Econst_int (Int.repr (-1150833019)) tuint))
    (Ssequence
      (Sassign
        (Ederef
          (Ebinop Oadd (Evar _h (tarray tuint 8))
            (Econst_int (Int.repr 2) tint) (tptr tuint)) tuint)
        (Econst_int (Int.repr 1013904242) tint))
      (Ssequence
        (Sassign
          (Ederef
            (Ebinop Oadd (Evar _h (tarray tuint 8))
              (Econst_int (Int.repr 3) tint) (tptr tuint)) tuint)
          (Econst_int (Int.repr (-1521486534)) tuint))
        (Ssequence
          (Sassign
            (Ederef
              (Ebinop Oadd (Evar _h (tarray tuint 8))
                (Econst_int (Int.repr 4) tint) (tptr tuint)) tuint)
            (Econst_int (Int.repr 1359893119) tint))
          (Ssequence
            (Sassign
              (Ederef
                (Ebinop Oadd (Evar _h (tarray tuint 8))
                  (Econst_int (Int.repr 5) tint) (tptr tuint)) tuint)
              (Econst_int (Int.repr (-1694144372)) tuint))
            (Ssequence
              (Sassign
                (Ederef
                  (Ebinop Oadd (Evar _h (tarray tuint 8))
                    (Econst_int (Int.repr 6) tint) (tptr tuint)) tuint)
                (Econst_int (Int.repr 528734635) tint))
              (Ssequence
                (Sassign
                  (Ederef
                    (Ebinop Oadd (Evar _h (tarray tuint 8))
                      (Econst_int (Int.repr 7) tint) (tptr tuint)) tuint)
                  (Econst_int (Int.repr 1541459225) tint))
                (Ssequence
                  (Scall None
                    (Evar _init_buf_state (Tfunction
                                            (Tcons
                                              (tptr (Tstruct _buffer_state noattr))
                                              (Tcons (tptr tvoid)
                                                (Tcons tuint Tnil))) tvoid
                                            cc_default))
                    ((Eaddrof (Evar _state (Tstruct _buffer_state noattr))
                       (tptr (Tstruct _buffer_state noattr))) ::
                     (Etempvar _input (tptr tvoid)) ::
                     (Etempvar _len tuint) :: nil))
                  (Ssequence
                    (Sloop
                      (Ssequence
                        (Ssequence
                          (Scall (Some _t'1)
                            (Evar _calc_chunk (Tfunction
                                                (Tcons (tptr tuchar)
                                                  (Tcons
                                                    (tptr (Tstruct _buffer_state noattr))
                                                    Tnil)) tint cc_default))
                            ((Evar _chunk (tarray tuchar 64)) ::
                             (Eaddrof
                               (Evar _state (Tstruct _buffer_state noattr))
                               (tptr (Tstruct _buffer_state noattr))) :: nil))
                          (Sifthenelse (Etempvar _t'1 tint) Sskip Sbreak))
                        (Ssequence
                          (Sset _p (Evar _chunk (tarray tuchar 64)))
                          (Ssequence
                            (Scall None
                              (Evar _memset (Tfunction
                                              (Tcons (tptr tvoid)
                                                (Tcons tint
                                                  (Tcons tuint Tnil)))
                                              (tptr tvoid) cc_default))
                              ((Evar _w (tarray tuint 64)) ::
                               (Econst_int (Int.repr 0) tint) ::
                               (Esizeof (tarray tuint 64) tuint) :: nil))
                            (Ssequence
                              (Ssequence
                                (Sset _i (Econst_int (Int.repr 0) tint))
                                (Sloop
                                  (Ssequence
                                    (Sifthenelse (Ebinop Olt
                                                   (Etempvar _i tint)
                                                   (Econst_int (Int.repr 16) tint)
                                                   tint)
                                      Sskip
                                      Sbreak)
                                    (Ssequence
                                      (Ssequence
                                        (Sset _t'57
                                          (Ederef
                                            (Ebinop Oadd
                                              (Etempvar _p (tptr tuchar))
                                              (Econst_int (Int.repr 0) tint)
                                              (tptr tuchar)) tuchar))
                                        (Ssequence
                                          (Sset _t'58
                                            (Ederef
                                              (Ebinop Oadd
                                                (Etempvar _p (tptr tuchar))
                                                (Econst_int (Int.repr 1) tint)
                                                (tptr tuchar)) tuchar))
                                          (Ssequence
                                            (Sset _t'59
                                              (Ederef
                                                (Ebinop Oadd
                                                  (Etempvar _p (tptr tuchar))
                                                  (Econst_int (Int.repr 2) tint)
                                                  (tptr tuchar)) tuchar))
                                            (Ssequence
                                              (Sset _t'60
                                                (Ederef
                                                  (Ebinop Oadd
                                                    (Etempvar _p (tptr tuchar))
                                                    (Econst_int (Int.repr 3) tint)
                                                    (tptr tuchar)) tuchar))
                                              (Sassign
                                                (Ederef
                                                  (Ebinop Oadd
                                                    (Evar _w (tarray tuint 64))
                                                    (Etempvar _i tint)
                                                    (tptr tuint)) tuint)
                                                (Ebinop Oor
                                                  (Ebinop Oor
                                                    (Ebinop Oor
                                                      (Ebinop Oshl
                                                        (Ecast
                                                          (Etempvar _t'57 tuchar)
                                                          tuint)
                                                        (Econst_int (Int.repr 24) tint)
                                                        tuint)
                                                      (Ebinop Oshl
                                                        (Ecast
                                                          (Etempvar _t'58 tuchar)
                                                          tuint)
                                                        (Econst_int (Int.repr 16) tint)
                                                        tuint) tuint)
                                                    (Ebinop Oshl
                                                      (Ecast
                                                        (Etempvar _t'59 tuchar)
                                                        tuint)
                                                      (Econst_int (Int.repr 8) tint)
                                                      tuint) tuint)
                                                  (Ecast
                                                    (Etempvar _t'60 tuchar)
                                                    tuint) tuint))))))
                                      (Sset _p
                                        (Ebinop Oadd
                                          (Etempvar _p (tptr tuchar))
                                          (Econst_int (Int.repr 4) tint)
                                          (tptr tuchar)))))
                                  (Sset _i
                                    (Ebinop Oadd (Etempvar _i tint)
                                      (Econst_int (Int.repr 1) tint) tint))))
                              (Ssequence
                                (Ssequence
                                  (Sset _i (Econst_int (Int.repr 16) tint))
                                  (Sloop
                                    (Ssequence
                                      (Sifthenelse (Ebinop Olt
                                                     (Etempvar _i tint)
                                                     (Econst_int (Int.repr 64) tint)
                                                     tint)
                                        Sskip
                                        Sbreak)
                                      (Ssequence
                                        (Ssequence
                                          (Ssequence
                                            (Ssequence
                                              (Sset _t'56
                                                (Ederef
                                                  (Ebinop Oadd
                                                    (Evar _w (tarray tuint 64))
                                                    (Ebinop Osub
                                                      (Etempvar _i tint)
                                                      (Econst_int (Int.repr 15) tint)
                                                      tint) (tptr tuint))
                                                  tuint))
                                              (Scall (Some _t'2)
                                                (Evar _right_rot (Tfunction
                                                                   (Tcons
                                                                    tuint
                                                                    (Tcons
                                                                    tuint
                                                                    Tnil))
                                                                   tuint
                                                                   cc_default))
                                                ((Etempvar _t'56 tuint) ::
                                                 (Econst_int (Int.repr 7) tint) ::
                                                 nil)))
                                            (Ssequence
                                              (Sset _t'55
                                                (Ederef
                                                  (Ebinop Oadd
                                                    (Evar _w (tarray tuint 64))
                                                    (Ebinop Osub
                                                      (Etempvar _i tint)
                                                      (Econst_int (Int.repr 15) tint)
                                                      tint) (tptr tuint))
                                                  tuint))
                                              (Scall (Some _t'3)
                                                (Evar _right_rot (Tfunction
                                                                   (Tcons
                                                                    tuint
                                                                    (Tcons
                                                                    tuint
                                                                    Tnil))
                                                                   tuint
                                                                   cc_default))
                                                ((Etempvar _t'55 tuint) ::
                                                 (Econst_int (Int.repr 18) tint) ::
                                                 nil))))
                                          (Ssequence
                                            (Sset _t'54
                                              (Ederef
                                                (Ebinop Oadd
                                                  (Evar _w (tarray tuint 64))
                                                  (Ebinop Osub
                                                    (Etempvar _i tint)
                                                    (Econst_int (Int.repr 15) tint)
                                                    tint) (tptr tuint))
                                                tuint))
                                            (Sset _s0
                                              (Ebinop Oxor
                                                (Ebinop Oxor
                                                  (Etempvar _t'2 tuint)
                                                  (Etempvar _t'3 tuint)
                                                  tuint)
                                                (Ebinop Oshr
                                                  (Etempvar _t'54 tuint)
                                                  (Econst_int (Int.repr 3) tint)
                                                  tuint) tuint))))
                                        (Ssequence
                                          (Ssequence
                                            (Ssequence
                                              (Ssequence
                                                (Sset _t'53
                                                  (Ederef
                                                    (Ebinop Oadd
                                                      (Evar _w (tarray tuint 64))
                                                      (Ebinop Osub
                                                        (Etempvar _i tint)
                                                        (Econst_int (Int.repr 2) tint)
                                                        tint) (tptr tuint))
                                                    tuint))
                                                (Scall (Some _t'4)
                                                  (Evar _right_rot (Tfunction
                                                                    (Tcons
                                                                    tuint
                                                                    (Tcons
                                                                    tuint
                                                                    Tnil))
                                                                    tuint
                                                                    cc_default))
                                                  ((Etempvar _t'53 tuint) ::
                                                   (Econst_int (Int.repr 17) tint) ::
                                                   nil)))
                                              (Ssequence
                                                (Sset _t'52
                                                  (Ederef
                                                    (Ebinop Oadd
                                                      (Evar _w (tarray tuint 64))
                                                      (Ebinop Osub
                                                        (Etempvar _i tint)
                                                        (Econst_int (Int.repr 2) tint)
                                                        tint) (tptr tuint))
                                                    tuint))
                                                (Scall (Some _t'5)
                                                  (Evar _right_rot (Tfunction
                                                                    (Tcons
                                                                    tuint
                                                                    (Tcons
                                                                    tuint
                                                                    Tnil))
                                                                    tuint
                                                                    cc_default))
                                                  ((Etempvar _t'52 tuint) ::
                                                   (Econst_int (Int.repr 19) tint) ::
                                                   nil))))
                                            (Ssequence
                                              (Sset _t'51
                                                (Ederef
                                                  (Ebinop Oadd
                                                    (Evar _w (tarray tuint 64))
                                                    (Ebinop Osub
                                                      (Etempvar _i tint)
                                                      (Econst_int (Int.repr 2) tint)
                                                      tint) (tptr tuint))
                                                  tuint))
                                              (Sset _s1
                                                (Ebinop Oxor
                                                  (Ebinop Oxor
                                                    (Etempvar _t'4 tuint)
                                                    (Etempvar _t'5 tuint)
                                                    tuint)
                                                  (Ebinop Oshr
                                                    (Etempvar _t'51 tuint)
                                                    (Econst_int (Int.repr 10) tint)
                                                    tuint) tuint))))
                                          (Ssequence
                                            (Sset _t'49
                                              (Ederef
                                                (Ebinop Oadd
                                                  (Evar _w (tarray tuint 64))
                                                  (Ebinop Osub
                                                    (Etempvar _i tint)
                                                    (Econst_int (Int.repr 16) tint)
                                                    tint) (tptr tuint))
                                                tuint))
                                            (Ssequence
                                              (Sset _t'50
                                                (Ederef
                                                  (Ebinop Oadd
                                                    (Evar _w (tarray tuint 64))
                                                    (Ebinop Osub
                                                      (Etempvar _i tint)
                                                      (Econst_int (Int.repr 7) tint)
                                                      tint) (tptr tuint))
                                                  tuint))
                                              (Sassign
                                                (Ederef
                                                  (Ebinop Oadd
                                                    (Evar _w (tarray tuint 64))
                                                    (Etempvar _i tint)
                                                    (tptr tuint)) tuint)
                                                (Ebinop Oadd
                                                  (Ebinop Oadd
                                                    (Ebinop Oadd
                                                      (Etempvar _t'49 tuint)
                                                      (Etempvar _s0 tuint)
                                                      tuint)
                                                    (Etempvar _t'50 tuint)
                                                    tuint)
                                                  (Etempvar _s1 tuint) tuint)))))))
                                    (Sset _i
                                      (Ebinop Oadd (Etempvar _i tint)
                                        (Econst_int (Int.repr 1) tint) tint))))
                                (Ssequence
                                  (Ssequence
                                    (Sset _i (Econst_int (Int.repr 0) tint))
                                    (Sloop
                                      (Ssequence
                                        (Sifthenelse (Ebinop Olt
                                                       (Etempvar _i tint)
                                                       (Econst_int (Int.repr 8) tint)
                                                       tint)
                                          Sskip
                                          Sbreak)
                                        (Ssequence
                                          (Sset _t'48
                                            (Ederef
                                              (Ebinop Oadd
                                                (Evar _h (tarray tuint 8))
                                                (Etempvar _i tint)
                                                (tptr tuint)) tuint))
                                          (Sassign
                                            (Ederef
                                              (Ebinop Oadd
                                                (Evar _ah (tarray tuint 8))
                                                (Etempvar _i tint)
                                                (tptr tuint)) tuint)
                                            (Etempvar _t'48 tuint))))
                                      (Sset _i
                                        (Ebinop Oadd (Etempvar _i tint)
                                          (Econst_int (Int.repr 1) tint)
                                          tint))))
                                  (Ssequence
                                    (Ssequence
                                      (Sset _i
                                        (Econst_int (Int.repr 0) tint))
                                      (Sloop
                                        (Ssequence
                                          (Sifthenelse (Ebinop Olt
                                                         (Etempvar _i tint)
                                                         (Econst_int (Int.repr 64) tint)
                                                         tint)
                                            Sskip
                                            Sbreak)
                                          (Ssequence
                                            (Ssequence
                                              (Ssequence
                                                (Ssequence
                                                  (Ssequence
                                                    (Sset _t'47
                                                      (Ederef
                                                        (Ebinop Oadd
                                                          (Evar _ah (tarray tuint 8))
                                                          (Econst_int (Int.repr 4) tint)
                                                          (tptr tuint))
                                                        tuint))
                                                    (Scall (Some _t'6)
                                                      (Evar _right_rot 
                                                      (Tfunction
                                                        (Tcons tuint
                                                          (Tcons tuint Tnil))
                                                        tuint cc_default))
                                                      ((Etempvar _t'47 tuint) ::
                                                       (Econst_int (Int.repr 6) tint) ::
                                                       nil)))
                                                  (Ssequence
                                                    (Sset _t'46
                                                      (Ederef
                                                        (Ebinop Oadd
                                                          (Evar _ah (tarray tuint 8))
                                                          (Econst_int (Int.repr 4) tint)
                                                          (tptr tuint))
                                                        tuint))
                                                    (Scall (Some _t'7)
                                                      (Evar _right_rot 
                                                      (Tfunction
                                                        (Tcons tuint
                                                          (Tcons tuint Tnil))
                                                        tuint cc_default))
                                                      ((Etempvar _t'46 tuint) ::
                                                       (Econst_int (Int.repr 11) tint) ::
                                                       nil))))
                                                (Ssequence
                                                  (Sset _t'45
                                                    (Ederef
                                                      (Ebinop Oadd
                                                        (Evar _ah (tarray tuint 8))
                                                        (Econst_int (Int.repr 4) tint)
                                                        (tptr tuint)) tuint))
                                                  (Scall (Some _t'8)
                                                    (Evar _right_rot 
                                                    (Tfunction
                                                      (Tcons tuint
                                                        (Tcons tuint Tnil))
                                                      tuint cc_default))
                                                    ((Etempvar _t'45 tuint) ::
                                                     (Econst_int (Int.repr 25) tint) ::
                                                     nil))))
                                              (Sset _s1__1
                                                (Ebinop Oxor
                                                  (Ebinop Oxor
                                                    (Etempvar _t'6 tuint)
                                                    (Etempvar _t'7 tuint)
                                                    tuint)
                                                  (Etempvar _t'8 tuint)
                                                  tuint)))
                                            (Ssequence
                                              (Ssequence
                                                (Sset _t'41
                                                  (Ederef
                                                    (Ebinop Oadd
                                                      (Evar _ah (tarray tuint 8))
                                                      (Econst_int (Int.repr 4) tint)
                                                      (tptr tuint)) tuint))
                                                (Ssequence
                                                  (Sset _t'42
                                                    (Ederef
                                                      (Ebinop Oadd
                                                        (Evar _ah (tarray tuint 8))
                                                        (Econst_int (Int.repr 5) tint)
                                                        (tptr tuint)) tuint))
                                                  (Ssequence
                                                    (Sset _t'43
                                                      (Ederef
                                                        (Ebinop Oadd
                                                          (Evar _ah (tarray tuint 8))
                                                          (Econst_int (Int.repr 4) tint)
                                                          (tptr tuint))
                                                        tuint))
                                                    (Ssequence
                                                      (Sset _t'44
                                                        (Ederef
                                                          (Ebinop Oadd
                                                            (Evar _ah (tarray tuint 8))
                                                            (Econst_int (Int.repr 6) tint)
                                                            (tptr tuint))
                                                          tuint))
                                                      (Sset _ch
                                                        (Ebinop Oxor
                                                          (Ebinop Oand
                                                            (Etempvar _t'41 tuint)
                                                            (Etempvar _t'42 tuint)
                                                            tuint)
                                                          (Ebinop Oand
                                                            (Eunop Onotint
                                                              (Etempvar _t'43 tuint)
                                                              tuint)
                                                            (Etempvar _t'44 tuint)
                                                            tuint) tuint))))))
                                              (Ssequence
                                                (Ssequence
                                                  (Sset _t'38
                                                    (Ederef
                                                      (Ebinop Oadd
                                                        (Evar _ah (tarray tuint 8))
                                                        (Econst_int (Int.repr 7) tint)
                                                        (tptr tuint)) tuint))
                                                  (Ssequence
                                                    (Sset _t'39
                                                      (Ederef
                                                        (Ebinop Oadd
                                                          (Evar _k (tarray tuint 64))
                                                          (Etempvar _i tint)
                                                          (tptr tuint))
                                                        tuint))
                                                    (Ssequence
                                                      (Sset _t'40
                                                        (Ederef
                                                          (Ebinop Oadd
                                                            (Evar _w (tarray tuint 64))
                                                            (Etempvar _i tint)
                                                            (tptr tuint))
                                                          tuint))
                                                      (Sset _temp1
                                                        (Ebinop Oadd
                                                          (Ebinop Oadd
                                                            (Ebinop Oadd
                                                              (Ebinop Oadd
                                                                (Etempvar _t'38 tuint)
                                                                (Etempvar _s1__1 tuint)
                                                                tuint)
                                                              (Etempvar _ch tuint)
                                                              tuint)
                                                            (Etempvar _t'39 tuint)
                                                            tuint)
                                                          (Etempvar _t'40 tuint)
                                                          tuint)))))
                                                (Ssequence
                                                  (Ssequence
                                                    (Ssequence
                                                      (Ssequence
                                                        (Ssequence
                                                          (Sset _t'37
                                                            (Ederef
                                                              (Ebinop Oadd
                                                                (Evar _ah (tarray tuint 8))
                                                                (Econst_int (Int.repr 0) tint)
                                                                (tptr tuint))
                                                              tuint))
                                                          (Scall (Some _t'9)
                                                            (Evar _right_rot 
                                                            (Tfunction
                                                              (Tcons tuint
                                                                (Tcons tuint
                                                                  Tnil))
                                                              tuint
                                                              cc_default))
                                                            ((Etempvar _t'37 tuint) ::
                                                             (Econst_int (Int.repr 2) tint) ::
                                                             nil)))
                                                        (Ssequence
                                                          (Sset _t'36
                                                            (Ederef
                                                              (Ebinop Oadd
                                                                (Evar _ah (tarray tuint 8))
                                                                (Econst_int (Int.repr 0) tint)
                                                                (tptr tuint))
                                                              tuint))
                                                          (Scall (Some _t'10)
                                                            (Evar _right_rot 
                                                            (Tfunction
                                                              (Tcons tuint
                                                                (Tcons tuint
                                                                  Tnil))
                                                              tuint
                                                              cc_default))
                                                            ((Etempvar _t'36 tuint) ::
                                                             (Econst_int (Int.repr 13) tint) ::
                                                             nil))))
                                                      (Ssequence
                                                        (Sset _t'35
                                                          (Ederef
                                                            (Ebinop Oadd
                                                              (Evar _ah (tarray tuint 8))
                                                              (Econst_int (Int.repr 0) tint)
                                                              (tptr tuint))
                                                            tuint))
                                                        (Scall (Some _t'11)
                                                          (Evar _right_rot 
                                                          (Tfunction
                                                            (Tcons tuint
                                                              (Tcons tuint
                                                                Tnil)) tuint
                                                            cc_default))
                                                          ((Etempvar _t'35 tuint) ::
                                                           (Econst_int (Int.repr 22) tint) ::
                                                           nil))))
                                                    (Sset _s0__1
                                                      (Ebinop Oxor
                                                        (Ebinop Oxor
                                                          (Etempvar _t'9 tuint)
                                                          (Etempvar _t'10 tuint)
                                                          tuint)
                                                        (Etempvar _t'11 tuint)
                                                        tuint)))
                                                  (Ssequence
                                                    (Ssequence
                                                      (Sset _t'29
                                                        (Ederef
                                                          (Ebinop Oadd
                                                            (Evar _ah (tarray tuint 8))
                                                            (Econst_int (Int.repr 0) tint)
                                                            (tptr tuint))
                                                          tuint))
                                                      (Ssequence
                                                        (Sset _t'30
                                                          (Ederef
                                                            (Ebinop Oadd
                                                              (Evar _ah (tarray tuint 8))
                                                              (Econst_int (Int.repr 1) tint)
                                                              (tptr tuint))
                                                            tuint))
                                                        (Ssequence
                                                          (Sset _t'31
                                                            (Ederef
                                                              (Ebinop Oadd
                                                                (Evar _ah (tarray tuint 8))
                                                                (Econst_int (Int.repr 0) tint)
                                                                (tptr tuint))
                                                              tuint))
                                                          (Ssequence
                                                            (Sset _t'32
                                                              (Ederef
                                                                (Ebinop Oadd
                                                                  (Evar _ah (tarray tuint 8))
                                                                  (Econst_int (Int.repr 2) tint)
                                                                  (tptr tuint))
                                                                tuint))
                                                            (Ssequence
                                                              (Sset _t'33
                                                                (Ederef
                                                                  (Ebinop Oadd
                                                                    (Evar _ah (tarray tuint 8))
                                                                    (Econst_int (Int.repr 1) tint)
                                                                    (tptr tuint))
                                                                  tuint))
                                                              (Ssequence
                                                                (Sset _t'34
                                                                  (Ederef
                                                                    (Ebinop Oadd
                                                                    (Evar _ah (tarray tuint 8))
                                                                    (Econst_int (Int.repr 2) tint)
                                                                    (tptr tuint))
                                                                    tuint))
                                                                (Sset _maj
                                                                  (Ebinop Oxor
                                                                    (Ebinop Oxor
                                                                    (Ebinop Oand
                                                                    (Etempvar _t'29 tuint)
                                                                    (Etempvar _t'30 tuint)
                                                                    tuint)
                                                                    (Ebinop Oand
                                                                    (Etempvar _t'31 tuint)
                                                                    (Etempvar _t'32 tuint)
                                                                    tuint)
                                                                    tuint)
                                                                    (Ebinop Oand
                                                                    (Etempvar _t'33 tuint)
                                                                    (Etempvar _t'34 tuint)
                                                                    tuint)
                                                                    tuint))))))))
                                                    (Ssequence
                                                      (Sset _temp2
                                                        (Ebinop Oadd
                                                          (Etempvar _s0__1 tuint)
                                                          (Etempvar _maj tuint)
                                                          tuint))
                                                      (Ssequence
                                                        (Ssequence
                                                          (Sset _t'28
                                                            (Ederef
                                                              (Ebinop Oadd
                                                                (Evar _ah (tarray tuint 8))
                                                                (Econst_int (Int.repr 6) tint)
                                                                (tptr tuint))
                                                              tuint))
                                                          (Sassign
                                                            (Ederef
                                                              (Ebinop Oadd
                                                                (Evar _ah (tarray tuint 8))
                                                                (Econst_int (Int.repr 7) tint)
                                                                (tptr tuint))
                                                              tuint)
                                                            (Etempvar _t'28 tuint)))
                                                        (Ssequence
                                                          (Ssequence
                                                            (Sset _t'27
                                                              (Ederef
                                                                (Ebinop Oadd
                                                                  (Evar _ah (tarray tuint 8))
                                                                  (Econst_int (Int.repr 5) tint)
                                                                  (tptr tuint))
                                                                tuint))
                                                            (Sassign
                                                              (Ederef
                                                                (Ebinop Oadd
                                                                  (Evar _ah (tarray tuint 8))
                                                                  (Econst_int (Int.repr 6) tint)
                                                                  (tptr tuint))
                                                                tuint)
                                                              (Etempvar _t'27 tuint)))
                                                          (Ssequence
                                                            (Ssequence
                                                              (Sset _t'26
                                                                (Ederef
                                                                  (Ebinop Oadd
                                                                    (Evar _ah (tarray tuint 8))
                                                                    (Econst_int (Int.repr 4) tint)
                                                                    (tptr tuint))
                                                                  tuint))
                                                              (Sassign
                                                                (Ederef
                                                                  (Ebinop Oadd
                                                                    (Evar _ah (tarray tuint 8))
                                                                    (Econst_int (Int.repr 5) tint)
                                                                    (tptr tuint))
                                                                  tuint)
                                                                (Etempvar _t'26 tuint)))
                                                            (Ssequence
                                                              (Ssequence
                                                                (Sset _t'25
                                                                  (Ederef
                                                                    (Ebinop Oadd
                                                                    (Evar _ah (tarray tuint 8))
                                                                    (Econst_int (Int.repr 3) tint)
                                                                    (tptr tuint))
                                                                    tuint))
                                                                (Sassign
                                                                  (Ederef
                                                                    (Ebinop Oadd
                                                                    (Evar _ah (tarray tuint 8))
                                                                    (Econst_int (Int.repr 4) tint)
                                                                    (tptr tuint))
                                                                    tuint)
                                                                  (Ebinop Oadd
                                                                    (Etempvar _t'25 tuint)
                                                                    (Etempvar _temp1 tuint)
                                                                    tuint)))
                                                              (Ssequence
                                                                (Ssequence
                                                                  (Sset _t'24
                                                                    (Ederef
                                                                    (Ebinop Oadd
                                                                    (Evar _ah (tarray tuint 8))
                                                                    (Econst_int (Int.repr 2) tint)
                                                                    (tptr tuint))
                                                                    tuint))
                                                                  (Sassign
                                                                    (Ederef
                                                                    (Ebinop Oadd
                                                                    (Evar _ah (tarray tuint 8))
                                                                    (Econst_int (Int.repr 3) tint)
                                                                    (tptr tuint))
                                                                    tuint)
                                                                    (Etempvar _t'24 tuint)))
                                                                (Ssequence
                                                                  (Ssequence
                                                                    (Sset _t'23
                                                                    (Ederef
                                                                    (Ebinop Oadd
                                                                    (Evar _ah (tarray tuint 8))
                                                                    (Econst_int (Int.repr 1) tint)
                                                                    (tptr tuint))
                                                                    tuint))
                                                                    (Sassign
                                                                    (Ederef
                                                                    (Ebinop Oadd
                                                                    (Evar _ah (tarray tuint 8))
                                                                    (Econst_int (Int.repr 2) tint)
                                                                    (tptr tuint))
                                                                    tuint)
                                                                    (Etempvar _t'23 tuint)))
                                                                  (Ssequence
                                                                    (Ssequence
                                                                    (Sset _t'22
                                                                    (Ederef
                                                                    (Ebinop Oadd
                                                                    (Evar _ah (tarray tuint 8))
                                                                    (Econst_int (Int.repr 0) tint)
                                                                    (tptr tuint))
                                                                    tuint))
                                                                    (Sassign
                                                                    (Ederef
                                                                    (Ebinop Oadd
                                                                    (Evar _ah (tarray tuint 8))
                                                                    (Econst_int (Int.repr 1) tint)
                                                                    (tptr tuint))
                                                                    tuint)
                                                                    (Etempvar _t'22 tuint)))
                                                                    (Sassign
                                                                    (Ederef
                                                                    (Ebinop Oadd
                                                                    (Evar _ah (tarray tuint 8))
                                                                    (Econst_int (Int.repr 0) tint)
                                                                    (tptr tuint))
                                                                    tuint)
                                                                    (Ebinop Oadd
                                                                    (Etempvar _temp1 tuint)
                                                                    (Etempvar _temp2 tuint)
                                                                    tuint))))))))))))))))
                                        (Sset _i
                                          (Ebinop Oadd (Etempvar _i tint)
                                            (Econst_int (Int.repr 1) tint)
                                            tint))))
                                    (Ssequence
                                      (Sset _i
                                        (Econst_int (Int.repr 0) tint))
                                      (Sloop
                                        (Ssequence
                                          (Sifthenelse (Ebinop Olt
                                                         (Etempvar _i tint)
                                                         (Econst_int (Int.repr 8) tint)
                                                         tint)
                                            Sskip
                                            Sbreak)
                                          (Ssequence
                                            (Sset _t'20
                                              (Ederef
                                                (Ebinop Oadd
                                                  (Evar _h (tarray tuint 8))
                                                  (Etempvar _i tint)
                                                  (tptr tuint)) tuint))
                                            (Ssequence
                                              (Sset _t'21
                                                (Ederef
                                                  (Ebinop Oadd
                                                    (Evar _ah (tarray tuint 8))
                                                    (Etempvar _i tint)
                                                    (tptr tuint)) tuint))
                                              (Sassign
                                                (Ederef
                                                  (Ebinop Oadd
                                                    (Evar _h (tarray tuint 8))
                                                    (Etempvar _i tint)
                                                    (tptr tuint)) tuint)
                                                (Ebinop Oadd
                                                  (Etempvar _t'20 tuint)
                                                  (Etempvar _t'21 tuint)
                                                  tuint)))))
                                        (Sset _i
                                          (Ebinop Oadd (Etempvar _i tint)
                                            (Econst_int (Int.repr 1) tint)
                                            tint)))))))))))
                      Sskip)
                    (Ssequence
                      (Ssequence
                        (Sset _i (Econst_int (Int.repr 0) tint))
                        (Sset _j (Econst_int (Int.repr 0) tint)))
                      (Sloop
                        (Ssequence
                          (Sifthenelse (Ebinop Olt (Etempvar _i tint)
                                         (Econst_int (Int.repr 8) tint) tint)
                            Sskip
                            Sbreak)
                          (Ssequence
                            (Ssequence
                              (Ssequence
                                (Sset _t'12 (Etempvar _j tint))
                                (Sset _j
                                  (Ebinop Oadd (Etempvar _t'12 tint)
                                    (Econst_int (Int.repr 1) tint) tint)))
                              (Ssequence
                                (Sset _t'19
                                  (Ederef
                                    (Ebinop Oadd (Evar _h (tarray tuint 8))
                                      (Etempvar _i tint) (tptr tuint)) tuint))
                                (Sassign
                                  (Ederef
                                    (Ebinop Oadd
                                      (Etempvar _hash (tptr tuchar))
                                      (Etempvar _t'12 tint) (tptr tuchar))
                                    tuchar)
                                  (Ecast
                                    (Ebinop Oshr (Etempvar _t'19 tuint)
                                      (Econst_int (Int.repr 24) tint) tuint)
                                    tuchar))))
                            (Ssequence
                              (Ssequence
                                (Ssequence
                                  (Sset _t'13 (Etempvar _j tint))
                                  (Sset _j
                                    (Ebinop Oadd (Etempvar _t'13 tint)
                                      (Econst_int (Int.repr 1) tint) tint)))
                                (Ssequence
                                  (Sset _t'18
                                    (Ederef
                                      (Ebinop Oadd (Evar _h (tarray tuint 8))
                                        (Etempvar _i tint) (tptr tuint))
                                      tuint))
                                  (Sassign
                                    (Ederef
                                      (Ebinop Oadd
                                        (Etempvar _hash (tptr tuchar))
                                        (Etempvar _t'13 tint) (tptr tuchar))
                                      tuchar)
                                    (Ecast
                                      (Ebinop Oshr (Etempvar _t'18 tuint)
                                        (Econst_int (Int.repr 16) tint)
                                        tuint) tuchar))))
                              (Ssequence
                                (Ssequence
                                  (Ssequence
                                    (Sset _t'14 (Etempvar _j tint))
                                    (Sset _j
                                      (Ebinop Oadd (Etempvar _t'14 tint)
                                        (Econst_int (Int.repr 1) tint) tint)))
                                  (Ssequence
                                    (Sset _t'17
                                      (Ederef
                                        (Ebinop Oadd
                                          (Evar _h (tarray tuint 8))
                                          (Etempvar _i tint) (tptr tuint))
                                        tuint))
                                    (Sassign
                                      (Ederef
                                        (Ebinop Oadd
                                          (Etempvar _hash (tptr tuchar))
                                          (Etempvar _t'14 tint)
                                          (tptr tuchar)) tuchar)
                                      (Ecast
                                        (Ebinop Oshr (Etempvar _t'17 tuint)
                                          (Econst_int (Int.repr 8) tint)
                                          tuint) tuchar))))
                                (Ssequence
                                  (Ssequence
                                    (Sset _t'15 (Etempvar _j tint))
                                    (Sset _j
                                      (Ebinop Oadd (Etempvar _t'15 tint)
                                        (Econst_int (Int.repr 1) tint) tint)))
                                  (Ssequence
                                    (Sset _t'16
                                      (Ederef
                                        (Ebinop Oadd
                                          (Evar _h (tarray tuint 8))
                                          (Etempvar _i tint) (tptr tuint))
                                        tuint))
                                    (Sassign
                                      (Ederef
                                        (Ebinop Oadd
                                          (Etempvar _hash (tptr tuchar))
                                          (Etempvar _t'15 tint)
                                          (tptr tuchar)) tuchar)
                                      (Ecast (Etempvar _t'16 tuint) tuchar))))))))
                        (Sset _i
                          (Ebinop Oadd (Etempvar _i tint)
                            (Econst_int (Int.repr 1) tint) tint))))))))))))))
|}.

Definition composites : list composite_definition :=
(Composite _buffer_state Struct
   ((_p, (tptr tuchar)) :: (_len, tuint) :: (_total_len, tuint) ::
    (_single_one_delivered, tint) :: (_total_len_delivered, tint) :: nil)
   noattr :: nil).

Definition global_definitions : list (ident * globdef fundef type) :=
((___builtin_ais_annot,
   Gfun(External (EF_builtin "__builtin_ais_annot"
                   (mksignature (AST.Tint :: nil) None
                     {|cc_vararg:=true; cc_unproto:=false; cc_structret:=false|}))
     (Tcons (tptr tschar) Tnil) tvoid
     {|cc_vararg:=true; cc_unproto:=false; cc_structret:=false|})) ::
 (___builtin_bswap,
   Gfun(External (EF_builtin "__builtin_bswap"
                   (mksignature (AST.Tint :: nil) (Some AST.Tint) cc_default))
     (Tcons tuint Tnil) tuint cc_default)) ::
 (___builtin_bswap32,
   Gfun(External (EF_builtin "__builtin_bswap32"
                   (mksignature (AST.Tint :: nil) (Some AST.Tint) cc_default))
     (Tcons tuint Tnil) tuint cc_default)) ::
 (___builtin_bswap16,
   Gfun(External (EF_builtin "__builtin_bswap16"
                   (mksignature (AST.Tint :: nil) (Some AST.Tint) cc_default))
     (Tcons tushort Tnil) tushort cc_default)) ::
 (___builtin_fabs,
   Gfun(External (EF_builtin "__builtin_fabs"
                   (mksignature (AST.Tfloat :: nil) (Some AST.Tfloat)
                     cc_default)) (Tcons tdouble Tnil) tdouble cc_default)) ::
 (___builtin_fsqrt,
   Gfun(External (EF_builtin "__builtin_fsqrt"
                   (mksignature (AST.Tfloat :: nil) (Some AST.Tfloat)
                     cc_default)) (Tcons tdouble Tnil) tdouble cc_default)) ::
 (___builtin_memcpy_aligned,
   Gfun(External (EF_builtin "__builtin_memcpy_aligned"
                   (mksignature
                     (AST.Tint :: AST.Tint :: AST.Tint :: AST.Tint :: nil)
                     None cc_default))
     (Tcons (tptr tvoid)
       (Tcons (tptr tvoid) (Tcons tuint (Tcons tuint Tnil)))) tvoid
     cc_default)) ::
 (___builtin_annot,
   Gfun(External (EF_builtin "__builtin_annot"
                   (mksignature (AST.Tint :: nil) None
                     {|cc_vararg:=true; cc_unproto:=false; cc_structret:=false|}))
     (Tcons (tptr tschar) Tnil) tvoid
     {|cc_vararg:=true; cc_unproto:=false; cc_structret:=false|})) ::
 (___builtin_annot_intval,
   Gfun(External (EF_builtin "__builtin_annot_intval"
                   (mksignature (AST.Tint :: AST.Tint :: nil) (Some AST.Tint)
                     cc_default)) (Tcons (tptr tschar) (Tcons tint Tnil))
     tint cc_default)) ::
 (___builtin_membar,
   Gfun(External (EF_builtin "__builtin_membar"
                   (mksignature nil None cc_default)) Tnil tvoid cc_default)) ::
 (___builtin_va_start,
   Gfun(External (EF_builtin "__builtin_va_start"
                   (mksignature (AST.Tint :: nil) None cc_default))
     (Tcons (tptr tvoid) Tnil) tvoid cc_default)) ::
 (___builtin_va_arg,
   Gfun(External (EF_builtin "__builtin_va_arg"
                   (mksignature (AST.Tint :: AST.Tint :: nil) None
                     cc_default)) (Tcons (tptr tvoid) (Tcons tuint Tnil))
     tvoid cc_default)) ::
 (___builtin_va_copy,
   Gfun(External (EF_builtin "__builtin_va_copy"
                   (mksignature (AST.Tint :: AST.Tint :: nil) None
                     cc_default))
     (Tcons (tptr tvoid) (Tcons (tptr tvoid) Tnil)) tvoid cc_default)) ::
 (___builtin_va_end,
   Gfun(External (EF_builtin "__builtin_va_end"
                   (mksignature (AST.Tint :: nil) None cc_default))
     (Tcons (tptr tvoid) Tnil) tvoid cc_default)) ::
 (___compcert_va_int32,
   Gfun(External (EF_external "__compcert_va_int32"
                   (mksignature (AST.Tint :: nil) (Some AST.Tint) cc_default))
     (Tcons (tptr tvoid) Tnil) tuint cc_default)) ::
 (___compcert_va_int64,
   Gfun(External (EF_external "__compcert_va_int64"
                   (mksignature (AST.Tint :: nil) (Some AST.Tlong)
                     cc_default)) (Tcons (tptr tvoid) Tnil) tulong
     cc_default)) ::
 (___compcert_va_float64,
   Gfun(External (EF_external "__compcert_va_float64"
                   (mksignature (AST.Tint :: nil) (Some AST.Tfloat)
                     cc_default)) (Tcons (tptr tvoid) Tnil) tdouble
     cc_default)) ::
 (___compcert_va_composite,
   Gfun(External (EF_external "__compcert_va_composite"
                   (mksignature (AST.Tint :: AST.Tint :: nil) (Some AST.Tint)
                     cc_default)) (Tcons (tptr tvoid) (Tcons tuint Tnil))
     (tptr tvoid) cc_default)) ::
 (___compcert_i64_dtos,
   Gfun(External (EF_runtime "__compcert_i64_dtos"
                   (mksignature (AST.Tfloat :: nil) (Some AST.Tlong)
                     cc_default)) (Tcons tdouble Tnil) tlong cc_default)) ::
 (___compcert_i64_dtou,
   Gfun(External (EF_runtime "__compcert_i64_dtou"
                   (mksignature (AST.Tfloat :: nil) (Some AST.Tlong)
                     cc_default)) (Tcons tdouble Tnil) tulong cc_default)) ::
 (___compcert_i64_stod,
   Gfun(External (EF_runtime "__compcert_i64_stod"
                   (mksignature (AST.Tlong :: nil) (Some AST.Tfloat)
                     cc_default)) (Tcons tlong Tnil) tdouble cc_default)) ::
 (___compcert_i64_utod,
   Gfun(External (EF_runtime "__compcert_i64_utod"
                   (mksignature (AST.Tlong :: nil) (Some AST.Tfloat)
                     cc_default)) (Tcons tulong Tnil) tdouble cc_default)) ::
 (___compcert_i64_stof,
   Gfun(External (EF_runtime "__compcert_i64_stof"
                   (mksignature (AST.Tlong :: nil) (Some AST.Tsingle)
                     cc_default)) (Tcons tlong Tnil) tfloat cc_default)) ::
 (___compcert_i64_utof,
   Gfun(External (EF_runtime "__compcert_i64_utof"
                   (mksignature (AST.Tlong :: nil) (Some AST.Tsingle)
                     cc_default)) (Tcons tulong Tnil) tfloat cc_default)) ::
 (___compcert_i64_sdiv,
   Gfun(External (EF_runtime "__compcert_i64_sdiv"
                   (mksignature (AST.Tlong :: AST.Tlong :: nil)
                     (Some AST.Tlong) cc_default))
     (Tcons tlong (Tcons tlong Tnil)) tlong cc_default)) ::
 (___compcert_i64_udiv,
   Gfun(External (EF_runtime "__compcert_i64_udiv"
                   (mksignature (AST.Tlong :: AST.Tlong :: nil)
                     (Some AST.Tlong) cc_default))
     (Tcons tulong (Tcons tulong Tnil)) tulong cc_default)) ::
 (___compcert_i64_smod,
   Gfun(External (EF_runtime "__compcert_i64_smod"
                   (mksignature (AST.Tlong :: AST.Tlong :: nil)
                     (Some AST.Tlong) cc_default))
     (Tcons tlong (Tcons tlong Tnil)) tlong cc_default)) ::
 (___compcert_i64_umod,
   Gfun(External (EF_runtime "__compcert_i64_umod"
                   (mksignature (AST.Tlong :: AST.Tlong :: nil)
                     (Some AST.Tlong) cc_default))
     (Tcons tulong (Tcons tulong Tnil)) tulong cc_default)) ::
 (___compcert_i64_shl,
   Gfun(External (EF_runtime "__compcert_i64_shl"
                   (mksignature (AST.Tlong :: AST.Tint :: nil)
                     (Some AST.Tlong) cc_default))
     (Tcons tlong (Tcons tint Tnil)) tlong cc_default)) ::
 (___compcert_i64_shr,
   Gfun(External (EF_runtime "__compcert_i64_shr"
                   (mksignature (AST.Tlong :: AST.Tint :: nil)
                     (Some AST.Tlong) cc_default))
     (Tcons tulong (Tcons tint Tnil)) tulong cc_default)) ::
 (___compcert_i64_sar,
   Gfun(External (EF_runtime "__compcert_i64_sar"
                   (mksignature (AST.Tlong :: AST.Tint :: nil)
                     (Some AST.Tlong) cc_default))
     (Tcons tlong (Tcons tint Tnil)) tlong cc_default)) ::
 (___compcert_i64_smulh,
   Gfun(External (EF_runtime "__compcert_i64_smulh"
                   (mksignature (AST.Tlong :: AST.Tlong :: nil)
                     (Some AST.Tlong) cc_default))
     (Tcons tlong (Tcons tlong Tnil)) tlong cc_default)) ::
 (___compcert_i64_umulh,
   Gfun(External (EF_runtime "__compcert_i64_umulh"
                   (mksignature (AST.Tlong :: AST.Tlong :: nil)
                     (Some AST.Tlong) cc_default))
     (Tcons tulong (Tcons tulong Tnil)) tulong cc_default)) ::
 (___builtin_bswap64,
   Gfun(External (EF_builtin "__builtin_bswap64"
                   (mksignature (AST.Tlong :: nil) (Some AST.Tlong)
                     cc_default)) (Tcons tulong Tnil) tulong cc_default)) ::
 (___builtin_clz,
   Gfun(External (EF_builtin "__builtin_clz"
                   (mksignature (AST.Tint :: nil) (Some AST.Tint) cc_default))
     (Tcons tuint Tnil) tint cc_default)) ::
 (___builtin_clzl,
   Gfun(External (EF_builtin "__builtin_clzl"
                   (mksignature (AST.Tint :: nil) (Some AST.Tint) cc_default))
     (Tcons tuint Tnil) tint cc_default)) ::
 (___builtin_clzll,
   Gfun(External (EF_builtin "__builtin_clzll"
                   (mksignature (AST.Tlong :: nil) (Some AST.Tint)
                     cc_default)) (Tcons tulong Tnil) tint cc_default)) ::
 (___builtin_ctz,
   Gfun(External (EF_builtin "__builtin_ctz"
                   (mksignature (AST.Tint :: nil) (Some AST.Tint) cc_default))
     (Tcons tuint Tnil) tint cc_default)) ::
 (___builtin_ctzl,
   Gfun(External (EF_builtin "__builtin_ctzl"
                   (mksignature (AST.Tint :: nil) (Some AST.Tint) cc_default))
     (Tcons tuint Tnil) tint cc_default)) ::
 (___builtin_ctzll,
   Gfun(External (EF_builtin "__builtin_ctzll"
                   (mksignature (AST.Tlong :: nil) (Some AST.Tint)
                     cc_default)) (Tcons tulong Tnil) tint cc_default)) ::
 (___builtin_fmax,
   Gfun(External (EF_builtin "__builtin_fmax"
                   (mksignature (AST.Tfloat :: AST.Tfloat :: nil)
                     (Some AST.Tfloat) cc_default))
     (Tcons tdouble (Tcons tdouble Tnil)) tdouble cc_default)) ::
 (___builtin_fmin,
   Gfun(External (EF_builtin "__builtin_fmin"
                   (mksignature (AST.Tfloat :: AST.Tfloat :: nil)
                     (Some AST.Tfloat) cc_default))
     (Tcons tdouble (Tcons tdouble Tnil)) tdouble cc_default)) ::
 (___builtin_fmadd,
   Gfun(External (EF_builtin "__builtin_fmadd"
                   (mksignature
                     (AST.Tfloat :: AST.Tfloat :: AST.Tfloat :: nil)
                     (Some AST.Tfloat) cc_default))
     (Tcons tdouble (Tcons tdouble (Tcons tdouble Tnil))) tdouble
     cc_default)) ::
 (___builtin_fmsub,
   Gfun(External (EF_builtin "__builtin_fmsub"
                   (mksignature
                     (AST.Tfloat :: AST.Tfloat :: AST.Tfloat :: nil)
                     (Some AST.Tfloat) cc_default))
     (Tcons tdouble (Tcons tdouble (Tcons tdouble Tnil))) tdouble
     cc_default)) ::
 (___builtin_fnmadd,
   Gfun(External (EF_builtin "__builtin_fnmadd"
                   (mksignature
                     (AST.Tfloat :: AST.Tfloat :: AST.Tfloat :: nil)
                     (Some AST.Tfloat) cc_default))
     (Tcons tdouble (Tcons tdouble (Tcons tdouble Tnil))) tdouble
     cc_default)) ::
 (___builtin_fnmsub,
   Gfun(External (EF_builtin "__builtin_fnmsub"
                   (mksignature
                     (AST.Tfloat :: AST.Tfloat :: AST.Tfloat :: nil)
                     (Some AST.Tfloat) cc_default))
     (Tcons tdouble (Tcons tdouble (Tcons tdouble Tnil))) tdouble
     cc_default)) ::
 (___builtin_read16_reversed,
   Gfun(External (EF_builtin "__builtin_read16_reversed"
                   (mksignature (AST.Tint :: nil) (Some AST.Tint) cc_default))
     (Tcons (tptr tushort) Tnil) tushort cc_default)) ::
 (___builtin_read32_reversed,
   Gfun(External (EF_builtin "__builtin_read32_reversed"
                   (mksignature (AST.Tint :: nil) (Some AST.Tint) cc_default))
     (Tcons (tptr tuint) Tnil) tuint cc_default)) ::
 (___builtin_write16_reversed,
   Gfun(External (EF_builtin "__builtin_write16_reversed"
                   (mksignature (AST.Tint :: AST.Tint :: nil) None
                     cc_default)) (Tcons (tptr tushort) (Tcons tushort Tnil))
     tvoid cc_default)) ::
 (___builtin_write32_reversed,
   Gfun(External (EF_builtin "__builtin_write32_reversed"
                   (mksignature (AST.Tint :: AST.Tint :: nil) None
                     cc_default)) (Tcons (tptr tuint) (Tcons tuint Tnil))
     tvoid cc_default)) ::
 (___builtin_nop,
   Gfun(External (EF_builtin "__builtin_nop"
                   (mksignature nil None cc_default)) Tnil tvoid cc_default)) ::
 (___builtin_debug,
   Gfun(External (EF_external "__builtin_debug"
                   (mksignature (AST.Tint :: nil) None
                     {|cc_vararg:=true; cc_unproto:=false; cc_structret:=false|}))
     (Tcons tint Tnil) tvoid
     {|cc_vararg:=true; cc_unproto:=false; cc_structret:=false|})) ::
 (_memcpy,
   Gfun(External (EF_external "memcpy"
                   (mksignature (AST.Tint :: AST.Tint :: AST.Tint :: nil)
                     (Some AST.Tint) cc_default))
     (Tcons (tptr tvoid) (Tcons (tptr tvoid) (Tcons tuint Tnil)))
     (tptr tvoid) cc_default)) ::
 (_memset,
   Gfun(External (EF_external "memset"
                   (mksignature (AST.Tint :: AST.Tint :: AST.Tint :: nil)
                     (Some AST.Tint) cc_default))
     (Tcons (tptr tvoid) (Tcons tint (Tcons tuint Tnil))) (tptr tvoid)
     cc_default)) :: (_k, Gvar v_k) ::
 (_right_rot, Gfun(Internal f_right_rot)) ::
 (_init_buf_state, Gfun(Internal f_init_buf_state)) ::
 (_calc_chunk, Gfun(Internal f_calc_chunk)) ::
 (_calc_sha_256, Gfun(Internal f_calc_sha_256)) :: nil).

Definition public_idents : list ident :=
(_calc_sha_256 :: _memset :: _memcpy :: ___builtin_debug :: ___builtin_nop ::
 ___builtin_write32_reversed :: ___builtin_write16_reversed ::
 ___builtin_read32_reversed :: ___builtin_read16_reversed ::
 ___builtin_fnmsub :: ___builtin_fnmadd :: ___builtin_fmsub ::
 ___builtin_fmadd :: ___builtin_fmin :: ___builtin_fmax ::
 ___builtin_ctzll :: ___builtin_ctzl :: ___builtin_ctz :: ___builtin_clzll ::
 ___builtin_clzl :: ___builtin_clz :: ___builtin_bswap64 ::
 ___compcert_i64_umulh :: ___compcert_i64_smulh :: ___compcert_i64_sar ::
 ___compcert_i64_shr :: ___compcert_i64_shl :: ___compcert_i64_umod ::
 ___compcert_i64_smod :: ___compcert_i64_udiv :: ___compcert_i64_sdiv ::
 ___compcert_i64_utof :: ___compcert_i64_stof :: ___compcert_i64_utod ::
 ___compcert_i64_stod :: ___compcert_i64_dtou :: ___compcert_i64_dtos ::
 ___compcert_va_composite :: ___compcert_va_float64 ::
 ___compcert_va_int64 :: ___compcert_va_int32 :: ___builtin_va_end ::
 ___builtin_va_copy :: ___builtin_va_arg :: ___builtin_va_start ::
 ___builtin_membar :: ___builtin_annot_intval :: ___builtin_annot ::
 ___builtin_memcpy_aligned :: ___builtin_fsqrt :: ___builtin_fabs ::
 ___builtin_bswap16 :: ___builtin_bswap32 :: ___builtin_bswap ::
 ___builtin_ais_annot :: nil).

Definition prog : Clight.program := 
  mkprogram composites global_definitions public_idents _main Logic.I.


