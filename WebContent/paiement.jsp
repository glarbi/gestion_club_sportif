<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="org.*" %>
<%@ page import="java.time.*"%>
<%@ page import="java.time.format.DateTimeFormatter"%>


<html>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Page de paiement</title>
</head>
<body>
<%
	PERSONNE myPersonne = new PERSONNE("_", "_", "_", "01/01/1990", "_", "_", "_", "01/01/1990");
	String idStr = request.getParameter("ID");
	Integer idInt = null;
	String montant = "";
	String check = "";
	ArrayList<ArrayList<Object>> affichages = null;
	if (idStr != null)
	{
		try {
			idInt = Integer.parseInt(idStr);
		} catch(java.lang.NumberFormatException e) {
			System.out.println("Exception : " + e.getMessage());
		}
		
		//java.util.Date d = new java.util.Date();
		LocalDate d = LocalDate.now();
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

		int my_year = 0;
		//if (d.getMonth()+1 >= 10) my_year = d.getYear()+1900; else my_year = d.getYear()+1899;
		if (d.getMonthValue()+1 >= 10) my_year = d.getYear(); else my_year = d.getYear()-1;
		
		montant = request.getParameter("montant_Octobre");
		check = request.getParameter("Octobre");
		if (check!=null && check.equals("on") && montant != null && Float.valueOf(montant)>=0)
			DBManager.set_PAIEMENT(idInt, my_year+"/10/01", Float.parseFloat(montant));
		else if (check==null && montant != null)
			DBManager.set_PAIEMENT(idInt, my_year+"/10/01", Float.valueOf(-1));
		montant = request.getParameter("montant_Novembre");
		check = request.getParameter("Novembre");
		if (check!=null && check.equals("on") && montant != null && Float.valueOf(montant)>=0)
			DBManager.set_PAIEMENT(idInt, my_year+"/11/01", Float.parseFloat(montant));
		else if (check==null && montant != null)
			DBManager.set_PAIEMENT(idInt, my_year+"/11/01", Float.valueOf(-1));
		montant = request.getParameter("montant_Decembre");
		check = request.getParameter("Decembre");
		if (check!=null && check.equals("on") && montant != null && Float.valueOf(montant)>=0)
			DBManager.set_PAIEMENT(idInt, my_year+"/12/01", Float.parseFloat(montant));
		else if (check==null && montant != null)
			DBManager.set_PAIEMENT(idInt, my_year+"/12/01", Float.valueOf(-1));
		montant = request.getParameter("montant_Janvier");
		check = request.getParameter("Janvier");
		if (check!=null && check.equals("on") && montant != null && Float.valueOf(montant)>=0)
			DBManager.set_PAIEMENT(idInt, (my_year+1)+"/01/01", Float.parseFloat(montant));
		else if (check==null && montant != null)
			DBManager.set_PAIEMENT(idInt, (my_year+1)+"/01/01", Float.valueOf(-1));
		montant = request.getParameter("montant_Fevrier");
		check = request.getParameter("Fevrier");
		if (check!=null && check.equals("on") && montant != null && Float.valueOf(montant)>=0)
			DBManager.set_PAIEMENT(idInt, (my_year+1)+"/02/01", Float.parseFloat(montant));
		else if (check==null && montant != null)
			DBManager.set_PAIEMENT(idInt, (my_year+1)+"/02/01", Float.valueOf(-1));
		montant = request.getParameter("montant_Mars");
		check = request.getParameter("Mars");
		if (check!=null && check.equals("on") && montant != null && Float.valueOf(montant)>=0)
			DBManager.set_PAIEMENT(idInt, (my_year+1)+"/03/01", Float.parseFloat(montant));
		else if (check==null && montant != null)
			DBManager.set_PAIEMENT(idInt, (my_year+1)+"/03/01", Float.valueOf(-1));
		montant = request.getParameter("montant_Avril");
		check = request.getParameter("Avril");
		if (check!=null && check.equals("on") && montant != null && Float.valueOf(montant)>=0)
			DBManager.set_PAIEMENT(idInt, (my_year+1)+"/04/01", Float.parseFloat(montant));
		else if (check==null && montant != null)
			DBManager.set_PAIEMENT(idInt, (my_year+1)+"/04/01", Float.valueOf(-1));
		montant = request.getParameter("montant_Mai");
		check = request.getParameter("Mai");
		if (check!=null && check.equals("on") && montant != null && Float.valueOf(montant)>=0)
			DBManager.set_PAIEMENT(idInt, (my_year+1)+"/05/01", Float.parseFloat(montant));
		else if (check==null && montant != null)
			DBManager.set_PAIEMENT(idInt, (my_year+1)+"/05/01", Float.valueOf(-1));
		montant = request.getParameter("montant_Juin");
		check = request.getParameter("Juin");
		if (check!=null && check.equals("on") && montant != null && Float.valueOf(montant)>=0)
			DBManager.set_PAIEMENT(idInt, (my_year+1)+"/06/01", Float.parseFloat(montant));
		else if (check==null && montant != null)
			DBManager.set_PAIEMENT(idInt, (my_year+1)+"/06/01", Float.valueOf(-1));
		montant = request.getParameter("montant_Juillet");
		check = request.getParameter("Juillet");
		if (check!=null && check.equals("on") && montant != null && Float.valueOf(montant)>=0)
			DBManager.set_PAIEMENT(idInt, (my_year+1)+"/07/01", Float.parseFloat(montant));
		else if (check==null && montant != null)
			DBManager.set_PAIEMENT(idInt, (my_year+1)+"/07/01", Float.valueOf(-1));
	
		if (idStr != null) {
			ArrayList<ArrayList<Object>> myList = null;
			if (idInt<=10)
			{
				myList = DBManager.getENTRAINEUR(idInt, "", "");
				if (myList.size() == 0)
				{
					idInt = 1;
					myList = DBManager.getENTRAINEUR(idInt, "", "");
				}
			}
			else
			{
				myList = DBManager.getATHLETE(idInt, "", "");
				if (myList.isEmpty())
				{
					idInt = 11;
					myList = DBManager.getATHLETE(idInt, "", "");
				}
			}
			if (myList.size() > 0){
				List<Object> ligne1 = myList.get(0);
				myPersonne.ID =		ligne1.get(0).toString();
				myPersonne.NOM =	ligne1.get(1).toString();
				myPersonne.PRENOM =	ligne1.get(2).toString();
			}
			
			// Paiements
			ArrayList<ArrayList<Object>> paiements = DBManager.get_PAIEMENT(idInt);
			affichages = new ArrayList<ArrayList<Object>>();
			for (int i=0; i<10; i++)
			{
				ArrayList<Object> affichage = new ArrayList<Object>();
				affichage.add(0, "0.00"); affichage.add(1, "");
				affichages.add(i, affichage);
			}
			ArrayList<Object> ligne = null;
			for (int i=0; i<paiements.size(); i++)
			{
				ligne = paiements.get(i);
				String tmp = ligne.get(1).toString();
				int pos = tmp.lastIndexOf("-");
				int mois = Integer.parseInt(tmp.substring(pos-2, pos)); // Mois
				tmp = ligne.get(2).toString(); //Montant
				ArrayList<Object> affichage = null;
				switch (mois) {
				case 10: {
					affichage = affichages.get(0);
					affichage.add(0, tmp);
					if (!tmp.equals("-1.00")) affichage.add(1, "CHECKED");
					break;
				}
				case 11: {
					affichage = affichages.get(1);
					affichage.add(0, tmp);
					if (!tmp.equals("-1.00")) affichage.add(1, "CHECKED");
					break;
				}
				case 12: {
					affichage = affichages.get(2);
					affichage.add(0, tmp);
					if (!tmp.equals("-1.00")) affichage.add(1, "CHECKED");
					break;
				}
				case 1: {
					affichage = affichages.get(3);
					affichage.add(0, tmp);
					if (!tmp.equals("-1.00")) affichage.add(1, "CHECKED");
					break;
				}
				case 2: {
					affichage = affichages.get(4);
					affichage.add(0, tmp);
					if (!tmp.equals("-1.00")) affichage.add(1, "CHECKED");
					break;
				}
				case 3: {
					affichage = affichages.get(5);
					affichage.add(0, tmp);
					if (!tmp.equals("-1.00")) affichage.add(1, "CHECKED");
					break;
				}
				case 4: {
					affichage = affichages.get(6);
					affichage.add(0, tmp);
					if (!tmp.equals("-1.00")) affichage.add(1, "CHECKED");
					break;
				}
				case 5: {
					affichage = affichages.get(7);
					affichage.add(0, tmp);
					if (!tmp.equals("-1.00")) affichage.add(1, "CHECKED");
					break;
				}
				case 6: {
					affichage = affichages.get(8);
					affichage.add(0, tmp);
					if (!tmp.equals("-1.00")) affichage.add(1, "CHECKED");
					break;
				}
				case 7: {
					affichage = affichages.get(9);
					affichage.add(0, tmp);
					if (!tmp.equals("-1.00")) affichage.add(1, "CHECKED");
					break;
				}
				}
			}
		}
	}
