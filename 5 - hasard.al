set nbCote = math.random(10)
set angle = 360 / nbCote // ??°

loop (nbCote) {
  algo.go (150)
  algo.turnRight (angle)
}
