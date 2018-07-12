
Inductive integer :=
| pZero : integer
| nZero : integer
| positive : nat -> integer
| negative : nat -> integer.

Definition one := positive 1.
Definition two := positive 2.
Definition nOne := negative 1.
Definition nTwo := negative 2.

(* I have forgotten why I can't do this. *)
Definition myGt (a b : nat) : bool :=
  match (a<b) with
  | True => true
  | False => false
  end.

Definition intAdd (a b : integer) : integer :=
  match a with
  | pZero => b
  | nZero => b
  | positive a' => match b with
                   | pZero => positive a'
                   | nZero => positive a'
                   | positive b' => positive (a'+b')
                   | negative b' => match (a'-b') with
                                    | true => positive (a'-b')
                                    | false => negative (b'-a')
                                    end



                   end
  | negative a' => positive a'
  end.

Lemma pAdd : intAdd one one = two.
Proof. reflexivity. Qed.

Lemma p