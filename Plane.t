unit
class Plane
    inherit Objects in "Objects.t"
    export HP, damage
    
    var HP,damage:int

    deferred proc boom
    deferred proc shoot
    
end Plane
