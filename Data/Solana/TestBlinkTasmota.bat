@echo off
cls    
:set   
	

	:: Get the Blink length set by the user in yourblinklength.txt 
	set /p blinklength=<%~dp0\yourblinklengthtasmota.txt
	
	:: Get the Tasmota IP from yourtasmotaip.txt 
	set /p ip=<%~dp0\yourtasmotaip.txt
 
	
		
:testblink
	set loop1=0
	:loop1
	powershell.exe -noprofile -command "Invoke-WebRequest -Uri %ip%" > nul
	set /a loop1=%loop1%+1 
	if "%loop1%"=="%blinklength%" goto exit
	goto loop1
	
	
:exit

exit