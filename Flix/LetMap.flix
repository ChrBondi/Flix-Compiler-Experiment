
def letMap(hof: List[Int32] -> Unit): Unit & Pure = 
    let x = 5;
    let list = List.repeat(1_000_000, 7);
    let newList = List.map((y -> x+y), list);
    hof(newList)

    
def letMap2(hof: List[Int32] -> Unit): Unit & Pure = 
    let x = 5+5;
    let list = List.repeat(1_000_000, 7);
    let newList = List.map((y -> x+y), list);
    hof(newList)