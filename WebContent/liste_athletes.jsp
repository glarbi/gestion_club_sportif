<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="org.*" %>
<%@ page import="java.time.*"%>
<%@ page import="java.time.format.DateTimeFormatter"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>LISTE DES ATHLETES</title>
<script type="text/javascript" src="jszip.js"></script>
<script type="text/javascript" src="FileSaver.js"></script>
<script type="text/javascript" src="myexcel.js"></script>
</head>
<body>
	<form name="athleteForm" method="get"
             style="width:50%;margin:auto;background-color:#c1d9fc;padding-bottom:15px;">
		<div>
			<h2 style="color:white;background-color:#6683b1;text-align:center">CHERCHER UN ATHLETE</h2>
			<p>Nom : <input type="text" name="nom" style=color:graytext value="Tapez le nom de l_athlète" size=25 align="right" /></p>
			<p>Prenom : <input type="text" name="prenom" style=color:graytext  value="Tapez le prénom de l_athlète" size=25 align="right" /></p>
            <p>ID : <input type="text" name="id" style=color:graytext  value="0" size=25 align="right" /></p>


			<p style="width:50%;margin:auto;"><input type="submit" name="OK" value="OK"/><INPUT type="reset"></p>
		</div>
		<a href="liste_athletes_non_assures.jsp">Liste des athletes non assurés</a>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<a href="liste_athletes_non_payes.jsp">Liste des athletes en retard de paiement</a>
		<br/>
		<a href="index.jsp">Retour à la page d'acceuil</a>
	</form>

	<br/>
	<input type="button" id="exportbtn" value="Exporter la liste" onclick="download_Athletes('Liste_Athletes.xlsx');" />
	<script src="myScripts.js"></script>
	<script src="scriptExcel_Liste_Athletes.js"></script>
	
	<table border="1" >
		<caption><h2 style="color:white;background-color:#6683b1;text-align:center">Liste des athlètes</h2></caption>
		<tr>								<!-- ligne1 -->
			<th> Identifiant </th>			<!-- case 1 -->
			<th> Nom </th>					<!-- case 2 -->
			<th> Prénom </th>				<!-- case 3 -->
			<th> Paiement </th>				<!-- case 4 -->
			<th> Assurance </th>			<!-- case 5 -->
			<th> Date de naissance </th>	<!-- case 6 -->
			<th> Lieu de naissance </th>	<!-- case 7 -->
			<th> Prénom du père </th>		<!-- case 8 -->
			<th> Profession du père </th>	<!-- case 9 -->
			<th> Nom de la mère </th>		<!-- case 10 -->
			<th> Prénom de la mère </th>	<!-- case 11 -->
			<th> Profession de la mère </th><!-- case 12 -->
			<th> Adresse </th>				<!-- case 13 -->
			<th> Téléphone </th>			<!-- case 14 -->
			<th> Date d'inscription </th>	<!-- case 15 -->
		</tr>
