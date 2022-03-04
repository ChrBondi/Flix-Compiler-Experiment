fun main(args: Array<String>) {
    val constant_runtime = benchmark(::constants)
    val deadvariable_runtime = benchmark(::deadVariable)
    val functionmap_runtime = benchmark(::functionMap)
    val letmap1_runtime = benchmark(::letMap)
    val letmap2_runtime = benchmark(::letMap2)
    val purevar1_runtime = benchmark(::getVarPure)
    val purevar2_runtime = benchmark(::getVarPure)
    println()
    print_benchmark("Constant", constant_runtime)
    print_benchmark("DeadVariable", deadvariable_runtime)
    print_benchmark("FunctionMap", functionmap_runtime)
    print_benchmark("LetMap1", letmap1_runtime)
    print_benchmark("LetMap2", letmap2_runtime)
    print_benchmark("PureVar1", purevar1_runtime)
    print_benchmark("PureVar2", purevar2_runtime)
}

fun print_benchmark(name: String, runtime: Triple<Long, Long, Long>) {
    println(name + ": total runtime: " + runtime.first + " average runtime: " + runtime.second + " median runtime: " + runtime.third)

}

fun benchmark(f: (((List<Int>) -> Unit ) -> Unit)): Triple<Long, Long, Long> {
    val n = 1_000
    val times = benchmark_ac(n, f, emptyList())
    val totalTime = times.sum()
    val totalTimeSeconds = totalTime/1_000_000_000
    val average = totalTime/n/1_000_000
    val median = times.sorted()[n/2]/1_000_000
    //Seconds
    return Triple(totalTimeSeconds, average, median)
}

fun benchmark_ac(n: Int, f: ((List<Int>) -> Unit) -> Unit, acc: List<Long>): List<Long>  {
    if (n > 0) {
        val before = System.nanoTime()
        f({ l: List<Int> -> {}})
        val after = System.nanoTime()
        val time = (after - before)
        return benchmark_ac(n - 1, f, listOf(time) + acc)
    }
    else {
        return acc
    }
}

fun constants(hof: (List<Int>) -> Unit)  {
    val x = true
    val y = List(1_000_000){100}
    val z = 3
    val w = 4
    hof(if (!x) y else listOf(z,w))
}

fun deadVariable(hof: (List<Int>) -> Unit): Unit {
    val x = List(1_000_000){7}
    hof(emptyList())
}

fun double(x: Int): Int = x*2

fun functionMap(hof: (List<Int>) -> Unit): Unit {
    val list = List(1_000_000){7}
    val newList = list.map(::double)
    hof(newList)
}

fun letMap(hof: (List<Int>) -> Unit): Unit {
    val x = 5
    val list = List(1_000_000){7}
    val newList = list.map{y -> x+y}
    hof(newList)
}

fun letMap2(hof: (List<Int>) -> Unit): Unit {
    val x = 5+5
    val list =  List(1_000_000){7}
    val newList = list.map{y -> x+y}
    hof(newList)
}

fun get42() = 42
fun getHello42(): Int  {
    print("Hello")
    return 42
}

fun getVarPure(hof: (List<Int>) -> Unit): Unit {
    val x = get42()
    val list = List(1_000_000){7}
    val newList = list.map{y -> x + y}
    hof(newList)
}

fun getVarImpure(hof: (List<Int>) -> Unit): Unit {
    val x = getHello42()
    val list =  List(1_000_000){7}
    val newList = list.map{y -> x + y}
    hof(newList)
}