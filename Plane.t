unit
class MyPlane
    inherit Plane in "Plane.t"
    body proc myPlane
	Draw.FillArc (pX, pY, 38, 4, 0, 180, col)
	Draw.FillArc (pX, pY, 38, 4, 180, 0, col)
	Draw.FillArc (pX, pY - 2, 4, 22, 0, 180, col)
	Draw.FillArc (pX - 13, pY - 6, 3, 21, 0, 360, col)
	Draw.FillArc (pX + 13, pY - 6, 3, 21, 0, 360, col)
	Draw.FillArc (pX, pY - 26, 22, 2, 0, 360, col)
	Draw.Line (pX - 19, pY + 13, pX - 7, pY + 13, col)
	Draw.Line (pX + 19, pY + 13, pX + 7, pY + 13, col)
    end MyPlane
end MyPlane

