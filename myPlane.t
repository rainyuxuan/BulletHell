unit
class myPlane
    inherit Objects in "Objects.t"
    proc myPlane
	Draw.Line (pX, pY + 6, pX - 38, pY + 2, col)
	Draw.Line (pX, pY + 6, pX + 38, pY + 2, col)
	Draw.FillArc (pX + 36, pY - 1, 5, 3, 295, 90, col)
	Draw.FillArc (pX - 36, pY - 1, 5, 3, 90, 245, col)
	Draw.Line (pX, pY - 6, pX - 38, pY - 4, col)
	Draw.Line (pX, pY - 6, pX + 38, pY - 4, col)
	Draw.Line (pX - 37, pY + 3, pX - 37, pY - 3, col)
	Draw.Line (pX + 37, pY + 3, pX + 37, pY - 3, col)
	Draw.Fill (pX, pY, col, col)
	Draw.FillArc (pX, pY, 4, 20, 0, 180, col)
	Draw.FillArc (pX - 13, pY, 3, 13, 0, 180, col)
	Draw.FillArc (pX + 13, pY, 3, 13, 0, 180, col)
	Draw.FillArc (pX - 13, pY - 5, 2, 28, 180, 0, col)
	Draw.FillArc (pX + 13, pY - 5, 2, 28, 180, 0, col)
	Draw.FillBox (pX - 16, pY - 30, pX + 17, pY - 26, col)
	Draw.FillArc (pX - 16, pY - 28, 2, 2, 90, 270, col)
	Draw.FillArc (pX + 16, pY - 28, 2, 2, 270, 90, col)
	Draw.Line (pX - 19, pY + 13, pX - 7, pY + 13, col)
	Draw.Line (pX + 19, pY + 13, pX + 7, pY + 13, col)
    end myPlane
end myPlane 
