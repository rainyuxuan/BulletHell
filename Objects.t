unit
class Objects
    export pX, pY, getX,getY, sP
    var pX, pY : int
    
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
