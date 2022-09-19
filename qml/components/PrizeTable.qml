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
import Ubuntu.Components 1.3
import QtQuick.Controls.Suru 2.2
//import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0
import io.thp.pyotherside 1.4



Rectangle {
    id: wrapper
    width: prizeTable.width - units.gu(3)
    height: prizeTable.height - units.gu(14)
    color: Suru.theme === 0 ? UbuntuColors.porcelain: "#111111"

        Component {
            id: tablePrizeDelegate
            Item { 
                width: wrapper.width
                height: units.gu(4.3)
                Column {
                    Label { text: i18n.tr('<b>%1.º Prize:</b> ').arg(index+1) + total_wins }
                    Label {
                        font.pixelSize: units.gu(1.3)
                        text: index == 0 ? i18n.tr('5 numbers + 2 starts') : index == 1 ?
                        i18n.tr("5 numbers + 1 star") : index == 2 ?
                        i18n.tr("5 numbers + 0 stars") : index == 3 ?
                        i18n.tr("4 numbers + 2 stars") : index == 4 ?
                        i18n.tr("4 numbers + 1 star") : index == 5 ?
                        i18n.tr("3 numbers + 2 stars") : index == 6 ?
                        i18n.tr("4 numbers + 0 stars") : index == 7 ?
                        i18n.tr("2 numbers + 2 stars") : index == 8 ?
                        i18n.tr("3 numbers + 1 star") : index == 9 ?
                        i18n.tr("3 numbers + 0 stars") : index == 10 ?
                        i18n.tr("1 number + 2 stars") : index == 11 ?
                        i18n.tr("2 numbers + 1 star") : i18n.tr("2 numbers + 0 stars")
                    }
                }
            }
        }
    ListView {
            anchors{
                top: prizeTable.top
                left: prizeTable.left
                right: prizeTable.right
                bottom: prizeTable.bottom
            }
            model: mainpage.prizes_ListModel
        delegate: tablePrizeDelegate
        focus: false
    }
}
        
