set stamp = algo.stamp.load("PlanetCute/Character Princess Girl");

algo.onTouch((x, y) {
	algo.autoClear();
	algo.goTo(x, y);
  stamp.draw();
});
algo.hide();
 