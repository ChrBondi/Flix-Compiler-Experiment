
def main(_args: Array[String]): Int32 & Impure =
    let iterations = 1000;

    let constant_runtime = benchmark(constants, iterations);
    let deadvariable_runtime = benchmark(deadVariable, iterations);
    let functionmap_runtime = benchmark(functionMap, iterations);
    let letmapconstant_runtime = benchmark(letMap,iterations);
    let letmapadd_runtime = benchmark(letMap2,iterations);
    let get_var_pure_runtime = benchmark(getVar, iterations);
    let get_var_impure_runtime = benchmark_impure(getVar2, iterations);

    println();
    print_benchmark("Constant", constant_runtime);
    print_benchmark("DeadVariable", deadvariable_runtime);
    print_benchmark("FunctionMap", functionmap_runtime);
    print_benchmark("LetMapConstant", letmapconstant_runtime);
    print_benchmark("LetMapAdd", letmapadd_runtime);
    print_benchmark("GetVarPure", get_var_pure_runtime);
    print_benchmark("GetVarImpure", get_var_impure_runtime);

    0

def print_benchmark(name: String, runtime: (Int64, Int64, Int64)): Unit & Impure = {
    let (totalTimeSeconds, average, median) = runtime;
    println(name + ": total runtime: " + Int64.toString(totalTimeSeconds) + " average runtime: " + Int64.toString(average) + " median runtime: " + Int64.toString(median))
}

def benchmark(f: (List[Int32] -> Unit) -> Unit, n: Int32): (Int64, Int64, Int64) & Impure = {
    let times = benchmark_ac(n, f, Nil); 
    getStatisticalData(n, times)
}

def benchmark_impure(f: (List[Int32] -> Unit) -> Unit & Impure, n: Int32): (Int64, Int64, Int64) & Impure = {
    let times = benchmark_ac_impure(n, f, Nil);
    getStatisticalData(n, times)
}

def benchmark_ac(n: Int32, f: ((List[Int32]) -> Unit) -> Unit, acc: List[Int64]): List[Int64] & Impure = {
    use Time/Epoch.nanoseconds;
    if (n > 0) {
        let before = nanoseconds();

        let _ = f((_: List[Int32]) -> ());

        let after = nanoseconds();
        let time = (after - before);
        benchmark_ac(n - 1, f, time :: acc)
    }
    else {
        acc
    }
}

def benchmark_ac_impure(n: Int32, f: ((List[Int32]) -> Unit) -> Unit & Impure, acc: List[Int64]): List[Int64] & Impure = {
    use Time/Epoch.nanoseconds;
    if (n > 0) {
        let before = nanoseconds();
        let _  = f((_: List[Int32]) -> ());
        let after = nanoseconds();
        let time = (after - before);
        benchmark_ac_impure(n - 1, f, time :: acc)
    }
    else {
        acc
    }
}


def getStatisticalData(n: Int32, times: List[Int64]): (Int64, Int64, Int64) = {
    let median = medianTime(n, times);

    let totalTime = List.foldLeft(((acc, e) -> acc + e), Int32.toInt64(0), times); // Int64
    let totalTimeSeconds = totalTimeToSeconds(totalTime);
    let average = averageTime(totalTime, n);

    //Seconds
    (totalTimeSeconds, average, median)
}

def medianTime(n: Int32, times: List[Int64]): Int64 = {
    let sorted = List.sort(times);
    let middle_elm = middle_elm(sorted, n);
    (middle_elm)/Int32.toInt64(1_000_000)
}

def middle_elm(lst: List[Int64], n: Int32): Int64 = {
    let middle_elm_lst = List.slice(n/2, n/2, lst);
    Option.getWithDefault(Int32.toInt64(0), List.head(middle_elm_lst))
}

def averageTime(totalTime: Int64, n: Int32): Int64 = {
    let avg_nano = (totalTime/Int32.toInt64(n));
    avg_nano/Int32.toInt64(1_000_000)
}

def totalTimeToSeconds(totalTime: Int64): Int64 = {
    totalTime/Int32.toInt64(1_000_000_000)
}


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