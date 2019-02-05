<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="org.*" %>
    <jsp:useBean id="mybean" scope="session" class="org.PropertyHandler" />
<jsp:setProperty name="mybean" property="*" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>DOSSIERS DES ENTRAINEURS</title>
</head>
<body>
	<form name="entraineurForm" method="get"
             style="width:50%;margin:auto;background-color:#c1d9fc;padding-bottom:15px;">
		
<!--		<div style="text-align:center;">-->
		<div>
			<h2 style="color:white;background-color:#6683b1;text-align:center">CHERCHER UN ENTRAINEUR</h2>
			<p>Nom : <input type="text" name="nom" style=color:graytext value="Tapez le nom de l_entraineur" size=25 align="right" /></p>
			<p>Prenom : <input type="text" name="prenom" style=color:graytext  value="Tapez le pr�nom de l_entraineur" size=25 align="right" /></p>
            <p>ID : <input type="text" name="id" style=color:graytext  value="0" size=25 align="right" /></p>


			<p style="width:50%;margin:auto;"><input type="submit" name="OK" value="OK"/><INPUT type="reset"></p>
		</div>
		<a href="liste_entraineurs_non_assures.jsp">Liste des entraineurs non assur�s</a>
		<br/>
		<a href="index.jsp">Retour � la page d'acceuil</a>
	</form>

<!-- **************************************************************** -->
		<br/>
		<table border="1" >
			<caption><h2 style="color:white;background-color:#6683b1;text-align:center">Liste des entraineurs</h2></caption>
			<tr>							<!-- ligne1 -->
				<th> Identifiant </th>			<!-- case 1 -->
				<th> Nom </th>					<!-- case 2 -->
				<th> Pr�nom </th>				<!-- case 3 -->
				<th> Paiement </th>				<!-- case 4 -->
				<th> Assurance </th>			<!-- case 5 -->
				<th> Date de naissance </th>	<!-- case 6 -->
				<th> Lieu de naissance </th>	<!-- case 7 -->
				<th> Adresse </th>				<!-- case 8 -->
				<th> T�l�phone </th>			<!-- case 9 -->
				<th> Date d'inscription </th>	<!-- case 10 -->
			</tr>
<%
	ENTRAINEUR myEntraineur = new ENTRAINEUR();
	
	//<jsp:getProperty name="mybean" property="nom"/>
	String t1 = request.getParameter("id");
	String t2 = request.getParameter("nom");
	String t3 = request.getParameter("prenom");
	if (t1==null && t2==null && t3==null) {
		myEntraineur.ID = "0";
		myEntraineur.NOM = "";
		myEntraineur.PRENOM = "";
	}
	else {
		if (t1 != null) myEntraineur.ID = t1;
		if (t2 != null) myEntraineur.NOM = t2;
		if (t3 != null) myEntraineur.PRENOM = t3;
	}

	ArrayList entraineurs = null;
	if (myEntraineur.ID == "0")
		entraineurs = DBManager.getENTRAINEUR(0, "", "");
	else {
		try {
			entraineurs = DBManager.getENTRAINEUR(Integer.parseInt(myEntraineur.ID), myEntraineur.NOM, myEntraineur.PRENOM);
		} catch(java.lang.NumberFormatException e) {
			System.out.println("Exception : " + e.getMessage());
		}
	}
	List ligne1 = null;
	for (int i=0; i<entraineurs.size(); i++)
	{
		ligne1 = (List)(entraineurs.get(i));
		myEntraineur.ID =				ligne1.get(0).toString();
		myEntraineur.NOM =				ligne1.get(1).toString();
		myEntraineur.PRENOM =			ligne1.get(2).toString();
		myEntraineur.DATE_NAIS =		ligne1.get(3).toString();
		myEntraineur.LIEU_NAIS =		ligne1.get(4).toString();
		myEntraineur.ADRESSE =			ligne1.get(5).toString();
		myEntraineur.NUM_TEL =			ligne1.get(6).toString();
		myEntraineur.DATE_INSCRIPTION =	ligne1.get(7).toString();
		
		String link_entraineur = "entraineur.jsp?ID="+myEntraineur.ID;
		String link_entraineur_paiement = "paiement.jsp?ID="+myEntraineur.ID;
		String link_entraineur_assurance = "assurance.jsp?ID="+myEntraineur.ID;
		
		java.util.Date d = new java.util.Date();
		String paiement = "";
		try {
			String date = String.valueOf(d.getYear()+1900)+"-"+String.valueOf(d.getMonth()+1)+"-01";
			if ( DBManager.check_PAIEMENT(Integer.parseInt(myEntraineur.ID), date) )
				paiement = "OK";
			else paiement = "<font color=\"red\">Non pay�</font>";
		} catch(java.lang.NumberFormatException e) {
			System.out.println("Exception : " + e.getMessage());
		}
		String assurance = "";
		try {
			if ( DBManager.check_ASSURANCE(Integer.parseInt(myEntraineur.ID), d) )
				assurance = "OK";
			else assurance = "<font color=\"red\">Non assur�</font>";
		} catch(java.lang.NumberFormatException e) {
			System.out.println("Exception : " + e.getMessage());
		}
%>
			<tr>												<!-- ligne i -->
				<th> <a href = <%=link_entraineur%>><%=myEntraineur.ID%></a> </th>				<!-- case 1 -->
				<th> <%=myEntraineur.NOM%> </th>				<!-- case 2 -->
				<th> <%=myEntraineur.PRENOM%> </th>				<!-- case 3 -->
				<th> <a href = <%=link_entraineur_paiement%>><%=paiement%></a> </th>		<!-- case 4 -->
				<th> <a href = <%=link_entraineur_assurance%>><%=assurance%></a> </th>		<!-- case 5 -->
				<th> <%=myEntraineur.DATE_NAIS%> </th>			<!-- case 4 -->
				<th> <%=myEntraineur.LIEU_NAIS%> </th>			<!-- case 5 -->
				<th> <%=myEntraineur.ADRESSE%> </th>			<!-- case 6 -->
				<th> <%=myEntraineur.NUM_TEL%> </th>			<!-- case 7 -->
				<th> <%=myEntraineur.DATE_INSCRIPTION%> </th>	<!-- case 8 -->
			</tr>
<%
	}
%>
		</table>
<!-- ********************************************************************** -->
	
</body>
</html>