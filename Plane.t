unit
class Plane
    inherit Objects in "Objects.t"
    import Bullet in "Bullet.t"
    export HP, damage,
	boom, shoot, hit

    var HP, damage : int


    deferred proc boom
    deferred proc shoot
    
    fcn hit (d:int):boolean
	HP -= d
	if HP<=0 then
	    active := false
	    erase
	    result true
	end if
	result false
    end hit
    % fcn getBulArr():flexible array 1..* of ^Bullet
    %     result bulArr
    % end getBulArr

end Plane
