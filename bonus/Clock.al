algo.hide ()

set buttonAPI = object(){
        set createButton = function(cposX, cposY, csizeX, csizeY, ccaption, ctextColor, cborderColor, cfillColor, func){
                return object(){
                        set x = cposX
                        set y = cposY
                        set sizeX = csizeX
                        set sizeY = csizeY
                        set borderColor = cborderColor
                        set fillColor = cfillColor
                        set caption = ccaption
                        set textColor = ctextColor
                        set boundFunction = func
                        set draw = function(){
                                algo.goTo(this.x, this.y)
                                algo.rotateTo(0)
                                algo.setColor(this.fillColor)
                                algo.plane(this.sizeX, this.sizeY)
                                algo.setColor(this.borderColor)
                                algo.rect(this.sizeX, this.sizeY)
                                algo.setColor(textColor)
                                if(this.sizeX / 9 > this.sizeY){algo.setTextSize(math.floor(this.sizeY * 3 / 4))}
                                else{algo.setTextSize(math.floor((this.sizeX * 3) / (4 * 9)))}
                                algo.text(this.caption)
                        }
                        set attract = function(ax, ay){
                                if(ax.between(this.x + this.sizeX / 2, this.x - this.sizeX / 2) && ay.between(this.y + this.sizeY / 2, this.y - this.sizeY / 2)){
                                        this.boundFunction()
                                }
                        }
                }
        }
}

set clock = object () {
        set UTC = 2
        set type = 0
        set typeNameList = array {"digital", "analog"}
        set round = 0
        set roundNameList = array {"round", "disround"}
        
        set getTime = function () {return (al.clock () + clock.UTC * 3600) % 86400}
        set getHour = function () {return clock.getTime () / 3600}
        set getMinute = function () {return clock.getTime () / 60 % 60}
        set getSecond = function () {return clock.getTime () % 60}
        set drawClockBg = function () {
                algo.goTo (0, algo.getTop () / 8)
                algo.circle (algo.getWidth () * 7 / 8)
                algo.rotateTo (0)
                loop (12) {
                        loop (4) {
                                algo.goTo (0, algo.getTop () / 8)
                                algo.turnRight (6)
                                algo.jump (algo.getRight () * 105 / 128)
                                algo.go (algo.getRight () * 7 / 128)
                        }
                        algo.goTo (0, algo.getTop () / 8)
                        algo.turnRight (6)
                        algo.jump (algo.getRight () * 49 / 64)
                        algo.go (algo.getRight () * 7 / 64)
                }
                algo.setTextSize (algo.getWidth () / 64)
                for (set i = 1; i <= 12; i++) {
                        algo.goTo (math.sin (30 * i) * algo.getRight () * 29 / 30, - math.cos (30 * i) * algo.getRight () * 29 / 32 + algo.getTop () / 8)
                        algo.text (i)
                }
        }
        set draw = function () {
                if (clock.type == 0) {
                        clock.drawClockBg ()
                        algo.goTo (0, algo.getTop () / 8)
                        algo.rotateTo (if (clock.round == 0) {clock.getSecond ()} else {math.floor (clock.getSecond ())} * 6)
                        algo.go (algo.getRight () * 6 / 8)
                        algo.goTo (0, algo.getTop () / 8)
                        algo.rotateTo (clock.getMinute () * 6)
                        algo.go (algo.getRight () * 5 / 8)
                        algo.goTo (0, algo.getTop () / 8)
                        algo.rotateTo (clock.getHour () * 30)
                        algo.go (algo.getRight () * 4 / 8)
                }
                else {
                        algo.goTo (0, 0)
                        algo.setTextSize (algo.getWidth () / 12)
                        algo.text (math.floor (clock.getHour ()) .. ":" .. if (clock.getMinute () < 10) {0} else {""} .. math.floor (clock.getMinute ()) .. ":" .. if (clock.getSecond () < 10) {0} else {""} .. if (clock.round == 0) {math.floor (clock.getSecond () * 10) / 10} else {math.floor (clock.getSecond ())})
                }
                
        }
        
}

ui.fullScreen ()
util.wait (1000)

set clockType = buttonAPI.createButton (algo.getLeft () / 2, algo.getBottom () * 5 / 8, algo.getRight (), algo.getBottom () / 4, "digital", 15, 15, 0, function () {
        clock.type = (clock.type + 1) % 2
        clockType.caption = clock.typeNameList [clock.type]
})
set clockRound = buttonAPI.createButton (algo.getRight () / 2, algo.getBottom () * 5 / 8, algo.getRight (), algo.getBottom () / 4, "round", 15, 15, 0, function () {
        clock.round = (clock.round + 1) % 2
        clockRound.caption = clock.roundNameList [clock.round]
})
set clockUTCLess = buttonAPI.createButton (algo.getLeft () * 2 / 3, algo.getTop () * 7 / 8, algo.getRight () * 2 / 3, algo.getBottom () / 4, "<", 15, 15, 0, function () {
        clock.UTC --
})
set clockUTCMore = buttonAPI.createButton (algo.getRight () * 2 / 3, algo.getTop () * 7 / 8, algo.getRight () * 2 / 3, algo.getBottom () / 4, ">", 15, 15, 0, function () {
clock.UTC ++
})

util.pulse (function () {
        algo.autoClear ()
        clock.draw ()
        clockType.draw ()
        clockRound.draw ()
        clockUTCLess.draw ()
        clockUTCMore.draw ()
        algo.goTo (0, algo.getTop () * 7 / 8)
        algo.setTextSize (algo.getWidth () / 21)
        algo.text ("utc: " .. clock.UTC - 1)
}, 50)

algo.onTap (function (x, y) {
        clockType.attract (x, y)
        clockRound.attract (x, y)
        clockUTCLess.attract (x, y)
        clockUTCMore.attract (x, y)
})
 
