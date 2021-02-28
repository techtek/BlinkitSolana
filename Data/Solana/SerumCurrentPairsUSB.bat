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
    
  



  
  
  
  
  
   
:start
cls
   
   
:: Display welcome message to the user welcome.txt      
	type %~dp0\data\welcome.txt

	
:: Let the user know that Blinkit is going to start and watch for new blockchain action with these details:
	echo %Blue%Serum %Grey%Blink on new Serum pairs%Grey%
	echo.
	  
:: Let the user know what USB drive is selected	  
	echo %Grey%Your USB Flash Drive: %flashdrive%
	echo.
	
:: Let the user know the selected node	  
	echo %Grey%Serum Node https://serum-api.bonfida.com/
	echo.	

:: Blink the LED, by copying the LED file from the Blinkit folder to the flashdrive
	echo %Grey%Testing LED Blink... 
	xcopy %~dp0\data\ledfile.led %flashdrive%. /Y > nul 
	echo.
	
:: Let the user know a sound is being played by displaying the text:
	echo %Grey%Testing Notification Sound...%White%
	
:: Play and test windows notification sound	
	powershell -c echo `a	

:: Let the user know that the program is starting to look for new Blockchain actions
	echo.
	echo %White%Blinkit is now connecting your USB flash drive to the %Blue%Serum%White% exchange...	  
	echo.
	
:: Blinkit Script 

:: Download data from the API and save it into a txt file
	powershell -Command "Invoke-WebRequest https://serum-api.bonfida.com/pairs -OutFile %~dp0\data\downloadeddata.txt"
	:: powershell -Command "(gc %~dp0\data\downloadeddata.txt) -replace '.$' | Set-Content %~dp0\data\downloadeddata.txt -Force
	powershell -Command "(gc %~dp0\data\downloadeddata.txt) -replace '^........................' | Set-Content %~dp0\data\downloadeddata.txt -Force

	
	PING localhost -n 4 >NUL
	

:main   
:: Download data from API and save it into a txt file
	powershell -Command "Invoke-WebRequest https://serum-api.bonfida.com/pairs -OutFile %~dp0\data\downloadeddata2.txt"
	:: powershell -Command "(gc %~dp0\data\downloadeddata2.txt) -replace '.$' | Set-Content %~dp0\data\downloadeddata2.txt -Force
	powershell -Command "(gc %~dp0\data\downloadeddata2.txt) -replace '^........................' | Set-Content %~dp0\data\downloadeddata2.txt -Force

	
	
	PING localhost -n 4 >NUL

    	
:: Compare the 2 downloaded files if different go to "notification", if the files are the same go to "next" 
    fc  %~dp0\data\downloadeddata.txt  %~dp0\data\downloadeddata2.txt > nul
	if errorlevel 1 goto notification 
	if errorlevel 0 goto next
		
		
:next
:: let the user know the program is running by displaying the text:  
	echo.
	echo %White%Blinkit is running... %Grey%
	
	set /p pairs=<%~dp0\data\downloadeddata2.txt
	echo Current Serum market pairs: %pairs%
	

  
	
:: Download data from API and save it into a txt file
	powershell -Command "Invoke-WebRequest https://serum-api.bonfida.com/pairs -OutFile %~dp0\data\downloadeddata2.txt"
	:: powershell -Command "(gc %~dp0\data\downloadeddata2.txt) -replace '.$' | Set-Content %~dp0\data\downloadeddata2.txt -Force
	powershell -Command "(gc %~dp0\data\downloadeddata2.txt) -replace '^........................' | Set-Content %~dp0\data\downloadeddata2.txt -Force

	 
	 
	 :: 7 seconds silent delay (works by pinging local host)
	 PING localhost -n 7 >NUL
	
	goto main

	
    
:notification

:: Let the user know, there is a new action detected by displaying the text:   
	echo.
	echo %White%Blinkit change detected %Magenta%Serum %White%new pair is added: 
	echo %Green%Light blink! %White% 
    echo.
	set /p pairs=<%~dp0\data\downloadeddata2.txt
	echo New node pairs: %pairs%
	:: powershell -Command "(gc %~dp0\data\downloadeddata2.txt) -replace '.$' | Set-Content %~dp0\data\downloadeddata2.txt -Force
	powershell -Command "(gc %~dp0\data\downloadeddata2.txt) -replace '^........................' | Set-Content %~dp0\data\downloadeddata2.txt -Force

	type %~dp0\data\downloadeddata2.txt	
	

:: Blink the LED by copying the LED file to the flash drive 
    	
	set loop=0
	:loop
	xcopy %~dp0\data\ledfile.led %flashdrive%. /Y > nul
	set /a loop=%loop%+1 
	if "%loop%"=="%blinklength%" goto sound
	goto loop

	
	
	:sound
	
:: Play windows notification sound
    powershell -c echo `a 	
	


:: Download new data from API and save it into a txt file
	powershell -Command "Invoke-WebRequest https://serum-api.bonfida.com/pairs -OutFile %~dp0\data\downloadeddata.txt"
	:: powershell -Command "(gc %~dp0\data\downloadeddata.txt) -replace '.$' | Set-Content %~dp0\data\downloadeddata.txt -Force
	powershell -Command "(gc %~dp0\data\downloadeddata.txt) -replace '^........................' | Set-Content %~dp0\data\downloadeddata.txt -Force

	 
	 PING localhost -n 5 >NUL

	goto main