/*
 *   Copyright 2018 notsag <maxime@gaston.sh>
 *
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program.  If not, see <https://www.gnu.org/licenses/>.
 */

import QtQuick 2.5

Rectangle {
    id: root
    color: "#000"

    property int stage

    Image {
        id: topRect
        anchors.horizontalCenter: parent.horizontalCenter
        y: root.height / 3
        source: "images/rectangle.svg"

        // BGRT logo
        Image {
            source: "/boot/grub/themes/bgrt-grub-theme/bgrt.png"
            anchors.centerIn: parent
        }

        // Grey rectangle
        Rectangle {
            radius: 4
            color: "#434344"
            anchors {
                bottom: parent.bottom
                bottomMargin: -50
                horizontalCenter: parent.horizontalCenter
            }
            height: 4
            width: height*64

            // Filled in blue
            Rectangle {
                radius: 3
                anchors {
                    left: parent.left
                    top: parent.top
                    bottom: parent.bottom
                }
                width: (parent.width / 6) * (stage - 1)
                color: "#ffffff"
                Behavior on width {
                    PropertyAnimation {
                        duration: 250
                        easing.type: Easing.InOutQuad
                    }
                }
            }
        }
    }
}
