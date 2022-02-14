let letMap = 
    let x = 5 in
    let list = List.init 1000000 (fun _ -> 7) in
    let newList = List.map (fun y -> x + y) list in
    List.iter (Printf.printf "%d ") newList

    
let letMap2 = 
    let x = 5+5 in
    let list = List.init 1000000 (fun _ -> 7) in
    let newList = List.map (fun y -> x+y) list in
    List.iter (Printf.printf "%d ") newList