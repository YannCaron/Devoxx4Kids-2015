set nbCote = 8
set angle = 360 / nbCote // 45°

loop (nbCote) {
  algo.go (100)
  algo.turnRight
    (angle)
}
