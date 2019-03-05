
unit
class Bullet
    inherit Objects in "Objects.t"
    %import Plane in "Plane.t"
    export tp, size,hit
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
	col := white
    end erase

    fcn hit ():boolean%arr: array 1.. * of ^Plane): boolean
	% for i : 1.. upper(arr)
	%     if pX = ^(arr(i)).getX() and pY = ^(arr(i)).getY() then
	%         result true
	%     end if
	% end for
	result false
    end hit
end Bullet
