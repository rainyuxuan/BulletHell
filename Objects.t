unit
class Objects
    export pX, pY, col, dX, dY, size, active,dfCol,
	getX, getY, sP, cons,
	move, draw, erase,
	setActive
    var pX, pY, dX, dY : int
    var tp, size, dfCol : int
    var col : int
    var active : boolean := true

    deferred proc cons (px, py, dx, dy, t, c, s : int)
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

    proc setActive (b : boolean)
	active := b
    end setActive

end Objects
