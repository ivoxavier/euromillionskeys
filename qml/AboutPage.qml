/*
 * 2022 Ivo Xavier
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; version 3.
 *
 * kaltracker is distributed in the hope that it will be useful,
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
import Lomiri.Components.ListItems 1.3 
import Lomiri.Components.Popups 1.3
import QtQuick.Controls.Suru 2.2
import QtQuick.LocalStorage 2.12
import Lomiri.Content 1.3
import QtQuick.Window 2.0
import "components"



Page{
    id: aboutPage
    objectName: 'AboutPage'
    header: PageHeader {
        title: i18n.tr("About")
        StyleHints {
            foregroundColor: "white"
            backgroundColor:  "blue" 
        }
    }

    Rectangle{
        anchors{
            top: parent.top
            left : parent.left
            right : parent.right
            bottom : parent.bottom
        }
        color : Suru.theme === 0 ? LomiriColor.porcelain : "#111111"
    }

    Flickable{
        id: flickable

        anchors{
            top: parent.header.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom 
        }

        contentWidth: parent.width
        contentHeight: main_column.height  

        ColumnLayout{
            id: main_column
            width: root.width


            LomiriShape{
                Layout.alignment: Qt.AlignCenter
                radius: "large"
                Layout.preferredWidth: units.gu(12)
                Layout.preferredHeight: units.gu(12)
                aspect: LomiriShape.DropShadow
                source: Image{
                    source: "../assets/logo.svg"
                }
            }

            Label {
                Layout.alignment: Qt.AlignCenter
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                text: i18n.tr("Version: ") + root.app_version
                
            }

            ListItem{
                width: root.width
                divider.visible: false
                ListItemLayout{
                    subtitle.text: i18n.tr("Credits")
                    subtitle.font.bold: true
                }
            }

            Label{
                Layout.alignment: Qt.AlignCenter
                text: i18n.tr("Results extracted from DOM of <a href='https://www.jogossantacasa.pt/web/SCCartazResult/'>%1</a>".arg("Jogos Santa Casa"))
            }
        }
    }
}