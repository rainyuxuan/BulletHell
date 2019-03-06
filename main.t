import MyPlane in "MyPlane.t", Small in "Small.t", Middle in "Middle.t"

View.Set ("graphics")
View.Update
setscreen ("graphics:400;600,nocursor")


%%%%%%%%%% Initialization %%%%%%%%%%%%%
Draw.FillBox (0, 0, 400, 550, 176)
var x : int := 200
var me : ^MyPlane
new me
^me.sP (200, 70)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




















%%%enemy test
var they : ^Small
new they
^they.cons(100,400,0,0,2,yellow,3)


process Main ()
    loop
	^me.shoot ()
	^they.draw
	^me.move ()
	Draw.FillBox (0, 550, 400, 600, white)
	delay (25)
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
