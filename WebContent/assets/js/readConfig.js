const req = new XMLHttpRequest();
req.open('GET', 'config.xml', false); 
req.send(null);

if (req.status == 200) {
    //console.log("Réponse reçue: %s", req.responseText);
    var parser = new DOMParser();
    var doc = parser.parseFromString(req.responseText, 'application/xml');
    var myClubName = doc.getElementsByTagName('CLUB_NAME')[0].childNodes[0].nodeValue;
    var myClubNameAbbreviation = doc.getElementsByTagName('CLUB_NAME_ABBREVIATION')[0].childNodes[0].nodeValue;
    //console.log("myClubNameAbbreviation: %s", myClubNameAbbreviation);
    document.getElementById("ClubName").innerHTML = myClubName;
    document.getElementById("ClubNameAbbreviation").innerHTML = myClubNameAbbreviation;
} else {
    console.log("Status de la réponse: %d (%s)", req.status, req.statusText);
}
