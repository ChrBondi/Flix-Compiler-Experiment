

let list_lenght = 200_000
let constants = fun () ->
  let x = 1 in
  let y = 2 in
  let z = 3 in
  let w = 4 in
  (*
  let list = List.init (list_lenght) (fun _ -> x+y+z+w) in
  print_endline "\nconstants";
  print_int (List.hd list) 
  *)
  List.iter (Printf.printf "%d ") (List.init (1_000_000) (fun _ -> x+y+z+w)) (* TODO ændrer tilbage*)

let deadVariable = fun () ->
    let _x = List.init list_lenght (fun _ -> 7) in
    print_string "\ndeadVariable called"

let double x = x*2
let functionMap =  fun() ->  
        let list = List.init list_lenght (fun _ -> 7) in (* TODO tilbage*)
        let newList = List.map double list in
        (*
        print_endline "\nfunctionMap";
        print_int (List.hd newList)
        *)
        List.iter (Printf.printf "%d ") newList

let get42 = 42
let getHello42 = Printf.printf "Hello"; 42

let getVar = fun() ->
            let x = get42 in
            let list = List.init list_lenght (fun _ -> 7) in
            let newList = List.map (fun y -> x+y) list in
            List.iter (Printf.printf "%d ") newList
        
let getVar2 = fun () ->
            let x = getHello42 in
            let list = List.init list_lenght (fun _ -> 7) in
            let newList = List.map (fun y -> x+y) list in
            List.iter (Printf.printf "%d ") newList


let letMap = fun () ->
              let x = 5 in
              let list = List.init list_lenght (fun _ -> 7) in
              let newList = List.map (fun y -> x + y) list in
              List.iter (Printf.printf "%d ") newList
          
              
let letMap2 = fun () ->
              let x = 5+5 in
              let list = List.init list_lenght (fun _ -> 7) in
              let newList = List.map (fun y -> x+y) list in
              List.iter (Printf.printf "%d ") newList


let benchmark f n =
  let rec loop(n1) = match n1 with
    | 0 -> ()
    | _ -> f(); loop(n1-1) in
  let before = Unix.gettimeofday () in (* in seconds*)
  loop(n);
  let after = Unix.gettimeofday () in (* in seconds*)
  (after -. before)

let main = fun () -> 
    let iterations = 50 in
    
    let constant_runtime = benchmark constants iterations in
    let deadvariable_runtime = benchmark deadVariable iterations in
    let functionmap_runtime = benchmark functionMap iterations in
    let letmap_runtime = benchmark letMap iterations in
    let letmap2_runtime = benchmark letMap2 iterations in
    let getvar_runtime = benchmark getVar iterations in
    let getvar2_runtime = benchmark getVar2 iterations in
    

    print_string ("\nConstant runtime: " ^ (string_of_float constant_runtime) ^ " s");
    print_string ("\nDead Variable runtime: " ^ (string_of_float deadvariable_runtime) ^ " s");
    print_string ("\nFunctionMap runtime: " ^ (string_of_float functionmap_runtime) ^ " s");
    print_string ("\nletMap runtime: " ^ (string_of_float letmap_runtime) ^ " s");
    print_string ("\nletMap2 runtime: " ^ (string_of_float letmap2_runtime) ^ " s");
    print_string ("\ngetVar runtime: " ^ (string_of_float getvar_runtime) ^ " s");
    print_string ("\ngetVar2 runtime: " ^ (string_of_float getvar2_runtime) ^ " s");
    print_endline "";
    ()


let () = main()
