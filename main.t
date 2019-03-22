%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Programmer  : Leo Liu
% Teacher     : Mr. Chow
% Course      : ICS4U
%
% Program Name: Bullet Hell
% Description : this is a shoot'em up game which you will need to
%               control your plane, which is continuously shooting,
%               to destroy your enemies, which unceasingly come out.
%               You need to dodge from the bullet hell of your enemies.
%               Each enemy you destroyed will give you score,
%               so you need to gain as much score as you can before
%               yourself get destroyed.
%               You win the game when you live for enough time,
%               indicated by the timer at the top right corner.
%               You lose when your HP get to zero, shown by the
%               red bar on top of the screen.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%% Import %%%%%%%%%%%%%%%%%%%%
import MyPlane in "MyPlane.t", Enemy in "Enemy.t"
%%%%%%%%%%%%%%%%%%%% HEADS UP DISPLAY %%%%%%%%%%%%%%%%%%%%
View.Set ("graphics")
View.Update
setscreen ("graphics:400;590,nocursor")
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%% GLOBAL VARIABLES %%%%%%%%%%%%%%%%%%%%
%%%%%% Overall Settings %%%%%%%
var timer : int := 0 % count the time
var gameOver : boolean := false
var victory : boolean := false

%%%%%% Specific Settings %%%%%%%
var vicCondition : int := 13141 %% time needed to win

%%%%%% Enemy Setup %%%%%
var openFire : boolean := false %%check pos to start shooting
var shootMode : int := 0    %% from left/right
var inBattle : boolean := false  %% if inBattle, then new waves of enemies will not be created
var timeRecord : int := 0  %% record time of death of middle enemy, for creating new middle

var eneArr : flexible array 1 .. 0 of ^Enemy %%store the enemies for scanning
new eneArr, 10
for i : 1 .. 10
    var newEne : ^Enemy
    new newEne
    eneArr (i) := newEne
    ^newEne.cons (-400, 530 - i * 5, 0, 0, 2, 0, 1000)
end for

%%%%%% User Setup %%%%%
var me : ^MyPlane %% user's plane
new me
^me.cons (200, 70, 0, 0, 1, white, 37)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%% Functions and Procedures %%%%%%%%%%%%%%%%%%%
%% this proc checks if the bullets have hit me or hit the enemies
proc checkHit
    % me hit ene
    for i : 1 .. upper ( ^me.bulArr)
	var x : int := ^ ( ^me.bulArr (i)).pX
	var y : int := ^ ( ^me.bulArr (i)).pY
	for j : 1 .. upper (eneArr)    %%%%%%%%% BUG no UNDERSTAND
	    if ^ (eneArr (j)).active
		    and x >= ^ (eneArr (j)).pX - 15
		    and x <= ^ (eneArr (j)).pX + 15
		    and y >= ^ (eneArr (j)).pY - 14
		    and y <= ^ (eneArr (j)).pY + 14 then

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
	    if ^ ( ^ (eneArr (i)).getBul (j)).pX > ^me.pX - 6
		    and ^ ( ^ (eneArr (i)).getBul (j)).pX < ^me.pX + 6
		    and ^ ( ^ (eneArr (i)).getBul (j)).pY > ^me.pY - 6
		    and ^ ( ^ (eneArr (i)).getBul (j)).pY < ^me.pY + 6
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

%% this fcn returns if the ene(small) are all killed so
%% that a new wave of enemies can immediately be created
fcn eneClear () : boolean
    for i : 1 .. 10
	if ^ (eneArr (i)).active then
	    result false
	end if
    end for
    result true
end eneClear
%%%%%%%%%%%%%%%%%%%% ENEMY WAVES %%%%%%%%%%%%%%%%%%%%
proc smallFromLeft %% create 10 smalls from left
    for i : 1 .. 10
	var newEne : ^Enemy
	new newEne
	eneArr (i) := newEne
	%cons(pX, pY, dX, dY, type, color, size)
	^newEne.cons (-i * 40, 530 - i * 5,
	    3, Rand.Int (-1, 1),
	    2, 73 + i * 3, 1000)
    end for
