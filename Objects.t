unit
class Objects
    export pX, pY, getX,getY, setPos
    var pX, pY : int
    
    fcn getX():int
	result pX
    end getX
    
    fcn getY():int
	result pY
    end getY
    
    proc setPos(x,y: int)
	pX := x
	pY := y
    end setPos
    
end Objects
