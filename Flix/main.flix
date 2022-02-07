def main(_args: Array[String]): Int32 & Impure =
    letMap();
    functionMap();
    print(fib(15));
    pure();
    deadVariable();
    0