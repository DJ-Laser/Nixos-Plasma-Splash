import QtQuick 2.5


Rectangle {
    id: root
    color: "black"

    property int stage

    onStageChanged: {
        if (stage == 1) {
            introAnimation.start();
            indicatorAnimation.start();
        } else if (stage == 5) {
            introAnimation.target = indicatorBar;
            introAnimation.from = 1;
            introAnimation.to = 0;
            introAnimation.running = true;
        }
    }

    Item {
        id: content
        anchors.fill: parent
        opacity: 1

        // Nixos logo
        Image {
            id: logo

            source: "images/nixos.svg"
            anchors.horizontalCenter: parent.horizontalCenter
            y: parent.height * 7/16 - height / 2

            sourceSize.height: 300
            sourceSize.width: 300
        }

        // Border of progress bar
        Rectangle {
            id: indicatorBar

            anchors.horizontalCenter: parent.horizontalCenter
            y: logo.y + logo.height + 100

            radius: 4
            color: "#434344"

            height: 10
            width: parent.width / 3

            // Moving progress bar
            Rectangle {

                anchors {
                    top: parent.top
                    bottom: parent.bottom
                }

                radius: 3
                color: "#ffffff"

                property real progress
                property real maxWidth: parent.width / Math.max(6 - stage, 1.5)
                property real animatedX: progress * (parent.width + maxWidth) - maxWidth

                x: Math.max(animatedX, 0)
                width: Math.min(parent.width - x, animatedX + maxWidth, maxWidth);

                Behavior on maxWidth {
                    SmoothedAnimation {
                        duration: 250
                        easing.type: Easing.InOutQuad
                    }
                }

                NumberAnimation on progress {
                    id: indicatorAnimation
                    from: 0
                    to: 1
                    duration: 2000
                    loops: Animation.Infinite
                    easing.type: Easing.InOutQuad
                    running: false
                }
            }
        }
    }

    OpacityAnimator {
        id: introAnimation
        running: false
        target: content
        from: 0
        to: 1
        duration: 1500
        easing.type: Easing.InOutQuad
    }
}

/*Rectangle {
    id: root
    color: "black"

    property int stage

    onStageChanged: {
        if (stage == 1) {
            introAnimation.running = true;
        } else if (stage == 5) {
            introAnimation.target = busyIndicator;
            introAnimation.from = 1;
            introAnimation.to = 0;
            introAnimation.running = true;
        }
    }

    Item {
        id: content
        anchors.fill: parent
        opacity: 0
        TextMetrics {
            id: units
            text: "M"
            property int gridUnit: boundingRect.height
            property int largeSpacing: units.gridUnit
            property int smallSpacing: Math.max(2, gridUnit/4)
        }

        Image {
            id: logo
            //match SDDM/lockscreen avatar positioning
            property real size: units.gridUnit * 8

            anchors.centerIn: parent

            source: "images/nixos.svg"

            sourceSize.width: size
            sourceSize.height: size
        }

        Image {
            id: busyIndicator
            //in the middle of the remaining space
            y: parent.height - (parent.height - logo.y) / 2 - height/2
            anchors.horizontalCenter: parent.horizontalCenter
            source: "images/nixos.svg"
            sourceSize.height: units.gridUnit * 3
            sourceSize.width: units.gridUnit * 3
            RotationAnimator on rotation {
                id: rotationAnimator
                from: 0
                to: 360
                duration: 800
                loops: Animation.Infinite
            }
        }

    }

    OpacityAnimator {
        id: introAnimation
        running: false
        target: content
        from: 0
        to: 1
        duration: 1000
        easing.type: Easing.InOutQuad
    }
}
*/
