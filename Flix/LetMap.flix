
def main(_args: Array[String]): Int32 & Impure = 
    let x = 5;
    let list = List.repeat(1000000, 7);
    let newList = List.map((y -> x+y), list);
    print(newList);
    x