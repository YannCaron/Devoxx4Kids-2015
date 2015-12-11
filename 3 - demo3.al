set nbCote = 4
set angle = 360 / nbCote // 90°

loop (nbCote) {
  algo.go (100)
  algo.turnRight (angle)
}
