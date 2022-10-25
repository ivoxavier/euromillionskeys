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
import Ubuntu.Components 1.3
import Ubuntu.Components.Popups 1.3
import QtQuick.Controls.Suru 2.2
//import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0
import io.thp.pyotherside 1.4
import "components"

Page {
    id: menuPage
    objectName: "MenuPage"

    header: PageHeader {
        id: header
        title: i18n.tr('Lotteries')
        
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
                        iconName: "settings"
                        text: i18n.tr("Settings")
                       onTriggered: pageStack.push(settingsPage) 
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
        color : Suru.theme === 0 ? UbuntuColors.porcelain: "#111111"
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
 
            BlankSpace{height:units.gu(2)}

            SlotBanner{
                id:slot_euroMillions
                game_banner: "../assets/euromillions_banner.svg"
                game_name : i18n.tr("EuroMillions")
                page_to_push : 0
                multipe_options: true
                Component.onCompleted: backend.call('main.next_draw_date', [2,5],
                function(returnValue) {
                    returnValue == true ?
                    slot_euroMillions.next_draw_day = i18n.tr("Next Draw: Today") : slot_euroMillions.next_draw_day = i18n.tr("Next Draw: ") + returnValue})
            }

            
            BlankSpace{}
            
            SlotBanner{
                id: slot_M1lhao
                game_banner: "../assets/m1lhao.svg"
                game_name : i18n.tr("M1llion")
                page_to_push : 1
                multipe_options: false
                Component.onCompleted: backend.call('main.next_draw_date', [5],
                function(returnValue) {
                    returnValue == true ?
                    slot_M1lhao.next_draw_day = i18n.tr("Next Draw: Today") : slot_M1lhao.next_draw_day = i18n.tr("Next Draw: ") + returnValue})
            }

            BlankSpace{}
        
        }
    }

}