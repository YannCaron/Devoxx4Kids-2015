// Program from GratisGrek
// http://www.algoid.net/phpBB3/viewtopic.php?f=6&t=1342&start=30

//Not so many settings this time just height and width. :)
//Set the height and width of the stamp 
//you want to create in pixels.
set height = 16
set width = 16

//Don't change this...
set size = 32
///_______________________________
//Feel free to modify and repost this program in any way you like.
/*-.________________________.-*/

algo.hide ();
// Initialize some variables and create the layout for the color selection
set cs = 0
set tool = "pen"

set loaded = array{}
set clr = array {{0,15},{8,7},{4,12},{5,13},{1,9},{3,11},{2,10},{6,14}}

set clrcount = 0
set scalerOn = false
set layersel = 0
set hidden = array{false,false,false}

//This creates the array and fills it with the value of bgcolor.
set img = array {}.create (height,function (){
        return array {}.create  (width, function (){return -1});
})
set imgB = array {}.create (height,function (){
        return array {}.create  (width, function (){return -1});
})
set imgT = array {}.create (height,function (){
        return array {}.create  (width, function (){return -1});
})
set temp = array{}
// create stamps
set colors = algo.stamp.clone (clr, 64)
set image = algo.stamp.clone (img,size)
set preview = algo.stamp.clone (img,7)
set previewB = algo.stamp.clone (imgB,7)
set previewT = algo.stamp.clone (imgT,7)
set imageB = algo.stamp.clone  (img,size)
set imageT = algo.stamp.clone (imgT,size)
//ui.fullScreen()
set colorselectedspaceX = 0
set colorselectedspaceY = 0
set drawspaceX = 0
set drawspaceY = 0
set colorspaceX = 0
set colorspaceY = 0
set cornerX = 0
set cornerY = 0
set buttonsX = 0
set buttonsY = 0
set scalerX = 0
set scalerY = 0
set layermenuX = 0
set layermenuY = 0
set originX = algo.getLeft()+126+ 64 +(width)*size
set prevsize = 120/((width+height)/2)
ui.fullScreen()

//postionter
set posupdate = function (){
        
        cornerX = algo.getLeft()+126
        cornerY = algo.getTop()
        colorselectedspaceX = cornerX-64
        colorselectedspaceY = cornerY-64
        
        colorspaceX = cornerX -64
        colorspaceY = cornerY + 256 + 32
        drawspaceX = cornerX + 32 +(width/2)*size
        drawspaceY = cornerY + 32 + (height/2)*size
        buttonsX = cornerX + 64
        buttonsY = cornerY - 64
        scalerX = drawspaceX + (width/2)*size+32
        scalerY = drawspaceY -  (height/2)*size+64
        layermenuX = algo.getRight () - 128
        layermenuY = colorspaceY
        prevsize = 120/((width+height)/2)
        
}

set clear = function () {
        set tbc = 10
        if  (layersel == 0) {
                tbc = imgT
        }else if  (layersel == 1) {
                tbc = img
        }else if  (layersel == 2) {
                tbc = imgB
        }
        for (set m = 0; m< height;m++) {
                for (set i = 0; i < width;i++) {
                        tbc [m] [i]= -1
                }}
}

set merge = function () {
        set tbc = 10
        if  (layersel == 0) {
                tbc = imgT
        }else if  (layersel == 1) {
                tbc = img
        }else if  (layersel == 2) {
                tbc = imgB
        }
        for (set m = 0;m<height;m++) {
                for (set i = 0;i<width;i++) {
                        if (hidden [2]==false){
                                temp  [m] [i]=imgB [m] [i]
                        }else if  (hidden [1]==false && hidden [2]==true) {
                                temp [m] [i]=img [m] [i]
                        }else {
                                temp [m] [i]=imgT [m] [i]
                        }
                        
                        if  (img [m] [i]!= -1 && hidden [1]==false) {
                                temp [m] [i]=img [m] [i]
                        }
                        if  (imgT [m] [i]!= -1&& hidden [0]==false) {
                                temp [m] [i] = imgT [m] [i]
                        }
                }}
        for (set m = 0;m<height;m++) {
                for (set i = 0;i<width;i++) {
                        tbc [m] [i]=temp [m] [i]
                }}
        
        temp = array{}
}
set save = function(){
        for (set m = 0;m<height;m++) {
                for (set i = 0;i<width;i++) {
                        if (hidden [2]==false){
                                temp  [m] [i]=imgB [m] [i]
                        }else if  (hidden [1]==false && hidden [2]==true) {
                                temp [m] [i]=img [m] [i]
                        }else {
                                temp [m] [i]=imgT [m] [i]
                        }
                        
                        if  (img [m] [i]!= -1 && hidden [1]==false) {
                                temp [m] [i]=img [m] [i]
                        }
                        if  (imgT [m] [i]!= -1&& hidden [0]==false) {
                                temp [m] [i] = imgT [m] [i]
                        }
                }}
        util.toClipboard(temp)
        loaded = temp.clone()
        temp = array{}
        algo.goTo(buttonsX,buttonsY)
        algo.box(64)
}

