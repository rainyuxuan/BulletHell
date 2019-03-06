import MyPlane in "MyPlane.t", Small in "Small.t", Middle in "Middle.t"

View.Set ("graphics")
View.Update
setscreen ("graphics:400;600,nocursor")


%%%%%%%%%% Initialization %%%%%%%%%%%%%
Draw.FillBox (0, 0, 400, 550, 176)

var me : ^MyPlane
new me
%^me.sP (200, 70)
^me.cons (200, 70, 0, 0, 1, white, 37)

var eneArr : flexible array 1 .. 20 of ^Small
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%% Functions and Procedures %%%%%%%%%

proc checkHit
    for i : 1 .. upper ( ^me.bulArr)
	var x : int := ^ ( ^me.bulArr (i)).pX
	var y : int := ^ ( ^me.bulArr (i)).pY
	 for j : 1..upper(eneArr)
	%     if x=^(eneArr(j)).pX and y = ^(eneArr(j)).pY then
	%        ^ ( ^me.bulArr (i)).setActive(false)
	%        ^ ( eneArr(j)).hit()
	%     end if
	 end for
    end for
end checkHit



%%%enemy test
var they : ^Small
new they
^they.cons (100, 400, 0, 0, 2, yellow, 3)


process Main ()
    loop
	^me.shoot ()
	^they.draw
	^me.move ()
	Draw.FillBox (0, 550, 400, 600, white)
	delay (25)
	%checkHit
	%checkHit
	
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
