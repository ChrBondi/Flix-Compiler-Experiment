(* OCaml exercises, weeks 35-36, dovs team *)


(* This exercise is based on the project described in Modern Compiler
   Implementation in ML, section PROGRAM, pages 10-12.

   Note that the code in in this file uses a function `buildEnv`
   (whose implementation is omitted) that hints at an approach
   alternative from the textbook.

   In the approach described in the book, the environment is empty at
   first, and every assignment at runtime extends the environment with
   a new binding. Lookup always selects the most recently added
   binding, so this works as expected for assignment (although it
   wastes memory if the same variable is assigned a new value many
   times).

   In the alternative approach, there is first a separate
   ("compilation") phase, where the program is analyzed to discover
   the exact set of variables that may be needed, and only then is the
   program executed (in a separate phase that would typically be
   referred to as "runtime"). In this approach, the environment never
   grows, it always contains `k` bindings for a program using `k`
   different variables; implementation of an assignment updates the
   environment with the new value. For example, [("a",3),("c",4)]
   becomes [("a",3),("c",7)] when an assignment to c changes it from 4
   to 7.

   Very dynamic languages (e.g., JavaScript) require the approach that
   modifies the environment at runtime, but for compiled languages, it
   is typical to fix the environments during compile time so that they
   are valid for all executions. The fixed format allows for
   optimizations and enables certain correctness guarantees to be
   established, e.g., in the shape of statically checked types.

   For this exercise, you may follow the description in the book
   (hence deleting the reference to buildEnv), or you may implement
   two separate phases (which includes implementing buildEnv), or you
   may decide to handle both approaches. In any case, the report
   should describe what you have done. It is worth mentioning that one
   can use a functional style (avoiding ref) for both approaches.

   When interpreting the expression from Fig.1.4 (i.e., prog) your
   soultion should output the following:

           8 7 80

   Notice there is a difference between call-by-value and call-by-name
   execution. For this small language, you should use call-by-value.

*)

module SLgrammar = struct

type id = string

type binop = Plus | Minus | Times | Div

type stm =
  | CompoundStm of stm * stm
  | AssignStm of id * exp
  | PrintStm of exp list
and exp =
  | IdExp of id
  | NumExp of int
  | OpExp of exp * binop * exp
  | EseqExp of stm * exp
end

module G = SLgrammar

type table = (G.id * int) list

let update_table (t, id, v): table = (id, v)::t

let rec update_table' (t, id, v): table = match t with
  | []            -> [(id,v)]
  | (id',v')::ts  ->
    if id' = id
    then (id',v)::ts
    else (id',v')::update_table' (ts,id,v)

exception UnboundVariable
let rec lookup (t,x): int =
  match t with
  | [] -> raise UnboundVariable
  | (id,v)::ts -> if id = x then v else lookup(ts,x)

exception NotImplemented (* when the entire assignment is complete, the
                            code should compile with this exception
                            declaration removed                            *)

(* -- Function stringOfStm: ---------------------------------------------- *)
(* Input: a value of type G.stm that corresponds to a statement in our
   language.

   Output: a string representation of that statement.

   Note: the assginment does not specify _how_ the string is
   formatted. There may be in general several ways of doing this. The
   example below is just one possibility.

   Example: For example program 'prog' (defined below) a possible output
   is string: "a := 5+3; b := (print(a,a-1), 10*a); print(b)"              *)

let rec stringOfStm stm =
  raise NotImplemented

(* -- Function buildEnv -------------------------------------------------- *)

(* Function buildEnv builds an initial environment if the interpreter uses
   a compilation phase.  The assignment page provides more detailed
   information about buildEnv.                                             *)

let buildEnv (s: G.stm) : table =
  raise NotImplemented

(* -- Function interpStm ------------------------------------------------- *)
(* Funtion interpStm interprets a G.stm - Implementation hints can be
   found in the book                                                       *)

let rec interpStm (stm,env): table =
  raise NotImplemented


(* -- Function printEnv -------------------------------------------------- *)

(* Given an environment (id * int) list, this function prints a string
   representation of the environment.

   Example: Given the environment [("a", 3), ("b", 5)], this function
   prints "[(a, 3), (b, 5)]".

   Note again, there are several ways to format an environment; feel free
   to pick one.                                                            *)

let printEnv env =
  raise NotImplemented

(* ----------------------------------------------------------------------- *)

let interp (s: G.stm): unit =
    let _ = print_endline ("Executing: " ^ (stringOfStm s)) in
    let env = buildEnv s in
    let env' = interpStm (s, env) in
    printEnv env'

(* -- Example for testing ------------------------------------------------ *)

let prog =
  (* a := 5+3; b := (print(a,a-1), 10*a); print(b) *)
  G.CompoundStm (
    G.AssignStm ("a", G.OpExp (G.NumExp 5, G.Plus, G.NumExp 3)),
    G.CompoundStm (
      G.AssignStm ("b", G.EseqExp (
        G.PrintStm [G.IdExp "a"; G.OpExp (G.IdExp "a", G.Minus, G.NumExp 1)],
        G.OpExp (G.NumExp 10, G.Times, G.IdExp "a"))),
      G.PrintStm [G.IdExp "b"]))

(* Calling the interpreter on the example program.

   TODO: Uncomment to proceed. Default implementation raises
   NotImplemented exception                                                *)

(* let _ = interp prog *)
