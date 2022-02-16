object deadVariable {

  def deadVariable(hof: List[Int] => Unit): Unit = {
    val x = List.fill(1000000)(7)
    hof(List())
  }
}


