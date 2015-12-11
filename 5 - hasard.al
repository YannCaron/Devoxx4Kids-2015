set nbCote = 3 + math.random(14)
set angle = 360 / nbCote // ??°

loop (nbCote) {
  algo.go (150)
  algo.turnRight (angle)
}
