unit
class Enemy
    inherit Plane in "Plane.t"
    export bulNum, hasShot,
	getBul

    damage := 5
    active := true
    size := 100
    var bulNum : int := 1
    var bulCnt : int := 1
    var bulArr : flexible array 1 .. 0 of ^Bullet
    var hasShot : boolean := false
    var midShootSpeed: int := 15

    body proc cons (px : int, py : int, dx : int, dy : int, t : int, c : int, s : int)
	pX := px
	pY := py
	dX := dx
	dY := dy
	tp := t    %1:small, 2:middle,3: boss
	dfCol := c
	HP := s
	size := s
	col := dfCol
	%%%%%%%%%%%%%%%%%%%%% small %%%%%%%%%%%%%%%%%%%%%%%%
	if tp = 2 then
	    new bulArr, 1
	    var temp : ^Bullet
	    new temp
	    ^temp.cons (pX, pY - 5, 0, -5, 2, Rand.Int (60, 90), 5)
	    ^temp.setActive (true)
	    bulArr (1) := temp
	    bulNum := 1
	    %%%%%%%%%%%%%%%%%%%%% middle %%%%%%%%%%%%%%%%%%%%%%%%
	elsif tp = 3 then
	    bulNum := 35
	    new bulArr, bulNum
	    for i : 1 .. 7
		var temp : ^Bullet
		new temp
		^temp.cons (pX, pY - 15, -8, -midShootSpeed, 2, 60 + i, 5)
		bulArr (i) := temp
		^ (bulArr (i)).setActive (false)
	    end for
	    for i : 8 .. 14
		var temp : ^Bullet
		new temp
		^temp.cons (pX, pY - 15, -4, -midShootSpeed, 2, 60 + i, 5)
		bulArr (i) := temp
		^ (bulArr (i)).setActive (false)
	    end for
	    for i : 15 .. 21
		var temp : ^Bullet
		new temp
		^temp.cons (pX, pY - 15, 0, -midShootSpeed, 2, 60 + i, 5)
		bulArr (i) := temp
		^ (bulArr (i)).setActive (false)
	    end for
	    for i : 22 .. 28
		var temp : ^Bullet
		new temp
		^temp.cons (pX, pY - 15, 4, -midShootSpeed, 2, 60 + i, 5)
		bulArr (i) := temp
		^ (bulArr (i)).setActive (false)
	    end for
	    for i : 29 .. 35
		var temp : ^Bullet
		new temp
		^temp.cons (pX, pY - 15, 8, -midShootSpeed, 2, 60 + i, 5)
		bulArr (i) := temp
		^ (bulArr (i)).setActive (false)
	    end for
	end if
    end cons

    fcn getBul (i : int) : ^Bullet
	result bulArr (i)
    end getBul

    body proc move
	%if active then
	erase
	pX += dX
	pY += dY
	draw
	if pY <= 400 or pY >= 520 then
	    dY := -dY
	end if
	if tp = 3 and (pX >= 390 or pX <=10) then
	    dX := -dX
	end if
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
	col := 151
	draw
	col := dfCol
    end erase

    body proc shoot
	%%%%%% small %%%%%%
	hasShot := true
	if tp = 2 then
	    if ^ (bulArr (1)).active then
		^ (bulArr (1)).move
	    end if
	elsif tp = 3 then
	    for i : 1 .. bulNum %go through each bullet
		if ^ (bulArr (i)).getY () <= -100 then %if exceed boundary
		    ^ (bulArr (i)).erase            %disappear and will not move/draw
		    ^ (bulArr (i)).setActive (false)
		    ^ (bulArr (i)).sP (pX, pY - 15)
		end if

		if ^ (bulArr (i)).active = true then %for each active bullet, move&draw
		    ^ (bulArr (i)).move
		else
		    %since only one bullet is shot from me each time,
		    %therefore we can only activate this bullet
		    %which is bulArr(bulCnt)
		    ^ (bulArr (bulCnt)).setActive (true)
		    ^ (bulArr (bulCnt + 7)).setActive (true)
		    ^ (bulArr (bulCnt + 14)).setActive (true)
		    ^ (bulArr (bulCnt + 21)).setActive (true)
		    ^ (bulArr (bulCnt + 28)).setActive (true)
		end if
	    end for
	    bulCnt += 1
	    if bulCnt = 8 then
		bulCnt := 1
	    end if
	end if

    end shoot

end Enemy
