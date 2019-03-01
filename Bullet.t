unit
class Bullet
    inherit Objects in "Objects.t"
    export tp, size
    var tp, size, dfCol : int

    %tp: type, user:1, enemy:2

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
	pX += dX
	pY += dY
	draw
    end move

    body proc draw
	Draw.FillOval (pX, pY, size, size, col)
    end draw

    body proc erase
	col := 176
	draw
	col := dfCol
    end erase

    proc hit
	%%%%%%%%%%%%5
    end hit
end Bullet