set load = function(){
        set tbc = 10
        if  (layersel == 0) {
                tbc = imgT
        }else if  (layersel == 1) {
                tbc = img
        }else if  (layersel == 2) {
                tbc = imgB
        }
        for (set m = 0;m<height;m++) {
                for (set i = 0;i<width;i++) {
                        tbc[m][i]=loaded[m][i]
                }}
        
        algo.goTo(buttonsX+128,buttonsY)
        algo.box(64)
}

// this function edits the arrays when you press the grid
/*set button = function(x,y,row,col){
        if ((  ( (-(width/2-0.5)*size)+size*col) +size/2)*sz > x && x > ( ((-(width/2-0.5)*size)+size*col)  -size/2)*sz && (  ((-(height/2-0.5)*size)+size*row) +size/2)*sz > y && y > (  ((-(height/2-0.5)*size)+size*row) -size/2)*sz ){ // I don't even know what this does anymore...
                img[row][col] = cs
        }
}*/

set button = function(x,y,row,col,layer){
        if ((drawspaceX+size+size*col)-width/2*size > x && x > (drawspaceX+size*col)-width/2*size && (drawspaceY+size+size*row)-height/2*size > y && y > (drawspaceY+size*row)-height/2*size){ // I don't even know what this does anymore...
                if  (tool == "pen"){
                        layer[row][col] = cs
                }
                if (tool == "fill"){
                        set filled = false
                        set targetcolor = layer [row][col]
                        layer [row][col] = 99
                        
                        loop((height+width)/2){
                                //util.wait(100)
                                
                                for  (set m = 0; m < height-1; m++){
                                        for  (set i = 0; i < width-1; i++ ) {
                                                
                                                
                                                
                                                if (layer[m][i] == 99 && m != 0 && i != 0 && m != height && i != width){
                                                        for  (set p = m-1; p < m+2; p++){
                                                                for  (set k = i-1; k < i+2; k++ ) {
                                                                        if (layer[p][k]==targetcolor ){
                                                                                layer[p][k] = 99
                                                                        }
                                                                }}
                                                }
                                        }}
                        }
                        for  (set m = 0; m < height; m++){
                                for  (set i = 0; i < width; i++ ) {
                                        if (layer[m][i]==99){
                                                layer[m][i]=cs
                                                
                                        }
                                }
                        }}
        }
}
//function for colorpanel 
//bx and by represents the x and y coordinates for the center of a button
set clrbutt = function (x,y,bx,by,css) {
        if  (x > (bx-32) && x<  (bx+32) && y >  (by-32) && y <  (by +32)) {
                cs = css
        }
}

set buttons = function (x,y,bx,by,value) {
        if  (x > bx -32 && x < bx + 32 && y > by - 32&& y < by + 32 ) {
                tool = value}}
set butts = function  (x,y,bx,by,thingy) {
        if  (x > bx -32 && x < bx + 32 && y > by - 32&& y < by + 32 ) {
                thingy ()}}


set scaler = function (x,y) {
        
        if  (x > scalerX -30 && x < scalerX+64 && y > scalerY-64 && y < scalerY+64) {
                scalerOn = true
        }
        if (scalerOn == true){
                if  (size > 8){
                        size =(32+ (x-originX)/width)
                }else  { size = size+1}
                //util.log (" " ..grejs)
        }
        
}

