/*
 * Copyright 2015 Canonical Ltd.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation; version 3.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.9
import Ubuntu.Components 1.3
//import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0

Rectangle {
    
    height: units.dp(2) 
    // a private property to catch theme background color change
    // use private property instead of embedding it into a QtObject to avoid further
    // performance decrease
    property bool __lightBackground: ColorUtils.luminance(theme.palette.normal.background) > 0.85
    // use a gradient of 4 steps instead of instantiating two Rectangles for performance reasons
    gradient: Gradient {
        GradientStop { position: 0.0; color: __lightBackground ? Qt.rgba(0, 0, 0, 0.1) : Qt.rgba(0, 0, 0, 0.4) }
        GradientStop { position: 0.49; color: __lightBackground ? Qt.rgba(0, 0, 0, 0.1) : Qt.rgba(0, 0, 0, 0.4) }
        GradientStop { position: 0.5; color: __lightBackground ? Qt.rgba(1, 1, 1, 0.4) : Qt.rgba(1, 1, 1, 0.1) }
        GradientStop { position: 1.0; color: __lightBackground ? Qt.rgba(1, 1, 1, 0.4) : Qt.rgba(1, 1, 1, 0.1) }
    }
}