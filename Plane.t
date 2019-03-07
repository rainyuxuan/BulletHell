unit
class Plane
    inherit Objects in "Objects.t"
    import Bullet in "Bullet.t"
    export HP, damage,
	boom, shoot, hit

    var HP, damage : int


    deferred proc boom
    deferred proc shoot
    
    proc hit (d:int)
	HP -= d
    end hit
    % fcn getBulArr():flexible array 1..* of ^Bullet
    %     result bulArr
    % end getBulArr

end Plane
