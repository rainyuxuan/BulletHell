unit
class MyPlane
    inherit Plane in "Plane.t"

    export EXP, life, sDx, sDy, bulArr
    var EXP, life : int
    var bulNum : int := 26
    var bulArr : array 1 .. 26 of ^Bullet
    dX := 0
    dY := 0
    tp := 1
    var bulCnt := 1

    HP := 100
    damage := 34

    proc sDx (x : int)
	dX := x
    end sDx

    proc sDy (y : int)
	dY := y
    end sDy

    body proc cons (px : int, py : int, dx : int, dy : int, t : int, c : int, s : int)
	pX := px
	pY := py
	dX := dx
	dY := dy
	tp := t
	dfCol := c
	damage := s
	col := dfCol
	for i : 1 .. bulNum
	    var temp : ^Bullet
	    new temp
	    ^temp.cons (pX, pY + 20, 0, 20, 1, 66 + i, 3)
	    bulArr (i) := temp
	end for
	%^ (bulArr (1)).setActive (false)
	%^ (bulArr (1)).draw
    end cons

    body proc move
	erase
	if pX + dX > 25 and pX + dX < 380 then
	    pX += dX
	end if
	if pY + dY > 45 and pY + dY < 200 then
	    pY += dY
	end if
	draw
	dX := 0
	dY := 0
    end move

    body proc draw
	Draw.FillBox (pX - 18, pY, pX + 18, pY + 10, col)
	Draw.Box (pX - 5, pY + 10, pX + 5, pY + 15, col)
	Draw.Box (pX - 3, pY + 10, pX + 3, pY + 13, col)
	Draw.FillBox (pX - 1, pY + 15, pX + 1, pY + 16, col)
	Draw.Line (pX - 9, pY + 17, pX + 9, pY + 17, col)
	Draw.FillBox (pX - 5, pY, pX + 5, pY - 3, col)
	Draw.FillBox (pX - 3, pY - 3, pX + 3, pY - 17, col)
	Draw.FillBox (pX - 7, pY - 17, pX + 7, pY - 21, col)
    end draw

    body proc erase
	col := 176
	draw
	col := dfCol
    end erase

    body proc shoot
	for i : 1 .. bulNum
	    if ^ (bulArr (i)).getY () <= pY then
		^ (bulArr (i)).setActive(false)
		^ (bulArr (i)).erase
		^ (bulArr (i)).move
		if ^ (bulArr (i)).getY() >= pY-5 then
		    ^ (bulArr (i)).setActive(true)
		    ^ (bulArr (i)).sP(pX,^ (bulArr (i)).getY())
		end if
	    end if
	    if ^ (bulArr (i)).getY () >= 555 then
		^ (bulArr (i)).erase
		^ (bulArr (i)).setActive (false)
		^ (bulArr (i)).sP(pX,-100)
		% var temp : ^Bullet
		% new temp
		% ^temp.cons (pX, pY + 15, 0, 20, 1, 66+i, 3)
		% bulArr (i) := temp
	    elsif ^ (bulArr (i)).active then
		^ (bulArr (i)).erase
		^ (bulArr (i)).move
		^ (bulArr (i)).draw
	    end if
	end for

	%
	% for i : 1 .. bulNum
	%     if ^ (bulArr (i)).getY () >= 555 then
	%         ^ (bulArr (i)).erase
	%         ^ (bulArr (i)).setActive (false)
	%         var temp : ^Bullet
	%         new temp
	%         ^temp.cons (pX, pY + 15, 0, 20, 1, 66+i, 3)
	%         bulArr (i) := temp
	%     end if
	%     if ^ (bulArr (i)).active = true then
	%         ^ (bulArr (i)).move
	%     else
	%         ^ (bulArr (bulCnt)).setActive (true)
	%     end if
	% end for
	% bulCnt += 1
	% if bulCnt = bulNum + 1 then
	%     bulCnt := 1
	% end if
    end shoot
end MyPlane
