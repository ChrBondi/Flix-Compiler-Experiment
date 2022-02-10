def deadVariable(): Unit & Impure = 
    let _x = List.repeat(1_000_000, 7);
    print()