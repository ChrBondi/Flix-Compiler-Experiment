object constant {
  def constants(): Unit = {
    val x = 1
    val y = 2
    val z = 3
    val w = 4
    print(List.fill(1_000_000)(x+y+z+w))
  }
}
