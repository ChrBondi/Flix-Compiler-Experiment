def double (x: Int): Int32 = x*2

def functionMap(hof : List[Int32] -> Unit): Unit & Pure =    
    let list = List.repeat(1_000_000, 7);
    let newList = List.map(double, list);
    hof(newList)