unit
class Plane
    inherit Objects in "Objects.t"
    import Bullet in "Bullet.t"
    export HP, damage,
	stopDisplay, boom, shoot, hit,
	sDx, sDy

    var HP, damage : int

    proc sDx (x : int)
	dX := x
    end sDx

    proc sDy (y : int)
	dY := y
    end sDy
    
    
    deferred proc shoot

    proc stopDisplay
	dfCol := 176
    end stopDisplay

    proc boom
	%draw
	Draw.FillStar (pX + 20, pY + 20, pX - 20, pY - 20, yellow)
	Draw.FillStar (pX - 13, pY - 13, pX + 13, pY + 13, red)
	delay (30)
	%erase
	Draw.FillStar (pX + 20, pY + 20, pX - 20, pY - 20, 176)
	Draw.FillStar (pX - 13, pY - 13, pX + 13, pY + 13, 176)
    end boom

    %this fcn processes to reduce HP,
    %at the same time results if the plane dies
    fcn hit (d : int) : boolean
	HP -= d
	if HP <= 0 then
	    active := false
	    erase
	    boom
	    stopDisplay
	    result true
	end if
	result false
    end hit



end Plane
