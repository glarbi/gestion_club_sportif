<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="org.*" %>
<%@ page import="java.time.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Liste des entraineurs non assurés</title>
</head>
<body>
	<h2 style="color:white;background-color:#6683b1;text-align:center">Liste des entraineurs non assurés</h2>
	<table border="1" >
		<tr>								<!-- ligne1 -->
			<th> Identifiant </th>			<!-- case 1 -->
			<th> Nom </th>					<!-- case 2 -->
			<th> Prénom </th>				<!-- case 3 -->
			<th> Depuis </th>				<!-- case 4 -->
			<th> Jusqu'au </th>				<!-- case 5 -->
		</tr>
<%
	ENTRAINEUR myEntraineur = null;
	ArrayList<ArrayList<Object>> entraineurs = null;
	ArrayList<Object> ligne1 = null;
	String debut = "";
	String fin   = "";
	entraineurs = DBManager.getENTRAINEUR_non_assures();
	for (int i=0; i<entraineurs.size(); i++)
	{
		ligne1 = entraineurs.get(i);
		myEntraineur = DBManager.getENTRAINEUR(Integer.valueOf(ligne1.get(0).toString()));
		debut = ligne1.get(1).toString();
		fin   = ligne1.get(2).toString();
		
		String link_entraineur_assurance = "assurance.jsp?ID="+myEntraineur.ID;
		
		//java.util.Date d = new java.util.Date();
		LocalDate d = LocalDate.now();
		String assurance = "";
		try {
			if ( DBManager.check_ASSURANCE(Integer.parseInt(myEntraineur.ID), d) )
				assurance = "OK";
			else assurance = "<font color=\"red\">Non assuré</font>";
		} catch(java.lang.NumberFormatException e) {
			System.out.println("Exception : " + e.getMessage());
		}
%>
		<tr>																			<!-- ligne i -->
			<th> <a href = <%=link_entraineur_assurance%>><%=myEntraineur.ID%></a> </th><!-- case 1 -->
			<th> <%=myEntraineur.NOM%> </th>											<!-- case 2 -->
			<th> <%=myEntraineur.PRENOM%> </th>											<!-- case 3 -->
			<th> <%=debut%> </th>														<!-- case 4 -->
			<th> <%=fin%> </th>															<!-- case 5 -->
		</tr>
<%
	}
%>
	</table>
	<br/>
	<a href="index.jsp">Retour à la page d'acceuil</a><br/>
	<a href="liste_entraineurs.jsp">Liste des entraineurs</a><br/>
</body>
</html>