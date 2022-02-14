let constants =
    let x = 1 in
    let y = 2 in
    let z = 3 in
    let w = 4 in
    List.iter (Printf.printf "%d ") (List.init (1_000_000) (fun _ -> x+y+z+w))