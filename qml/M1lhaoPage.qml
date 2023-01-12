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

import QtQuick 2.12
import Lomiri.Components 1.3
import Lomiri.Components.Popups 1.3
import QtQuick.Controls.Suru 2.2
//import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0
import io.thp.pyotherside 1.4
import "components"

Page {
    id: m1lhao
    objectName: "M1lhaoPage"

    property var key_draw 
    property var data_draw

    header: PageHeader {
        id: header
        title: i18n.tr('M1llion')
        
        StyleHints {
            foregroundColor: "white"
            backgroundColor:  "blue" 
        }
    
    ActionBar {
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        StyleHints {
            backgroundColor:  "blue" 
        }
        numberOfSlots: 1
        actions: [  Action{
                        iconName: "info"
                       onTriggered: pageStack.push(aboutPage) 
                    }
                ]
    }
    
    }

    Rectangle{
        anchors{
            top: parent.top
            left : parent.left
            right : parent.right
            bottom : parent.bottom
        }
        color : Suru.theme === 0 ? LomiriColors.porcelain: "#111111"
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
        interactive: false
        ColumnLayout{
            id: main_column
            width: root.width

            ActivityIndicator{
                id: activityIndicator
                Layout.alignment: Qt.AlignCenter
                width: units.gu(3)
                height: width 
                running: true
            }

            
            RowLayout{
                Layout.alignment: Qt.AlignCenter
                width: parent.width
                spacing: units.gu(1)

                Label{
                    id: prize_draw_data_label
                    Layout.alignment: Qt.AlignHCenter
                    font.pixelSize: units.gu(2)
                    text: i18n.tr('Last Draw: ') + data_draw
                }
            }

            BlankSpace{}

            Label{
                Layout.alignment: Qt.AlignHCenter
                font.pixelSize: units.gu(4)
                font.bold: true
                text: key_draw
            }
        
        }
    }
 

    Component.onCompleted:{
        activityIndicator.running = true
        backend.call('main.get_m1llion_dom', [], function(returnValue) {})
        backend.setHandler('m1llion_dom_downloaded', function() {
            activityIndicator.running = false, activityIndicator.visible = false 
            backend.call('main.get_draw_date', ["m1lhao"], function(returnValue) {data_draw = returnValue})
            backend.call('main.get_m1llion_key', [], function(returnValue) {key_draw = returnValue})
    });
    }
}