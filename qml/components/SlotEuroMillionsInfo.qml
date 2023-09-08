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
	Layout.preferredWidth: root.width - units.gu(3)
    Layout.preferredHeight: units.gu(15)
	color : "white"
	radius: "large"
	aspect : LomiriShape.Flat

	property var next_draw_day	
	
	ColumnLayout{  
		width: parent.width
		spacing:units.gu(1.5)

		RowLayout{
			width:parent.width
			LomiriShape{
				Layout.preferredWidth: parent.width
				Layout.preferredHeight: units.gu(5)
				aspect: LomiriShape.Flat
				backgroundColor: LomiriColors.ash
				Text{
					width: parent.width
					height: parent.height
					text: i18n.tr("Next's Draws")
					horizontalAlignment: Text.AlignHCenter
					verticalAlignment: Text.AlignVCenter
					font.pixelSize: units.gu(2)
				}
			}
		}

		RowLayout{
			Layout.alignment: Qt.AlignLeft
			spacing: units.gu(1)

			Label {
				Layout.alignment: Qt.AlignVCenter
				text: i18n.tr("EuroMillions:")
				wrapMode: Label.WordWrap
				font.pixelSize: units.gu(2)
				color: "black"
			}
			Label {
				Layout.alignment: Qt.AlignVCenter
				text: euromillionsPlugin.next_draw_day_euroMillions !== undefined ? euromillionsPlugin.next_draw_day_euroMillions : ""
				wrapMode: Label.WordWrap
				font.pixelSize: units.gu(2)
				color: "black"
			}
		}
		
		RowLayout{
			Layout.alignment: Qt.AlignLeft
			spacing: units.gu(1)

			Label {
				Layout.alignment: Qt.AlignVCenter
				text: "M1lhão:"
				font.pixelSize: units.gu(2)
				color: "black"
			}
			Label {
				Layout.alignment: Qt.AlignVCenter
				text: euromillionsPlugin.next_draw_day_m1lhao !== undefined ? euromillionsPlugin.next_draw_day_m1lhao : ""
				font.pixelSize: units.gu(2)
				color: "black"
			}
		}

		
		RowLayout{
			Layout.alignment: Qt.AlignHCenter
			spacing: units.gu(1)
		}
	}
}