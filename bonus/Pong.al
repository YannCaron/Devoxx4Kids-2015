
algo.hide()
set f11 = ui.fullScreen

set mouse = object(){
        set x = 0
        set y = 0
        set down = 0
}

set global = object(){
        set onPage = "menu"
}

set hud = object(){
        set borders = function(){
                algo.goTo(algo.getLeft(), algo.getTop())
                algo.lineTo(algo.getRight(), algo.getTop())
                algo.goTo(algo.getLeft(), algo.getBottom())
                algo.lineTo(algo.getRight(), algo.getBottom())
        }
        set names = function(){
                algo.goTo(algo.getLeft() + 100, algo.getTop() - 20)
                algo.text("p1")
                algo.goTo(algo.getRight() - 100, algo.getTop() - 20)
                algo.text(game.p2.name)
        }
        set score = function(){
                algo.goTo(0, algo.getTop() - 20)
                algo.text(game.p1.pts .. ":" .. game.p2.pts)
        }
}

util.pulse(function(){
        algo.autoClear()
        f11()
        if(global.onPage == "menu"){
                //Draw Pong!
                algo.goTo(0, algo.getTop() - 20)
                algo.setTextSize(40)
                algo.text("PONG!")
                algo.setTextSize(20)
                //Draw One Player
                if(mouse.x.between(algo.getLeft() + 5, algo.getLeft() + 200) && mouse.y.between(-105, -85)){
                        algo.goTo(-150, 50)
                        algo.setStroke(3)
                        algo.setColor(algo.color.RED)
                        algo.lineTo(-150, -50)
                        algo.goTo(-150, 70)
                        algo.text("player")
                        algo.goTo(150, 50)
                        algo.setStroke(3)
                        algo.setColor(algo.color.GRAY)
                        algo.lineTo(150, -50)
                        algo.goTo(150, 70)
                        algo.text("cpu")
                        algo.goTo(0, 0)
                        algo.setColor(15)
                        algo.text("vs")
                        
                        algo.setColor(algo.color.RED)
                }
                algo.goTo(algo.getLeft() + 100, -100)
                algo.text("one player")
                algo.setColor(15)
                
                //Draw Two Players
                if(mouse.x.between(algo.getLeft() + 5, algo.getLeft() + 220) && mouse.y.between(-75, -55)){
                        algo.goTo(-150, 50)
                        algo.setStroke(3)
                        algo.setColor(algo.color.RED)
                        algo.lineTo(-150, -50)
                        algo.goTo(-150, 70)
                        algo.text("player 1")
                        algo.goTo(150, 50)
                        algo.setStroke(3)
                        algo.setColor(algo.color.BLUE)
                        algo.lineTo(150, -50)
                        algo.goTo(150, 70)
                        algo.text("player 2")
                        algo.setStroke(1)
                        algo.goTo(0, 0)
                        algo.setColor(15)
                        algo.text("vs")
                        
                        algo.setColor(algo.color.RED)
                }
                algo.goTo(algo.getLeft() + 105, -70)
                algo.text("two players")
                algo.setColor(15)
                algo.setStroke(1)
        }
        if(global.onPage == "game"){
                game.run()
        }
}, 20)

