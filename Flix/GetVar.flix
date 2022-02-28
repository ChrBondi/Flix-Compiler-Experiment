def _getVariable(): Int32 & Pure = 42

def _getVar(hof : List[Int32] -> Unit): Unit & Pure = 
    let x = getVariable();
    let list = List.repeat(1000000, 7);
    let newList = List.map((y -> x+y), list);
    hof(newList)

def _getVariable2(): Int32 & Impure = print("Hello"); 42

def _getVar2(hof : List[Int32] -> Unit): Unit & Impure = 
    let x = getVariable2();
    let list = List.repeat(1000000, 7);
    let newList = List.map((y -> x+y), list);
    hof(newList)