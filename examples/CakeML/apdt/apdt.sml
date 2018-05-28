datatype apdt = USM
       | KIM of int
       | SIG
       | AT of int * apdt
       | LN of apdt * apdt
       | BR of apdt * apdt;

val apdtEx1 = AT 2 (LN (BR (KIM 1)
                       (AT 1 (LN USM SIG))) SIG);

datatype ev = Mt
            | K of int * int
            | U of int
            | G of ev * int
            | SS of ev * ev
            | P of ev * ev;

fun sequ e1 e2 = case e1 of
                     Mt => e2
                   | _  => SS e1 e2;

fun para e1 e2 = case (e1, e2) of
                     (Mt, _) => e2
                   | (_, Mt) => e1
                   |  _      => P e1 e2;

fun eval t p e = case t of
                     KIM q => sequ e (K q p)
                   | USM => sequ e (U p)
                   | SIG => G e p
                   | AT q t => eval t q e
                   | LN t1 t2 => eval t2 p (eval t1 p e)
                   | BR t1 t2 => para (eval t1 p e) (eval t2 p e);

fun eapdt t = eval t 0 Mt;

val printList = TextIO.print_list;

fun evidencePrint e =
    let
        fun printHelper e =
            case e of
                K q p => (printList ["(K ", Int.toString q, " ", Int.toString p, ") "]; ())
              | U p => (printList ["(U ", Int.toString p, ") "]; ())
              | G e' p => (print "(G "; printHelper e'; print (Int.toString p); print ") "; ())
              | SS e1 e2 => (print "(SS "; printHelper e1; printHelper e2; print ") "; ())
              | P  e1 e2 => (print "(P "; printHelper e1; printHelper e2; print ") "; ());
    in
        printHelper e;
        print "\n";
        ()
    end;

val aTerm = (KIM 1);

evidencePrint (eapdt aTerm);
evidencePrint (eapdt apdtEx1);
