unit
class Enemy
    inherit Objects in "Objects.t"
    body proc draw
	Draw.FillBox (pX - 18, pY, pX + 18, pY - 10, col)
	Draw.Box (pX - 5, pY - 10, pX + 5, pY - 15, col)
	Draw.Box (pX - 3, pY - 10, pX + 3, pY - 13, col)
	Draw.FillBox (pX - 1, pY - 15, pX + 1, pY - 16, col)
	Draw.Line (pX - 9, pY - 17, pX + 9, pY - 17, col)
	Draw.FillBox (pX - 5, pY, pX + 5, pY + 3, col)
	Draw.FillBox (pX - 3, pY + 3, pX + 3, pY + 17, col)
	Draw.FillBox (pX - 7, pY + 17, pX + 7, pY + 21, col)
    end draw
end Enemy
