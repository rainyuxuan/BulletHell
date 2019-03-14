import MyPlane in "MyPlane.t", Enemy in "Enemy.t"

View.Set ("graphics")
View.Update
setscreen ("graphics:400;600,nocursor")

%%%%%%%%%%%%%%%%%%%% Initialization %%%%%%%%%%%%%%%%%%%%%%%
Draw.FillBox (0, 0, 400, 550, 176)

%%%%%% Overall settings %%%%%%%
var timer : int := 0 % count the time
var gameOver : boolean := false

%%%%%% Enemy Setup %%%%%
var eneArr : flexible array 1 .. 0 of ^Enemy %%store the enemies for scanning
var openFire : boolean := false %%check pos to start shooting
var shootMode : int := 0

%%%%%% Me Setup %%%%%
var me : ^MyPlane
new me
^me.cons (200, 70, 0, 0, 1, white, 37)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%% Functions and Procedures %%%%%%%%%%%%%%%%%%%

proc checkHit
    % me hit ene
    for i : 1 .. upper ( ^me.bulArr)
	var x : int := ^ ( ^me.bulArr (i)).pX
	var y : int := ^ ( ^me.bulArr (i)).pY
	for j : 1 .. upper (eneArr)    %%%%%%%%% BUG no UNDERSTAND
	    if (x >= ^ (eneArr (j)).pX - 15 and x <= ^ (eneArr (j)).pX + 15)
		    and (y >= ^ (eneArr (j)).pY - 14 and y <= ^ (eneArr (j)).pY + 14)
		    and ^ (eneArr (j)).active then
		^ ( ^me.bulArr (i)).setActive (false)
		^ ( ^me.bulArr (i)).erase ()
		if ^ (eneArr (j)).hit ( ^me.damage) then
		    ^me.addEXP ( ^ (eneArr (j)).size)
		end if
	    end if
	end for
    end for
    % ene hit me
    for i : 1 .. upper (eneArr)
	for j : 1 .. ^ (eneArr (i)).bulNum
	    if ^ ( ^ (eneArr (i)).getBul (j)).pX > ^me.pX - 8 and ^ ( ^ (eneArr (i)).getBul (j)).pX < ^me.pX + 8
		    and ^ ( ^ (eneArr (i)).getBul (j)).pY > ^me.pY - 8 and ^ ( ^ (eneArr (i)).getBul (j)).pY < ^me.pY + 8
		    and ^ ( ^ (eneArr (i)).getBul (j)).active then
		^ ( ^ (eneArr (i)).getBul (j)).setActive (false)
		^ ( ^ (eneArr (i)).getBul (j)).erase ()
		if ^me.hit ( ^ (eneArr (i)).damage) then
		    gameOver := true
		end if
	    end if
	end for
    end for
end checkHit

fcn eneClear () : boolean
    for i : 1 .. upper (eneArr)
	if ^ (eneArr (i)).active then
	    result false
	end if
    end for
    result true
end eneClear
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% WAVES %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
proc smallFromLeft
    new eneArr, 10
    for i : 1 .. 10
	var they : ^Enemy
	new they
	eneArr (i) := they
	%pX, pY, dX, dY, type, color, size
	^they.cons (-i * 40, 530 - i * 5,
	    3, Rand.Int (-1, 1),
	    2, 60 + i * 3, 1000)
	%%% test with stable
	% ^they.cons (50 + i * 50, 500 - i * 5,
	%     0, 0,
	%     2, 60 + i * 3, 1000)
	%%%% end test
    end for
end smallFromLeft

proc smallFromRight
    new eneArr, 10
    for i : 1 .. 10
	var they : ^Enemy
	new they
	%pX, pY, dX, dY, type, color, size
	^they.cons (400 + i * 40, 530 - i * 5,
	    - 3, Rand.Int (-1, 1),
	    2, 60 + i * 3, 1000)
	eneArr (i) := they
    end for
end smallFromRight

