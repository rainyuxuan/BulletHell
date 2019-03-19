%% this is a class of bullets shot from planes (user&enemies), 
%% it inherit class Objects because it is an object
unit
class Bullet
    inherit Objects in "Objects.t"
    
    active := false %% initialize

    %% constructor %%
    body proc cons (px : int, py : int, dx : int, dy : int, t : int, c : int, s : int)
	pX := px
	pY := py
	dX := dx
	dY := dy
	tp := t
	dfCol := c
	size := s %% size of the bullet
	col := dfCol
    end cons

    body proc move %% move the bullet
	erase
	pX += dX
	pY += dY
	draw
    end move

    body proc draw %% draw the bullet
	Draw.FillOval (pX, pY, size, size, col)
    end draw

    body proc erase %% erase the bullet (draw with background color)
	col := 151
	draw
	col := dfCol
    end erase

end Bullet
