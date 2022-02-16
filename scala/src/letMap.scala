object letMap {

  def letMap(hof: List[Int] => Unit): Unit = {
    val x = 5
    val list = List.fill(1000000)(7)
    val newList = list.map(y => x+y)
    hof(newList)
  }

  def letMap2(hof: List[Int] => Unit): Unit = {
    val x = 5+5
    val list = List.fill(1000000)(7)
    val newList = list.map(y => x+y)
    hof(newList)
  }
}
