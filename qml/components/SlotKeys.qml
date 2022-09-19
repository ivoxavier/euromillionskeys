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


RowLayout{
	id: wrapper
	Layout.alignment: Qt.AlignCenter
	width: parent.width
	spacing: units.gu(0.2)

	property bool draw_key

	Circle{
		digit_label: wrapper.draw_key ? list_key_draw[0] : list_key_gen[0]
		shape_color: "blue"
		digit_label_color: "white"
	}     

	Circle{
		digit_label: wrapper.draw_key ? list_key_draw[1] : list_key_gen[1]
		shape_color: "blue"
		digit_label_color: "white"
	} 

	Circle{
		digit_label: wrapper.draw_key ? list_key_draw[2] : list_key_gen[2]
		shape_color: "blue"
		digit_label_color: "white"
	}     
	
	Circle{
		digit_label: wrapper.draw_key ? list_key_draw[3] : list_key_gen[3]
		shape_color: "blue"
		digit_label_color: "white"
	}  

	Circle{
		digit_label: wrapper.draw_key ? list_key_draw[4] : list_key_gen[4]
		shape_color: "blue"
		digit_label_color: "white"
	}

	Label{
		text: "+"
		font.pixelSize: units.gu(2)
		font.bold: true
	}

	Circle{
		digit_label: wrapper.draw_key ? list_key_draw[5] : list_key_gen[5]
		shape_color: "#e7d30b"
		digit_label_color: "black"
	}   

	Circle{
		digit_label: wrapper.draw_key ? list_key_draw[6] : list_key_gen[6]
		shape_color: "#e7d30b"
		digit_label_color: "black"

	} 

	   
}