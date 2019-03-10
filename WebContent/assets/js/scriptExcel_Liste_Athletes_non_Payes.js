var excel_Athletes_non_Payes = $JExcel.new("Calibri light 10 #333333");
excel_Athletes_non_Payes.set( {sheet:0,value:"Liste des athletes" } );
var evenRow = excel_Athletes_non_Payes.addStyle( { border: "none,none,none,thin #333333" });
var oddRow = excel_Athletes_non_Payes.addStyle ( { fill: "#ECECEC", border: "none,none,none,thin #333333" });
 
var headers=["Identifiant", "Nom", "Prénom"];
var formatHeader = excel_Athletes_non_Payes.addStyle ( {
    border: "none,none,none,thin #333333", font: "Calibri 12 #0000AA B"}
);
for (var i=0; i<headers.length; i++){              // Loop headers
    excel_Athletes_non_Payes.set(0, i, 0, headers[i], formatHeader);    // Set CELL header text & header format
    excel_Athletes_non_Payes.set(0, i, undefined, "auto");             // Set COLUMN width to auto 
    excel_Athletes_non_Payes.set(0, i, undefined, 30, excel_Athletes_non_Payes.addStyle( {align:"L C"})); // Align columns to the left center
}
