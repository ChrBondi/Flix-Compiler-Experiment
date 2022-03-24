def foo(x: Int32): Int32 = bar(7, x)

def bar(x: Int32, y: Int32): Int32 = x+y

def main(_args: Array[String]): Int32 & Impure =
 print(foo(5))
 0