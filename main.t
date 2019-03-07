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
new eneArr, 10
for i : 1 .. 10
    var they : ^Enemy
    new they
    eneArr (i) := they
    ^they.cons (50 + (i - 1) * 35, 400 - i * 5, 0, 1, 2, yellow, 3)
end for
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%% Functions and Procedures %%%%%%%%%

proc checkHit
    for i : 1 .. upper ( ^me.bulArr)
	var x : int := ^ ( ^me.bulArr (i)).pX
	var y : int := ^ ( ^me.bulArr (i)).pY
	for j : 1 .. upper (eneArr)
	    if x = ^ (eneArr (j)).pX and y = ^ (eneArr (j)).pY then
		^ ( ^me.bulArr (i)).setActive (false)
		^ (eneArr (j)).hit ( ^me.damage)
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
	checkHit
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
