import QtQuick 2.3
import QtQuick.Controls 2.0
import Charts 1.0
import "Chart.js" as ChartJs

Item {
    id: chart

    anchors.fill: parent
    property string defaultFontFamily: "sans-serif"
    property int defaultFontSize: 15
    property string chartType: ChartType.doughnut;
    property var model;
    property var chartData;


    Canvas{
        id: canvas
        anchors.fill: parent

        property var chartInstance;
        property var style: {
            "display" : "block"
        }
        property var currentStyle : {
            "padding-left" : 0, "padding-right" : 0, "padding-bottom" : 0, "padding-top" : 0
        }

        property alias parentNode : canvas
        property alias clientWidth : canvas.width
        property alias clientHeight : canvas.height

        property var onresize;
        property var mousemove;
        property var mouseout;
        property var click;
        property var touchstart;

        function addEventListener(eventType, method){
            if(eventType in this)
                this[eventType] = method;
        }

        property double chartAnimation: 0;

        onWidthChanged: {
            if(onresize){
                onresize();
            }
        }

        onHeightChanged: {
            if(onresize){
                onresize();
            }
        }

        function getBoundingClientRect(){
            return { "left" : 0, "top": 0, "right": canvas.width, "bottom": canvas.height}
        }

        function buildData(){
            if(chartData)
                return;

            if(model){

            }else{
                chartData = { datasets : [], labels : [] }
            }
        }

        onPaint: {
            if(!canvas.chartInstance){
                buildData();
                canvas.chartInstance = new ChartJs.Chart( canvas, { options : {
                                                  maintainAspectRatio: false,
                                                  defaultColor: 'rgba(0,0,0,0.1)',
                                                  defaultFontFamily: defaultFontFamily,
                                                  defaultFontSize: defaultFontSize,
                                              },
                                              type: chartType,
                                              data: chartData
                                          });
                chartAnimator.start();
            }
            canvas.chartInstance.draw(Math.min(Math.max(canvas.chartAnimation, 0), 1));
        }

        function getAttribute(attribute){
            if(attribute in this)
                return this[attribute];
        }

        function insertBefore(what, where){
            what.contentWindow = canvas;
        }

        onChartAnimationChanged: {
            requestPaint();
        }

        PropertyAnimation {
            id: chartAnimator;
            target: canvas;
            property: "chartAnimation";
            from: 0.05;
            to: 1;
            duration: 500;
            easing.type: Easing.InOutSine;
        }
    }

    MouseArea {
        id: mouseArea;
        anchors.fill: parent
        hoverEnabled: true;
        enabled: true;

        onPositionChanged: {
            if (canvas.mousemove) {
                canvas.mousemove({ type: 'mousemove', clientX: mouse.x,
                                     clientY: mouse.y, srcElement: canvas});
                canvas.requestPaint();
            }
        }

        onClicked: {
            if(canvas.click){
                canvas.click({type: 'click', clientX: mouse.x,
                                 clientY: mouse.y, srcElement: canvas});
                canvas.requestPaint();
            }
        }

        onPressed: {
            if(canvas.touchstart){
                canvas.touchstart({type: 'touchstart', clientX: mouse.x,
                                      clientY: mouse.y, srcElement: canvas});
                canvas.requestPaint();
            }
        }

        onExited: {
            if (canvas.mouseout) {
                canvas.mouseout({type: 'mouseout', srcElement: canvas});
                canvas.requestPaint();
            }
        }
    }

}
