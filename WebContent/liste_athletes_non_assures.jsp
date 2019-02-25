<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%@ page import="org.*"%>
<%@ page import="java.time.*"%>


<!DOCTYPE html">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Liste des athl�tes non assur�s</title>
<script type="text/javascript" src="jszip.js"></script>
<script type="text/javascript" src="FileSaver.js"></script>
<script type="text/javascript" src="myexcel.js"></script>
</head>
<body>
	<script src="scriptExcel_Liste_Athletes_non_Assures.js"></script>
	<h2 style="color: white; background-color: #6683b1; text-align: center">Liste
		des athl�tes non assur�s</h2>
	<table border="1">
		<tr>
			<!-- ligne1 -->
			<th>Identifiant</th>
			<!-- case 1 -->
			<th>Nom</th>
			<!-- case 2 -->
			<th>Pr�nom</th>
			<!-- case 3 -->
			<th>Date de naissace</th>
			<!-- case 4 -->
			<th>Depuis</th>
			<!-- case 5 -->
			<th>Jusqu'au</th>
			<!-- case 6 -->
		</tr>
		<%
	ATHLETE myAthlete = null;
	ArrayList<ArrayList<Object>> athletes = null;
	ArrayList<Object> ligne1 = null;
	String debut = "";
	String fin   = "";
	athletes = DBManager.getATHLETE_non_assures();
	for (int i=0; i<athletes.size(); i++)
	{
		ligne1 = athletes.get(i);
		myAthlete = DBManager.getATHLETE(Integer.valueOf(ligne1.get(0).toString()));
		debut = ligne1.get(1).toString();
		fin   = ligne1.get(2).toString();
		
		String link_athlete_assurance = "assurance.jsp?ID="+myAthlete.ID;
		
		LocalDate d = LocalDate.now();
		String assurance = "";
		try {
			if ( DBManager.check_ASSURANCE(Integer.parseInt(myAthlete.ID), d) )
				assurance = "OK";
			else assurance = "<font color=\"red\">Non assur�</font>";
		} catch(java.lang.NumberFormatException e) {
			System.out.println("Exception : " + e.getMessage());
		}
%>
		<tr>
			<!-- ligne i -->
			<th><a href=<%=link_athlete_assurance%>><%=myAthlete.ID%></a></th>
			<!-- case 1 -->
			<th><%=myAthlete.NOM%></th>
			<!-- case 2 -->
			<th><%=myAthlete.PRENOM%></th>
			<!-- case 3 -->
			<th><%=myAthlete.DATE_NAIS%></th>
			<!-- case 4 -->
			<th><%=debut%></th>
			<!-- case 5 -->
			<th><%=fin%></th>
			<!-- case 6 -->
		</tr>
		<script>
		excel_Athletes_non_Assures.set(0,0,<%=i%>+1,"<%=myAthlete.ID%>");
		excel_Athletes_non_Assures.set(0,1,<%=i%>+1,"<%=myAthlete.NOM%>");
		excel_Athletes_non_Assures.set(0,2,<%=i%>+1,"<%=myAthlete.PRENOM%>");
		excel_Athletes_non_Assures.set(0,3,<%=i%>+1,"<%=myAthlete.DATE_NAIS%>");
		excel_Athletes_non_Assures.set(0,4,<%=i%>+1,"<%=debut%>");
		excel_Athletes_non_Assures.set(0,5,<%=i%>+1,"<%=fin%>");
		</script>
	    <%
	}
		%>
	</table>
	<br />
	<br />

	<input type="button" id="exportbtn" value="Exporter la liste" onclick="download_Athletes_non_Assures('Liste_Athletes_non_Assures.xlsx');" />
	<script src="myScripts.js"></script>

	<br />
	<br />
	<br />
	<a href="index.jsp">Retour � la page d'acceuil</a>
	<br />
	<a href="liste_athletes.jsp">Liste des athl�tes</a>
	<br />
</body>
</html>