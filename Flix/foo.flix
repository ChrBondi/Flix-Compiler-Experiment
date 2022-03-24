def f(x: Int32): Int32 = g(x)

def g(x: Int32): Int32 = x!

def h(): Int32 = 5

def _main(_args: Array[String]): Int32 & Impure = f(h())