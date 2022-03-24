
def main(_args: Array[String]): Int32 & Impure =
    let iterations = 1000;

    let deadvariable_runtime = benchmark(deadVariable, iterations);

    print_benchmark("DeadVariable", deadvariable_runtime);
    0

def print_benchmark(name: String, runtime: (Int64, Int64, Int64)): Unit & Impure = {
    let (totalTimeSeconds, average, median) = runtime;
    println(name + ": total runtime: " + Int64.toString(totalTimeSeconds) + " average runtime: " + Int64.toString(average) + " median runtime: " + Int64.toString(median))
}

def benchmark(f: (List[Int32] -> Unit) -> Unit, n: Int32): (Int64, Int64, Int64) & Impure = {
    let times = benchmark_ac(n, f, Nil); 
    getStatisticalData(n, times)
}

def benchmark_ac(n: Int32, f: ((List[Int32]) -> Unit) -> Unit, acc: List[Int64]): List[Int64] & Impure = {
    if (n > 0) {
        let before = timeInNanoSeconds();
        let _ = f((_: List[Int32]) -> ()) as & Impure; //Dead 
        let after = timeInNanoSeconds();
        let time = (after - before);
        println(time);
        benchmark_ac(n - 1, f, time :: acc)
    }
    else {
        acc
    }
}

def timeInNanoSeconds(): Int64 & Impure = {
    use Time/Epoch.nanoseconds;
    nanoseconds()
    //Epoch.nanoseconds()
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
    let middle_elm_lst = List.slice(n/2, (n/2)+1, lst);
    Option.getWithDefault(Int32.toInt64(0), List.head(middle_elm_lst))
}

def averageTime(totalTime: Int64, n: Int32): Int64 = {
    let avg_nano = (totalTime/Int32.toInt64(n));
    avg_nano/Int32.toInt64(1_000_000)
}

def totalTimeToSeconds(totalTime: Int64): Int64 = {
    totalTime/Int32.toInt64(1_000_000_000)
}

def deadVariable(hof : List[Int32] -> Unit): Unit & Pure = 
    let _x = List.repeat(1_000_000, 7);
    hof(Nil)
