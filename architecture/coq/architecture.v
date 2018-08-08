Require Import APDT.

Module Architecture.
  
  (** Place identifiers *)

  Inductive Places :=
  | seL4AM
  | platformAM
  | userAM
  | mpAM.

  Inductive Measures : Places -> Places -> Prop :=
  | sel4Plat: Measures seL4AM platformAM.

  
  
  
End Architecture.
       