%>
	<form name="PaiementForm" method="get"
             style="width:50%;margin:auto;background-color:#c1d9fc;padding-bottom:15px;">
<%
	if (idInt<=10)
	{
%>
	<p align="center"><B>Information sur le paiement de l'entraineur</B></p>
<%
	}
	else
	{
%>
	<p align="center"><B>Information sur le paiement de l'athlète</B></p>
<%
	}
%>
	<table>
		<tr>
			<th>
				<p align="left">Identifiant :</p>
			</th>
			<th>
				<p><input readonly="readonly" type="text" name="ID" style=color:graytext  value="<%=myPersonne.ID%>" size=25 align="right" /></p>
			</th>
		</tr>
		<tr>
			<th>
				<p align="left">Nom de l'athlète :</p>
			</th>
			<th>
				<p align="left"><%=myPersonne.NOM%></p>
			</th>
		</tr>
		<tr>
			<th>
				<p align="left">Prénom de l'athlète :</p>
			</th>
			<th>
				<p align="left"><%=myPersonne.PRENOM%></p>
			</th>
		</tr>
		<tr>
			<th>
				<p align="left"></p>
			</th>
			<th>
				<p align="left"></p>
			</th>
		</tr>
		<tr>
			<th>
				<p align="left"><INPUT TYPE=CHECKBOX NAME="Octobre" <%=(affichages.get(0)).get(1).toString()%>>Octobre</p>
			</th>
			<th>
				<p align="left">Montant : <input type="text" name="montant_Octobre" style=color:graytext  value="<%=(affichages.get(0)).get(0).toString()%>" size=25 align="right" /></p>
			</th>
		</tr>
		<tr>
			<th>
				<p align="left"><INPUT TYPE=CHECKBOX NAME="Novembre" <%=(affichages.get(1)).get(1).toString()%>>Novembre</p>
			</th>
			<th>
				<p align="left">Montant : <input type="text" name="montant_Novembre" style=color:graytext  value="<%=(affichages.get(1)).get(0).toString()%>" size=25 align="right" /></p>
			</th>
		</tr>
		<tr>
			<th>
				<p align="left"><INPUT TYPE=CHECKBOX NAME="Decembre" <%=(affichages.get(2)).get(1).toString()%>>Décembre</p>
			</th>
			<th>
				<p align="left">Montant : <input type="text" name="montant_Decembre" style=color:graytext  value="<%=(affichages.get(2)).get(0).toString()%>" size=25 align="right" /></p>
			</th>
		</tr>
		<tr>
			<th>
				<p align="left"><INPUT TYPE=CHECKBOX NAME="Janvier" <%=(affichages.get(3)).get(1).toString()%>>Janvier</p>
			</th>
			<th>
				<p align="left">Montant : <input type="text" name="montant_Janvier" style=color:graytext  value="<%=(affichages.get(3)).get(0).toString()%>" size=25 align="right" /></p>
			</th>
		</tr>
		<tr>
			<th>
				<p align="left"><INPUT TYPE=CHECKBOX NAME="Fevrier" <%=(affichages.get(4)).get(1).toString()%>>Février</p>
			</th>
			<th>
				<p align="left">Montant : <input type="text" name="montant_Fevrier" style=color:graytext  value="<%=(affichages.get(4)).get(0).toString()%>" size=25 align="right" /></p>
			</th>
		</tr>
		<tr>
			<th>
				<p align="left"><INPUT TYPE=CHECKBOX NAME="Mars" <%=(affichages.get(5)).get(1).toString()%>>Mars</p>
			</th>
			<th>
				<p align="left">Montant : <input type="text" name="montant_Mars" style=color:graytext  value="<%=(affichages.get(5)).get(0).toString()%>" size=25 align="right" /></p>
			</th>
		</tr>
		<tr>
			<th>
				<p align="left"><INPUT TYPE=CHECKBOX NAME="Avril" <%=(affichages.get(6)).get(1).toString()%>>Avril</p>
			</th>
			<th>
				<p align="left">Montant : <input type="text" name="montant_Avril" style=color:graytext  value="<%=(affichages.get(6)).get(0).toString()%>" size=25 align="right" /></p>
			</th>
		</tr>
		<tr>
			<th>
				<p align="left"><INPUT TYPE=CHECKBOX NAME="Mai" <%=(affichages.get(7)).get(1).toString()%>>Mai</p>
			</th>
			<th>
				<p align="left">Montant : <input type="text" name="montant_Mai" style=color:graytext  value="<%=(affichages.get(7)).get(0).toString()%>" size=25 align="right" /></p>
			</th>
		</tr>
		<tr>
			<th>
				<p align="left"><INPUT TYPE=CHECKBOX NAME="Juin" <%=(affichages.get(8)).get(1).toString()%>>Juin</p>
			</th>
			<th>
				<p align="left">Montant : <input type="text" name="montant_Juin" style=color:graytext  value="<%=(affichages.get(8)).get(0).toString()%>" size=25 align="right" /></p>
			</th>
		</tr>
		<tr>
			<th>
				<p align="left"><INPUT TYPE=CHECKBOX NAME="Juillet" <%=(affichages.get(9)).get(1).toString()%>>Juillet</p>
			</th>
			<th>
				<p align="left">Montant : <input type="text" name="montant_Juillet" style=color:graytext  value="<%=(affichages.get(9)).get(0).toString()%>" size=25 align="right" /></p>
			</th>
		</tr>
	</table>
	<INPUT TYPE=SUBMIT NAME="submit_paiement" VALUE="Mise à jour">
	</form>
	<br/>
	<a href="index.jsp">Retour à la page d'acceuil</a><br/>
	<a href="liste_athletes.jsp">Liste des athlètes</a><br/>
	<a href="liste_entraineurs.jsp">Liste des entraineurs</a><br/>
<%
	if (idStr != null)
	{
		%>
		<a href="paiement.jsp?ID=<%=idInt+1%>">Suivant --></a><br/>
<%
	}
%>
</body>
</html>