end smallFromLeft

proc smallFromRight %% create 10 smalls from right
    for i : 1 .. 10
	var newEne : ^Enemy
	new newEne
	%cons(pX, pY, dX, dY, type, color, size)
	^newEne.cons (400 + i * 40, 530 - i * 5,
	    - 3, Rand.Int (-1, 1),
	    2, 73 + i * 3, 1000)
	eneArr (i) := newEne
    end for
end smallFromRight

proc middleFromLeft %% create 1 middle from left
    var newEne : ^Enemy
    new newEne
    ^newEne.cons (20, 450, 2, -1, 3, Rand.Int (96, 103), 13900)
    eneArr (upper (eneArr)) := newEne
end middleFromLeft

%%%%%%%%%%%%%%%%%%%%%% PROCESSES %%%%%%%%%%%%%%%%%%%%%%%%%
%% main behaviors %%
process MAIN
    loop
	%%%%%% main actions %%%%%%%
	^me.move ()
	for i : 1 .. upper (eneArr)
	    ^ (eneArr (i)).move ()
	end for
	^me.shoot ()
	checkHit

	%%%%%%%%%%%%%%%%%%%%%%%%%%% build Enemy %%%%%%%%%%%%%%%%%%%%%%%%%%%

	%%%%%%% middle: each 300t %%%%%%%%
	if timer mod 300 = 299 and upper (eneArr) < 15 then
	    new eneArr, upper (eneArr) + 1
	    middleFromLeft
	elsif timer mod 300 = 299 then
	    for i : 11 .. 15
		if ^ (eneArr (i)).pY <= 0 then
		    var newEne : ^Enemy
		    new newEne
		    ^newEne.cons (20, 450, 2, -1, 3, Rand.Int (96, 103), 13900)
		    eneArr (i) := newEne
		    exit
		end if
	    end for
	end if
	%%%%% middle when died %%%%%
	for i : 11 .. upper (eneArr)
	    if not ^ (eneArr (i)).active then
		%% hide outside the screen for bullets to continue
		^ (eneArr (i)).sP (0, -500)
		timeRecord := timer
		%% create new
		if timer = timeRecord + 100 then
		    var newEne : ^Enemy
		    new newEne
		    ^newEne.cons (20, -450, 2, -1, 3, Rand.Int (96, 103), 13900)
		    eneArr (i) := newEne
		end if
	    end if
	end for

	%%%%%%%%%%% small %%%%%%%%%%%
	if not inBattle and timer > 100 then
	    openFire := false
	    %% choose mode : left/right %%
	    if timer mod 2 = 0 then
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
	    %%%%%%%%%%%%%%%%%%%%
	else
	    %%% start to shoot %%%
	    %% small shoot %%
	    if openFire then
		for i : 1 .. 10
		    if ^ (eneArr (i)).active or ^ (eneArr (i)).hasShot then
			^ (eneArr (i)).shoot
		    end if
		end for
	    end if
	    %% middle shoot %%
	    for i : 11 .. upper (eneArr)
		^ (eneArr (i)).shoot ()
	    end for

	    %%%%%%%%%%% check end of a battle : eneClear/out of screen %%%%%%%%%%
	    if eneClear () then
		for i : 1 .. upper (eneArr)
		    for j : 1 .. ^ (eneArr (i)).bulNum
			^ ( ^ (eneArr (i)).getBul (j)).erase ()
		    end for
		end for
		inBattle := false
	    end if
	    %% Condition of openFire & inBattle %%
	    %%% openFire when all planes reach a good position
	    %%% end Battle when all plane out of the screen
	    if shootMode = 1 then
		if ^ (eneArr (1)).pX >= Rand.Int (300, 380) and not openFire then
		    openFire := true
		    for i : 1 .. 10
			^ ( ^ (eneArr (i)).getBul (1)).sP ( ^ (eneArr (i)).pX, ^ (eneArr (i)).pY - 20)
		    end for
		end if
		if ^ (eneArr (1)).pX >= 820 then
		    inBattle := false
		end if

	    elsif shootMode = -1 then
		if ^ (eneArr (1)).pX <= Rand.Int (20, 100) and not openFire then
		    openFire := true
		    for i : 1 .. 10
			^ ( ^ (eneArr (i)).getBul (1)).sP ( ^ (eneArr (i)).pX, ^ (eneArr (i)).pY - 20)
		    end for
		end if
		if ^ (eneArr (1)).pX <= -420 then
		    inBattle := false
		end if
	    end if
	end if 


	%%%%%%%%% System Control %%%%%%%%%
	delay (25)
	timer += 1
	%View.Update
	%% VIC / OVER %%
	if timer >= vicCondition then
	    victory := true
	end if
	exit when gameOver or victory
    end loop