set game = object(){
        set p1 = object(){
                set pts = 0
                set y = 0
                set speed = 8
                set length = 0.1
                set draw = function(){
                        algo.setColor(algo.color.BLUE)
                        algo.setStroke(3)
                        algo.goTo(algo.getLeft() + 10, game.p1.y + algo.getHeight() * game.p1.length)
                        algo.lineTo(algo.getLeft() + 10, game.p1.y - algo.getHeight() * game.p1.length)
                        algo.setStroke(1)
                        algo.setColor(15)
                }
                set move = function(){
                        if(mouse.y > game.p1.y && math.abs(mouse.y - game.p1.y) >= game.p1.speed){
                                game.p1.y += game.p1.speed
                        }
                        elseif(mouse.y < game.p1.y && math.abs(mouse.y - game.p1.y) >= game.p1.speed){
                                game.p1.y -= game.p1.speed
                        }
                }
        }
        set ball = object(){
                set x = 0
                set y = 0
                set speed = 15
                set dx = (math.random(2) * 2 - 1) * speed
                set dy = 0
                set draw = function(){
                        algo.goTo(game.ball.x, game.ball.y)
                        algo.disc(20)
                }
                set move = function(motionM){
                        game.ball.x += game.ball.dx / motionM
                        game.ball.y += game.ball.dy / motionM
                }
                set bounce = function(){
                        if(game.ball.x.between(algo.getLeft() + 10, algo.getLeft() + 15) && game.ball.y.between(game.p1.y + algo.getHeight() * game.p1.length, game.p1.y - algo.getHeight() * game.p1.length)){
                                game.ball.dy = math.sin((game.ball.y - game.p1.y) * 90 / (algo.getHeight() * game.p1.length)) * game.ball.speed
                                game.ball.dx = math.cos((game.ball.y - game.p1.y) * 90 / (algo.getHeight() * game.p1.length)) * game.ball.speed
                                game.ball.speed += 0.25
                        }
                        if(game.ball.x.between(algo.getRight() - 10, algo.getRight() - 15) && game.ball.y.between(game.p2.y + algo.getHeight() * game.p2.length, game.p2.y - algo.getHeight() * game.p2.length)){
                                game.ball.dy = math.sin((game.ball.y - game.p2.y) * 90 / (algo.getHeight() * game.p2.length)) * game.ball.speed
                                game.ball.dx = -math.cos((game.ball.y - game.p2.y) * 90 / (algo.getHeight() * game.p2.length)) * game.ball.speed
                                game.ball.speed += 0.25
                        }
                        if(game.ball.y > algo.getBottom() || game.ball.y < algo.getTop()){game.ball.dy = -game.ball.dy}
                }
                set ai = function(motion){
                        for(set i = 0; i < motion; i++){
                                game.ball.move(motion)
                                game.ball.bounce()
                        }
                }
                set checkOut = function(){
                        if(game.ball.x > algo.getRight() + 5){
                                game.p1.pts ++
                                game.restartRound()
                        }
                        if(game.ball.x < algo.getLeft() - 5){
                                game.p2.pts ++
                                game.restartRound()
                        }
                }
        }
        set restartRound = function(){
                set game.p1.y = 0
                set game.p1.speed = 8
                set game.p1.length = 0.1
                set game.ball.x = 0
                set game.ball.y = 0
                set game.ball.speed = 15
                set game.ball.dx = (math.random(2) * 2 - 1) * game.ball.speed
                set game.ball.dy = 0
                set game.p2.y = 0
                set game.p2.speed = 10
                set game.p2.length = 0.1
        }
        set p2 = object(){
                set pts = 0
                set toGo = object(){
                        set dir = 0
                        set go = 0
                }
                set name = ""
                set y = 0
                set speed = 10
                set length = 0.1
                set draw = function(){
                        algo.setStroke(3)
                        if(game.p2.name == "cpu"){algo.setColor(algo.color.GRAY)}
                        else{algo.setColor(algo.color.RED)}
                        algo.goTo(algo.getRight() - 10, game.p2.y + algo.getHeight() * game.p2.length)
                        algo.lineTo(algo.getRight() - 10, game.p2.y - algo.getHeight() * game.p2.length)
                        algo.setStroke(1)
                        algo.setColor(15)
                }
                set move = function(){
                        if(game.p2.name == "cpu"){
                                if(game.ball.y > game.p2.y && math.abs(game.ball.y - game.p2.y) >= game.p2.speed){
                                        game.p2.y += game.p2.speed
                                }
                                elseif(game.ball.y < game.p2.y && math.abs(game.ball.y - game.p2.y) >= game.p2.speed){
                                        game.p2.y -= game.p2.speed
                                }
                        }
                        if(game.p2.name == "p2"){
                                if(game.p2.toGo.dir == 1 && algo.getBottom() > game.p2.y + 2 * game.p2.length || game.p2.toGo.dir == -1 && algo.getTop() < game.p2.y - 2 * game.p2.length){game.p2.y += game.p2.speed * game.p2.toGo.go * game.p2.toGo.dir}
                        }
                }
        }
        set run = function(){
                game.p1.draw()
                game.p1.move()
                game.p2.draw()
                game.p2.move()
                game.ball.ai(20)
                game.ball.draw()
                game.ball.checkOut()
                hud.borders()
                hud.names()
                hud.score()
        }
}

algo.onTap(function(x, y){
        mouse.down = 0
        if(global.onPage == "menu"){
                if(mouse.x.between(algo.getLeft() + 5, algo.getLeft() + 200) && mouse.y.between(-105, -85)){
                        global.onPage = "game"
                        game.p2.name = "cpu" 
                }
                if(mouse.x.between(algo.getLeft() + 5, algo.getLeft() + 220) && mouse.y.between(-75, -55)){
                        global.onPage = "game"
                        game.p2.name = "p2" 
                }
        }
})

algo.onMove(function(x, y){
        mouse.x = x
        mouse.y = y
})

algo.onDrag(function(x, y){
        mouse.x = x
        mouse.y = y
})

algo.onUp(function(x, y){
        mouse.down = 0
})

algo.onKey(function(key){
        if(key == "w"){
                if(game.p2.toGo.dir == -1){
                        game.p2.toGo.go = (game.p2.toGo.go + 1) % 2
                }
                else{
                        game.p2.toGo.dir = -1
                        game.p2.toGo.go = 1
                }
        }
        if(key == "s"){
                if(game.p2.toGo.dir == 1){
                        game.p2.toGo.go = (game.p2.toGo.go + 1) % 2
                }
                else{
                        game.p2.toGo.dir = 1
                        game.p2.toGo.go = 1
                }
        }
})
 
