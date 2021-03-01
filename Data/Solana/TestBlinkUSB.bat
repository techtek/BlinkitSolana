@echo off
cls    
:set   
	
	:: Get the flashdrive letter set by the user in yourusbdrive.txt
	set /p flashdrive=<%~dp0\yourusbdrive.txt
	
	:: Get the Blink length set by the user in yourblinklength.txt 
	set /p blinklength=<%~dp0\yourblinklength.txt
	
	
	
	:: Colour settings
	set ESC=
	set Red=%ESC%[91m
	set White=%ESC%[37m
	set Green=%ESC%[32m
	set Magenta=%ESC%[35m
	set Blue=%ESC%[94m
    set Grey=%ESC%[90m

:testblink
	set loop1=0
	:loop1
	xcopy %~dp0\data\ledfile.led %flashdrive%. /Y > nul
	set /a loop1=%loop1%+1 
	if "%loop1%"=="%blinklength%" goto menu
	goto loop1