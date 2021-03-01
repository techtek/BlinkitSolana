@echo off
cls    
:set   
	

	:: Get the Blink length set by the user in yourblinklength.txt 
	set /p blinklength=<%~dp0\yourblinklengthtasmota.txt
	
	:: Get the Tasmota IP from yourtasmotaiprgb.txt 
	set /p ip=<%~dp0\yourtasmotaiprgb.txt
 
 
	:: put the request in the yourtasmotarequest.txt 
 	echo /cm?cmnd=color%%20%%23FF04000000> %~dp0\yourtasmotarequest.txt 
	
 
 	:: Get the request from yourtasmotarequest.txt 
	set /p request=<%~dp0\yourtasmotarequest.txt  

 	:: Set off  
	set off=/cm?cmnd=Power%%20Off	

	
	


	
:testblink
	set loop1=0
	:loop1
	

	powershell.exe -noprofile -command "Invoke-WebRequest -Uri %ip%/cm?cmnd=color%%20%%233F00450000" > nul
	
		:: PING localhost -n 1 >NUL
	
	powershell.exe -noprofile -command "Invoke-WebRequest -Uri %ip%/cm?cmnd=color%%20%%236000690000" > nul
	
		:: PING localhost -n 1 >NUL

	powershell.exe -noprofile -command "Invoke-WebRequest -Uri %ip%/cm?cmnd=color%%20%%23A200B00000" > nul
	
		:: PING localhost -n 1 >NUL
	
	powershell.exe -noprofile -command "Invoke-WebRequest -Uri %ip%/cm?cmnd=color%%20%%23D300E60000" > nul
	
		:: PING localhost -n 1 >NUL
	
	powershell.exe -noprofile -command "Invoke-WebRequest -Uri %ip%/cm?cmnd=color%%20%%23D400FF0000" > nul
	
		:: PING localhost -n 1 >NUL
	
	powershell.exe -noprofile -command "Invoke-WebRequest -Uri %ip%/cm?cmnd=color%%20%%238C00FF0000" > nul

		:: PING localhost -n 1 >NUL		
	
	powershell.exe -noprofile -command "Invoke-WebRequest -Uri %ip%/cm?cmnd=color%%20%%236200FF0000" > nul
	
	    :: PING localhost -n 1 >NUL

	powershell.exe -noprofile -command "Invoke-WebRequest -Uri %ip%/cm?cmnd=color%%20%%233700FF0000" > nul
	
		:: 	PING localhost -n 1 >NUL

	powershell.exe -noprofile -command "Invoke-WebRequest -Uri %ip%/cm?cmnd=color%%20%%230099FF0000" > nul
	
		:: 	PING localhost -n 1 >NUL

	powershell.exe -noprofile -command "Invoke-WebRequest -Uri %ip%/cm?cmnd=color%%20%%2300BBFF0000" > nul
	
			:: 	PING localhost -n 1 >NUL
	
	powershell.exe -noprofile -command "Invoke-WebRequest -Uri %ip%/cm?cmnd=color%%20%%2300D4FF0000" > nul
	
		:: 	PING localhost -n 1 >NUL

	powershell.exe -noprofile -command "Invoke-WebRequest -Uri %ip%/cm?cmnd=color%%20%%2300FBFF0000" > nul
	
		:: 	PING localhost -n 1 >NUL		
		
	powershell.exe -noprofile -command "Invoke-WebRequest -Uri %ip%/cm?cmnd=color%%20%%2300B4D90000" > nul
	
			:: 	PING localhost -n 1 >NUL
	
	powershell.exe -noprofile -command "Invoke-WebRequest -Uri %ip%/cm?cmnd=color%%20%%230086A10000" > nul
	
		:: 	PING localhost -n 1 >NUL

	powershell.exe -noprofile -command "Invoke-WebRequest -Uri %ip%/cm?cmnd=color%%20%%23004A590000" > nul
	
		:: 	PING localhost -n 1 >NUL	
		
	powershell.exe -noprofile -command "Invoke-WebRequest -Uri %ip%/cm?cmnd=color%%20%%2300262E0000" > nul
	
		:: 	PING localhost -n 1 >NUL			
		
	
	
	powershell.exe -noprofile -command "Invoke-WebRequest -Uri %ip%%off%" > nul

	
	
	
	
	
	
	set /a loop1=%loop1%+1 
	if "%loop1%"=="%blinklength%" goto exit
	goto loop1

:: Play sound (deze moet naar elke de functie batch scripts)
powershell -c (New-Object Media.SoundPlayer "%~dp0\data\SolanaNotificationSound.wav").PlaySync();
		
	
:exit

exit