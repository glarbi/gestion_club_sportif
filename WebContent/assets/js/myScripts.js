
function download_Athletes(filename) {
	console.log("download_Athletes");
	excel_Athletes.generate(filename);
}

function download_Athletes_non_Assures(filename) {
	console.log("download_Athletes_non_Assures");
	excel_Athletes_non_Assures.generate(filename);
}

function download_Athletes_non_Payes(filename) {
	console.log("download_Athletes_non_Payes");
	excel_Athletes_non_Payes.generate(filename);
}

function download_Entraineur(filename) {
	console.log("download_Entraineur");
	excel_Entraineurs.generate(filename);
}

/******************** Read XML file *******************************************/


function readXMLDoc(xml) {
    var x, i, xmlDoc, txt;
    xmlDoc = xml.responseXML;
    txt = "";
    x = xmlDoc.documentElement.childNodes;
    for (i = 0; i < x.length; i++) { 
        if (x[i].nodeType == 1) {	//Node.ELEMENT_NODE	1	Un noeud Element  tel que <p> ou <div>.
        							// more information on: https://developer.mozilla.org/fr/docs/Web/API/Node/nodeType
            txt += x[i].nodeName + "<br>";
        }
    }
    document.getElementById("demo").innerHTML = txt; 
}