set layerselection = function(x,y,bx,by,level){
        if  (x > bx -64 && x < bx + 64 && y > by - 64 && y < by + 64 ) {
                layersel = level
        }
}
set layerhide = function(x,y,bx,by,level){
        if  (x > bx -32 && x < bx + 32 && y > by - 32&& y < by + 32 ) {
                if  (hidden [level] == false){
                        hidden [level] = true} else { 
                        hidden  [level] = false}
        }
}
set venne = function (grejlolB,grejlol,grejlolT){
        if  (hidden [2] == false){
                grejlolB}
        if  (hidden [1] == false){
                grejlol}
        if  (hidden [0] == false){
                grejlolT}
        
}
//draw color selection and grid.
set draws = function(){
        
        algo.autoClear()
        //colorselected
        algo.goTo(colorselectedspaceX,colorselectedspaceY)
        algo.setColor(cs)
        algo.box(64)
        algo.setColor(15)
        algo.square(64)
        //Colorselection
        algo.goTo (colorspaceX,colorspaceY)
        algo.rect (132,520)
        colors.draw ()
        
        algo.goTo (drawspaceX,drawspaceY)
        /*
        if  (hidden [2] == false) {
                
                imageB.delete ()
                imageB = algo.stamp.clone (imgB,size)
                
                //imageB.draw ()
        }
        if  (hidden [1] == false) {
                
                
                image.delete ()
                image = algo.stamp.clone (img,size)
                
                //image.draw ()
        }
        
        if  (hidden [0] == false){
                
                
                imageT.delete ()
                imageT = algo.stamp.clone (imgT,size)
                //imageT.draw ()
        }
        */
        venne(imageB.delete(),image.delete(),imageT.delete())
        venne(imageB = algo.stamp.clone(imgB,size),image = algo.stamp.clone(img,size),imageT = algo.stamp.clone(imgT,size))
        
        /*
        if  (hidden [2] == false){
                imageB = algo.stamp.clone(imgB,size)}
        if  (hidden [1] == false){
                image = algo.stamp.clone(img,size)}
        if  (hidden [0] == false){
                imageT = algo.stamp.clone(imgT,size)}
        */
        if  (hidden [2] == false){
                imageB.draw()}
        if  (hidden [1] == false){
                image.draw()}
        if  (hidden [0] == false){
                imageT.draw()}
        
        
        
        
        
        
        
        algo.rect ((width*size+8),(height*size+8))
        //BUTTONS!![!
        algo.goTo(buttonsX,buttonsY)
        algo.square (64)
        algo.text("save")
        algo.goTo(buttonsX+128,buttonsY)
        algo.square (64)
        algo.text ("load")
        algo.goTo(buttonsX+128*2,buttonsY)
        algo.square (64)
        if (tool == "pen"){
                algo.circle(64)
        }
        algo.text ("pen")
        algo.goTo(buttonsX+128*3,buttonsY)
        algo.square (64)
        if(tool=="fill"){
                algo.circle(64)
        }
        algo.text("fill")
        algo.goTo(buttonsX+128*4,buttonsY)
        algo.square (64)
        if(cs==-1){
                algo.circle(64)
        }
        algo.text("eraser")
        algo.goTo(buttonsX+128*5,buttonsY)
        algo.square (64)
        algo.text("clear")
        algo.goTo(buttonsX+128*6,buttonsY)
        algo.square (64)
        algo.text("merge")
        //scaler
        //This doesn't work for some reason, the poly show's up in the wrong place
        //algo.poly (array {scalerX-30,scalerY-64,scalerX,scalerY-32,scalerX,scalerY+32,scalerX-30,scalerY+64})
        algo.goTo (scalerX-8,scalerY-16)
        algo.setColor (-1)
        algo.lineTo (scalerX-8,scalerY+16)
        
        //layermenu
        
        algo.goTo (layermenuX,layermenuY)
        algo.setColor (15)
        algo.rect (256,512)
        algo.goTo (layermenuX,layermenuY-236)
        algo.text ("Layers")
        
        previewT = algo.stamp.clone (imgT,prevsize)
        preview = algo.stamp.clone (img,prevsize)
        previewB = algo.stamp.clone (imgB,prevsize)
        //Top
        algo.goTo (layermenuX,layermenuY-118)
        if (layersel == 0) {
                algo.plane (256,138)
                algo.setColor(0)
        }else{
                algo.rect (256 ,138)}
        //algo.goTo (layermenuX-64,layermenuY-118)
        previewT.draw ()
        if  (hidden [0]== true){
                algo.goTo(layermenuX+108,layermenuY-168)
                algo.text ("X")}else{
                algo.goTo(layermenuX+108,layermenuY-168)
                algo.text ("O")}
        algo.setColor(15)
        //Middle
        algo.goTo (layermenuX,layermenuY+20)
        if (layersel == 1) {
                algo.plane (256,138)
                algo.setColor(0)
        }else {
                algo.rect (256,138)}
        //algo.goTo (layermenuX-64,layermenuY+20)
        preview.draw ()
        if  (hidden [1]== true){
                algo.goTo(layermenuX+108,layermenuY-34)
                algo.text ("X")}else{
                algo.goTo(layermenuX+108,layermenuY-34)
                algo.text ("O")}
        algo.setColor(15)
        //Bottom
        algo.goTo (layermenuX,layermenuY+158)
        if (layersel == 2) {
                algo.plane (256,138)
                algo.setColor(0)
        }else{
                algo.rect (256,138)}
        //algo.goTo (layermenuX-64,layermenuY+158)
        previewB.draw ()
        if  (hidden [2]== true){
                algo.goTo(layermenuX+108,layermenuY+104)
                algo.text ("X")}else{
                algo.goTo(layermenuX+108,layermenuY+104)
                algo.text ("O")}
        algo.setColor(15)
        //algo.circle(100)
        //algo.circle(5)
        previewT.delete ()
        preview.delete ()
        previewB.delete ()
}


