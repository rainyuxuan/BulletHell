import MyPlane in "MyPlane.t", Enemy in "Enemy.t"

View.Set ("graphics")
View.Update
setscreen ("graphics:400;600,nocursor")

%%%%%%%%%% Initialization %%%%%%%%%%%%%
Draw.FillBox (0, 0, 400, 550, 176)
var timer : int := 0 % count the time for guanqia

var me : ^MyPlane
new me
%^me.sP (200, 70)
^me.cons (200, 70, 0, 0, 1, white, 37)

var eneArr : flexible array 1 .. 0 of ^Enemy

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%% Functions and Procedures %%%%%%%%%

proc checkHit
    for i : 1 .. upper ( ^me.bulArr)
        var x : int := ^ ( ^me.bulArr (i)).pX
        var y : int := ^ ( ^me.bulArr (i)).pY
        for j : 1 .. upper (eneArr)
            if (x >= ^ (eneArr (j)).pX - 13 and x <= ^ (eneArr (j)).pX + 13)
                    and (y >= ^ (eneArr (j)).pY - 10 and y <= ^ (eneArr (j)).pY + 10)
                    and ^ (eneArr (j)).active then
                ^ ( ^me.bulArr (i)).setActive (false)
                if ^ (eneArr (j)).hit ( ^me.damage) then
                    ^me.addEXP ( ^ (eneArr (j)).size)
                end if
            end if
        end for
    end for
end checkHit




%%%%%%%%%%%%%%%%%%%%%% PROCESSES %%%%%%%%%%%%%%%%%%%%%%%%%
process MAIN ()
    loop
        ^me.shoot ()
        for i : 1 .. upper (eneArr)
            ^ (eneArr (i)).move ()
        end for
        ^me.move ()
        %Draw.FillBox (0, 550, 400, 600,  white)
        delay (25)
        checkHit
        %checkHit
    end loop
end MAIN

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
var inBattle : boolean := false
process SCHEDULE
    loop
        delay (50)
        if not inBattle then
            if timer = 20 then
                new eneArr, 10
                for i : 1 .. 10
                    var they : ^Enemy
                    new they
                    eneArr (i) := they
                    %pX, pY, dX, dY, type, color, size
                    ^they.cons (0 - 350 + (i - 1) * 35, 570 - i * 5,
                        - 2, 1, 
                        2, 60 + i * 3, 1000)
                end for
            elsif timer = 300 then
                new eneArr, 10
                for i : 1 .. 10
                    var they : ^Enemy
                    new they
                    eneArr (i) := they
                    %pX, pY, dX, dY, type, color, size
                    ^they.cons (400 + 350 - (i - 1) * 35, 570 - i * 5,
                        2, 1,
                        2, 60 + i * 3, 1000)
                end for

            end if
        end if
        timer += 1
    end loop
end SCHEDULE

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
var direct : string (1)
process CONTROL ()
    var direct : array char of boolean
    loop
        Input.KeyDown (direct)
        if direct (KEY_UP_ARROW) then
            ^me.sDy (4)
        end if
        if direct (KEY_DOWN_ARROW) then
            ^me.sDy (-4)
        end if
        if direct (KEY_RIGHT_ARROW) then
            ^me.sDx (4)
        end if
        if direct (KEY_LEFT_ARROW) then
            ^me.sDx (-4)
        end if
    end loop
end CONTROL

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
process UI_DISPLAY
    loop
        locatexy (2, 580)
        put "Your score: ", ^me.EXP
        Draw.FillBox (0, 550, 400, 570, white)
        Draw.FillBox (0, 550, 4 * ^me.HP, 570, red)
        delay (100)
    end loop
end UI_DISPLAY

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%% MAIN PROGRAM %%%%%%%%%%%%%%%%%
fork CONTROL
fork MAIN
fork UI_DISPLAY
fork SCHEDULE
