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
    id: mainpage
    objectName: "MainPage"

    property var list_key_draw 
    property var list_key_gen
    property var data_draw
    property ListModel prizes_ListModel : ListModel{dynamicRoles: true}

    header: PageHeader {
        id: header
        title: i18n.tr('EuroMillions Keys')
        
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

            RowLayout{
                Layout.alignment: Qt.AlignCenter
                width: parent.width
                spacing: units.gu(0.2)

                SlotKeys{draw_key: true}
            }

            Divider{Layout.alignment: Qt.AlignCenter; width: parent.width}

            BlankSpace{}

            Label{
                id: results_header_label
                Layout.alignment: Qt.AlignHCenter
                font.pixelSize: units.gu(1.5)
                text: i18n.tr('Total Winners & Prizes')
            }

            BlankSpace{height: units.gu(3)}

            PrizeTable{
                id: prizeTable
                Layout.alignment: Qt.AlignCenter
                Layout.preferredWidth: root.width - units.gu(9)
                Layout.preferredHeight: units.gu(35)
            }
        
        }
    }

     BottomEdge{
        id: bottom_edge
        //parent : home_page

        contentComponent: Page{
            id: bottom_edge_page
        
            height: bottom_edge.height
    

            header: PageHeader{
                title : i18n.tr("Keys Generator")

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
                anchors{
                    top: parent.header.bottom
                    left: parent.left
                    right: parent.right
                    bottom: parent.bottom
                }
                contentWidth: parent.width
                contentHeight: page_bottom_column.height
                ColumnLayout{
                    id: page_bottom_column
                    width: root.width

                    SlotKeys{draw_key: false}

                    BlankSpace{height:units.gu(15)}

                    Button{
                        id: button_generate
                        Layout.alignment: Qt.AlignHCenter
                        Layout.preferredWidth: units.gu(10)
                        Layout.preferredHeight: units.gu(3)
                        text: i18n.tr("New")
                        color: "green"
                        onClicked: {
                            backend.call('main.generate_key', [], function(returnValue) {list_key_gen = returnValue})
                        }
                    }
                    
                }

            }
        }
    }

    Component.onCompleted:{
        activityIndicator.running = true
        backend.call('main.get_dom', [], function(returnValue) {})
        backend.setHandler('dom_downloaded', function() {
            activityIndicator.running = false, activityIndicator.visible = false 
            backend.call('main.get_date', [], function(returnValue) {data_draw = returnValue})
            backend.call('main.get_key_draw', [], function(returnValue) {list_key_draw = returnValue})
            backend.call('main.get_prizes', [], function(returnValue) {
                Object.entries(JSON.parse(returnValue)).forEach(([key,value]) => {
                    prizes_ListModel.append({total_wins: String(value).replace(","," - ")})
                })
                })
    });
        backend.call('main.generate_key', [], function(returnValue) {list_key_gen = returnValue})
    }
}