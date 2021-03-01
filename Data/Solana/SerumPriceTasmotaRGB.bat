@echo off
cls    
:set   

    :: Set the SRM price
	set /p srmprice=<%~dp0\data\serumpricestriped.txt 

	:: Get the Tasmota device IP from yourtasmotaip.txt 
	set /p ip=<%~dp0\yourtasmotaiprgb.txt
	
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
	echo %Blue%Serum %Grey%Blink on SRM price changes%Grey%
	echo.

	  
:: Let the user know the price API provider	  
	echo %Grey%Coin Gecko Price
	echo.	

:: Let the user know the Tasmota device ip that is set 	  
	echo %Grey%Your Tasmota device IP: %ip%
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
	echo %White%Blinkit is now connecting your Tasmota device to the %Blue%Serum%White% price...	  
	echo.
	
:: Blinkit Script 


::  Download the latest SRM Price and put it inside a txt files
	powershell -Command "Invoke-WebRequest https://cutt.ly/nlcKQpr -OutFile %~dp0\data\serumprice.txt"
	
:: Find and display the latest Serum SRM Price in USD from the downloaded txt files	  
	for /F "delims=" %%a in ('findstr /I ""usd"" %~dp0\data\serumprice.txt') do set "batToolDir0=%%a"

:: Update the SRM price in USD into txt file
	echo %batToolDir0%> %~dp0\data\serumpricestriped.txt

	
:: Deletes unwanted characters from the serumpricestriped.txt and keep only the numeric value
	
	:: Delete characters from serumpricestriped.txt
	FOR /f "delims=" %%i IN (%~dp0\data\serumpricestriped.txt) DO (
	SET line=%%i
	SET line=!line:"=!
	SET line=!line:serum=!
	SET line=!line:usd=!
	SET line=!line::=!
	SET line=!line:,=!
	SET line=!line:{=!
	SET line=!line:}=!
	SET line=!line:}=!
	echo !line! > %~dp0\data\serumpricestriped.txt
	)
		
	
	
	PING localhost -n 4 >NUL
	

:main   

::  Download the latest SRM Price and put it inside a txt files
	powershell -Command "Invoke-WebRequest https://cutt.ly/nlcKQpr -OutFile %~dp0\data\serumprice2.txt"
	
:: Find and display the latest Serum SRM Price in USD from the downloaded txt files	  
	for /F "delims=" %%a in ('findstr /I ""usd"" %~dp0\data\serumprice2.txt') do set "batToolDir1=%%a"

:: Update the SRM price in USD into txt file
	echo %batToolDir1%> %~dp0\data\serumpricestriped2.txt

	
:: Deletes unwanted characters from the serumpricestriped2.txt and keep only the numeric value
	
	:: Delete characters from serumpricestriped2.txt
	FOR /f "delims=" %%i IN (%~dp0\data\serumpricestriped2.txt) DO (
	SET line=%%i
	SET line=!line:"=!
	SET line=!line:serum=!
	SET line=!line:usd=!
	SET line=!line::=!
	SET line=!line:,=!
	SET line=!line:{=!
	SET line=!line:}=!
	SET line=!line:}=!
	echo !line! > %~dp0\data\serumpricestriped2.txt
	)
	
	
	PING localhost -n 4 >NUL

    	
:: Compare the 2 downloaded files if different go to "notification", if the files are the same go to "next" 
set /p priceold=<%~dp0\data\serumpricestriped.txt
set /p pricenew=<%~dp0\data\serumpricestriped2.txt


	
	if %priceold% equ %pricenew% goto next
	if %pricenew% gtr %priceold% goto notificationhigherprice
	goto notificationlowerprice
	
	
	
			
:next
:: let the user know the program is running by displaying the text:  
	echo.
	echo %White%Blinkit is running... %Grey%

	set /p srmprice=<%~dp0\data\serumpricestriped2.txt 
	echo Current SRM Price (USD): %srmprice% 
    
	
	
::  Download the latest SRM Price and put it inside a txt files
	powershell -Command "Invoke-WebRequest https://cutt.ly/nlcKQpr -OutFile %~dp0\data\serumprice2.txt"
	
:: Find and display the latest Serum SRM Price in USD from the downloaded txt files	  
	for /F "delims=" %%a in ('findstr /I ""usd"" %~dp0\data\serumprice2.txt') do set "batToolDir2=%%a"

:: Update the SRM price in USD into txt file
	echo %batToolDir2%> %~dp0\data\serumpricestriped2.txt

	
