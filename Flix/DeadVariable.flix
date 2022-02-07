def deadVariable(): Unit & Impure = 
    let x = List.repeat(1000000, 7);
    if (true) print() else print(x)