import MyPlane in "MyPlane.t", Enemy in "Enemy.t"

View.Set ("graphics")
View.Update
setscreen ("graphics:400;600,nocursor")

%%%%%%%%%% Initialization %%%%%%%%%%%%%
Draw.FillBox (0, 0, 400, 550, 176)
var timer : int := 0 % count the time for guanqia
var gameOver : boolean := false

var me : ^MyPlane
new me
%^me.sP (200, 70)
^me.cons (200, 70, 0, 0, 1, white, 37)

var eneArr : flexible array 1 .. 0 of ^Enemy


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%% Functions and Procedures %%%%%%%%%

proc checkHit
    for i : 1 .. upper ( ^me.bulArr)
	var x : int := ^ ( ^me.bulArr (i)).pX
	var y : int := ^ ( ^me.bulArr (i)).pY
	for j : 1 .. upper (eneArr)
	    if (x >= ^ (eneArr (j)).pX - 13 and x <= ^ (eneArr (j)).pX + 13)
		    and (y >= ^ (eneArr (j)).pY - 10 and y <= ^ (eneArr (j)).pY + 10)
		    and ^ (eneArr (j)).active then
		^ ( ^me.bulArr (i)).setActive (false)
		if ^ (eneArr (j)).hit ( ^me.damage) then
		    ^me.addEXP ( ^ (eneArr (j)).size)
		end if
	    end if
	end for
    end for
end checkHit


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% WAVES %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
proc smallFromLeft
    new eneArr, 10
    for i : 1 .. 10
	var they : ^Enemy
	new they
	eneArr (i) := they
	%pX, pY, dX, dY, type, color, size
	^they.cons (0 - 500 + (i - 1) * 50, 570 - i * 5,
	    - 2, 1,
	    2, 60 + i * 3, 1000)
    end for
end smallFromLeft

proc smallFromRight
    new eneArr, 10
    for i : 1 .. 10
	var they : ^Enemy
	new they
	eneArr (i) := they
	%pX, pY, dX, dY, type, color, size
	^they.cons (400 + 500 - (i - 1) * 35, 570 - i * 5,
	    2, 1,
	    2, 60 + i * 3, 1000)
    end for
end smallFromRight



%%%%%%%%%%%%%%%%%%%%%% PROCESSES %%%%%%%%%%%%%%%%%%%%%%%%%
process MAIN ()
    loop
	^me.shoot ()
	for i : 1 .. upper (eneArr)
	    ^ (eneArr (i)).move ()
	end for
	^me.move ()
	%Draw.FillBox (0, 550, 400, 600,  white)
	delay (25)
	checkHit
	%checkHit
	if timer mod 20 = 0 then
	    % gameOver := ^me.hit (5)
	end if
	exit when gameOver
    end loop
end MAIN

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
var inBattle : boolean := false
process SCHEDULE
    loop

	if not inBattle then
	    if timer mod 200 = 0 then
		for i : 1 .. upper (eneArr)
		    ^ (eneArr (i)).erase
		end for
		smallFromLeft
		inBattle := true
	    elsif timer mod 300 = 0 then
		for i : 1 .. upper (eneArr)
		    ^ (eneArr (i)).erase
		end for
		smallFromRight
		inBattle := true
	    end if
	end if
	delay (50)
	timer += 1
	if ^ (eneArr (upper (eneArr))).pX > 800
		or ^ (eneArr (1)).pX < -400 then
	    inBattle := false
	end if
    end loop
end SCHEDULE

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
var direct : string (1)
process CONTROL ()
    var direct : array char of boolean
    loop
	Input.KeyDown (direct)
	if direct (KEY_UP_ARROW) then
	    ^me.sDy (4)
	end if
	if direct (KEY_DOWN_ARROW) then
	    ^me.sDy (-4)
	end if
	if direct (KEY_RIGHT_ARROW) then
	    ^me.sDx (4)
	end if
	if direct (KEY_LEFT_ARROW) then
	    ^me.sDx (-4)
	end if
    end loop
end CONTROL

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
process UI_DISPLAY
    loop
	locatexy (2, 580)
	put "Your score: ", ^me.EXP
	Draw.FillBox (0, 550, 400, 570, gray)
	Draw.FillBox (0, 550, 4 * ^me.HP, 570, red)
	delay (100)
    end loop
end UI_DISPLAY

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%% MAIN PROGRAM %%%%%%%%%%%%%%%%%
fork CONTROL
fork MAIN
fork UI_DISPLAY
fork SCHEDULE
