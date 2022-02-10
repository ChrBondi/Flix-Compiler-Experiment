(* This file contains a subset of examples from the course-document. 
   Use this file as a sandbox for your interactions with OCaml *)

(* -------------------------------------------------- *)
(* Usage:    > utop
             OR
             > rlwrap ocaml
             THEN
             # use "bytecode.ml";;
   Optionally:
             # open Bytecode;;

When the file is modified, run use (and open) again to load the new
version into REPL.

*)


(* OCaml basics *)


let res = 3 + 4;;

(* Hello, world function *)

let hello_world () = Printf.printf ("Hello, world!\n")

(* ------- Functions -------- *)

let junkmail title name = "Dear " ^ title ^ " " ^ name ^ ", you have won $$$"
let s = junkmail "Mr" "Tambourine Man"





(* To run this function, reload the file with the #use ... directive 
   and then evaluat hello_world() function.contents

   Also try to evaluate hello_world without the parens. 
*)

(* Recursive function declaration with pattern matching *)
let rec fac n = match n with 
   0 -> 1 
 | _ -> n * fac (n - 1);; 


 let rec loop i j f =
   if i <= j then (f i; loop(i+1) j f )
   else ()

(*invoked example: 
   loop 1 5 (fun i -> print_something_every_time());;
*)


let print_something_once = Printf.printf "Once"
(* Ovenfor kontra nedenfor*)
let print_something_every_time () = Printf.printf "Every"