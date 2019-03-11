unit
class Enemy
    inherit Plane in "Plane.t"

    damage := 5
    active := true
    size := 100

    body proc cons (px : int, py : int, dx : int, dy : int, t : int, c : int, s : int)
	pX := px
	pY := py
	dX := dx
	dY := dy
	tp := t    %1:small, 2:middle,3: boss
	dfCol := c
	HP := s
	col := dfCol
    end cons

    body proc move
	%if active then
	    erase
	    pX -= dX
	    pY -= dY
	    draw
	%end if
    end move

    body proc draw
	if tp = 2 then
	    var x : array 1 .. 3 of int
	    x (1) := pX - 20
	    x (2) := pX + 20
	    x (3) := pX
	    var y : array 1 .. 3 of int
	    y (1) := pY + 8
	    y (2) := pY + 8
	    y (3) := pY - 4
	    Draw.FillPolygon (x, y, 3, col)
	    Draw.FillOval (pX, pY - 2, 3, 14, col)
	elsif tp = 3 then
	    Draw.FillArc (pX, pY, 38, 4, 180, 0, col)
	    Draw.FillArc (pX, pY + 2, 4, 22, 360, 0, col)
	    Draw.FillArc (pX - 13, pY - 5, 3, 11, 180, 0, col)
	    Draw.FillArc (pX + 13, pY - 5, 3, 11, 180, 0, col)
	    Draw.Line (pX - 19, pY - 13, pX - 7, pY - 13, col)
	    Draw.Line (pX + 19, pY - 13, pX + 7, pY - 13, col)
	end if
    end draw

    body proc erase
	col := 176
	draw
	col := dfCol
    end erase

end Enemy
