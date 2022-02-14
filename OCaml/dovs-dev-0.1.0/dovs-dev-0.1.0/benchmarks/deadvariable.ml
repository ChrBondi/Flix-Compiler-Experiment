let deadVariable = 
    let _x = List.init 1_000_000 (fun _ -> 7) in
    Printf.printf ""