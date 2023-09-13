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
import Lomiri.Components 1.3
//import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Lomiri.Components.Popups 1.3
import Qt.labs.settings 1.0
import io.thp.pyotherside 1.4
import "components"
import "backend"
import "pages"
import "settings"
import "lotteries"

MainView {
    id: root
    objectName: 'mainView'
    applicationName: 'euromillionskeys.ivoxavier'
    automaticOrientation: true
    backgroundColor : LomiriColors.porcelain

    property var app_version : "3.0.1"

    width: units.gu(45)
    height: units.gu(75)

    AppSettings{id: appSettings}
    
    ConnectionChecker{id:connChecker}
    
    PageStack {
        id: pageStack
        anchors.fill: parent
        onCurrentPageChanged:{
            console.log("Current Stack: " + currentPage.objectName)
        }
    }

    //message confirming the ingestion on bottom 
    Component{
        id: noNetwrokDialog
        MessageDialog{
            msg: i18n.tr("No Network. Please enable it and restart the app!")
        }
    }

    Component{
        id:lotteryGames
        LotteryGamesPage{}
    }
    

    Component{
        id:settingsPage
        SettingsPage{}
    }

    Backend{id: backend}
    
    Component.onCompleted:{
        if(appSettings.isCleanInstall){
            appSettings.isCleanInstall = false
            pageStack.push(lotteryGames)
        }else{
            pageStack.push(lotteryGames)
        }
        
    }
}
