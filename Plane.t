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
	dfCol := 151
    end stopDisplay

    proc boom
	%draw
	var x : int := pX
	var y : int := pY
	Draw.FillStar (x + 20, y + 20, x - 20, y - 20, yellow)
	Draw.FillStar (x - 13, y - 13, x + 13, y + 13, red)
	delay (30)
	%erase
	Draw.FillStar (x + 20, y + 20, x - 20, y - 20, 151)
	Draw.FillStar (x - 13, y - 13, x + 13, y + 13, 151)
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
