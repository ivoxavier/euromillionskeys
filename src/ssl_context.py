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

import ssl

'''This is need on 20.04 to avoid the following error:
ssl.SSLError: [SSL: WRONG_SIGNATURE]'''

# Create a SSL context
CONTEXT = ssl.create_default_context()
# Skip hostname verification
CONTEXT.check_hostname = False
# Set verify mode to CERT_NONE
CONTEXT.verify_mode = ssl.CERT_NONE
# Set the minimum SSL version to 1
CONTEXT.set_ciphers('DEFAULT@SECLEVEL=1')