/*
 * Copyright (C) 2022-2023  Ivo Xavier
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
	Layout.preferredWidth: root.width - units.gu(6)
    Layout.preferredHeight: units.gu(28)
	color : "white"
	radius: "large"
	aspect: LomiriShape.Flat

	property int page_to_push : 0
	property bool multipe_options
	property var next_draw_day

	//public API's	
	
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
					text: "M1lhão"
					horizontalAlignment: Text.AlignHCenter
					verticalAlignment: Text.AlignVCenter
					font.pixelSize: units.gu(2)
				}
			}
		}

		Icon{Layout.alignment: Qt.AlignCenter;name:"non-starred";height: units.gu(3)}

		RowLayout{
			Layout.alignment: Qt.AlignCenter
			spacing: units.gu(1)

			Label {
				Layout.alignment: Qt.AlignVCenter
				text: euromillionsPlugin.draw_n_m1lhao ? (euromillionsPlugin.draw_n_m1lhao.length < 9 ? euromillionsPlugin.draw_n_m1lhao : "Report Issue With DOM") : ""
				wrapMode: Label.WordWrap
				font.pixelSize: units.gu(2)
				color: "black"
			}
		}

		RowLayout{
			Layout.alignment: Qt.AlignLeft
			spacing: units.gu(1)
			Icon{Layout.alignment: Qt.AlignVCenter;name:"calendar";height: units.gu(3)}

			Label {
				id: dateLabel
				Layout.alignment: Qt.AlignVCenter
				text: euromillionsPlugin.m1lhao_date !== undefined ? euromillionsPlugin.m1lhao_date : ""
				font.pixelSize: units.gu(2)
				color: "black"
			}
		}
		
		RowLayout{
			Layout.alignment: Qt.AlignCenter
			spacing: units.gu(1)
			Text{
				width: parent.width
				height: parent.height
				text: euromillionsPlugin.m1lhao !== undefined ? euromillionsPlugin.m1lhao : ""
				horizontalAlignment: Text.AlignHCenter
				verticalAlignment: Text.AlignVCenter
				font.pixelSize: units.gu(2.5)
				font.bold: true
			}
		}

		RowLayout{
			Layout.alignment: Qt.AlignHCenter
			spacing: units.gu(1)
			Text{
				text: i18n.tr("Jackpot:")
				font.pixelSize: units.gu(2)
			}
			Text{
				text: "€1.000.000,00"
				font.pixelSize: units.gu(2)
				font.bold: true
			}
		}
	}
}