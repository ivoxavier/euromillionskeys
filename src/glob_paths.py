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
import os

#this is needed to be able to run the app in the desktop
try:
    DUMMY_PATH = os.path.dirname(__file__) + "/dummy_path"
    if not os.path.exists(DUMMY_PATH):
        try:
            os.makedirs(DUMMY_PATH)
        except Exception as e:
            print("Can't create dir:\n"+DUMMY_PATH)
except Exception as e:
            pass

#workaround to detect if we are running on mobile or desktop
def is_mobile():
    try:
        os.environ["XDG_DATA_HOME"]
        return True
    except:
        return False

LANDING_ZONE = "%s/euromillionskeys.ivoxavier/" % os.environ["XDG_DATA_HOME"] if is_mobile() else DUMMY_PATH

#we need this to be able to store the html files
if not os.path.exists(LANDING_ZONE):
    try:
        os.makedirs(LANDING_ZONE)
    except Exception as e:
        print("Can't create dir:\n"+LANDING_ZONE)

EUROMILLIONS_DOM = LANDING_ZONE + "/euromillions_dom.html"
M1LLION_DOM = LANDING_ZONE + "/m1llion_dom.html"
