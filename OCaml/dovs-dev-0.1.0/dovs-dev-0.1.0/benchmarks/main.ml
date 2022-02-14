
let constants = fun () ->
  let x = 1 in
  let y = 2 in
  let z = 3 in
  let w = 4 in
  List.iter (Printf.printf "%d ") (List.init (1_000_000) (fun _ -> x+y+z+w))

  let deadVariable = fun () ->
    let _x = List.init 1_000_000 (fun _ -> 7) in
    Printf.printf ""

let double x = x*2
let functionMap =  fun() ->  
        let list = List.init 1_000_000 (fun _ -> 7) in
        let newList = List.map double list in
        List.iter (Printf.printf "%d ") newList

let get42 = 42
let getHello42 = Printf.printf "Hello"; 42

let getVar = fun() ->
            let x = get42 in
            let list = List.init 1000000 (fun _ -> 7) in
            let newList = List.map (fun y -> x+y) list in
            List.iter (Printf.printf "%d ") newList
        
let getVar2 = fun () ->
            let x = getHello42 in
            let list = List.init 1000000 (fun _ -> 7) in
            let newList = List.map (fun y -> x+y) list in
            List.iter (Printf.printf "%d ") newList


let letMap = fun () ->
              let x = 5 in
              let list = List.init 1000000 (fun _ -> 7) in
              let newList = List.map (fun y -> x + y) list in
              List.iter (Printf.printf "%d ") newList
          
              
let letMap2 = fun () ->
              let x = 5+5 in
              let list = List.init 1000000 (fun _ -> 7) in
              let newList = List.map (fun y -> x+y) list in
              List.iter (Printf.printf "%d ") newList


let benchmark f n =
  let rec loop(n1) = match n1 with
    | 0 -> 0
    | _ -> f(); loop(n1-1) in
  let before = Unix.gettimeofday () in (* in seconds*)
  loop(n);
  let after = Unix.gettimeofday () in (* in seconds*)
  (after -. before)

let main = fun () -> 
    let iterations = 1000 in
    let constant_runtime = benchmark constants iterations in
    let deadvariable_runtime = benchmark deadVariable iterations in
    let functionmap_runtime = benchmark functionMap iterations in
    let letmap_runtime = benchmark letMap iterations in
    let letmap2_runtime = benchmark letMap2 iterations in
    let getvar_runtime = benchmark getVar iterations in
    let getvar2_runtime = benchmark getVar2 iterations in

    Printf.printf "Constant runtime:  %f s" constant_runtime;
    Printf.printf "Dead Variable runtime: %f s" deadvariable_runtime;
    Printf.printf "FunctionMap runtime: %f s" functionmap_runtime;
    Printf.printf "letMap runtime: %f s" letmap_runtime;
    Printf.printf "letMap2 runtime: %f s" letmap2_runtime;
    Printf.printf "getVar runtime: %f s" getvar_runtime;
    Printf.printf "getVar2 runtime: %f s" getvar2_runtime;
    ()


let () = main()
