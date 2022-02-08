def constants(): Unit & Impure = 
    let x = 1;
    let y = 2;
    let z = 3;
    let w = 4;
    print(List.repeat(1_000_000, x+y+z+w))