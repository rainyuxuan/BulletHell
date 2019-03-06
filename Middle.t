unit
class Middle 
    inherit Enemy in "Enemy.t"


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
	Draw.FillArc (pX, pY, 38, 4, 0, 180, col)
	Draw.FillArc (pX, pY, 38, 4, 180, 0, col)
	Draw.FillArc (pX, pY - 2, 4, 22, 180, 0, col)
	Draw.FillArc (pX - 13, pY + 6, 3, 21, 0, 360, col)
	Draw.FillArc (pX + 13, pY + 6, 3, 21, 0, 360, col)
	Draw.FillArc (pX, pY + 26, 22, 2, 0, 360, col)
	Draw.Line (pX - 19, pY - 13, pX - 7, pY - 13, col)
	Draw.Line (pX + 19, pY - 13, pX + 7, pY - 13, col)
    end draw
    body proc erase
	col := 176 
	draw
	col := dfCol
    end erase
end Middle
