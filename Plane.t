unit
class Plane
    inherit Objects in "Objects.t"
    import Bullet in "Bullet.t"
    export HP, damage, bulArr
    
    var HP,damage:int
    var bulArr: flexible array 1..0 of ^Bullet

    deferred proc boom
    deferred proc shoot
    
end Plane
