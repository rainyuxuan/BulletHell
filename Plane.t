%% this is a class of all the planes (user&enemies),
%% it imports class Bullet for shooting
%% it inherit class Objects because it is an object
unit
class Plane
    inherit Objects in "Objects.t"
    import Bullet in "Bullet.t"
    export HP, damage, bulNum, bulCnt,
	stopDisplay, boom, shoot, hit,
	sDx, sDy

    var HP, damage : int %% HP and Damage to HP
    var bulNum, bulCnt : int %% max bullet number & count the bullet for re-shoot

    proc sDx (x : int) %% set dX
	dX := x
    end sDx

    proc sDy (y : int)  %% set dY
	dY := y
    end sDy


    deferred proc shoot %% shooting, differ among type of planes

    proc stopDisplay
	dfCol := 151
    end stopDisplay

    proc boom  %% when HP <= 0 (die), there will be an explosion
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

    %this fcn processes to reduce HP when hitted,
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
