import java.time.LocalDate

object main {
  def main(args: Array[String]): Unit = {

    val constant_runtime = benchmark(constant.constants)
    val deadvariable_runtime = benchmark(deadVariable.deadVariable)
    val functionmap_runtime = benchmark(functionMap.functionMap)
    val letmap_runtime = benchmark(letMap.letMap)
    val purevar_runtime = benchmark(pureVar.pure)
    println()
    println("Constant runtime: " + constant_runtime)
    println("Dead Variable runtime: " + deadvariable_runtime)
    println("FunctionMap runtime: " + functionmap_runtime)
    println("LetMap runtime: " + letmap_runtime)
    println("PureVar runtime: " + purevar_runtime)

  }

  def benchmark(f: () => Unit): Long = {
    val before = System.nanoTime()
    benchmark_ac(1000, f)
    val after = System.nanoTime()
    //Seconds
    ((after - before) / 1_000_000_000)
  }

  def benchmark_ac(n: Int, f: () => Unit): Unit = {
    if (n > 0) {
      f()
      benchmark_ac(n - 1, f)
    }
  }
}
