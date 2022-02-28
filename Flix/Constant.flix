def constants(hof : List[Int32] -> Unit): Unit & Pure = 
    let x = 1;
    let y = 2;
    let z = 3;
    let w = 4;
    hof(List.repeat(1_000_000, x+y+z+w))