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
import QtQuick.Controls 2.2 as QQC2
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0
import io.thp.pyotherside 1.4
import "../components"


ColumnLayout{
    id: main_column
    width: parent.width

    property var list_key_draw 
    property var list_key_gen
    property var data_draw
    property var draw_n
    property var draw_n_m1lhao
    property var jackpot
    property var m1lhao
    property var m1lhao_date
    property var next_draw_day_euroMillions
    property var next_draw_day_m1lhao
    property ListModel prizes_ListModel : ListModel{dynamicRoles: true}

    Icon{Layout.alignment: Qt.AlignCenter;name:"settings";height: units.gu(3)
    MouseArea{
        
        anchors.fill: parent
        onClicked: pageStack.push(settingsPage)
        
    }
    }
    BlankSpace{height: units.gu(2)}
    ActivityIndicator{
        id: activityIndicator
        Layout.alignment: Qt.AlignCenter
        width: units.gu(3)
        height: width 
        running: true
    }

    SlotEuroMillionsKeys{Layout.alignment: Qt.AlignCenter}
    
    BlankSpace{height: units.gu(2)}

    SlotM1lhao{Layout.alignment: Qt.AlignCenter}

    BlankSpace{height: units.gu(3.5)}

    Label{
        Layout.alignment: Qt.AlignHCenter
        font.pixelSize: units.gu(2)
        text: i18n.tr('EuroMillions Winners & Prizes')
    }
    Divider{Layout.alignment: Qt.AlignCenter; width: parent.width}

    BlankSpace{height: units.gu(3.5)}
    
    

    PrizeTable{
        id: prizeTable
        Layout.alignment: Qt.AlignCenter
        Layout.preferredWidth: root.width - units.gu(9)
        Layout.preferredHeight: units.gu(35)
    }

    BlankSpace{height: units.gu(1)}
    Divider{Layout.alignment: Qt.AlignCenter; width: parent.width}

    BlankSpace{height: units.gu(2)}
    SlotEuroMillionsInfo{Layout.alignment: Qt.AlignCenter}

    BlankSpace{height: units.gu(3.5)}

    Label{
        Layout.alignment: Qt.AlignHCenter
        font.pixelSize: units.gu(2)
        text: i18n.tr('EuroMillions Key Generator')
    }
   
    Divider{Layout.alignment: Qt.AlignCenter; width: parent.width}

    SlotKeys{Layout.alignment: Qt.AlignCenter;draw_key: false}

    BlankSpace{height: units.gu(3)}

    Icon{
        Layout.alignment: Qt.AlignCenter
        name:"reload"
        height: units.gu(3)
        MouseArea{
            anchors.fill: parent
            onClicked:{
                backend.call('main.generate_key', [], function(returnValue) {list_key_gen = returnValue})
            }
        }
    }

    Component.onCompleted:{
        activityIndicator.running = true
        backend.call('main.get_euromillions_dom', [], function(returnValue) {})
        backend.call('main.get_m1llion_dom', [], function(returnValue) {})
        backend.setHandler('euromillions_dom_downloaded', function() {
            activityIndicator.running = false, activityIndicator.visible = false 
            backend.call('main.get_draw_n', ["euromillions"], function(returnValue) {draw_n = returnValue})
            backend.call('main.get_draw_date', ["euromillions"], function(returnValue) {data_draw = returnValue})
            backend.call('main.get_euromillions_key', [], function(returnValue) {list_key_draw = returnValue})
            backend.call('main.get_jackpot', [], function(returnValue) {jackpot = returnValue})
            backend.call('main.get_m1llion_key', [], function(returnValue) {m1lhao = returnValue})
            backend.call('main.get_draw_date', ["m1lhao"], function(returnValue) {m1lhao_date = returnValue})
            backend.call('main.get_draw_n', ["m1lhao"], function(returnValue) {draw_n_m1lhao = returnValue})
            backend.call('main.get_euromillions_prizes', [], function(returnValue) {
                Object.entries(JSON.parse(returnValue)).forEach(([key,value]) => {
                    prizes_ListModel.append({total_wins: String(value).replace(","," - ")})
                })
                })
        });
        backend.call('main.generate_key', [], function(returnValue) {list_key_gen = returnValue})
        backend.call('main.next_draw_date', [1,4],
                function(returnValue) {
                    returnValue == true ?
                    euromillionsPlugin.next_draw_day_euroMillions = i18n.tr("Today") : euromillionsPlugin.next_draw_day_euroMillions = returnValue})
        backend.call('main.next_draw_date', [4],
                function(returnValue) {
                    returnValue == true ?
                    euromillionsPlugin.next_draw_day_m1lhao = i18n.tr("Today") : euromillionsPlugin.next_draw_day_m1lhao = returnValue})           
    }
}




