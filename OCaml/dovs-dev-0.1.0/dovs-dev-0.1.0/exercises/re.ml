(* OCaml exercises, weeks 35-36, dovs team *)

(* Usage:       > utop 
                OR
                > rlwrap ocaml
                THEN
                # use "re.ml";;
   Optionally:
                # open RE;;
*)

module RE = struct

(* We consider a simple datatype for regular expressions *)

type re =
  | Chr of char             (* just a character *)
  | Alter of re * re        (* choice of two regexps        *)
  | Concat of re * re       (* concatenation of two regexps *)
  | Star of re              (* Kleene star *)
  | Eps                     (* empty string *)

(* Example regular expressions *)

let ex1 = Chr 'a'

let ex2 = Chr 'b'

let ex3 = Chr 'c'

let ex4 = Concat (ex1, ex2)

let ex5 = Alter (ex1, Alter (ex2, ex3))

let ex6 = Star (Alter (Chr 'a', (Alter (Chr 'b', Chr 'c'))))

let ex7 = Star (Concat (Alter (Chr 'x', Eps), ex6))

let ex8 = Alter (Concat (ex1, ex3), Concat (ex2, ex3))

let ex9 = Concat (Alter (ex1, ex3), Alter (ex2, ex3))

(* of course, you can define your own examples now... *)

(*****************************************************************************

EXERCISE: implement function `re_to_str` that converts a regular expression
to a string. Use an underscore "_"  to print Eps. Observe that because of the
precedence of regexp operators (i.e., Star binds closer than Concat that in
turn binds closer than Alter), the resulting string may need to parenthesize
certain sub-regexpressions.

part 1) Implement a naive version that parenthesizes the sub-regexpressions
even when that is strictly speaking not necessary.

part 2) Implement a better version that parentheses the sub-regexpressions _only_
when it is necessary, following the standard rules of precedence for regular
expressions.

Example of output for part 2:

# open RE;;

# re_to_str ex5;;
- : string = "a|b|c"

# re_to_str ex6;;
- : string = "(a|b|c)*"

# re_to_str (Concat  (Chr 'a', Concat (Star (Chr 'b'), Chr 'c')));;
- : string = "ab*c"

# re_to_str (Concat ( Star (Concat ( Chr 'a', Chr 'b')), Chr 'c'));;
- : string = "(ab)*c"

*****************************************************************************)

exception NotImplemented

let rec re_to_str (r:re) : string =
  raise NotImplemented (* your code here *)

end (* of structure RE *)
