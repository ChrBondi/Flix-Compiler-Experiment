let get42 = 42

let getVar = 
    let x = get42 in
    let list = List.init 1000000 (fun _ -> 7) in
    let newList = List.map (fun y -> x+y) list in
    List.iter (Printf.printf "%d ") newList

let getHello42 = Printf.printf "Hello"; 42

let getVar2 = 
    let x = getHello42 in
    let list = List.init 1000000 (fun _ -> 7) in
    let newList = List.map (fun y -> x+y) list in
    List.iter (Printf.printf "%d ") newList