set draw = function (x, y) {
	algo.goTo (x, y);
	algo.disc (25);
}

set changeColor = function () {
	algo.setColor (math.random(16));
}

algo.hide();
algo.onTouch(draw);
util.pulse(changeColor, 1500); // pour les plus avancés