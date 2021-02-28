@echo off
cls    
:set   
	
	:: Get the Tasmota device IP from yourtasmotaip.txt 
	set /p ip=<%~dp0\yourtasmotaiprgb.txt
	
	:: Get the Blink length set by the user in yourblinklength.txt 
	set /p blinklength=<%~dp0\yourblinklengthtasmota.txt
	
	:: Get the Solana node from solananode.txt 
	set /p solananode=<%~dp0\solananode.txt 
    
	:: JSON request body 
    set jsonbody='{\"jsonrpc\":\"2.0\",\"method\":\"getEpochSchedule\",\"id\":1}'
	

	
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
	echo %Magenta%Solana %Grey%Blink on epoch%Grey%
	echo.
	  
:: Let the user know the Tasmota device ip that is set 	  
	echo %Grey%Your Tasmota device IP: %ip%
	echo.	
	
:: Let the user know the selected solananode	  
	echo %Grey%Solana Node %solananode%
	echo.	

:: Blink the light, by requesting the Tasmota toggle url
	echo %Grey%Testing Tasmota Device Blink... 
    START /MIN CMD.EXE /C %~dp0\TestBlinkTasmotaRGBSolanaColours.bat  
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

:: Download data from the Solana API and save it into a txt file
	powershell Invoke-RestMethod -ContentType 'application/json' -Method Post -Uri %solananode% -Body %jsonbody% -UserAgent "curl" -OutFile  %~dp0\data\downloadeddata.txt"
	powershell -Command "(gc %~dp0\data\downloadeddata.txt) -replace '.$' | Set-Content %~dp0\data\downloadeddata.txt -Force
	powershell -Command "(gc %~dp0\data\downloadeddata.txt) -replace '^.................................' | Set-Content %~dp0\data\downloadeddata.txt -Force

	
	PING localhost -n 4 >NUL
	

:main   
:: Download data from Solana API and save it into a txt file
	powershell Invoke-RestMethod -ContentType 'application/json' -Method Post -Uri %solananode% -Body %jsonbody% -UserAgent "curl" -OutFile  %~dp0\data\downloadeddata2.txt"
	powershell -Command "(gc %~dp0\data\downloadeddata2.txt) -replace '.$' | Set-Content %~dp0\data\downloadeddata2.txt -Force
	powershell -Command "(gc %~dp0\data\downloadeddata2.txt) -replace '^.................................' | Set-Content %~dp0\data\downloadeddata2.txt -Force

	
	
	PING localhost -n 4 >NUL

    	
:: Compare the 2 downloaded files if different go to "notification", if the files are the same go to "next" 
    fc  %~dp0\data\downloadeddata.txt  %~dp0\data\downloadeddata2.txt > nul
	if errorlevel 1 goto notification 
	if errorlevel 0 goto next
		
		
:next
:: let the user know the program is running by displaying the text:  
	echo.
	echo %White%Blinkit is running... %Grey%
	
	set /p epoch=<%~dp0\data\downloadeddata2.txt
	echo Epoch: %epoch%
	

  
	
:: Download data from Solana API and save it into a txt file
	powershell Invoke-RestMethod -ContentType 'application/json' -Method Post -Uri %solananode% -Body %jsonbody% -UserAgent "curl" -OutFile  %~dp0\data\downloadeddata2.txt"
	powershell -Command "(gc %~dp0\data\downloadeddata2.txt) -replace '.$' | Set-Content %~dp0\data\downloadeddata2.txt -Force
	powershell -Command "(gc %~dp0\data\downloadeddata2.txt) -replace '^.................................' | Set-Content %~dp0\data\downloadeddata2.txt -Force

	 
	 
	 :: 7 seconds silent delay (works by pinging local host)
	 PING localhost -n 7 >NUL
	
	goto main

	
    
:notification

:: Let the user know, there is a new action detected by displaying the text:   
	echo.
	echo %White%Blinkit change detected %Magenta%Solana %White%epoch: 
	echo %Green%Light blink! %White% 
    echo.
	set /p epoch=<%~dp0\data\downloadeddata2.txt
	echo New epoch: %epoch%
	powershell -Command "(gc %~dp0\data\downloadeddata2.txt) -replace '.$' | Set-Content %~dp0\data\downloadeddata2.txt -Force
	powershell -Command "(gc %~dp0\data\downloadeddata2.txt) -replace '^.................................' | Set-Content %~dp0\data\downloadeddata2.txt -Force

	type %~dp0\data\downloadeddata2.txt	
	

:: Blink the Tasmota device
    START /MIN CMD.EXE /C %~dp0\TestBlinkTasmotaRGBSolanaColours.bat  goto sound


	
	
	:sound
	
:: Play windows notification sound
    powershell -c echo `a 	
	


:: Download new data from Solana API and save it into a txt file
	powershell Invoke-RestMethod -ContentType 'application/json' -Method Post -Uri %solananode% -Body %jsonbody% -UserAgent "curl" -OutFile  %~dp0\data\downloadeddata.txt"
	powershell -Command "(gc %~dp0\data\downloadeddata.txt) -replace '.$' | Set-Content %~dp0\data\downloadeddata.txt -Force
	powershell -Command "(gc %~dp0\data\downloadeddata.txt) -replace '^.................................' | Set-Content %~dp0\data\downloadeddata.txt -Force

	 
	 PING localhost -n 5 >NUL

	goto main