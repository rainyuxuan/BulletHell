unit
class Plane
    inherit Objects in "Objects.t"
    export draw
    deferred proc draw
end Plane

%var plane := Pic.FileNew("picMyPlane.jpg")
%Draw.FillBox(1,1,500,500,black)
%Pic.Draw(plane, 150,70,picCopy)

