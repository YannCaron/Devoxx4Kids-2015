set carre = function (x, y) {
algo.clear ();
algo.goTo (x, y);
loop (4) {
    	algo.go (100);
    	algo.turnRight (90);
  	}
};

algo.onTouch (carre);
