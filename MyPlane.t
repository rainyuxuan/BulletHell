unit
class myPlane
    inherit Objects in "Objects.t" %pX,pY,
    proc drawPlane
        Draw.FillBox (pX - 18, pY, pX + 18, pY + 10, white)
        Draw.Box (pX - 5, pY + 10, pX + 5, pY + 15, 18)
        Draw.Box (pX - 3, pY + 10, pX + 3, pY + 13, 18)
        Draw.FillBox (pX - 1, pY + 15, pX + 1, pY + 16, black)
        Draw.Line (pX - 9, pY + 17, pX + 9, pY + 17, black)
        Draw.FillBox (pX - 5, pY, pX + 5, pY - 3, 32)
        Draw.FillBox (pX - 3, pY - 3, pX + 3, pY - 17, 14)
        Draw.FillBox (pX - 2, pY - 3, pX + 2, pY - 17, 43)
        Draw.FillBox (pX - 1, pY - 3, pX + 1, pY - 17, 41)
        Draw.FillBox (pX - 7, pY - 17, pX + 7, pY - 21, 41)
        Draw.FillBox (pX - 7, pY - 21, pX - 3, pY - 19, 43)
        Draw.FillBox (pX + 7, pY - 21, pX + 3, pY - 19, 43)
        Draw.FillBox (pX - 18, pY + 4, pX - 5, pY + 10, 14)
        Draw.FillBox (pX + 5, pY + 4, pX + 18, pY + 10, 14)
        Draw.FillBox (pX - 18, pY + 5, pX - 8, pY + 10, 51)
        Draw.FillBox (pX + 8, pY + 5, pX + 18, pY + 10, 51)
        Draw.FillBox (pX + 10, pY + 7, pX + 18, pY + 10, 41)
        Draw.FillBox (pX - 18, pY + 7, pX - 10, pY + 10, 41)
        Draw.FillBox (pX - 18, pY, pX + 18, pY + 3, 14)
        Draw.Box (pX - 18, pY, pX + 18, pY + 10, 25)
        Draw.Box (pX - 8, pY - 16, pX + 8, pY - 21, 25)
    end drawPlane
end myPlane
