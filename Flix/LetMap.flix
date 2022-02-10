
def letMap(): Unit & Impure = 
    let x = 5;
    let list = List.repeat(1_000_000, 7);
    let newList = List.map((y -> x+y), list);
    print(newList)

    
def _letMap(): Unit & Impure = 
    let x = 5+5;
    let list = List.repeat(1_000_000, 7);
    let newList = List.map((y -> x+y), list);
    print(newList)