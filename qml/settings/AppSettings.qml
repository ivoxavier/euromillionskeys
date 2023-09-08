/*
 * Copyright (C) 2022  Ivo Xavier
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; version 3.
 *
 * euromillionskeys is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.7
import Lomiri.Components 1.3
//import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Controls.Suru 2.2
import Qt.labs.settings 1.0
import io.thp.pyotherside 1.4

Settings {
    property bool isCleanInstall: true   
    property string backgroundColor1: Suru.theme === 0 ? "#112326" : "#000000"//"#4d82d3"
    property string backgroundColor2: Suru.theme === 0 ? "#060f14" : "#6da77ff"
}
