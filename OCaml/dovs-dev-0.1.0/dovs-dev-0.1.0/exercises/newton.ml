(*******************************************************************************
dOvs exercise week 35. dovs team

This exercise is based on Chapter 1.3.3 of textbook

  Structure and Interpretation of Computer Programs
        by H. Abelson and G.J. Sussman.

Usage:       > utop
             OR
             > rlwrap ocaml
             THEN
             # use "newton.ml";;
Optionally:
             # open Newton;;

When the file is modified, run use (and open) again to load the modified
version into REPL.

Note: we will talk about structures later

*******************************************************************************)

module Newton = struct

(*******************************************************************************
Recall the definition of the derivative of real-valued functions from basic
Calculus.  https://simple.wikipedia.org/wiki/Derivative_(mathematics)


                         f (x + δx) - f (x)
       f' (x) =   lim   --------------------
                 δx → 0          δx

We can approximate this using the function `deriv` below, where we set dx to a
fixed small value.
*******************************************************************************)

let deriv (f: float -> float) : (float -> float) =
  let dx = 0.00001
  in fun x -> let x' = x +. dx in (f x' -. f x) /. dx

(*******************************************************************************
We can now use Newton's method to find the root of a real-valued function.
https://en.wikipedia.org/wiki/Newton%27s_method

The basic idea is that given a real-valued differentiable function, f, we seek
the root to the equation f(x) = 0. To do this, we start with a guess root x0,
and use the formula

                  f(x0)
       x1 = x0 - -------
                  f'(x0)

where f' is the derivative of f. Then, from x1, we can compute x2, x3, etc, in
a similar manner:

                        f(x_i)
       x_{i+1} = x_i - --------               [1]
                       f'(x_i)

The idea is to contine this process until we find x_n such that

       x_n - x_{n-1} < δ

Here, δ is some threshold value that we predefine. Typically, the smaller the
δ, the more iterations are needed.

Function `newton_transform` below returns a lambda expression for computing the
next value x_{i+1} from the previous one; it essentially encodes the formula
[1] above.
*******************************************************************************)

let newton_transform (f: float -> float) : (float -> float) =
  let f' = deriv f
  in fun x -> x -. (f x /. f' x)

(*******************************************************************************
Given a function f, we say that value x is a _fixed point_ of function f, if it
holds that

        f(x) = x.

For some functions, the fixed point can be computed by starting  from an
initial guess, by applying f repeatedly.

        f (x),
        f (f (x)),
        f (f (f (x))),
        ...

With this idea, we derive the function `fixed_point_approx` that takes a
function as an argument and produces an approximation to the function's fixed
point.
*******************************************************************************)

let fixed_point_approx (f: float -> float) (first_guess: float): float =
  let tolerance = 0.0000001
  in let close_enough v1 v2 = (abs_float (v1 -. v2)) < tolerance
  in let rec test current_guess = (
      let new_guess = f current_guess
      in if close_enough new_guess current_guess
      then new_guess
      else test new_guess
    )
  in test first_guess

(*******************************************************************************
Finally, we can combine the `fixed_point_approx` and `newton_transform` to
define our top-level function for computing the root using the Newton's method.
*******************************************************************************)

let newton_method g = fixed_point_approx (newton_transform g)

(* Function print_newton is a wrapper around newton_method that also does some
   formatting of reals for better output *)

let print_newton g guess =
  let root = newton_method g guess
  in print_endline (string_of_float root)

(* One example of using this function

# print_newton sin 2.0;;
3.14159265359

*)
(* You can use an online graphing tool to double check what you get
     https://www.desmos.com/calculator *)

(* Here are some other example functions to play with *)

(* x^2  *)
let square x = x *. x

(* x^3  *)
let cube x = x *. x *. x

(* EXERCISE: test the evaluation of `deriv` on a few example functions such as
   x^2, x^3, sin, cos, etc (feel free to define your own functions here). Check
   that the computation of the derivatives is as expected. Note that you can
   also take a derivative of a derivative! *)


(* EXERCISE: define square and cubic roots using newton_method

   Hint: square root of y is a value x such that x^2 = y, i.e., the function
         must be of the form f = x^2 - y. Then we look for the value of x
         starting from some guess.

*)

exception NotImplemented
let sqrt' y = raise NotImplemented

let cubert' y = raise NotImplemented

(* After you've implemented the above, you should be able to try in REPL

# Newton.sqrt' 9.0;;
- : float = 3.0000000000000027
# Newton.cubert' 8.0;;
- : float = 2.0000000000000067

*)

end
