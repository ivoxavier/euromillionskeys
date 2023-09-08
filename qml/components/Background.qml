/*
 * Copyright (C) 2023  Ivo Xavier
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
import QtGraphicalEffects 1.0
import QtQuick 2.12
import Lomiri.Components 1.3
import Lomiri.Components.Popups 1.3
import QtQuick.Controls.Suru 2.2

LinearGradient {
    opacity: 1
    anchors.fill: parent
    start: Qt.point(0, 0)
    end: Qt.point(parent.width, parent.height)
    gradient: Gradient {
        GradientStop { position: 0.0; color: appSettings.backgroundColor1 }
        GradientStop { position: 1.0; color: appSettings.backgroundColor2 }
    }
} 