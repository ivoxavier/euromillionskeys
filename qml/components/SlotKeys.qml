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
import Lomiri.Components 1.3
//import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0


RowLayout{
	id: wrapper
	
	//width: parent.width
	spacing: units.gu(0.2)

	property bool draw_key

	// Check if list_key_draw and list_key_gen are defined and have enough elements
    function getKeyAtIndex(index) {
        if (wrapper.draw_key) {
            return list_key_draw && list_key_draw.length > index ? list_key_draw[index] : "";
        } else {
            return list_key_gen && list_key_gen.length > index ? list_key_gen[index] : "";
        }
    }

	Circle{
		digit_label.text: getKeyAtIndex(0)
		shape_color: LomiriColors.ash
		digit_label_color: "white"
	}     

	Circle{
		digit_label.text: getKeyAtIndex(1)
		shape_color: LomiriColors.ash
		digit_label_color: "white"
	} 

	Circle{
		digit_label.text: getKeyAtIndex(2)
		shape_color: LomiriColors.ash
		digit_label_color: "white"
	}     
	
	Circle{
		digit_label.text: getKeyAtIndex(3)
		shape_color: LomiriColors.ash
		digit_label_color: "white"
	}  

	Circle{
		digit_label.text: getKeyAtIndex(4)
		shape_color: LomiriColors.ash
		digit_label_color: "white"
	}

	Label{
		text: "+"
		font.pixelSize: units.gu(2)
		font.bold: true
	}

	Circle{
		digit_label.text: getKeyAtIndex(5)
		shape_color: LomiriColors.purple
		digit_label_color: "white"
	}   

	Circle{
		digit_label.text: getKeyAtIndex(6)
		shape_color: LomiriColors.purple
		digit_label_color: "white"
	} 

	   
}