<%
	ATHLETE myAthlete = new ATHLETE();
	
	String t1 = request.getParameter("id");
	String t2 = request.getParameter("nom");
	String t3 = request.getParameter("prenom");
	if (t1==null && t2==null && t3==null) {
		myAthlete.ID = "0";
		myAthlete.NOM = "";
		myAthlete.PRENOM = "";
	}
	else {
		if (t1 != null) myAthlete.ID = t1;
		if (t2 != null) myAthlete.NOM = t2;
		if (t3 != null) myAthlete.PRENOM = t3;
	}

	ArrayList<ArrayList<Object>> athletes = null;
	if (myAthlete.ID == "0")
		athletes = DBManager.getATHLETE(0, "", "");
	else {
		try {
	athletes = DBManager.getATHLETE(Integer.parseInt(myAthlete.ID), myAthlete.NOM, myAthlete.PRENOM);
		} catch(java.lang.NumberFormatException e) {
	System.out.println("Exception : " + e.getMessage());
		}
	}
	int athletesSize = athletes.size();
	%>
	<script>
	for (var i=1;i < <%=athletesSize%>;i++) excel_Athletes.set({row:i, style: i%2==0 ? evenRow: oddRow  });
	</script>
	<%
	ArrayList<Object> ligne1 = null;

	for (int i=0; i<athletesSize; i++)
	{
		ligne1 = athletes.get(i);
		myAthlete.ID =				ligne1.get(0).toString();
		myAthlete.NOM =				ligne1.get(1).toString();
		myAthlete.PRENOM =			ligne1.get(2).toString();
		myAthlete.DATE_NAIS =		ligne1.get(3).toString();
		myAthlete.LIEU_NAIS =		ligne1.get(4).toString();
		myAthlete.prenomPere =		ligne1.get(5).toString();
		myAthlete.profPere =		ligne1.get(6).toString();
		myAthlete.nomMere =			ligne1.get(7).toString();
		myAthlete.prenomMere =		ligne1.get(8).toString();
		myAthlete.profMere =		ligne1.get(9).toString();
		myAthlete.ADRESSE =			ligne1.get(10).toString();
		myAthlete.NUM_TEL =			ligne1.get(11).toString();
		myAthlete.DATE_INSCRIPTION =ligne1.get(12).toString();
		
		String link_athlete = "athlete.jsp?ID="+myAthlete.ID;
		String link_athlete_paiement = "paiement.jsp?ID="+myAthlete.ID;
		String link_athlete_assurance = "assurance.jsp?ID="+myAthlete.ID;
		
		LocalDate d = LocalDate.now();
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-");

		String paiement = "";
		String paiementToExcel = "";
		try {
			String date = d.format(formatter);
			if ( DBManager.check_PAIEMENT(Integer.parseInt(myAthlete.ID), date+"01") ) {
				paiement = "OK";
				paiementToExcel = "OK";
			} else {
				paiement = "<font color=\"red\">Non payé</font>";
				paiementToExcel = "no OK";
			}
		} catch(java.lang.NumberFormatException e) {
			System.out.println("Exception : " + e.getMessage());
		}
		String assurance = "";
		String assuranceToExcel = "";
		try {
			if ( DBManager.check_ASSURANCE(Integer.parseInt(myAthlete.ID), d) ) {
				assurance = "OK";
				assuranceToExcel = "OK";
			} else {
				assurance = "<font color=\"red\">Non assuré</font>";
				assuranceToExcel = "no OK";
			}
		} catch(java.lang.NumberFormatException e) {
			System.out.println("Exception : " + e.getMessage());
		}
%>
		<tr>																		<!-- ligne i -->
			<th> <a href = <%=link_athlete%>><%=myAthlete.ID%></a> </th>			<!-- case 1 -->
			<th> <%=myAthlete.NOM%> </th>											<!-- case 2 -->
			<th> <%=myAthlete.PRENOM%> </th>										<!-- case 3 -->
			<th> <a href = <%=link_athlete_paiement%>><%=paiement%></a> </th>		<!-- case 4 -->
			<th> <a href = <%=link_athlete_assurance%>><%=assurance%></a> </th>		<!-- case 5 -->
			<th> <%=myAthlete.DATE_NAIS%> </th>										<!-- case 6 -->
			<th> <%=myAthlete.LIEU_NAIS%> </th>										<!-- case 7 -->
			<th> <%=myAthlete.prenomPere%> </th>									<!-- case 8 -->
			<th> <%=myAthlete.profPere%> </th>										<!-- case 9 -->
			<th> <%=myAthlete.nomMere%> </th>										<!-- case 10 -->
			<th> <%=myAthlete.prenomMere%> </th>									<!-- case 11 -->
			<th> <%=myAthlete.profMere%> </th>										<!-- case 12 -->
			<th> <%=myAthlete.ADRESSE%> </th>										<!-- case 13 -->
			<th> <%=myAthlete.NUM_TEL%> </th>										<!-- case 14 -->
			<th> <%=myAthlete.DATE_INSCRIPTION%> </th>								<!-- case 15 -->
		</tr>
		<script>
		excel_Athletes.set(0,0,<%=i%>+1,"<%=myAthlete.ID%>");
		excel_Athletes.set(0,1,<%=i%>+1,"<%=myAthlete.NOM%>");
		excel_Athletes.set(0,2,<%=i%>+1,"<%=myAthlete.PRENOM%>");
		excel_Athletes.set(0,3,<%=i%>+1,"<%=paiementToExcel%>");
		excel_Athletes.set(0,4,<%=i%>+1,"<%=assuranceToExcel%>");
		excel_Athletes.set(0,5,<%=i%>+1,"<%=myAthlete.DATE_NAIS%>");
		excel_Athletes.set(0,6,<%=i%>+1,"<%=myAthlete.LIEU_NAIS%>");
		excel_Athletes.set(0,7,<%=i%>+1,"<%=myAthlete.prenomPere%>");
		excel_Athletes.set(0,8,<%=i%>+1,"<%=myAthlete.profPere%>");
		excel_Athletes.set(0,9,<%=i%>+1,"<%=myAthlete.nomMere%>");
		excel_Athletes.set(0,10,<%=i%>+1,"<%=myAthlete.prenomMere%>");
		excel_Athletes.set(0,11,<%=i%>+1,"<%=myAthlete.profMere%>");
		excel_Athletes.set(0,12,<%=i%>+1,"<%=myAthlete.ADRESSE%>");
		excel_Athletes.set(0,13,<%=i%>+1,"<%=myAthlete.NUM_TEL%>");
		excel_Athletes.set(0,14,<%=i%>+1,"<%=myAthlete.DATE_INSCRIPTION%>");
	    </script>
	    <%
	}
		%>
	</table>
</body>
</html>