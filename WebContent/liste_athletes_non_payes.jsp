<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="org.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Liste des athl�tes en retard de paiement</title>
<script type="text/javascript" src="jszip.js"></script>
<script type="text/javascript" src="FileSaver.js"></script>
<script type="text/javascript" src="myexcel.js"></script>
</head>
<body>
	<script src="scriptExcel_Liste_Athletes_non_Payes.js"></script>
	<h2 style="color:white;background-color:#6683b1;text-align:center">Liste des athl�tes en retard de paiement</h2>
	<table border="1" >
		<tr>								<!-- ligne1 -->
			<th> Identifiant </th>			<!-- case 1 -->
			<th> Nom </th>					<!-- case 2 -->
			<th> Pr�nom </th>				<!-- case 3 -->
		</tr>
<%
	ATHLETE myAthlete = null;
	ArrayList<Object> athletes = DBManager.getATHLETE_non_payes();

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
		<script>
		excel_Athletes_non_Payes.set(0,0,<%=i%>+1,"<%=myAthlete.ID%>");
		excel_Athletes_non_Payes.set(0,1,<%=i%>+1,"<%=myAthlete.NOM%>");
		excel_Athletes_non_Payes.set(0,2,<%=i%>+1,"<%=myAthlete.PRENOM%>");
		</script>
	    <%
	}
		%>
	</table>
	<br/>
	<br/>
	
	<input type="button" id="exportbtn" value="Exporter la liste" onclick="download_Athletes_non_Payes('Liste_Athletes_non_Payes.xlsx');" />
	<script src="myScripts.js"></script>
	
	<br/>
	<br/>
	<br/>
	<a href="index.jsp">Retour � la page d'acceuil</a><br/>
	<a href="liste_athletes.jsp">Liste des athl�tes</a><br/>
</body>
</html>