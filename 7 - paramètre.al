set carre = function (x, y) {
algo.goTo (x, y);
loop (4) {
    	algo.go (100);
    	algo.turnRight (90);
  	}
};

carre (100, 100);
carre (100, -100);
carre (-100, -100);
