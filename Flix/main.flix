
def main(_args: Array[String]): Int32 & Impure =
    let iterations = 1000;
    let constant_runtime = benchmark(constants, iterations);
    let deadvariable_runtime = benchmark(deadVariable, iterations);
    let functionmap_runtime = benchmark(functionMap, iterations);
    let letmap_runtime = benchmark(letMap,iterations);
    let getvar_runtime = benchmark(getVar, iterations);
    let letmap2_runtime = benchmark(letMap2,iterations);
    let getvar2_runtime = benchmark(getVar2, iterations);

    println();
    println("Number of iterations: " + Int32.toString(iterations));
    println("Constant runtime: " + Float64.toString(constant_runtime) + "s");
    println("Dead Variable runtime: " + Float64.toString(deadvariable_runtime) + "s");
    println("FunctionMap runtime: " + Float64.toString(functionmap_runtime) + "s");
    println("letMap runtime: " + Float64.toString(letmap_runtime) + "s");    
    println("getVar runtime: " + Float64.toString(getvar_runtime) + "s");
    println("letMap2 runtime: " + Float64.toString(letmap2_runtime) + "s");    
    println("getVar2 runtime: " + Float64.toString(getvar2_runtime) + "s");

    0

def benchmark(f: (List[Int32] -> Unit) -> Unit & ef , n: Int32): Float64 & Impure =
    use Time/Epoch.nanoseconds;
    def loop(n1) = match n1 {
        case 0 => 0
        case _ => f((_: List[Int32]) -> ()); loop(n1-1)
    };
    let before = nanoseconds();
    loop(n);
    let after = nanoseconds();
    (Int64.toFloat64(after) - Int64.toFloat64(before)) / Int32.toFloat64(1_000_000_000)


def constants(hof : List[Int32] -> Unit): Unit & Pure = 
    let x = 1;
    let y = 2;
    let z = 3;
    let w = 4;
    hof(List.repeat(1_000_000, x+y+z+w))


def deadVariable(hof : List[Int32] -> Unit): Unit & Pure = 
    let _x = List.repeat(1_000_000, 7);
    hof(Nil)

def fib(n: Int32): Int32 & Pure =
    if (n == 0)  0 
    else if (n == 1) 1 
    else fib(n-2) + fib(n-1)

def double (x: Int32): Int32 = x*2

def functionMap(hof : List[Int32] -> Unit): Unit & Pure =    
    let list = List.repeat(1_000_000, 7);
    let newList = List.map(double, list);
    hof(newList)

def get42(): Int32 & Pure = 42

def getVar(hof : List[Int32] -> Unit): Unit & Pure = 
    let x = get42();
    let list = List.repeat(1_000_000, 7);
    let newList = List.map((y -> x+y), list);
    hof(newList)

def getHello42(): Int32 & Impure = print("Hello"); 42

def getVar2(hof : List[Int32] -> Unit): Unit & Impure = 
    let x = getHello42();
    let list = List.repeat(1_000_000, 7);
    let newList = List.map((y -> x+y), list);
    hof(newList)


def letMap(hof: List[Int32] -> Unit): Unit & Pure = 
    let x = 5;
    let list = List.repeat(1_000_000, 7);
    let newList = List.map((y -> x+y), list);
    hof(newList)

    
def letMap2(hof: List[Int32] -> Unit): Unit & Pure = 
    let x = 5+5;
    let list = List.repeat(1_000_000, 7);
    let newList = List.map((y -> x+y), list);
    hof(newList)