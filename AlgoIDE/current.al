set stamp = algo.stamp.load("PlanetCute/Star");

algo.onTouch((x, y){
	algo.turnLeft(math.random(360));
	algo.goTo(x, y);
	util.pulse({
		algo.autoClear();
		algo.go(5);
		stamp.draw();
	});
	
});
algo.hide();
