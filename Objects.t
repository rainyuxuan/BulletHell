unit
class Objects
    export pX, pY, col, dX, dY,
	getX, getY, sP, cons,
	move, draw, erase
    var pX, pY,dX, dY : int
    var col : int
    
    deferred proc cons(px, py, dx, dy, t, c, s : int)
    deferred proc erase
    deferred proc draw
    deferred proc move

    fcn getX () : int
	result pX
    end getX

    fcn getY () : int
	result pY
    end getY

    proc sP (x, y : int) %set position
	pX := x
	pY := y
    end sP

end Objects
