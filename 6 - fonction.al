set carre = function () {
  loop (4) {
    algo.go (100)
    algo.turnRight (90)
  }
}

algo.goTo(50, 50)
carre ()
algo.goTo(-100, -100)
carre ()
algo.goTo(50, -150)
carre ()
algo.goTo(25, 90)
carre ()
