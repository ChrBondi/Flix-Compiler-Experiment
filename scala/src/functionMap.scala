object functionMap {
  def double(x: Int): Int = x*2

  def functionMap(hof: List[Int] => Unit): Unit = {
    val list = List.fill(1000000)(7)
    val newList = list.map(double)
    hof(newList)
  }
}
