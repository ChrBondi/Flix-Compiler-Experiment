use Time/Epoch.nanoseconds;

def main(_args: Array[String]): Int32 & Impure =
    let constant_runtime = benchmark(constants, 10);
    let deadvariable_runtime = benchmark(deadVariable, 100);
    let functionmap_runtime = benchmark(functionMap, 10);
    let letmap_runtime = benchmark(letMap,10);
    let getvar_runtime = benchmark(getVar, 10);
    let letmap2_runtime = benchmark(letMap2,10);
    let getvar2_runtime = benchmark(getVar2, 10);

    println();

    println("Constant runtime: " + Float64.toString(constant_runtime) + "s");
    println("Dead Variable runtime: " + Float64.toString(deadvariable_runtime) + "s");
    println("FunctionMap runtime: " + Float64.toString(functionmap_runtime) + "s");
    println("letMap runtime: " + Float64.toString(letmap_runtime) + "s");    
    println("getVar runtime: " + Float64.toString(getvar_runtime) + "s");
    println("letMap2 runtime: " + Float64.toString(letmap2_runtime) + "s");    
    println("getVar2 runtime: " + Float64.toString(getvar2_runtime) + "s");

    0

def benchmark(f: (List[Int32] -> Unit) -> Unit & ef , n: Int32): Float64 & Impure =
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

def deadVariable(hof : List[int] -> Unit): Unit & Pure = 
    let _x = List.repeat(1_000_000, 7);
    hof(Nil)

def double (x: Int32): Int32 = x*2

def functionMap(hof : List[Int32] -> Unit): Unit & Pure =    
    let list = List.repeat(1_000_000, 7);
    let newList = List.map(double, list);
    hof(newList)

def getVariable(): Int32 & Pure = 42

def getVar(hof : List[Int32] -> Unit): Unit & Pure = 
    let x = getVariable();
    let list = List.repeat(1000000, 7);
    let newList = List.map((y -> x+y), list);
    hof(newList)

def getVariable2(): Int32 & Impure = print("Hello"); 42

def getVar2(hof : List[Int32] -> Unit): Unit & Impure = 
    let x = getVariable2();
    let list = List.repeat(1000000, 7);
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