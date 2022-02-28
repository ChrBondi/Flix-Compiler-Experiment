def deadVariable(hof : List[int] -> Unit): Unit & Pure = 
    let _x = List.repeat(1_000_000, 7);
    hof(Nil)