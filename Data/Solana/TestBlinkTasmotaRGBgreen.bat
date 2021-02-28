@echo off
cls    
:set   
	

	:: Get the Blink length set by the user in yourblinklength.txt 
	set /p blinklength=<%~dp0\yourblinklengthtasmota.txt
	
	:: Get the Tasmota IP from yourtasmotaiprgb.txt 
	set /p ip=<%~dp0\yourtasmotaiprgb.txt
 
 
	:: put the request in the yourtasmotarequest.txt 
 	echo /cm?cmnd=color%%20%%2326FF000000> %~dp0\yourtasmotarequest.txt 
	
 
 	:: Get the request from yourtasmotarequest.txt 
	set /p request=<%~dp0\yourtasmotarequest.txt  

 	:: Set off  
	set off=/cm?cmnd=Power%%20Off	



	
	
:testblink
	set loop1=0
	:loop1
	powershell.exe -noprofile -command "Invoke-WebRequest -Uri %ip%%request%" > nul
	powershell.exe -noprofile -command "Invoke-WebRequest -Uri %ip%%off%" > nul
	set /a loop1=%loop1%+1 
	if "%loop1%"=="%blinklength%" goto exit
	goto loop1
	
	
:exit

exit