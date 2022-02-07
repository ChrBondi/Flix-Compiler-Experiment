def getVariable(): Int32 & Pure = 42

def pure(): Unit & Impure = 
    let x = getVariable();
    let list = List.repeat(1000000, 7);
    let newList = List.map((y -> x+y), list);
    print(newList)