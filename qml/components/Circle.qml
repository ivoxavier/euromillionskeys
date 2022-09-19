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

import QtQuick 2.9
import Ubuntu.Components 1.3
//import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0

AbstractButton {
	id: button

    //public api
	property alias digit_label: digit_label.text
	property alias digit_label_color: digit_label.color
    property alias shape_color: shape.color
	

	width: units.gu(6)
	height: units.gu(6)
	opacity: 1.0//button.pressed ? 0.5 : (enabled ? 1 : 0.2)
    z: 100
	Behavior on opacity {
		UbuntuNumberAnimation { }
	}

	Rectangle {
		id: shape		
        anchors.centerIn: parent
        height: units.gu(4)
        width:  height
		radius: height*0.5
	}

	Label {
		id: digit_label
        anchors.centerIn: parent
        font.pixelSize: units.gu(2.5)
        font.bold: true
		z: 1
	}
}