//Decides what happens when something is pressed
set tappitytap = function (x,y){
        
        butts(x,y,buttonsX,buttonsY,save)
        butts(x,y,buttonsX+128,buttonsY,load)
        buttons (x,y,buttonsX+256,buttonsY,"pen")
        buttons (x,y,buttonsX+128*3,buttonsY,"fill")
        layerselection (x,y,layermenuX,layermenuY-118,0)
        layerselection (x,y,layermenuX,layermenuY+20,1)
        layerselection (x,y,layermenuX,layermenuY+158,2)
        layerhide (x,y,layermenuX+108,layermenuY-168,0)
        layerhide (x,y,layermenuX+108,layermenuY-34,1)
        layerhide (x,y,layermenuX+108,layermenuY+104,2)
        butts (x,y,buttonsX+128*5,buttonsY,clear)
        butts (x,y,buttonsX+128*6,buttonsY,merge)
        
        
        
        //Color selection
        clrbutt (x,y,colorspaceX-32,colorspaceY-228,0)
        clrbutt (x,y,colorspaceX-32,colorspaceY-160,8)
        clrbutt (x,y,colorspaceX-32,colorspaceY-96,4)
        clrbutt (x,y,colorspaceX-32,colorspaceY-34,5)
        clrbutt (x,y,colorspaceX-32,colorspaceY+34,1)
        clrbutt (x,y,colorspaceX-32,colorspaceY+96,3)
        clrbutt (x,y,colorspaceX-32,colorspaceY+160,2)
        clrbutt (x,y,colorspaceX-32,colorspaceY+228,6)
        clrbutt (x,y,buttonsX+128*4,buttonsY,-1)
        clrbutt (x,y,colorspaceX+32,colorspaceY-228,15)
        clrbutt (x,y,colorspaceX+32,colorspaceY-160,7)
        clrbutt (x,y,colorspaceX+32,colorspaceY-96,12)
        clrbutt (x,y,colorspaceX+32,colorspaceY-24,13)
        clrbutt (x,y,colorspaceX+32,colorspaceY+24,9)
        clrbutt (x,y,colorspaceX+32,colorspaceY+96,11)
        clrbutt (x,y,colorspaceX+32,colorspaceY+160,10)
        clrbutt (x,y,colorspaceX+32,colorspaceY+228,14)
        
        
        
        
        //gridthings
        for  (set count2 = 0; count2 < height; count2++){
                for  (set count = 0; count < width; count++ ) {
                        if  (layersel == 1){
                                button (x,y,count2,count,img)}
                        if  (layersel == 2) {
                                button (x,y,count2,count,imgB)
                        }
                        if  (layersel == 0){
                                button (x,y,count2,count,imgT)}
                        
                }
        }
        
        
}

set drag = function(x,y){
        scaler (x,y)
        
        
        clrbutt (x,y,colorspaceX-32,colorspaceY-228,0)
        clrbutt (x,y,colorspaceX-32,colorspaceY-160,8)
        clrbutt (x,y,colorspaceX-32,colorspaceY-96,4)
        clrbutt (x,y,colorspaceX-32,colorspaceY-34,5)
        clrbutt (x,y,colorspaceX-32,colorspaceY+34,1)
        clrbutt (x,y,colorspaceX-32,colorspaceY+96,3)
        clrbutt (x,y,colorspaceX-32,colorspaceY+160,2)
        clrbutt (x,y,colorspaceX-32,colorspaceY+228,6)
        clrbutt (x,y,buttonsX+128*4,buttonsY,-1)
        clrbutt (x,y,colorspaceX+32,colorspaceY-228,15)
        clrbutt (x,y,colorspaceX+32,colorspaceY-160,7)
        clrbutt (x,y,colorspaceX+32,colorspaceY-96,12)
        clrbutt (x,y,colorspaceX+32,colorspaceY-24,13)
        clrbutt (x,y,colorspaceX+32,colorspaceY+24,9)
        clrbutt (x,y,colorspaceX+32,colorspaceY+96,11)
        clrbutt (x,y,colorspaceX+32,colorspaceY+160,10)
        clrbutt (x,y,colorspaceX+32,colorspaceY+228,14)
        
        
        //gridthings
        for  (set count2 = 0; count2 < height; count2++){
                for  (set count = 0; count < width; count++ ) {
                        if  (layersel == 1){
                                button (x,y,count2,count,img)}
                        if  (layersel == 2) {
                                button (x,y,count2,count,imgB)
                        }
                        if  (layersel == 0){
                                button (x,y,count2,count,imgT)}
                        
                }
        }
}
set uppity = function (x,y) {
        //if  (scalerOn == true ) {
                scalerOn = false
                //}
        
}

set gameloop = function(){
        posupdate()
        draws()
}

algo.onTap (tappitytap)
algo.onTouch (drag)
algo.onUp (uppity)


util.pulse(gameloop,10)


//imgB= array{}
 
