.pragma library


function CanvasPattern(){}
function CanvasGradient(){}

var requiredModules = {};
var module = {};
var window = {
    "requestAnimationFrame" : function(){
    }
}

var document = {
    "defaultView" : {
        "getComputedStyle" : function(obj){
            if( "style" in obj ){
                return obj["style"];
            }
            return {
                "max-widht" : 0
            }
        }
    },
    "createElement" : function(tag){
        return {"classlist" : {
                "add" : function(){}
            },
            "style": {}
        };
    }
}

function require(path){
    if(path.search("./src") != 0){
        path = "./src/" + path;
    }
    if(path.search("\\.js") == -1 ){
        path = path + ".js";
    }

    if(!(path in requiredModules)){
        var status = Qt.include(path);
        switch(status.status){
        default:
            console.error("failed to load " + path + " Reason: " + status.status)
            if(status.status == 3){
                console.error(status.exception.message);
                console.error(status.exception.stack);
            }
            break;
        case 0:
            break;
        }
        requiredModules[path] = module.exports;
    }
    return requiredModules[path];
}

require("./src/chart.js");
