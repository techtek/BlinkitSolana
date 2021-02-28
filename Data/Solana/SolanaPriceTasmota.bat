@echo off
cls    
:set   

    :: Set the sol price
	set /p solprice=<%~dp0\data\solanasolpricestriped.txt 

	:: Get the Tasmota device IP from yourtasmotaip.txt 
	set /p ip=<%~dp0\yourtasmotaip.txt
	
	:: Get the Blink length set by the user in yourblinklength.txt 
	set /p blinklength=<%~dp0\yourblinklengthtasmota.txt
	
	
	
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
	echo %Magenta%Solana %Grey%Blink on SOL price changes%Grey%
	echo.

	  
:: Let the user know the price API provider	  
	echo %Grey%Coin Gecko Price
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


::  Download the latest sol Price and put it inside a txt files
	powershell -Command "Invoke-WebRequest https://cutt.ly/bgxiI9Q -OutFile %~dp0\data\solanasolprice.txt"
	
:: Find and display the latest solana sol Price in USD from the downloaded txt files	  
	for /F "delims=" %%a in ('findstr /I ""usd"" %~dp0\data\solanasolprice.txt') do set "batToolDir0=%%a"

:: Update the sol price in USD into txt file
	echo %batToolDir0%> %~dp0\data\solanasolpricestriped.txt

	
:: Deletes unwanted characters from the solanasolpricestriped.txt and keep only the numeric value
	
	:: Delete characters from solanasolpricestriped.txt
	FOR /f "delims=" %%i IN (%~dp0\data\solanasolpricestriped.txt) DO (
	SET line=%%i
	SET line=!line:"=!
	SET line=!line:solana=!
	SET line=!line:usd=!
	SET line=!line::=!
	SET line=!line:,=!
	SET line=!line:{=!
	SET line=!line:}=!
	SET line=!line:}=!
	echo !line! > %~dp0\data\solanasolpricestriped.txt
	)
		
	
	
	PING localhost -n 4 >NUL
	

:main   

::  Download the latest sol Price and put it inside a txt files
	powershell -Command "Invoke-WebRequest https://cutt.ly/bgxiI9Q -OutFile %~dp0\data\solanasolprice2.txt"
	
:: Find and display the latest solana sol Price in USD from the downloaded txt files	  
	for /F "delims=" %%a in ('findstr /I ""usd"" %~dp0\data\solanasolprice2.txt') do set "batToolDir1=%%a"

:: Update the sol price in USD into txt file
	echo %batToolDir1%> %~dp0\data\solanasolpricestriped2.txt

	
:: Deletes unwanted characters from the solanasolpricestriped2.txt and keep only the numeric value
	
	:: Delete characters from solanasolpricestriped2.txt
	FOR /f "delims=" %%i IN (%~dp0\data\solanasolpricestriped2.txt) DO (
	SET line=%%i
	SET line=!line:"=!
	SET line=!line:solana=!
	SET line=!line:usd=!
	SET line=!line::=!
	SET line=!line:,=!
	SET line=!line:{=!
	SET line=!line:}=!
	SET line=!line:}=!
	echo !line! > %~dp0\data\solanasolpricestriped2.txt
	)
	
	
	PING localhost -n 4 >NUL

    	
:: Compare the 2 downloaded files if different go to "notification", if the files are the same go to "next" 
set /p priceold=<%~dp0\data\solanasolpricestriped.txt
set /p pricenew=<%~dp0\data\solanasolpricestriped2.txt


	
	if %priceold% equ %pricenew% goto next
	if %pricenew% gtr %priceold% goto notificationhigherprice
	goto notificationlowerprice
	
	
	
			
:next
:: let the user know the program is running by displaying the text:  
	echo.
	echo %White%Blinkit is running... %Grey%

	set /p solprice=<%~dp0\data\solanasolpricestriped2.txt 
	echo Current SOL Price (USD): %solprice% 
    
	
	
::  Download the latest sol Price and put it inside a txt files
	powershell -Command "Invoke-WebRequest https://cutt.ly/bgxiI9Q -OutFile %~dp0\data\solanasolprice2.txt"
	
:: Find and display the latest solana sol Price in USD from the downloaded txt files	  
	for /F "delims=" %%a in ('findstr /I ""usd"" %~dp0\data\solanasolprice2.txt') do set "batToolDir2=%%a"

:: Update the sol price in USD into txt file
	echo %batToolDir2%> %~dp0\data\solanasolpricestriped2.txt

	
