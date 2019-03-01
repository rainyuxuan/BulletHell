unit
class MyPlane
    inherit Plane in "Plane.t"

    export EXP, life, sDx, sDy
    var EXP, life : int
    var dfCol : int := white
    var bulArr : flexible array 1 .. 0 of ^Bullet
    col := dfCol
    dX := 0
    dY := 0
    var bulCnt := 0

    proc sDx (x : int)
	dX := x
    end sDx

    proc sDy (y : int)
	dY := y
    end sDy

    body proc move
	erase
	pX += dX
	pY += dY
	draw
	%delay(300)
	%dX:=0
	%dY:=0
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

    body proc shoot %% need to put into array
	var temp : ^Bullet
	bulCnt += 1
	if bulCnt >= 50 then
	    for i : 1 .. upper (bulArr)
		^ (bulArr (i)).erase
	    end for
	    bulCnt := 1
	end if
	new bulArr, bulCnt

	new temp
	bulArr (upper (bulArr)) := temp
	^temp.cons (pX, pY + 20, 0, 30, 1, white, 3)
	for i : 1 .. upper (bulArr)
	    ^ (bulArr (i)).move
	end for
	%^temp.draw
	%delay(10)
    end shoot
end MyPlane
