%% this is a class of enemy planes
%% it imports class Bullet for shooting (in class Plane)
%% it inherit class Plane because it is a type of plane

%% there are two types of enemies, they have different ways of shooting and HP
%% type 2: small: one bullet, shoot only once
%% type 3: middle: 5 lines of 7 bullets, no stop shooting

unit
class Enemy
    inherit Plane in "Plane.t"
    export hasShot,
	getBul

    damage := 5 %% damage of enemy
    active := true %% initialize
    bulNum := 1  % max number of bullet
    bulCnt := 1  % for re-shoot
    var bulArr : flexible array 1 .. 0 of ^Bullet %% store all the bullets
    var hasShot : boolean := false %% bullet will not disappear even if the plane crashes
    %% this boolean makes sure it is still active
    var midShootSpeed : int := 15  %% speed of bullets of middle plane

    body proc cons (px : int, py : int, dx : int, dy : int, t : int, c : int, s : int)
	pX := px
	pY := py
	dX := dx
	dY := dy
	tp := t    % type 2:small, 3:middle
	dfCol := c
	HP := s    % since size are fixed, here it is used as the HP
	size := s
	col := dfCol
	%%%%%%%%%%%%%%%%%%%%% small %%%%%%%%%%%%%%%%%%%%%%%%
	if tp = 2 then
	    %% build bullet
	    new bulArr, 1
	    var temp : ^Bullet
	    new temp
	    ^temp.cons (pX, pY - 5, 0, -5, 2, Rand.Int (60, 90), 5)
	    ^temp.setActive (true)
	    bulArr (1) := temp
	    bulNum := 1

	    %%%%%%%%%%%%%%%%%%%%% middle %%%%%%%%%%%%%%%%%%%%%%%%
	elsif tp = 3 then
	    %% build bullets
	    bulNum := 35
	    new bulArr, bulNum
	    %% each lines
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

    %% return a bullet object in bulArr
    fcn getBul (i : int) : ^Bullet
	result bulArr (i)
    end getBul

    body proc move %% move the plane
	erase
	pX += dX
	pY += dY
	draw
	if pY <= 400 or pY >= 520 then %% bounce back
	    dY := -dY
	end if
	%% only middle will bounce back at vertical boundaries
	if tp = 3 and (pX >= 390 or pX <= 10) then
	    dX := -dX
	end if
    end move

    body proc draw %% draw plane base on type
	%% small %%
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
	    %% middle %%
	elsif tp = 3 then
	    Draw.FillArc (pX, pY, 38, 4, 180, 0, col)
	    Draw.FillArc (pX, pY + 2, 4, 22, 360, 0, col)
	    Draw.FillArc (pX - 13, pY - 5, 3, 11, 180, 0, col)
	    Draw.FillArc (pX + 13, pY - 5, 3, 11, 180, 0, col)
	    Draw.Line (pX - 19, pY - 13, pX - 7, pY - 13, col)
	    Draw.Line (pX + 19, pY - 13, pX + 7, pY - 13, col)
	end if
    end draw

    body proc erase %% erase the plane
	col := 151
	draw
	col := dfCol
    end erase

    body proc shoot %% move all the bullets
	%%%%%% small %%%%%%
	hasShot := true
	if tp = 2 then
	    if ^ (bulArr (1)).active then
		^ (bulArr (1)).move
	    end if
	    %%%%%% middle %%%%%%
	elsif tp = 3 then
	    for i : 1 .. bulNum %go through each bullet
		if ^ (bulArr (i)).pY <= -100 then %if exceed boundary
		    ^ (bulArr (i)).erase            %disappear and will not move/draw
		    ^ (bulArr (i)).setActive (false)
		    ^ (bulArr (i)).sP (pX, pY - 15) % reset its position
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
	    if bulCnt = 8 then % restart counting
		bulCnt := 1
	    end if
	end if

    end shoot

end Enemy
