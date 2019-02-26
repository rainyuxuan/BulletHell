unit
class Objects
    export  pX, pY, col,
	    getX,getY, sP, 
	    move, draw, erase
    var pX, pY : int
    var col : int
    
    deferred proc erase
    deferred proc draw
    deferred proc move
    
    fcn getX():int
	result pX
    end getX
    
    fcn getY():int
	result pY
    end getY
    
    proc sP(x,y: int) %set position
	pX := x
	pY := y
    end sP

end Objects
