
set int = function {
        ui.fullScreen ();
        ui.hideMenu ();
        algo.hide ();
        // setting up the ui.
        algo.setBgColor (15); 
        algo.goTo (0,-550);
        algo.setColor (7) //gray
        algo.plane (1100,460)
        algo.setColor (15) //white
        algo.rect (1005,405)
        algo.goTo  (-400,-650);
        algo.setColor(12); // red
        algo.plane (200,200);
        algo.goTo (-200,-650);
        algo.setColor (10); //green
        algo.plane (200,200);
        algo.goTo (0,-650);
        algo.setColor (11); //cyan
        algo.plane (200,200);
        algo.goTo  (200,-650);
        algo.setColor (0); //black
        algo.plane (200,200);
        algo.goTo  (400,-650);
        algo.setColor(15); //white eraeser bg.
        algo.plane (200,200);
        algo.setColor (0);//Black square around eraeser.
        algo.square (195,195);
        algo.text ("Eraser")
        //Brush size selection.
        algo.setColor (15);//White bg.
        algo.goTo (0,-450);
        algo.plane  (1000,200);
        algo.setColor (0);
        algo.goTo  (-400,-450);
        algo.disc(10)
        algo.goTo (-200,-450);
        algo.disc (20)
        algo.goTo (0,-450);
        algo.rect (995,195)
        algo.disc (40)
        algo.goTo  (200,-450);
        algo.disc (80)
        algo.goTo  (400,-450);
        algo.disc (160)
}
set draw = function  (x,y) {
        algo.lineTo (x,y) // Draws the line
}


set jump = function (x,y)  {
        algo.goTo(x,y) // Jumps to the posistion you tap
        if  (x<-300 && y<-550){ // If you press the red square...
                algo.setColor(12) // Set color to red.
        } else if   (x>-300 && x<-100 && y<-550) { // If green square...
                algo.setColor (10) // Set to green.
        } else if  (x> -100 && x <100 && y<-550) { // If cyan square...
                algo.setColor (11); // Set to cyan.
        }else if  (x>100 && x<300 && y<-550) { // If Black square...
                algo.setColor (0); // Set to black.
        } else if  (x>300 && y <-550) { // If ereaser...
                algo.setColor  (15)// Set to white.
        }else if  (x>-500 && x<-300 && y<-350 && y>-550) {
                algo.setStroke (1);
        }else if  (x>-300 && x<-100 && y<-350 && y>-550) {
                algo.setStroke (4);
        }else if  (x>-100 && x<100 && y<-350 && y>-550) {
                algo.setStroke (7);
        }else if  (x>100 && x<300 && y<-350 && y>-550) {
                algo.setStroke (15);
        }else if  (x>300 && x<500 && y<-350 && y>-550) {
                algo.setStroke (30);
        }
        
        
        //algo.text  (x .. y) 
}

int ();
algo.onTap (jump)
algo.onTouch (draw)







 
