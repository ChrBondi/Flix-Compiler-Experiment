

def main(_args: Array[String]): Int32 & Impure =
    let constant_runtime = benchmark(constants, 10);
    let deadvariable_runtime = benchmark(deadVariable, 100);
    let functionmap_runtime = benchmark(functionMap, 10);
    let letmap_runtime = benchmark(letMap,10);
    let getvar_runtime = benchmark(getVar, 10);

    println();

    println("Constant runtime: " + Float64.toString(constant_runtime) + "s");
    println("Dead Variable runtime: " + Float64.toString(deadvariable_runtime) + "s");
    println("FunctionMap runtime: " + Float64.toString(functionmap_runtime) + "s");
    println("letMap runtime: " + Float64.toString(letmap_runtime) + "s");    
    println("getVar runtime: " + Float64.toString(getvar_runtime) + "s");

    0

def benchmark(f: Unit -> Unit & ef , n: Int32): Float64 & Impure =
    def loop(n1) = match n1 {
        case 0 => 0
        case _ => f(); loop(n1-1)
    };
    let before = Epoch.nanoseconds();
    loop(n);
    let after = Epoch.nanoseconds();
    (Int64.toFloat64(after) - Int64.toFloat64(before)) / Int32.toFloat64(1_000_000_000)
