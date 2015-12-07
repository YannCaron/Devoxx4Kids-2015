algo.hide()
ui.fullScreen()

set hud = object(){
        set showFrame = function(){
                algo.goTo(algo.getLeft() + algo.getRight(), algo.getBottom() + algo.getTop())
                algo.rect(algo.getRight() - algo.getLeft(), algo.getBottom() - algo.getTop())
        }
}

set a = object(){
        set x = 0
        set y = 0
        set by = 0
        set ax = 0
        set ay = 0
        set startTime = al.clock()
        set g = 100
        set sx = 0
        set sy = 0
        set dx = 0
        set dy = 0
        set mouseDown = false
        set setup = function(){
                if(a.mouseDown == true){
                        algo.goTo(a.sx, a.sy)
                        algo.circle(10)
                        algo.lineTo(a.ax, a.ay)
                }
        }
        set build = function(){
                if(a.mouseDown == false){
                        algo.goTo(a.sx - a.dx * (al.clock() - a.startTime), a.sy + a.g * math.pow(al.clock() - a.startTime, 2) - (a.dy + a.by) * (al.clock() - a.startTime))
                        algo.circle(10)
                }
        }
        set shoot = function(){
                if(a.mouseDown == false){
                        a.x = algo.getX()
                        a.y = algo.getY()
                }
        }
        set bounce = function(){
                if(a.y < algo.getTop()){
                        a.sx = a.x
                        a.sy = a.y
                        a.dy = (a.sy + a.g * math.pow(al.clock() - a.startTime, 2) - (a.dy + a.by) * (al.clock() - a.startTime)) / (10 / 4)
                        a.dx = a.dx / (5 / 4)
                        a.startTime = al.clock()
                }
                elseif(a.y > algo.getBottom()){
                        a.sx = a.x
                        a.sy = a.y
                        a.dy = (a.sy + a.g * math.pow(al.clock() - a.startTime, 2) - (a.dy + a.by) * (al.clock() - a.startTime)) / (10 / 4)
                        a.dx = a.dx / (5 / 4)
                        a.startTime = al.clock()
                }
                elseif(a.x < algo.getLeft()){
                        a.sx = a.x
                        a.sy = a.y
                        a.dx = (a.sx + a.dx * (al.clock() - a.startTime)) / (2)
                        a.dy = a.dy 
                        a.startTime = al.clock()
                }
                elseif(a.x > algo.getRight()){
                        a.sx = a.x
                        a.sy = a.y
                        a.dx = (a.sx + a.dx * (al.clock() - a.startTime)) / (2)
                        a.dy = a.dy
                        a.startTime = al.clock()
                }
        }
}

util.pulse(function(){
        algo.clear()
        a.build()
        a.setup()
        a.shoot()
        a.bounce()
        hud.showFrame()
}, 20)

algo.onClick(function(x, y){
        a.mouseDown = true
        a.sx = x
        a.sy = y
        a.ax = x
        a.ay = y
})

algo.onDrag(function(x, y){
        a.ax = x
        a.ay = y
})

algo.onUp(function(x, y){
        a.mouseDown = false
        a.startTime = al.clock()
        a.dx = (x - a.sx) * 10
        a.dy = (y - a.sy) * 10
})
 