:: Deletes unwanted characters from the serumpricestriped2.txt and keep only the numeric value

	:: Delete characters from serumpricestriped.txt
	FOR /f "delims=" %%i IN (%~dp0\data\serumpricestriped2.txt) DO (
	SET line=%%i
	SET line=!line:"=!
	SET line=!line:serum=!
	SET line=!line:usd=!
	SET line=!line::=!
	SET line=!line:,=!
	SET line=!line:{=!
	SET line=!line:}=!
	SET line=!line:}=!
	echo !line! > %~dp0\data\serumpricestriped2.txt
	)
	 
	 :: 7 seconds silent delay (works by pinging local host)
	 PING localhost -n 7 >NUL
	
	goto main

	
    
:notificationhigherprice

:: Let the user know, there is a new action detected by displaying the text:   
	echo.
	echo %White%Blinkit new price change detected for %Blue%Serum %White% 
	echo %Green%Light blink!, the price of SRM went up. %Grey% 

	set /p srmprice=<%~dp0\data\serumpricestriped2.txt 
	echo Current SRM Price (USD): %srmprice% 
   


:: Blink the Tasmota device
    START /MIN CMD.EXE /C %~dp0\TestBlinkTasmotaRGBgreen.bat  goto sound


	
	
	:sound
	
:: Play windows notification sound
    powershell  [system.media.systemsounds]::Hand.play()	
	


::  Download the latest SRM Price and put it inside a txt files
	powershell -Command "Invoke-WebRequest https://cutt.ly/nlcKQpr -OutFile %~dp0\data\serumprice.txt"
	
:: Find and display the latest Serum SRM Price in USD from the downloaded txt files	  
	for /F "delims=" %%a in ('findstr /I ""usd"" %~dp0\data\serumprice.txt') do set "batToolDir3=%%a"

:: Update the SRM price in USD into txt file
	echo %batToolDir3%> %~dp0\data\serumpricestriped.txt

	
:: Deletes unwanted characters from the serumpricestriped.txt and keep only the numeric value
	
	:: Delete characters from serumpricestriped.txt
	FOR /f "delims=" %%i IN (%~dp0\data\serumpricestriped.txt) DO (
	SET line=%%i
	SET line=!line:"=!
	SET line=!line:serum=!
	SET line=!line:usd=!
	SET line=!line::=!
	SET line=!line:,=!
	SET line=!line:{=!
	SET line=!line:}=!
	SET line=!line:}=!
	echo !line! > %~dp0\data\serumpricestriped.txt
	)
	 
	 PING localhost -n 5 >NUL

	goto main
	
	
:notificationlowerprice	
:: Let the user know, there is a new action detected by displaying the text:   
	echo.
	echo %White%Blinkit new price change detected for %Blue%Serum %White% 
	echo %Red%Light blink!, the price of SRM went down. %Grey% 

   	set /p srmprice=<%~dp0\data\serumpricestriped2.txt 
	echo Current SRM Price (USD): %srmprice% 


:: Blink the Tasmota device
    START /MIN CMD.EXE /C %~dp0\TestBlinkTasmotaRGBred.bat  goto sound


	
	
	:sound
	
:: Play windows notification sound
    powershell  [system.media.systemsounds]::Hand.play()
	


::  Download the latest SRM Price and put it inside a txt files
	powershell -Command "Invoke-WebRequest https://cutt.ly/nlcKQpr -OutFile %~dp0\data\serumprice.txt"
	
:: Find and display the latest Serum SRM Price in USD from the downloaded txt files	  
	for /F "delims=" %%a in ('findstr /I ""usd"" %~dp0\data\serumprice.txt') do set "batToolDir3=%%a"

:: Update the SRM price in USD into txt file
	echo %batToolDir3%> %~dp0\data\serumpricestriped.txt

	
:: Deletes unwanted characters from the serumpricestriped.txt and keep only the numeric value
	
	:: Delete characters from serumpricestriped.txt
	FOR /f "delims=" %%i IN (%~dp0\data\serumpricestriped.txt) DO (
	SET line=%%i
	SET line=!line:"=!
	SET line=!line:serum=!
	SET line=!line:usd=!
	SET line=!line::=!
	SET line=!line:,=!
	SET line=!line:{=!
	SET line=!line:}=!
	SET line=!line:}=!
	echo !line! > %~dp0\data\serumpricestriped.txt
	)
	 
	 PING localhost -n 5 >NUL

	goto main