:: Deletes unwanted characters from the solanasolpricestriped2.txt and keep only the numeric value

	:: Delete characters from solanasolpricestriped.txt
	FOR /f "delims=" %%i IN (%~dp0\data\solanasolpricestriped2.txt) DO (
	SET line=%%i
	SET line=!line:"=!
	SET line=!line:solana=!
	SET line=!line:usd=!
	SET line=!line::=!
	SET line=!line:,=!
	SET line=!line:{=!
	SET line=!line:}=!
	SET line=!line:}=!
	echo !line! > %~dp0\data\solanasolpricestriped2.txt
	)
	 
	 :: 7 seconds silent delay (works by pinging local host)
	 PING localhost -n 7 >NUL
	
	goto main

	
    
:notificationhigherprice

:: Let the user know, there is a new action detected by displaying the text:   
	echo.
	echo %White%Blinkit new price change detected for %Magenta%Solana %White% 
	echo %Green%Light blink!, the price of sol went up. %Grey% 

	set /p solprice=<%~dp0\data\solanasolpricestriped2.txt 
	echo Current SOL Price (USD): %solprice% 
   


:: Blink the Tasmota device
    START /MIN CMD.EXE /C %~dp0\TestBlinkTasmota.bat  goto sound


	
	
	:sound
	
:: Play windows notification sound
    powershell  [system.media.systemsounds]::Hand.play()	
	


::  Download the latest sol Price and put it inside a txt files
	powershell -Command "Invoke-WebRequest https://cutt.ly/bgxiI9Q -OutFile %~dp0\data\solanasolprice.txt"
	
:: Find and display the latest Solana sol Price in USD from the downloaded txt files	  
	for /F "delims=" %%a in ('findstr /I ""usd"" %~dp0\data\solanasolprice.txt') do set "batToolDir3=%%a"

:: Update the sol price in USD into txt file
	echo %batToolDir3%> %~dp0\data\solanasolpricestriped.txt

	
:: Deletes unwanted characters from the solanasolpricestriped.txt and keep only the numeric value
	
	:: Delete characters from solanasolpricestriped.txt
	FOR /f "delims=" %%i IN (%~dp0\data\solanasolpricestriped.txt) DO (
	SET line=%%i
	SET line=!line:"=!
	SET line=!line:solana=!
	SET line=!line:usd=!
	SET line=!line::=!
	SET line=!line:,=!
	SET line=!line:{=!
	SET line=!line:}=!
	SET line=!line:}=!
	echo !line! > %~dp0\data\solanasolpricestriped.txt
	)
	 
	 PING localhost -n 5 >NUL

	goto main
	
	
:notificationlowerprice	
:: Let the user know, there is a new action detected by displaying the text:   
	echo.
	echo %White%Blinkit new price change detected for %Magenta%Solana %White% 
	echo %Red%Light blink!, the price of sol went down. %Grey% 

   	set /p solprice=<%~dp0\data\solanasolpricestriped2.txt 
	echo Current SOL Price (USD): %solprice% 


:: Blink the Tasmota device
    START /MIN CMD.EXE /C %~dp0\TestBlinkTasmota.bat  goto sound


	
	
	:sound
	
:: Play windows notification sound
    powershell  [system.media.systemsounds]::Hand.play()
	


::  Download the latest sol Price and put it inside a txt files
	powershell -Command "Invoke-WebRequest https://cutt.ly/bgxiI9Q -OutFile %~dp0\data\solanasolprice.txt"
	
:: Find and display the latest Solana sol Price in USD from the downloaded txt files	  
	for /F "delims=" %%a in ('findstr /I ""usd"" %~dp0\data\solanasolprice.txt') do set "batToolDir3=%%a"

:: Update the sol price in USD into txt file
	echo %batToolDir3%> %~dp0\data\solanasolpricestriped.txt

	
:: Deletes unwanted characters from the solanasolpricestriped.txt and keep only the numeric value
	
	:: Delete characters from solanasolpricestriped.txt
	FOR /f "delims=" %%i IN (%~dp0\data\solanasolpricestriped.txt) DO (
	SET line=%%i
	SET line=!line:"=!
	SET line=!line:solana=!
	SET line=!line:usd=!
	SET line=!line::=!
	SET line=!line:,=!
	SET line=!line:{=!
	SET line=!line:}=!
	SET line=!line:}=!
	echo !line! > %~dp0\data\solanasolpricestriped.txt
	)
	 
	 PING localhost -n 5 >NUL

	goto main