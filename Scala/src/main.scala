object main {
  def main(args: Array[String]): Unit = {
    val constant_runtime = benchmark(constants)
    val deadvariable_runtime = benchmark(deadVariable)
    val functionmap_runtime = benchmark(functionMap)
    val letmapconstant_runtime = benchmark(letMapConstant)
    val letmapadd_runtime = benchmark(letMapAdd)
    val get_var_pure_runtime = benchmark(getVarPure)
    val get_var_impure_runtime = benchmark(getVarImpure)
    println()
    print_benchmark("Constant", constant_runtime)
    print_benchmark("DeadVariable", deadvariable_runtime)
    print_benchmark("FunctionMap", functionmap_runtime)
    print_benchmark("LetMapConstant", letmapconstant_runtime)
    print_benchmark("LetMapAdd", letmapadd_runtime)
    print_benchmark("GetVarPure", get_var_pure_runtime)
    print_benchmark("GetVarImpure", get_var_impure_runtime)
  }

  def print_benchmark(name: String, runtime: (Long, Long, Long)) {
    println(name + ": total runtime: " + runtime._1 + " s, average runtime: " + runtime._2 + " ms, median runtime: " + runtime._3 + " ms")
  }

  def benchmark(f: (List[Int] => Unit) => Unit): (Long, Long, Long) = {
    val n = 1_000
    val times = benchmark_ac(n, f, Nil)
    val totalTime = times.foldLeft(0.0)(_ + _)
    val totalTimeSeconds = totalTime / 1_000_000_000
    val average = totalTime / n / 1_000_000
    val median = times.sortWith(_ > _).apply(n / 2) / 1_000_000
    (totalTimeSeconds.toLong, average.toLong, median)
  }

  def benchmark_ac(n: Int, f: (List[Int] => Unit) => Unit, acc: List[Long]): List[Long] = {
    if (n > 0) {
      val before = System.nanoTime()
      f((l: List[Int]) => ())
      val after = System.nanoTime()
      val time = (after - before)
      benchmark_ac(n - 1, f, time :: acc)
    }
    else acc
  }

    def constants(hof: List[Int] => Unit): Unit = {
      val x = true
      val y = List.fill(1_000_000)(100)
      val z = 3
      val w = 4
      hof(if (!x) y else List(z, w))
    }

    def deadVariable(hof: List[Int] => Unit): Unit = {
      val x = List.fill(1000000)(7)
      hof(List())
    }

    def double(x: Int): Int = x * 2

    def functionMap(hof: List[Int] => Unit): Unit = {
      val list = List.fill(1000000)(7)
      val newList = list.map(double)
      hof(newList)
    }

    def letMapConstant(hof: List[Int] => Unit): Unit = {
      val x = 5
      val list = List.fill(1000000)(7)
      val newList = list.map(y => x + y)
      hof(newList)
    }

    def letMapAdd(hof: List[Int] => Unit): Unit = {
      val x = 5 + 5
      val list = List.fill(1000000)(7)
      val newList = list.map(y => x + y)
      hof(newList)
    }

    def get42() = 42

    def getHello42: Int = {
      print("Hello")
      42
    }

    def getVarPure(hof: List[Int] => Unit): Unit = {
      val x = get42()
      val list = List.fill(1000000)(7)
      val newList = list.map(y => x + y)
      hof(newList)
    }

    def getVarImpure(hof: List[Int] => Unit): Unit = {
      val x = getHello42
      val list = List.fill(1000000)(7)
      val newList = list.map(y => x + y)
      hof(newList)
    }

    def fib(n: Int): Int = {
      if (n == 0) 0
      else if (n == 1) 1
      else fib(n - 2) + fib(n - 1)
    }
  }