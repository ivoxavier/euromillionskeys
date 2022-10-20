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
//import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Ubuntu.Components.Popups 1.3
import Qt.labs.settings 1.0
import io.thp.pyotherside 1.4
import "components"

MainView {
    id: root
    objectName: 'mainView'
    applicationName: 'euromillionskeys.ivoxavier'
    automaticOrientation: true

    property var app_version : "2.0.0"

    width: units.gu(45)
    height: units.gu(75)

    AppSettings{id: appSettings}
    
    PageStack {
        id: pageStack
        anchors.fill: parent
        onCurrentPageChanged:{
            console.log("Current Stack: " + currentPage.objectName)
        }
    }

    Component{
        id:menuPage
        MenuPage{}
    }
    
    Component{
        id:euroMillionsPage
        EuroMillionsPage{}
    }

    Component{
        id:m1lhaoPage
        M1lhaoPage{}
    }

    Component{
        id:aboutPage
        AboutPage{}
    }

    Backend{id: backend}
    
    Component.onCompleted:{
        if(appSettings.isCleanInstall){
            backend.call('main.create_dir', [], function(returnValue) {})
            appSettings.isCleanInstall = false
            pageStack.push(menuPage)
        }else{
            pageStack.push(menuPage)
        }
        
    }
}
