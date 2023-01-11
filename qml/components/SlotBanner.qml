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


LomiriShape{
	id: outer_frame
	Layout.alignment: Qt.AlignCenter
	Layout.preferredWidth: root.width - units.gu(5)
    Layout.preferredHeight: units.gu(14)
	color : "white"
	radius: "large"

	property int page_to_push : 0
	property bool multipe_options
	property var next_draw_day

	//public API's	
	property alias game_name : inner_shape.inner_shape_banner_text
	property alias game_banner : inner_shape.inner_shape_img_path
	
	Column{  
		width: parent.width
		
		Row{
			anchors.horizontalCenter: parent.horizontalCenter
			Text{text:next_draw_day}
			
		}

		LomiriShape{
				id: inner_shape

				//public API
				property alias inner_shape_img_path: img.source
				property alias inner_shape_banner_text : banner_text.text
				
				anchors.horizontalCenter: parent.horizontalCenter
				
				width: parent.width - units.gu(0.2)
				height: units.gu(7)
				aspect: LomiriShape.Inset

				Text{
					id: banner_text
					text: i18n.tr("Next Draw: %1").arg(inner_shape.inner_shape_banner_text)
					font.pixelSize: units.gu(2)
					font.bold: true
				}

				source: Image{
					id: img
					source: inner_shape.inner_shape_img_path
					fillMode: Image.Stretch
				}
			} 
		
		BlankSpace{}
		
		Row{
			anchors.horizontalCenter: parent.horizontalCenter
			spacing: units.gu(2)
			Text{
				text: i18n.tr("RESULTS")
				font.pixelSize: units.gu(2)
				font.bold: true
				MouseArea{
					anchors.fill: parent
					onClicked: page_to_push == 0 ? pageStack.push(euroMillionsPage) : pageStack.push(m1lhaoPage)
				}
			}

			Text{
				text: i18n.tr("GENERATE KEY")
				visible : multipe_options
				font.pixelSize: units.gu(2)
				font.bold: true
				MouseArea{
					anchors.fill: parent
					onClicked: pageStack.push(euroMillionsPage,{push_bottom_edge:true})
				}
			}

		}
	}
}