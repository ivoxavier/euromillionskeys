'''
 Copyright (C) 2022  Ivo Xavier

 This program is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation; version 3.

 euromillionskeys is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.

 You should have received a copy of the GNU General Public License
  along with this program.  If not, see <http://www.gnu.org/licenses/>.
'''
import time
import urllib.request
import os
import codecs
import pyotherside
import re
import json
import random
from time import strftime
from datetime import datetime
from bs4 import BeautifulSoup

global landing_zone
landing_zone = "%s/euromillionskeys.ivoxavier/dom.html" % os.environ["XDG_DATA_HOME"]

def create_dir():
        try:
                os.mkdir("%s/euromillionskeys.ivoxavier" % os.environ["XDG_DATA_HOME"])
        except FileExistsError:
                print("Directory already exists")

def get_dom():
        url = "https://www.jogossantacasa.pt/web/SCCartazResult/euroMilhoes"
        urllib.request.urlretrieve(url, landing_zone) 
        pyotherside.send('dom_downloaded')

def get_key_draw():
    with codecs.open(landing_zone, 'r', encoding='utf-8', errors="ignore") as f:
            soup = BeautifulSoup(f, 'html.parser')
            key_draw = (soup.find("div", {"class": "betMiddle twocol regPad"})
            .find("li").get_text()).split(" ")
            #delete '+' from key_draw
            del key_draw[5]
    return key_draw

def get_date():
        with codecs.open(landing_zone, 'r', encoding='utf-8', errors="ignore") as f:
                soup = BeautifulSoup(f, 'html.parser')
                main_div = (soup.find("div", {"class": "bgCenter sendBtn betnow"}))
                data_tag = main_div.find("span", {"class": "dataInfo"}).get_text()
                data_no_tag = re.sub('\s+', '', data_tag)
                data_cleaned = data_no_tag[data_no_tag.find("DatadoSorteio"):]
                #We need this for data in this format to store in database
                return strftime("%Y-%m-%d", datetime.strptime(data_cleaned[(data_cleaned
                .find("-")+1):]
                .replace("/","-"), "%d-%m-%Y").timetuple())

def get_prizes():
        with codecs.open(landing_zone, 'r', encoding='utf-8', errors="ignore") as f:
                soup = BeautifulSoup(f, 'html.parser')
                main_div = (soup.find("div", {"class": "stripped betMiddle customfiveCol regPad"}))
                jackpot_div = (soup.find("div", {"class": "betMiddle twocol"}))
                prizes = []
                money_prizes = []
                jackpot = []
                for i in main_div.find_all("li", {"class": "litleCol"}):
                        prizes.append(int(i.get_text().replace(".","")))
                for j in main_div.find_all("ul"):
                        cleaned_money_prizes = "".join(str(j) for j in j.get_text().split(" "))
                        cleaned_money_prizes =  re.sub('\s+', '', cleaned_money_prizes).partition("€")[-1] + "€"
                        money_prizes.append(cleaned_money_prizes)
                for k in jackpot_div.find_all("li", {"class": "stronger"}):
                        cleaned_jackpot = "".join(str(k) for k in k.get_text().split(" "))
                        cleaned_jackpot =  re.sub('\s+', '', cleaned_jackpot).partition("€")[-1].strip()+"€"
                        jackpot.append(cleaned_jackpot)
                del jackpot[0]

                total_amount_prizes = {
                        1 : [(prizes[0] + prizes[1]), jackpot[0]],
                        2 : [(prizes[2] + prizes[3]), money_prizes[1]],
                        3 : [(prizes[4] + prizes[5]), money_prizes[2]],
                        4 : [(prizes[6] + prizes[7]), money_prizes[3]],
                        5 : [(prizes[8] + prizes[9]), money_prizes[4]],
                        6 : [(prizes[10] + prizes[11]), money_prizes[5]],
                        7 : [(prizes[12] + prizes[13]), money_prizes[6]],
                        8 : [(prizes[14] + prizes[15]), money_prizes[7]],
                        9 : [(prizes[16] + prizes[17]), money_prizes[8]],
                        10 : [(prizes[18] + prizes[19]), money_prizes[9]],
                        11 : [(prizes[20] + prizes[21]), money_prizes[10]],
                        12 : [(prizes[22] + prizes[23]), money_prizes[11]],
                        13 : [(prizes[24] + prizes[25]), money_prizes[12]],
                }
                return json.dumps(total_amount_prizes)

def generate_key():
        rdn_key = []
        def rdn_numbers():
                return random.randint(1,50)
        def rdn_stars():
                return random.randint(1,12)

        for i in range(0,5):
                #empty list return False. First iteration only
                if not rdn_key:
                        rdn_key.append(rdn_numbers())
                else:
                        new_num = rdn_numbers()
                        while new_num in rdn_key:
                                new_num = rdn_numbers()
                        rdn_key.append(new_num)

        for i in range(0,2):
                new_star = rdn_stars()
                if i == 0:
                        rdn_key.append(new_star)
                else:
                        while new_star == rdn_key[5]:
                                new_star = rdn_stars()
                        rdn_key.append(new_star)
        return rdn_key