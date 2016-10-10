import QtQuick 2.6
import QtQuick.Window 2.2
import Charts 1.0

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    Chart{
        anchors.fill: parent
        onWidthChanged: {
            console.log(width);
        }

        function randomScalingFactor() {
            return Math.round(Math.random() * 100);
        }

        chartData: {
            "datasets": [{
                             "data": [
                                 randomScalingFactor(),
                                 randomScalingFactor(),
                                 randomScalingFactor(),
                                 randomScalingFactor(),
                                 randomScalingFactor(),
                             ],
                             "backgroundColor": [
                                 "#F7464A",
                                 "#46BFBD",
                                 "#FDB45C",
                                 "#949FB1",
                                 "#4D5360",
                             ],
                             "label": 'Dataset 1'
                         }, {
                             "hidden": true,
                             "data": [
                                 randomScalingFactor(),
                                 randomScalingFactor(),
                                 randomScalingFactor(),
                                 randomScalingFactor(),
                                 randomScalingFactor(),
                             ],
                             "backgroundColor": [
                                 "#F7464A",
                                 "#46BFBD",
                                 "#FDB45C",
                                 "#949FB1",
                                 "#4D5360",
                             ],
                             "label": 'Dataset 2'
                         }, {
                             "data": [
                                 randomScalingFactor(),
                                 randomScalingFactor(),
                                 randomScalingFactor(),
                                 randomScalingFactor(),
                                 randomScalingFactor(),
                             ],
                             "backgroundColor": [
                                 "#F7464A",
                                 "#46BFBD",
                                 "#FDB45C",
                                 "#949FB1",
                                 "#4D5360",
                             ],
                             "label": 'Dataset 3'
                         }],
                    "labels": [
                        "Red",
                        "Green",
                        "Yellow",
                        "Grey",
                        "Dark Grey"
                    ]
        }
    }
}
