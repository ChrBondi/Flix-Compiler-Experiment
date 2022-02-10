object functionMap {
  def double(x: Int): Int = x*2

  def functionMap(): Unit = {
    val list = List.fill(1_000_000)(7)
    val newList = list.map(double)
    print(newList)
  }
}
