let double x = x*2
let functionMap =    
    let list = List.init 1_000_000 (fun _ -> 7) in
    let newList = List.map double list in
    List.iter (Printf.printf "%d ") newList