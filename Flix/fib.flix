def fib(n: Int32): Int32 & Pure =
    if (n == 0)  0 
    else if (n == 1) 1 
    else fib(n-2) + fib(n-1)
    
def main(_args: Array[String]): Int32 & Impure = 
    print(fib(15));
    0
