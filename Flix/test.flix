pub def foo(): Int32 = 
    def bar(y: Int32) = y;
    let x = 42;
    bar(x)

def main(): String & Impure =
    print("Hello");
    let _ = foo();
    "hello"