object deadVariable {

  def deadVariable(): Unit = {
    val x = List.fill(1_000_000)(7)
    print()
  }
}


