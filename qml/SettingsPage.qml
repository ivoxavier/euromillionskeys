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
//import QtQuick.Controls 2.2 as QQC2
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0
import Ubuntu.Components.ListItems 1.3 
import Ubuntu.Components.Popups 1.3
import QtQuick.Controls.Suru 2.2
import io.thp.pyotherside 1.5
import "components"


Page{
    id: settingsPage
    objectName: 'SettingsPage'
    header: PageHeader {
                title: i18n.tr("Settings")
                StyleHints {
                    foregroundColor: "white"
                    backgroundColor:  "blue" 
                }
            }

    Component{
        id: clean_dialog
        MessageDialog{msg:i18n.tr("Cleaned!")}
    }

    Rectangle{
        anchors{
            top: parent.header.bottom
            left : parent.left
            right : parent.right
            bottom : parent.bottom
        }
        color : Suru.theme === 0 ? UbuntuColor.porcelain : "#111111" 
    }

    Flickable {

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


            ListItem {
                divider.visible: false
                ListItemLayout{
                    subtitle.text: i18n.tr("Downloads")
                    subtitle.font.bold : true
                }  
            }       


            ListItem {
                divider.visible : false
                ListItemLayout{
                    title.text: i18n.tr("DOM Files")
                    title.font.bold : true
                
                    Button{
                        text: i18n.tr("Delete")
                        color: UbuntuColors.red
                        onClicked: backend.call('main.clean_dir', [], function(returnValue) {}), PopupUtils.open(clean_dialog)
                    }   
                }
            }
        }  
    }
}