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
import Lomiri.Components 1.3
import Lomiri.Components.Popups 1.3
//import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0


Item {
    property bool isOnline: false
    property string source: "https://www.jogossantacasa.pt/web/SCCartazResult/euroMilhoes"

    function checkInternetConnection() {
        var xhr = new XMLHttpRequest();
        xhr.open("GET", source);

        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.DONE) {
                if (xhr.status === 200) {
                    isOnline = true;
                } else {
                    isOnline = false;
                }
            }
        }

        xhr.send();
    }

    Timer {
        id: networkCheckTimer
        interval: 1 // Check every 5 seconds
        running: false
        repeat: true

        onTriggered: {
            checkInternetConnection();
        }
    }

    onIsOnlineChanged: {
        if (isOnline) {
            // You can now trigger your file download here
            console.log("Internet connection is available.");
			networkCheckTimer.stop()
        } else {
            console.log("No internet connection. Download aborted.");
        }
    }
}