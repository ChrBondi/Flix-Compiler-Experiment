def double (x: Int): Int32 = x*2

def functionMap(): Unit & Impure =    
    let list = List.repeat(1_000_000, 7);
    let newList = List.map(double, list);
    print(newList)