object main {
  def main(args: Array[String]): Unit = {

    val constant_runtime = benchmark(constant.constants)
    val deadvariable_runtime = benchmark(deadVariable.deadVariable)
    val functionmap_runtime = benchmark(functionMap.functionMap)
    val letmap1_runtime = benchmark(letMap.letMap)
    val letmap2_runtime = benchmark(letMap.letMap2)
    val purevar1_runtime = benchmark(pureVar.pure)
    val purevar2_runtime = benchmark(pureVar.pure2)
    println()
    println("Constant runtime: " + constant_runtime)
    println("Dead Variable runtime: " + deadvariable_runtime)
    println("FunctionMap runtime: " + functionmap_runtime)
    println("LetMap1 runtime: " + letmap1_runtime)
    println("LetMap2 runtime: " + letmap2_runtime)
    println("PureVar1 runtime: " + purevar1_runtime)
    println("PureVar2 runtime: " + purevar2_runtime)
  }

  def benchmark(f: (List[Int] => Unit ) => Unit): Long = {
    val before = System.nanoTime()
    benchmark_ac(10_000, f)
    val after = System.nanoTime()
    //Seconds
    (after - before) / 1000000000
  }

  def benchmark_ac(n: Int, f: (List[Int] => Unit) => Unit): Unit = {
    if (n > 0) {
      f((l: List[Int]) => ())
      benchmark_ac(n - 1, f)
    }
  }
}
