@echo off

cls    
:set   

    :: Set the SOL price
	set /p solprice=<%~dp0\data\solpricestriped.txt 

	:: Get the Tasmota device IP from yourtasmotaip.txt 
	set /p ip=<%~dp0\yourtasmotaip.txt
	
	:: Get the Blink length set by the user in yourblinklength.txt 
	set /p blinklength=<%~dp0\yourblinklengthtasmota.txt
	
		:: Get the Blink length set by the user in yourblinklength.txt 
	set /p pricealertprice=<%~dp0\yourpricealert.txt
	
	
	
	:: Colour settings
	set ESC=
	set Red=%ESC%[91m
	set White=%ESC%[37m
	set Green=%ESC%[32m
	set Magenta=%ESC%[35m
	set Blue=%ESC%[94m
    set Grey=%ESC%[90m

  
	SETLOCAL enabledelayedexpansion


  
  
  
  
  
   
:start
cls
   

   
:: Display welcome message to the user welcome.txt      
	type %~dp0\data\welcome.txt

	
:: Let the user know that Blinkit is going to start and watch for new blockchain action with these details:
	echo %Magenta%Solana %Grey%Blink on SOL price below the set alert price%Grey%
	echo.

	  
:: Let the user know additional information	  
	echo %Grey%Coin Gecko price is used
	echo.	

:: Let the user know the selected node	  
	echo %Grey%The price alert is set at (USD): %pricealertprice%
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


::  Download the latest SOL Price and put it inside a txt files
	powershell -Command "Invoke-WebRequest https://cutt.ly/bgxiI9Q -OutFile %~dp0\data\solprice.txt"
	
:: Find and display the latest Solana SOL Price in USD from the downloaded txt files	  
	for /F "delims=" %%a in ('findstr /I ""usd"" %~dp0\data\solprice.txt') do set "batToolDir0=%%a"

:: Update the SOL price in USD into txt file
	echo %batToolDir0%> %~dp0\data\solpricestriped.txt

	
:: Deletes unwanted characters from the solpricestriped.txt and keep only the numeric value
	
	:: Delete characters from solpricestriped.txt
	for /f "delims=" %%a in (%~dp0\data\solpricestriped.txt) do (
    set variabl=%%a
	:: keep only the needed chars ( 4 chars starting from position 16)
	set adjpric=!variabl:~16,4!
	)
	
	echo !adjpric! > %~dp0\data\solpricestriped.txt
		
	
	
	PING localhost -n 4 >NUL
	

:main   

::  Download the latest SOL Price and put it inside a txt files
	powershell -Command "Invoke-WebRequest https://cutt.ly/bgxiI9Q -OutFile %~dp0\data\solprice2.txt"
	
:: Find and display the latest SOL Price in USD from the downloaded txt files	  
	for /F "delims=" %%a in ('findstr /I ""usd"" %~dp0\data\solprice2.txt') do set "batToolDir1=%%a"

:: Update the SOL price in USD into txt file
	echo %batToolDir1%> %~dp0\data\solpricestriped2.txt

	
:: Deletes unwanted characters from the solpricestriped2.txt and keep only the numeric value
	
	:: Delete characters from solpricestriped2.txt
	for /f "delims=" %%a in (%~dp0\data\solpricestriped2.txt) do (
    set variable=%%a
	:: keep only the needed chars ( 4 chars starting from position 16)
	set adjprice=!variable:~16,4!
	)
	
	echo !adjprice! > %~dp0\data\solpricestriped2.txt
	
	
	
	PING localhost -n 4 >NUL

    	
:: Compare the 2 downloaded files if different go to "notification", if the files are the same go to "next" 

	set /p priceold=<%~dp0\data\solpricestriped.txt
	set /p pricenew=<%~dp0\data\solpricestriped2.txt
 
	set newprice=!pricenew:~0,-1!
	
	FOR %%? IN (%~dp0\yourpricealert.txt) DO ( SET /A alertstrlength=%%~z? )
	FOR %%? IN (%~dp0\data\solpricestriped2.txt) DO ( SET /A newpricestrlength=%%~z? -3 )

	if !newpricestrlength! EQU !alertstrlength! (
		if !newprice! LEQ !pricealertprice! (
			goto notification
		)
			if !newprice! GTR !pricealertprice! (
				goto next 
			)
	)
	
	if !newpricestrlength! LSS !alertstrlength! (
			goto notification
	)
	
	

	
:next
:: let the user know the program is running by displaying the text:  
	echo.
	echo %White%Blinkit is running... %Grey%

	set /p solprice=<%~dp0\data\solpricestriped2.txt 
	echo Current SOL Price (USD): %solprice% 
    
	
	
::  Download the latest SOL Price and put it inside a txt files
	powershell -Command "Invoke-WebRequest https://cutt.ly/bgxiI9Q -OutFile %~dp0\data\solprice2.txt"
	
:: Find and display the latest SOL Price in USD from the downloaded txt files	  
	for /F "delims=" %%a in ('findstr /I ""usd"" %~dp0\data\solprice2.txt') do set "batToolDir2=%%a"

:: Update the SOL price in USD into txt file
	echo %batToolDir2%> %~dp0\data\solpricestriped2.txt

	
:: Deletes unwanted characters from the solpricestriped2.txt and keep only the numeric value

	:: Delete characters from solpricestriped2.txt
	for /f "delims=" %%a in (%~dp0\data\solpricestriped2.txt) do (
    set variable=%%a
	:: keep only the needed chars ( 4 chars starting from position 16)
	set adjsprice=!variable:~16,4!
	)
	
	echo !adjsprice! > %~dp0\data\solpricestriped2.txt
	
	 
	 :: 8 seconds silent delay (works by pinging local host)
	 PING localhost -n 7 >NUL
	
	goto main

	
    
:notification

:: Let the user know, there is a new action detected by displaying the text:   
	echo.
	echo %White%Blinkit %Magneta%Solana%White% price alert is reached!
	echo %Green%Light blink! %Grey% 

	set /p solprice=<%~dp0\data\solpricestriped2.txt 
	echo Current SOL Price (USD): %solprice% 
   


:: Blink the Tasmota device
    START /MIN CMD.EXE /C %~dp0\TestBlinkTasmota.bat  goto sound


	
	
	:sound
	
:: Play windows notification sound
    powershell  [system.media.systemsounds]::Hand.play()
	


::  Download the latest SOL Price and put it inside a txt files
	powershell -Command "Invoke-WebRequest https://cutt.ly/bgxiI9Q -OutFile %~dp0\data\solprice.txt"
	
:: Find and display the latest SOL Price in USD from the downloaded txt files	  
	for /F "delims=" %%a in ('findstr /I ""usd"" %~dp0\data\solprice.txt') do set "batToolDir3=%%a"

:: Update the SOL price in USD into txt file
	echo %batToolDir3%> %~dp0\data\solpricestriped.txt

	
:: Deletes unwanted characters from the solpricestriped.txt and keep only the numeric value
	
	:: Delete characters from solpricestriped.txt
	for /f "delims=" %%a in (%~dp0\data\solpricestriped.txt) do (
    set variabl=%%a
	:: keep only the needed chars ( 4 chars starting from position 16)
	set adjpric=!variabl:~16,4!
	)
	
	echo !adjpric! > %~dp0\data\solpricestriped.txt
	
	 
	 PING localhost -n 5 >NUL

	goto main
	
