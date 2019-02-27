unit
class MyPlane
    inherit Plane in "Plane.t"
    
    export EXP, life
    var EXP, life:int
    var dfCol:int:=white
    col:=dfCol

    body proc move
	erase
	pX += dX
	pY += dY
	draw
    end move

    body proc draw
	Draw.FillBox (pX - 18, pY, pX + 18, pY + 10, col)
	Draw.Box (pX - 5, pY + 10, pX + 5, pY + 15, col)
	Draw.Box (pX - 3, pY + 10, pX + 3, pY + 13, col)
	Draw.FillBox (pX - 1, pY + 15, pX + 1, pY + 16, col)
	Draw.Line (pX - 9, pY + 17, pX + 9, pY + 17, col)
	Draw.FillBox (pX - 5, pY, pX + 5, pY - 3, col)
	Draw.FillBox (pX - 3, pY - 3, pX + 3, pY - 17, col)
	Draw.FillBox (pX - 7, pY - 17, pX + 7, pY - 21, col)
    end draw
    
    body proc erase
	col:= 176
	draw
	col:=dfCol
    end erase
    
    body proc shoot %% need to put into array
	var bul : ^Bullet
	new bul
	^bul.cons(pX, pY + 20, 0, 8, 1, white, 3)
	^bul.move
    end shoot
end MyPlane
