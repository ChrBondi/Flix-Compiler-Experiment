object constant {
  def constants(hof: List[Int] => Unit): Unit = {
    val x = true
    val y = List.fill(1_000_000)(100)
    val z = 3
    val w = 4
    hof(if (!x) y else List(z,w))
  }
}
