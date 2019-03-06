unit
class Plane
    inherit Objects in "Objects.t"
    import Bullet in "Bullet.t"
    export HP, damage,
	boom, shoot

    var HP, damage : int


    deferred proc boom
    deferred proc shoot

    % fcn getBulArr():flexible array 1..* of ^Bullet
    %     result bulArr
    % end getBulArr

end Plane
