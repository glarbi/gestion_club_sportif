function download(filename) {
	//alert(text);
	text = document.getElementById("toExcelTag").innerHTML;
	var element = document.createElement('a');
	element.setAttribute('href', 'data:text/plain;charset=utf-8,'
			+ encodeURIComponent(text));
	element.setAttribute('download', filename);

	element.style.display = 'none';
	document.body.appendChild(element);

	element.click();

	document.body.removeChild(element);
}

/*************** Excel script *************************/
function randomDate(start, end) {
    var d= new Date(start.getTime() + Math.random() * (end.getTime() - start.getTime()));
    return d;
}

function download1(filename, myAthlete) {
	var excel = $JExcel.new("Calibri light 10 #333333");
	excel.set( {sheet:0,value:"Liste des athlètes" } );
	var evenRow=excel.addStyle( { border: "none,none,none,thin #333333"});
	var oddRow=excel.addStyle ( { fill: "#ECECEC" ,border: "none,none,none,thin #333333"}); 
	for (var i=1;i<50;i++) excel.set({row:i,style: i%2==0 ? evenRow: oddRow  });
	excel.set({row:3,value: 30  });
	 
	var headers=["Header 0","Header 1","Header 2","Header 3","Header 4"];
	var formatHeader=excel.addStyle ( {
	    border: "none,none,none,thin #333333",font: "Calibri 12 #0000AA B"}
	);
	
	for (var i=0;i<headers.length;i++){              // Loop headers
	    excel.set(0,i,0,headers[i],formatHeader);    // Set CELL header text & header format
	    excel.set(0,i,undefined,"auto");             // Set COLUMN width to auto 
	}
	            
	var initDate = new Date(2000, 0, 1);
	var endDate = new Date(2016, 0, 1);
	var dStyle = excel.addStyle ( {
	    align: "R",
	    format: "yyyy.mm.dd hh:mm:ss",
	    font: "#00AA00"}
	);
	
	for (var i=1;i<50;i++){                                    // Generate 50 rows
	    excel.set(0,0,i,"This is line "+i);                    // This column is a TEXT
	    var d=randomDate(initDate,endDate);                    // Get a random date
	    excel.set(0,1,i,d.toLocaleString());                   // Random date as STRING
	    excel.set(0,2,i,$JExcel.toExcelLocalTime(d));          // Date as a NUMERIC
	    excel.set(0,3,i,$JExcel.toExcelLocalTime(d),dStyle);   // Date as a NUMERIC in dStyle.format
	    excel.set(0,4,i,"Some other text");                    // Some other text
	}

	excel.set(0,1,undefined,30);                               // Set COLUMN B to 30 chars width
	excel.set(0,3,undefined,30);                               // Set COLUMN D to 20 chars width
	excel.set(0,4,undefined,20, excel.addStyle( {align:"R"})); // Align column 4 to the right
	excel.set(0,1,3,undefined,excel.addStyle( {align:"L T"})); // CELL B4  to LEFT-TOP
	excel.set(0,2,3,undefined,excel.addStyle( {align:"C C"})); // CELL C4  to CENTER-CENTER
	excel.set(0,3,3,undefined,excel.addStyle( {align:"R B"})); // CELL D4  to RIGHT-BOTTOM
	excel.generate(filename);
}

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

