import MyPlane in "MyPlane.t"
setscreen ("graphics:400;600,nocursor")

Draw.FillBox (0, 0, 400, 550, 176)
var x : int := 200
var me : ^MyPlane
new me
^me.sP (200, 70)
^me.draw ()
delay (10)
for i : 1 .. 20
    ^me.erase ()
    ^me.sP (x - 5 * i, 80+5*i)
    ^me.draw ()
    delay (30)
end for
