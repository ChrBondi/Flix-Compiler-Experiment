object pureVar {

  def get42() = 42
  def getHello42: Int =  {
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
}
