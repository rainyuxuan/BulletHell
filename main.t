import MyPlane in "MyPlane.t"
setscreen ("graphics:400;600,nocursor")

Draw.FillBox (0, 0, 400, 550, 176)
var x : int := 200
var me : ^MyPlane
new me
^me.sP (200, 70)
^me.draw ()
delay (10)
process main ()
    loop
	^me.erase ()
	%^me.sP (x - 5 * i, 80 + 5 * i)
	^me.draw ()
	^me.shoot ()
	^me.move()
	Draw.FillBox (0, 550, 400, 600, white)
	delay (30)
    end loop

end main

var direct:string(1)

process userinput ()
    loop
	getch (direct)
	if direct = KEY_UP_ARROW then
	    %sP++
	    ^me.sDy(5)
	    ^me.sDx(0)
	end if
	if direct = KEY_DOWN_ARROW then
	    ^me.sDy(-5)
	    ^me.sDx(0)
	end if
	if direct = KEY_RIGHT_ARROW then
	    ^me.sDx(5)
	    ^me.sDy(0)
	end if
	if direct = KEY_LEFT_ARROW then
	    ^me.sDx(-5)
	    ^me.sDy(0)
	end if
    end loop
end userinput

fork userinput
fork main
