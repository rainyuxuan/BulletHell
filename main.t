import MyPlane in "MyPlane.t", Enemy in "Enemy.t"

View.Set ("graphics")
View.Update
setscreen ("graphics:400;600,nocursor")

%%%%%%%%%% Initialization %%%%%%%%%%%%%
Draw.FillBox (0, 0, 400, 550, 176)
var timer : int := 0 % count the time for guanqia

var me : ^MyPlane
new me
%^me.sP (200, 70)
^me.cons (200, 70, 0, 0, 1, white, 37)

var eneArr : flexible array 1 .. 0 of ^Enemy
proc newWave
    new eneArr, 10
    for i : 1 .. 10
	var they : ^Enemy
	new they
	eneArr (i) := they
	^they.cons (0 - 350 + (i - 1) * 35, 600 - i * 5, -2, 1, 2, 60 + i * 3, 300)
    end for
end newWave
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%% Functions and Procedures %%%%%%%%%

proc checkHit
    for i : 1 .. upper ( ^me.bulArr)
	var x : int := ^ ( ^me.bulArr (i)).pX
	var y : int := ^ ( ^me.bulArr (i)).pY
	for j : 1 .. upper (eneArr)
	    if (x >= ^ (eneArr (j)).pX - 5 and x <= ^ (eneArr (j)).pX + 5) 
	    and (y >= ^ (eneArr (j)).pY - 4 and y <= ^ (eneArr (j)).pY + 4) then
		^ ( ^me.bulArr (i)).setActive (false)
		if ^ (eneArr (j)).hit ( ^me.damage) then
		    ^ me.addEXP( ^ (eneArr (j)).size)
		end if
		%locatexy (0, 5r70)
		%put ^ (eneArr (j)).HP
	    end if
	end for
    end for
end checkHit

%%%enemy test

process Main ()
    loop
	^me.shoot ()
	for i : 1 .. upper (eneArr)
	    ^ (eneArr (i)).move ()
	end for
	^me.move ()
	Draw.FillBox (0, 550, 400, 600, white)
	delay (25)
	checkHit
	%checkHit
	if timer mod 400 = 0 then
	    newWave ()
	end if
	timer += 1
    end loop
end Main

var direct : string (1)

process userinput ()
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
end userinput

fork userinput
fork Main
