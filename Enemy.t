unit
class Enemy
    inherit Plane in "Plane.t"

    damage := 5
    active := true
    size := 100
    var bulArr : flexible array 1 .. 0 of ^Bullet

    body proc cons (px : int, py : int, dx : int, dy : int, t : int, c : int, s : int)
	pX := px
	pY := py
	dX := dx
	dY := dy
	tp := t    %1:small, 2:middle,3: boss
	dfCol := c
	HP := s
	col := dfCol
	if (tp = 2) then
	    new bulArr, 1
	elsif (tp = 3) then
	    new bulArr, 5
	end if

	for i : 1 .. upper (bulArr)
	    var temp : ^Bullet
	    new temp
	    ^temp.cons (pX, pY - 16, 0, -20, 2, 66 + i, 3)
	    ^temp.setActive (false)
	    bulArr (i) := temp
	end for
	%^ (bulArr (1)).setActive (false)

    end cons

    body proc move
	if active then
	    erase
	    pX -= dX
	    pY -= dY
	    draw
	end if
    end move

    body proc draw
	%if active = true then
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
	    %Draw.Line (pX, pY - 4, pX - 20, pY + 8, col)
	    %Draw.Line (pX, pY - 4, pX + 20, pY + 8, col)
	    %Draw.Fill (pX, pY, col, col)
	    Draw.FillOval (pX, pY - 2, 3, 14, col)
	elsif tp = 3 then
	    %Draw.FillArc (pX, pY, 38, 4, 0, 180, col)
	    Draw.FillArc (pX, pY, 38, 4, 180, 0, col)
	    Draw.FillArc (pX, pY + 2, 4, 22, 360, 0, col)
	    Draw.FillArc (pX - 13, pY - 5, 3, 11, 180, 0, col)
	    Draw.FillArc (pX + 13, pY - 5, 3, 11, 180, 0, col)
	    %Draw.FillArc (pX -13, pY + 26, 22, 2, 0, 360, col)
	    Draw.Line (pX - 19, pY - 13, pX - 7, pY - 13, col)
	    Draw.Line (pX + 19, pY - 13, pX + 7, pY - 13, col)
	end if
	%end if
    end draw

    body proc erase
	col := 176
	draw
	col := dfCol
    end erase

    proc s_shoot
	for i : 1 .. upper (bulArr)
	    if ^ (bulArr (i)).getY () <= 0 then
		^ (bulArr (i)).erase
		^ (bulArr (i)).setActive (false)
		var temp : ^Bullet
		new temp
		^temp.cons (pX, pY -16, 0, -20, 2, 66+i, 3)
		bulArr(i) := temp
	    end if
	    if ^ (bulArr (i)).active = true then
		^ (bulArr (i)).move
	    else
	    end if
	end for
    end s_shoot
    
    proc m_shoot
    end m_shoot

    body proc shoot 
	if (tp = 2) then
	    s_shoot
	elsif tp = 3 then
	    m_shoot
	end if
    end shoot
end Enemy
