%% this is a class of user's plane
%% it imports class Bullet for shooting (in class Plane)
%% it inherit class Plane because it is a type of plane
unit
class MyPlane
    inherit Plane in "Plane.t"
    export EXP, bulArr, addEXP

    var EXP : int %% score
    bulNum := 25 %% max bullet number
    var bulArr : array 1 .. 25 of ^Bullet %% store all bellets
    dX := 0 %% initialize dX
    dY := 0 %% initialize dY
    bulCnt := 1 %% for re-shoot

    HP := 1000 %% health point
    damage := 25 %% damage to enemies
    EXP := 0 %% score

    body proc cons (px : int, py : int, dx : int, dy : int, t : int, c : int, s : int)
	pX := px
	pY := py
	dX := dx
	dY := dy
	tp := t %% doesn' really matter
	dfCol := c
	damage := s %% since size is fixed, s is used for damage
	col := dfCol
	%% build bulArr %%
	for i : 1 .. bulNum
	    var temp : ^Bullet
	    new temp
	    ^temp.cons (pX, pY + 20, 0, 20, 1, 66 + i, 3)
	    bulArr (i) := temp
	    ^ (bulArr (i)).setActive (true)
	end for
    end cons

    body proc move %% move my plane
	erase
	if pX + dX > 25 and pX + dX < 380 then %% no exceed boundary
	    pX += dX
	end if
	if pY + dY > 45 and pY + dY < 200 then
	    pY += dY
	end if
	draw
	dX := 0
	dY := 0
    end move

    body proc draw  %% draw my plane
	Draw.FillBox (pX - 18, pY, pX + 18, pY + 10, col)
	Draw.Box (pX - 5, pY + 10, pX + 5, pY + 15, col)
	Draw.Box (pX - 3, pY + 10, pX + 3, pY + 13, col)
	Draw.FillBox (pX - 1, pY + 15, pX + 1, pY + 16, col)
	Draw.Line (pX - 9, pY + 17, pX + 9, pY + 17, col)
	Draw.FillBox (pX - 5, pY, pX + 5, pY - 3, col)
	Draw.FillBox (pX - 3, pY - 3, pX + 3, pY - 17, col)
	Draw.FillBox (pX - 7, pY - 17, pX + 7, pY - 21, col)
    end draw

    body proc erase  %% erase my plane
	col := 151
	draw
	col := dfCol
    end erase

    % this proc adds EXP when destroy an enemy
    proc addEXP (e : int) % e is HP of Enemy, used to calculate score
	EXP += e div 100
    end addEXP

    body proc shoot %% move all the bullets
	for i : 1 .. bulNum %go through each bullet
	    if ^ (bulArr (i)).pY >= 525 then   %if exceed boundary
		^ (bulArr (i)).erase                %disappear and will not move/draw
		^ (bulArr (i)).setActive (false)
		var temp : ^Bullet                  %create new bullet for future use
		new temp
		^temp.cons (pX, pY + 15, Rand.Int (-1, 1), 20, 1, 66 + i, 3)
		bulArr (i) := temp
	    end if

	    if ^ (bulArr (i)).active = true then    %for each active bullet, move&draw
		^ (bulArr (i)).move
	    else
		%since only one bullet is shot from me each time,
		%therefore we can only activate this bullet
		%which is bulArr(bulCnt)
		^ (bulArr (bulCnt)).setActive (true)
	    end if
	end for
	bulCnt += 1
	if bulCnt = bulNum + 1 then %% re-count
	    bulCnt := 1
	end if
    end shoot
end MyPlane
