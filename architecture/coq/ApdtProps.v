(** Attestation Protocol Description Terms *)

Require Import PeanoNat.

Module Type APDTMod.

Parameter P : Type.
  
Inductive Order: Type :=
| SEQ: Order
| PAR: Order.

Inductive APDT: Type :=
| USM: APDT
| KIM: P -> APDT
| SIG: APDT
| AT: P -> APDT -> APDT
| LN: APDT -> APDT -> APDT
| BR: Order -> APDT -> APDT -> APDT.

Axiom eq_apdt_dec:
  forall x y: APDT, {x = y} + {x <> y}.

(* Proof.
  intros.
  decide equality; decide equality.
Defined. *)
Hint Resolve eq_apdt_dec.

(** The example *)

(*
Definition ex :=
  AT 2 (LN (BR PAR (KIM 1)
                   (AT 1 (LN USM SIG))) SIG).

(** Another example *)

Definition aex :=
  AT 2 (LN (LN (KIM 1)
                   (AT 1 (LN USM SIG))) SIG).
 *)

(** Evidence Forms *)

Inductive Ev: Type :=
| Mt: Ev                     (* Empty evidence *)
| N: P -> Ev                  (* Nonce evidence *)
| K: P -> P -> Ev              (* Kernel measurement *)
| U: P -> Ev                  (* User space measurement *)
| G: Ev -> P -> Ev             (* Signature *)
| SS: Ev -> Ev -> Ev           (* Really should be S, but conflicts *)
| PP: Ev -> Ev -> Ev.           (* Parallel *)

Axiom eq_ev_dec :
  forall x y: Ev, {x = y} + {x <> y}.
(*
Proof.
  intros.
  decide equality; decide equality.
Defined.*)
Hint Resolve eq_ev_dec.

Inductive is_Mt : Ev -> Prop :=
| isMt : is_Mt Mt.
Hint Constructors is_Mt.

Definition is_Mt_dec : forall e, {is_Mt e} + {~ is_Mt e}.
Proof.
  intros.
  destruct e; try (right; unfold not; intros; inversion H; contradiction).
  left. eauto.
Defined.

(** * Denotational Semantics

    The evidence associated with a APDT *)

Definition sequ e1 e2: Ev :=
  match e1 with
  | Mt => e2
  | _ => SS e1 e2
  end.

Definition para e1 e2: Ev :=
  match (e1, e2) with
  | (Mt, _) => e2
  | (_, Mt) => e1
  | _ => PP e1 e2
  end.

Fixpoint eval (t: APDT) (p: P) (e: Ev): Ev :=
  match t with
  | KIM q => sequ e (K q p)
  | USM => sequ e (U p)
  | SIG => G e p
  | AT q t => eval t q e
  | LN t1 t2 =>
    eval t2 p (eval t1 p e)
  | BR SEQ t1 t2 =>
    sequ (eval t1 p e) (eval t2 p e)
  | BR PAR t1 t2 =>
    para (eval t1 p e) (eval t2 p e)
  end.

(** Evaluate APDT

Definition eapdt (t: APDT): Ev :=
  eval t 0 Mt.

Definition aTerm := (KIM 1).

Example evalTerm : (eapdt aTerm) = (K 1 0).
Proof.
  cbv. reflexivity.
Qed. *)


(** * Properties *)

(** Equivalent APDTs *)

Definition equiv_terms t1 t2 :=
  forall e p, eval t1 p e = eval t2 p e.

Lemma at_at:
  forall p q t,
    equiv_terms (AT p (AT q t)) (AT q t).
Proof.
  unfold equiv_terms.
  intros; simpl; auto.
Qed.

(** Facts about [sequ] and [para] *)

Ltac inv H := inversion H; clear H; subst.

Lemma sequ_mt:
  forall e f,
    sequ e f = Mt -> e = Mt /\ f = Mt.
Proof.
  intros e f H; destruct e; destruct f;
    auto; simpl in H; inv H.
Qed.

Lemma para_mt:
  forall e f,
    para e f = Mt -> e = Mt /\ f = Mt.
Proof.
  intros e f H; destruct e; destruct f;
    auto; simpl in H; inv H.
Qed.

Lemma sequ_mt_e:
  forall e,
    sequ Mt e = e.
Proof.
  intros; simpl; auto.
Qed.

Lemma sequ_SS:
  forall e f,
    e <> Mt -> sequ e f = SS e f.
Proof.
  intros; destruct e; simpl; auto; tauto.
Qed.

Lemma para_mt_e:
  forall e,
    para Mt e = e.
Proof.
  intros; simpl; auto.
Qed.

Lemma para_e_mt:
  forall e,
    para e Mt = e.
Proof.
  intros; destruct e; simpl; auto.
Qed.

Lemma para_P:
  forall e f,
    e <> Mt -> f <> Mt -> para e f = PP e f.
Proof.
  intros; destruct e; destruct f; simpl; auto; tauto.
Qed.

(** No term is associated with the empty evidence form. *)

Lemma eval_not_mt:
  forall e p t,
    eval t p e <> Mt.
Proof. 
  intros e p t.
  revert p.
  revert e.
  induction t; intros; intro; simpl in H; auto.
  - destruct e; auto; inv H.
  - destruct e; auto; inv H.
  - destruct e; auto; inv H.
  - apply IHt in H; auto.
  - apply IHt2 in H; auto.
  - destruct o.
    + destruct (eval t1 p e);
        try (simpl in H; congruence).
    + apply para_mt in H. destruct H. apply IHt1 in H. inversion H.
Qed.
Hint Resolve eval_not_mt.

Lemma sequ_eval_SS:
  forall e1 e2 p1 t1,
    sequ (eval t1 p1 e1) e2 =
    SS (eval t1 p1 e1) e2.
Proof.
  intros; apply sequ_SS; apply eval_not_mt.
Qed.

Lemma para_eval_P:
  forall e1 e2 p1 p2 t1 t2,
    para (eval t1 p1 e1) (eval t2 p2 e2) =
    PP (eval t1 p1 e1) (eval t2 p2 e2).
Proof.
  intros; apply para_P; apply eval_not_mt.
Qed.

(** [eval] is injective on evidence forms. *)

Lemma eval_inj:
  forall e f p t,
    eval t p e = eval t p f -> e = f.
Proof.
  intros.
  revert H.
  revert p.
  revert f.
  revert e.
  induction t; intros; simpl in H.
  - destruct e; destruct f; inv H; auto.
  - destruct e; destruct f; inv H; auto.
  - destruct e; destruct f; inv H; auto.
  - apply IHt in H; auto.
  - eauto.
  - destruct o.
    + simpl in H;
        rewrite sequ_eval_SS in H;
        rewrite sequ_eval_SS in H;
        inv H.
    eauto.
    + simpl in H;
        rewrite para_eval_P in H;
        rewrite para_eval_P in H;
        inv H.
    eauto.
Qed.

End APDTMod.