proc middleFromLeft
    new eneArr, 1
    var they : ^Enemy
    new they
    ^they.cons (20, 450, 2, -1, 3, white, 15000)
    eneArr (1) := they
end middleFromLeft

%%%%%%%%%%%%%%%%%%%%%% PROCESSES %%%%%%%%%%%%%%%%%%%%%%%%%
process MAIN ()
    loop
	^me.shoot ()

	^me.move ()
	delay (25)
	for i : 1 .. upper (eneArr)
	    ^ (eneArr (i)).move ()
	end for
	checkHit
	exit when gameOver
    end loop
end MAIN

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
var inBattle : boolean := false
process SCHEDULE
    loop
	if not inBattle then
	    %% choose mode %%
	    openFire := false
	    delay(500)
	    if timer mod 4 = 0 then
		for i : 1 .. upper (eneArr)
		    ^ (eneArr (i)).erase
		end for

		shootMode := 3
		middleFromLeft
		inBattle := true
	    elsif timer mod 2 = 0 then
		for i : 1 .. upper (eneArr)
		    ^ (eneArr (i)).erase
		end for

		shootMode := 1
		smallFromLeft
		inBattle := true
	    elsif timer mod 2 not= 0 then
		for i : 1 .. upper (eneArr)
		    ^ (eneArr (i)).erase
		end for

		shootMode := -1
		smallFromRight
		inBattle := true
	    end if
	    %%%%%%%%%
	else
	    %%% start to shoot %%%
	    if openFire then
		for i : 1 .. upper (eneArr)
		    if ^ (eneArr (i)).active or ^ (eneArr (i)).hasShot then
			^ (eneArr (i)).shoot
		    end if
		end for
	    end if


	    %%%%%% end of a battle %%%%%
	    if eneClear () then
		for i : 1 .. upper (eneArr)
		    for j : 1 .. ^ (eneArr (i)).bulNum
			^ ( ^ (eneArr (i)).getBul (j)).erase ()
		    end for
		end for
		inBattle := false

		%new eneArr, 0
	    end if

	    if shootMode = 1 then
		if ^ (eneArr (1)).pX >= Rand.Int (300, 380) and not openFire then
		    openFire := true
		    for i : 1 .. upper (eneArr)
			^ ( ^ (eneArr (i)).getBul (1)).sP ( ^ (eneArr (i)).pX, ^ (eneArr (i)).pY - 20)
		    end for
		end if
		if ^ (eneArr (upper (eneArr))).pX >= 420 then
		    inBattle := false
		    %new eneArr, 0
		end if
	    elsif shootMode = -1 then
		if ^ (eneArr (1)).pX <= Rand.Int (20, 100) and not openFire then
		    openFire := true
		    for i : 1 .. upper (eneArr)
			^ ( ^ (eneArr (i)).getBul (1)).sP ( ^ (eneArr (i)).pX, ^ (eneArr (i)).pY - 20)
		    end for
		end if
		if ^ (eneArr (upper (eneArr))).pX <= -20 then
		    inBattle := false
		    %new eneArr, 0
		end if
	    elsif shootMode = 3 then
		if ^ (eneArr (1)).pX <= 350 and ^ (eneArr (1)).pX >= 50 and not openFire then
		    openFire := true
		    for i : 1 .. upper (eneArr)
			^ ( ^ (eneArr (i)).getBul (1)).sP ( ^ (eneArr (i)).pX, ^ (eneArr (i)).pY - 15)
		    end for
		end if
	    end if
	end if
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	delay (50)
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
	delay (100)
	locatexy (2, 580)
	put "Your score: ", ^me.EXP, " eC:", eneClear (), " timer: ",
	    timer, " oF: ", openFire, " iB: ", inBattle
	Draw.FillBox (0, 550, 400, 570, gray)
	Draw.FillBox (0, 550, 4 * ^me.HP, 570, red)
	delay (100)
    end loop
end UI_DISPLAY

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%% Main Program %%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%% Game LOOP %%%%%%%%%%%%%%%%%
fork CONTROL
fork MAIN
fork UI_DISPLAY
fork SCHEDULE
