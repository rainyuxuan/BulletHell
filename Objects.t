%%% this is a class for all the objects in the game %%%
unit
class Objects
    export pX, pY, col, dX, dY, size, active, dfCol,
	cons, move, draw, erase,
	sP, setActive
    var pX, pY, dX, dY : int    %% position and moving direction
    var tp, size, dfCol : int   %% type, size, default color
    var col : int               %% current color (for erase)
    var active : boolean := true %% if the object is still working(alive)

    deferred proc cons (px, py, dx, dy, t, c, s : int) %% constructor
    deferred proc erase  %% erase (draw with background color)
    deferred proc draw   %% draw
    deferred proc move   %% move

    proc sP (x, y : int) %% set position
	pX := x
	pY := y
    end sP

    proc setActive (b : boolean) %% set active
	active := b
    end setActive

end Objects
