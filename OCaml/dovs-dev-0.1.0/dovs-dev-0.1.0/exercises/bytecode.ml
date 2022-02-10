(* OCaml exercises, weeks 35-36, dovs team *)
(* The exercise is based on a similar one in the book Software
   Foundations by Pierce et al. *)

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

Note: we will talk about the structures later. For now, we use them in
a very basic form *)


(* -------------------------------------------------- *)

(* In this exercisee, we study a simple stateful evaluator for
   arithmetic expressions, a stack machine, and a compiler from
   arithmetic expressions to the stack machine *)

module Bytecode = struct

(* -- PART 1: arithmetic expressions ----------------- *)

(* We express our arithmetic expressions using a datatype declaration *)

type aexp =
  | ANum of int
  | AId of string
  | APlus of aexp * aexp
  | AMinus of aexp * aexp
  | AMult of aexp * aexp

(* State

   For simplicity, we model the state as _total_ functions from
   variable names (modele d here as strings) to integers
*)

type state = string -> int

(* An empty state is the state that returns some default value: in this case
   we let the default value to be zero *)

let st_empty: state = fun _ -> 0

(* State update.

   The new state agrees with st on all variables except x
*)

let st_update (st: state) (x: string) (v: int) : state =
  fun x' -> if x = x' then v else st x'

(* Evaluation

   This is our evaluator of arithmetic expressions.
*)

let rec aeval (st: state) (a: aexp) : int = match a with
  | ANum n -> n          (* evaluation of a constant is just the constant itself *)
  | AId x -> st x        (* evaluation of a variable goes via the state lookup   *)
  | APlus (a1, a2) -> (aeval st a1) + (aeval st a2) (* recursive calls ...       *)
  | AMinus (a1, a2) -> (aeval st a1) - (aeval st a2)
  | AMult (a1, a2) -> (aeval st a1) * (aeval st a2)

(* Here is a simple example that corresponds to the expression 2 + 2 *)

let example1_aexp = APlus (ANum 2, ANum 2)
let example1_result = aeval st_empty example1_aexp

(* This evaluates to 4; to check it in REPL, type Bytecode.example1_result *)

(* Exercise 1:

   Create an example that evaluats expression x * y - 2, for the state
   where x is set to 11 and y is set to 4
*)

let ex_state = st_update st_empty "x" 11
let ex_state = st_update ex_state "y" 7
let ex_aexp = AMinus(AMult (AId "x", AId "y"), ANum 2)
let exercise1 = aeval ex_state ex_aexp
   (* TODO: replace with your implementation *)

(* -- PART 2 : the stack machine  ------------------- *)

(* We now consider a simple stack machine defined as follows: *)

type sinstr =
  SPush of int | SLoad of string | SPlus | SMinus | SMult

(* The informal semantics of this stack machine is as follows:

  - SPush n pushes the integer n on top of the stack
  - SLoad x pushes the value stored in variable x on top of the stack
  - SPlus pops two values from the stack and pushes on the value
          corresponding to their sum
  - SMinus and SMult are similar to SPlus
 *)


(* Exercise 2:

   Write a function to evaluate programs in the stack language. It
   should take as input a state, a stack represented as a list of
   numbers (top stack item is the head of the list), and a program
   represented as a list of instructions, and it should return the
   stack after executing the program. Test your function on the two
   example tests below.  Note that the specification leaves
   unspecified what to do when encountering an SPlus, SMinus, or SMult
   instruction if the stack contains less than two elements. In a
   sense, it is immaterial what we do, since our compiler will never
   emit such a malformed program. *)

let rec s_execute (st: state) (stack: int list) (prog: sinstr list) : int list =
  [] (* TODO: replace with your implementation *)

(* These are our test programs *)

let s_execute_test1 =
    s_execute st_empty
              []
              [SPush 5; SPush 3; SPush 1; SMinus]

(* should return [2; 5] *)

let s_execute_test2 =
    s_execute (st_update st_empty "X" 3)
              [3; 4]
              [SPush 4; SLoad "X"; SMult; SPlus]

(* should return [15; 4] *)

(* Exercise 3:

   Write a function that compiles an aexp into a stack machine
   program. The effect of running the program should be the same as
   pushing the value of the expression on the stack. *)

let rec s_compile (e: aexp) : sinstr list =
  [] (* TODO: replace with your implementation *)

(* Exercise 4:

   Create a few more test aexps that demonstrate the correctness of
   the output of your compiler. Hint: given an aexp, and bytecode
   program from your compiler that corresponds to it, the direct
   evaluator from part 1 and the bytecode evaluator that you wrote
   should produce the same output, when run in the same states.

 *)
 

end
