unit
class Small
    inherit Enemy in "Enemy.t" 

    
    HP:=100
    tp:= 2

    body proc cons (px : int, py : int, dx : int, dy : int, t : int, c : int, s : int)
	pX := px
	pY := py
	dX := dx
	dY := dy
	tp := t
	dfCol := c
	size := s
	col := dfCol
    end cons
    
    body proc move
	erase
	pX -= dX
	pY -= dY
	draw
    end move
    
    body proc draw
	Draw.Line (pX - 20, pY + 8, pX + 20, pY + 8, col)
	Draw.Line (pX, pY - 4, pX - 20, pY + 8, col)
	Draw.Line (pX, pY - 4, pX + 20, pY + 8, col)
	Draw.Fill (pX, pY, col, col)
	Draw.FillOval (pX, pY - 2, 3, 14, col)
    end draw
    
    body proc erase
	col := 176
	draw
	col := dfCol
    end erase
	
end Small
