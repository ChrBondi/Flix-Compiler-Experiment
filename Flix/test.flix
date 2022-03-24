pub def foo(): Int32 = 
    def bar(y: Int32) = y;
    let x = 42;
    bar(x)

def _main2(_args: Array[String]): Int32 & Impure =
    print("Hello");
    foo()