unit
class Plane
    inherit Objects in "Objects.t"
    import Bullet in "Bullet.t"
    export HP, damage,
	boom, shoot, hit

    var HP, damage : int


    deferred proc shoot
    
    proc boom
	%draw
	Draw.FillStar(pX+17,pY+17,pX-17,pY-17,yellow)
	Draw.FillStar(pX-10,pY-10,pX+10,pY+10,red)
	delay(35)
	%erase
	Draw.FillStar(pX+17,pY+17,pX-17,pY-17,176)
	Draw.FillStar(pX-10,pY-10,pX+10,pY+10,176)
    end boom

    %this fcn processes to reduce HP,
    %at thte same time results if the plane dies
    fcn hit (d : int) : boolean
	HP -= d
	if HP <= 0 then
	    active := false
	    erase
	    boom
	    result true
	end if
	result false
    end hit

    

end Plane
