<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="org.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Liste des athlètes en retard de paiement</title>
</head>
<body>
	<h2 style="color:white;background-color:#6683b1;text-align:center">Liste des athlètes en retard de paiement</h2>
	<table border="1" >
		<tr>								<!-- ligne1 -->
			<th> Identifiant </th>			<!-- case 1 -->
			<th> Nom </th>					<!-- case 2 -->
			<th> Prénom </th>				<!-- case 3 -->
		</tr>
<%
	ATHLETE myAthlete = null;
	ArrayList<Object> athletes = DBManager.getATHLETE_non_payes();
	String toExcel = "";
	for (int i=0; i<athletes.size(); i++)
	{
		myAthlete = DBManager.getATHLETE( (Integer)(athletes.get(i)) );
		
		String link_athlete_paiement = "paiement.jsp?ID="+myAthlete.ID;
%>
		<tr>																		<!-- ligne i -->
			<th> <a href = <%=link_athlete_paiement%>><%=myAthlete.ID%></a> </th>	<!-- case 1 -->
			<th> <%=myAthlete.NOM%> </th>											<!-- case 2 -->
			<th> <%=myAthlete.PRENOM%> </th>										<!-- case 3 -->
		</tr>
<%
		toExcel = toExcel + myAthlete.ID + "\t"  + myAthlete.NOM + "\t"  + myAthlete.PRENOM + "\n" ;
	}
%>
	</table>
	<p hidden=true id="toExcelTag"><%=toExcel %></p>
	<br/>
	<br/>
	
	<input type="button" id="exportbtn" value="Exporter la liste" onclick="download('hello.xls');" />
	<script src="myScripts.js"></script>
	
	<br/>
	<br/>
	<br/>
	<a href="index.jsp">Retour à la page d'acceuil</a><br/>
	<a href="liste_athletes.jsp">Liste des athlètes</a><br/>
</body>
</html>