(* OCaml exercises, week 37, dovs team *)

module Partition = struct

(*******************************************************************************
Given a string `s` and a list [s_1; ...; s_k] say that this list is a _partition_
of length k of string `s` if it holds that

                                s = s_1 ^ ... ^ s_k

where ^ is the string concatenation operation. For example, given a string
"abcd", the lists ["abc"; "d"], ["ab"; "cd"], ["a"; "bcd"] are all partitions of
length 2 of this string.

EXERCISE 1a: write a function `partition` of a string and an integer `n` that
returns a list of all partitions of size `n` of the string.

For example,

# partition "abcd" 2;;
- : string list list = [["abc"; "d"]; ["ab"; "cd"]; ["a"; "bcd"]]

*******************************************************************************)

exception NotImplemented

let partition (input: string) (n: int) : string list list =
  raise NotImplemented

(*******************************************************************************
EXERCISE 1b: consider also implementing a variant of the above that allows
some of the partition elements to be empty:

# partition_with_empty "abcd" 2;;
- : string list list =
[["abcd"; ""]; ["abc"; "d"]; ["ab"; "cd"]; ["a"; "bcd"]; [""; "abcd"]]

*******************************************************************************)

let partition_with_empty (input: string) (n: int) : string list list =
  raise NotImplemented


(*******************************************************************************
EXERCISE 2: Suppose now that we want to filter our partitions of a given length
based on certian criteria. We consider filtering criterias that are given to us
as a list of type (string option list), and assume that the lists have the same
length as the length of our partitions. The idea is that if the i-th element of
that list is  (Some s) then, we reject the partitions that do not have string
`s` in the i-th position. Implement this in a function `partFilter`.

Examples:

# partFilter [None; Some "cd"]  (partition "abcd" 2);;
- : string list list = [["ab"; "cd"]]

# partFilter [None; None]  (partition "abcd" 2);;
- : string list list = [["abc"; "d"]; ["ab"; "cd"]; ["a"; "bcd"]]

# partFilter [Some "cd"; None]  (partition "abcd" 2);;
- : string list list = []

Hint: use List.filter with List.fold_left and List.combine

*******************************************************************************)

let partFilter (criteria: string option list) (ps: string list list) : string list list =
	raise NotImplemented

end
