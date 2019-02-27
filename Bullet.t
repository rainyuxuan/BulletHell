unit
class Bullet
    inherit Objects in "Objects.t"
    export  tp, size
    var tp, size, dfCol : int

    %tp: type, user:1, enemy:2

    body proc cons (px, py, dx, dy, t, c, s : int)
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
	pX += dX
	pY += dY
	draw
    end move

    body proc draw
	Draw.FillOval (dX, dY, size, size, col)
    end draw

    body proc erase
	col := 176
	draw
	col := dfCol
    end erase
    
    proc hit
	
    end hit
end Bullet