end MAIN

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% for user to control the plane
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
	delay(25)
	exit when gameOver
    end loop
end CONTROL

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Display HP, score, vicCondition on the top of the screen
process UI_DISPLAY
    loop
	delay (100)
	locatexy (2, 580)
	put "Your score: ", ^me.EXP, " " : 15,
	    "Survive ", (vicCondition - timer) * 25 div 1000, "s to win"
	Draw.FillBox (0, 550, 400, 570, gray)
	Draw.FillBox (0, 550, 4 * ^me.HP div 10, 570, 41)   %%%% HP
	delay (100)
    end loop
end UI_DISPLAY

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%% Main Program %%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%% Cover & Instruction %%%%%%%%%%%%%
var inInstruction : boolean := false %% check if currently in instruction page
var input : array char of boolean %% user input
%% font setting %%
colorback (151)
color (white)

%% cover page %%
Music.PlayFileLoop ("2.WAV")
Draw.FillBox (0, 0, 400, 590, 151)
Draw.FillStar (150, 250, 250, 350, white)
locatexy (0, 400)
put "" : 20, "BULLET HELL"
locatexy (0, 200)
put "" : 12, "Press SHIFT for instructions"
put "" : 16, "Press SPACE to start"
loop
    Input.KeyDown (input) %% get input for next step
    if input (' ') then %% clear the screen and start the game
	var cbg : int := 31
	Draw.FillBox (0, 0, 400, 590, cbg)
	Draw.FillBox (0, 0, 400, 550, 151)
	colorback (cbg)
	color (black)
	exit
    elsif input (KEY_SHIFT) then %% instruction page
	inInstruction := true
	cls
	locatexy (0, 330)
	put "" : 5, "Control your plane with the ARROW KEYS"
	put "" : 8, "Save yourself from the bullet hell"
	put "" : 16, "and Shoot'em UP!!!"
	put ""
	put "" : 10, "Press SPACE to start the game"
    end if

    delay (100)
end loop

%%%%%%%%%%%%%%%%%%% In Game %%%%%%%%%%%%%%%%%%

fork MAIN
fork UI_DISPLAY
delay(1500)
fork CONTROL

%%%%%%%%%%%%%%%%% End of Game %%%%%%%%%%%%%%%%
loop
    if victory then %% Vic: plane exit, display star
	^me.cons ( ^me.pX, ^me.pY, 0, 4, 1, white, 37)
	Draw.FillBox (0, 0, 400, 550, 151)
	^me.draw ()
	delay (1000)
	loop
	    ^me.draw ()
	    delay (50)
	    ^me.erase ()
	    ^me.sP ( ^me.pX, ^me.pY - 4)
	    exit when ^me.pY < -50
	end loop
	Draw.FillStar (80, 150, 320, 390, white)
	exit
    elsif gameOver then
	delay (200)
	exit
    end if
end loop

if gameOver then  %% GG: flash(explosion), black screen
    var gOTimer : int := 0 %% control time of flashing
    %%% flashing %%%
    loop
	Draw.FillBox (0, 0, 400, 550, white)
	delay (15)
	Draw.FillBox (0, 0, 400, 550, 151)
	delay (15)
	gOTimer += 1
	exit when gOTimer = 20
    end loop
    %%% black screen %%%
    Draw.FillBox (0, 0, 400, 590, black)
    colorback (black)
    color (white)
    locatexy (0, 300)
    put "" : 16, "qwq, MISSION FAILED"
end if
