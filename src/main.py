'''
 Copyright (C) 2022-2023  Ivo Xavier

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
import glob
import glob_paths
import calendar
import ssl_context
import requests
from time import strftime
from datetime import datetime, timedelta
from bs4 import BeautifulSoup

def clean_dir():
        to_clean_path = glob.glob(glob_paths.LANDING_ZONE)
        for files in to_clean_path:
            os.remove(files)

def next_draw_date(draw_weekday1, draw_weekday2=None):
    today_date = datetime.now()
    today_date_week_day = today_date.weekday()
    euromillions_draw_time = datetime.strptime("20:30:00", "%H:%M:%S").time()
    
    next_draw_date_euromillions = None

    if today_date_week_day in [draw_weekday1, draw_weekday2] and today_date.time() >= euromillions_draw_time:
        days_until_draw = 7
    else:
        days_until_draw = (draw_weekday1 - today_date_week_day + 7) % 7 if today_date_week_day != draw_weekday1 else 0

    next_draw_date_euromillions = today_date + timedelta(days=days_until_draw)

    #m1lhao is always on friday
    m1lhao_day = 4
    if today_date_week_day == m1lhao_day:
        if today_date.time() >= euromillions_draw_time:
            days_until_draw = 7
        else:
            days_until_draw = 0
    else:
        days_until_draw = (m1lhao_day - today_date_week_day + 7) % 7

    next_draw_date_m1lhao = today_date + timedelta(days=days_until_draw)

    if next_draw_date_euromillions < next_draw_date_m1lhao:
        return next_draw_date_euromillions.strftime("%Y-%m-%d")
    else:
        return next_draw_date_m1lhao.strftime("%Y-%m-%d")


def get_euromillions_dom():
        url = "https://www.jogossantacasa.pt/web/SCCartazResult/euroMilhoes"
        with urllib.request.urlopen(url, context=ssl_context.CONTEXT) as u, \
        codecs.open(glob_paths.EUROMILLIONS_DOM, 'wb') as f:
                f.write(u.read())
        pyotherside.send('euromillions_dom_downloaded')

def get_m1llion_dom():
        url = "https://www.jogossantacasa.pt/web/SCCartazResult/m1lhao"
        with urllib.request.urlopen(url, context=ssl_context.CONTEXT) as u, \
        codecs.open(glob_paths.M1LLION_DOM, 'wb') as f:
                f.write(u.read()) 
        pyotherside.send('m1llion_dom_downloaded')

def get_m1llion_key():
    with codecs.open(glob_paths.M1LLION_DOM, 'r', encoding='utf-8', errors="ignore") as f:
            soup = BeautifulSoup(f, 'html.parser')
            main_div = (soup.find("div", {"class": "stripped betMiddle3 threecol regPad"}))
            return main_div.find("li",{"id":"code_m1"}).get_text() 

def get_euromillions_key():
    with codecs.open(glob_paths.EUROMILLIONS_DOM, 'r', encoding='utf-8', errors="ignore") as f:
            soup = BeautifulSoup(f, 'html.parser')
            key_draw = (soup.find("div", {"class": "betMiddle twocol regPad"})
            .find("li").get_text()).split(" ")
            #delete '+' from key_draw
            del key_draw[5]
    return key_draw

def get_draw_n(lotterie_type):
        which_dom_file = glob_paths.EUROMILLIONS_DOM if lotterie_type == "euromillions" else glob_paths.M1LLION_DOM
        with codecs.open(which_dom_file, 'r', encoding='utf-8', errors="ignore") as f:
                soup = BeautifulSoup(f, 'html.parser')
                main_div = (soup.find("div", {"class": "bgCenter sendBtn betnow"}))
                sub_div = re.sub('\s+','',main_div.find("span", {"class": "dataInfo"}).get_text())
                return sub_div[sub_div[sub_div.find("Sorteio:"):16].find(":")-(-1):16].strip()

def get_draw_date(lotterie_type):
        which_dom_file = glob_paths.EUROMILLIONS_DOM if lotterie_type == "euromillions" else glob_paths.M1LLION_DOM
        with codecs.open(which_dom_file, 'r', encoding='utf-8', errors="ignore") as f:
                soup = BeautifulSoup(f, 'html.parser')
                main_div = (soup.find("div", {"class": "bgCenter sendBtn betnow"}))
                sub_div = re.sub('\s+','',main_div.find("span", {"class": "dataInfo"}).get_text())
                draw_data = sub_div[sub_div.find("DatadoSorteio"):]
                #We need this for data in this format to store in database
                return strftime("%Y-%m-%d", datetime.strptime(draw_data[(draw_data
                .find("-")+1):]
                .replace("/","-"), "%d-%m-%Y").timetuple())

def get_jackpot():
        with codecs.open(glob_paths.EUROMILLIONS_DOM, 'r', encoding='utf-8', errors="ignore") as f:
                soup = BeautifulSoup(f, 'html.parser')
                main_div = (soup.find("div",{"class": "betMiddle twocol"}))
                jackpot = ""
                for i in main_div.find_all("li",{"class": "stronger"}):
                        jackpot = "".join(re.sub('\s+', '', i.get_text()))
                return jackpot

def get_euromillions_prizes():
        with codecs.open(glob_paths.EUROMILLIONS_DOM, 'r', encoding='utf-8', errors="ignore") as f:
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