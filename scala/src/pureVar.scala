object pureVar {

  def get42() = 42
  def getHello42: Int =  {
    print("Hello")
    42
  }

  def pure(): Unit = {
    val x = get42()
    val list = List.fill(1000000)(7)
    val newList = list.map(y => x + y)
    print(newList)
  }

  def pure2(): Unit = {
    val x = getHello42
    val list = List.fill(1_000_000)(7)
    val newList = list.map(y => x + y)
    print(newList)
  }
}
