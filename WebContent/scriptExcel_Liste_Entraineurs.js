var excel_Entraineurs = $JExcel.new("Calibri light 10 #333333");
excel_Entraineurs.set( {sheet:0,value:"Liste des entraineurs" } );
var evenRow = excel_Entraineurs.addStyle( { border: "none,none,none,thin #333333"});
var oddRow = excel_Entraineurs.addStyle ( { fill: "#ECECEC", border: "none,none,none,thin #333333"}); 
 
var headers = ["Identifiant", "Nom", "Prénom", "Paiement", "Assurance", "Date de naissance", "Lieu de naissance", "Adresse", "Téléphone", "Date inscription"];
var formatHeader = excel_Entraineurs.addStyle ( {
    border: "none,none,none,thin #333333", font: "Calibri 12 #0000AA B"}
);
for (var i=0; i<headers.length; i++){              // Loop headers
    excel_Entraineurs.set(0, i, 0, headers[i], formatHeader);    // Set CELL header text & header format
    excel_Entraineurs.set(0, i, undefined, "auto");             // Set COLUMN width to auto 
    excel_Entraineurs.set(0, i, undefined, 30, excel_Entraineurs.addStyle( {align:"L C"})); // Align columns to the left center
}
