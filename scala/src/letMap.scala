object letMap {

  def letMap(): Unit = {
    val x = 5
    val list = List.fill(1_000_000)(7)
    val newList = list.map(y => x+y)
    print(newList)
  }

  def letMap2(): Unit = {
    val x = 5+5
    val list = List.fill(1_000_000)(7)
    val newList = list.map(y => x+y)
    print(newList)
  }
}
