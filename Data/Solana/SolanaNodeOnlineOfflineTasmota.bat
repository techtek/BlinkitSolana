@echo off
cls    
:set   
	
	:: Get the Tasmota device IP from yourtasmotaip.txt 
	set /p ip=<%~dp0\yourtasmotaip.txt
	
	:: Get the Blink length set by the user in yourblinklength.txt 
	set /p blinklength=<%~dp0\yourblinklengthtasmota.txt
	
	:: Get the Solana node from solananode.txt 
	set /p solananode=<%~dp0\solananode.txt 
    	
	
	:: Colour settings
	set ESC=
	set Red=%ESC%[91m
	set White=%ESC%[37m
	set Green=%ESC%[32m
	set Magenta=%ESC%[35m
	set Blue=%ESC%[94m
    set Grey=%ESC%[90m
    
  



  
  
  
  
  
   
:start
cls
   
   
:: Display welcome message to the user welcome.txt      
	type %~dp0\data\welcome.txt

	
:: Let the user know that Blinkit is going to start and watch for new blockchain action with these details:
	echo %Magenta%Solana %Grey%Blink on node status offline%Grey%
	echo.
	  
:: Let the user know the Tasmota device ip that is set 	  
	echo %Grey%Your Tasmota device IP: %ip%
	echo.	
	
:: Let the user know the selected solananode	  
	echo %Grey%Solana Node %solananode%
	echo.	

:: Blink the light, by requesting the Tasmota toggle url
	echo %Grey%Testing Tasmota Device Blink... 
    START /MIN CMD.EXE /C %~dp0\TestBlinkTasmota.bat  
	echo.
	
:: Let the user know a sound is being played by displaying the text:
	echo %Grey%Testing Notification Sound...%White%
	
:: Play and test windows notification sound	
	powershell -c echo `a	

:: Let the user know that the program is starting to look for new Blockchain actions
	echo.
	echo %White%Blinkit is now connecting your Tasmota device to the %Magenta%Solana%White% blockchain...	  
	echo.
	
:: Blinkit Script 

	PING localhost -n 4 >NUL
	

:main   


    powershell -Command "(gc %~dp0\solananode.txt) -replace '^........' | Set-Content %~dp0\solananodestripped.txt -Force

	set /p nodeslist=<%~dp0\solananodestripped.txt
	set addresses=%nodeslist%
	for %%a in (%addresses%) do ping %%a -n 1 > nul || goto notification 

	
		
:next
:: let the user know the program is running by displaying the text:  
	echo.
	echo %White%Blinkit is running... %Grey%
	echo %Grey%Node %solananode% status: %Green%online%grey% 
	
	 
	 :: 7 seconds silent delay (works by pinging local host)
	 PING localhost -n 7 >NUL
	
	goto main

	
	
:notification

:: Let the user know, there is a new action detected by displaying the text:   
	echo.
	echo %White%Blinkit is running... %Grey%
	echo %Grey%Node %solananode% status: %Red%offline%grey%
	echo %Grey%Light blink! %White% 



:: Blink the Tasmota device
    START /MIN CMD.EXE /C %~dp0\TestBlinkTasmota.bat  goto sound

	

	
	
	:sound
	
:: Play windows notification sound
    powershell -c echo `a

	 :: 7 seconds silent delay (works by pinging local host)
	 PING localhost -n 7 >NUL

goto main