unit
class MyPlane
    inherit Plane in "Plane.t"
    
    export EXP, life, sDx, sDy,bulArr
    var EXP, life : int
    dfCol := white
    var bulArr : array 1 .. 20 of ^Bullet
    %var eneArr : array 1 .. 15 of ^Enemy
    col := dfCol
    dX := 0
    dY := 0
    tp:=1
    var bulCnt := 1
    var bulNum: int := 1
    var isBulBuilt : boolean := false
    HP := 100
    damage := 34
    
    % proc setEnemyList(arr: array 1.. * of ^Enemy)
    %     for i: 1.. upper(arr)
    %         eneArr(i) := arr(i)
    %     end for
    % end setEnemyList

    proc sDx (x : int)
	dX := x
    end sDx

    proc sDy (y : int)
	dY := y
    end sDy

    body proc move
	erase
	if pX + dX > 25 and pX + dX < 380 then
	    pX += dX
	end if
	if pY + dY > 25 and pY + dY < 200 then
	    pY += dY
	end if
	draw
	%delay(300)
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

    body proc shoot %% need to put into array
	%%at the beginnning
	if bulCnt <= 17 and not isBulBuilt then
	    var temp : ^Bullet
	    new temp
	    ^temp.cons (pX, pY + 20, 0, 30, 1, white, 3)
	    bulArr (bulCnt) := temp
	    bulCnt += 1
	    if bulCnt >= 17 then
		isBulBuilt := true
	    end if
	end if

	%normally
	for i : 1 .. bulCnt - 1
	    if ^ (bulArr (i)).getY () >= 555 then
		var temp : ^Bullet
		new temp
		^temp.cons (pX, pY + 20, 0, 30, 1, white, 3)
		bulArr (i) := temp
	    else
		^ (bulArr (i)).move
	    end if
	end for
    end shoot
end MyPlane
