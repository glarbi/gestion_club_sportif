<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="org.*" %>
<%@ page import="java.util.StringTokenizer" %>

<html>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Page athlète</title>
</head>
<body>
<%
	List dayList = new ArrayList();
	for (int i=0; i<31; i++)
		dayList.add(i, Integer.valueOf(i+1));
	
	List monthList = new ArrayList();
	for (int i=0; i<12; i++)
		monthList.add(i, Integer.valueOf(i+1));
	
	List yearList = new ArrayList();
	for (int i=0; i<30; i++)
		yearList.add(i, Integer.valueOf(i+1990));
	Integer day_naissance = 1;
	Integer month_naissance = 1;
	Integer year_naissance = 1;
	Integer day_inscription = 1;
	Integer month_inscription = 1;
	Integer year_inscription = 1;
	String tmp = null;
	
	tmp = request.getParameter("Day_naissance");
	if (tmp != null) day_naissance = Integer.valueOf(tmp);
	tmp = request.getParameter("Month_naissance");
	if (tmp != null) month_naissance = Integer.valueOf(tmp);
	tmp = request.getParameter("Year_naissance");
	if (tmp != null) year_naissance = Integer.valueOf(tmp);
	tmp = request.getParameter("Day_inscription");
	if (tmp != null) day_inscription = Integer.valueOf(tmp);
	tmp = request.getParameter("Month_inscription");
	if (tmp != null) month_inscription = Integer.valueOf(tmp);
	tmp = request.getParameter("Year_inscription");
	if (tmp != null) year_inscription = Integer.valueOf(tmp);

	String t1 = request.getParameter("ID");
	String t2 = request.getParameter("Nom");
	String t3 = request.getParameter("Prenom");
	String t4 = year_naissance.toString()+"-"+month_naissance.toString()+"-"+day_naissance.toString();
	String t5 = request.getParameter("LieuNais");
	String t6 = request.getParameter("PrenomPere");
	String t7 = request.getParameter("ProfPere");
	String t8 = request.getParameter("NomMere");
	String t9 = request.getParameter("PrenomMere");
	String t10 = request.getParameter("ProfMere");
	String t11 = request.getParameter("Adresse");
	String t12 = request.getParameter("Tel");
	String t13 = year_inscription.toString()+"-"+month_inscription.toString()+"-"+day_inscription.toString();

	if ((t1!=null && t2!=null && t3!=null && t5!=null && t6!=null && t7!=null && t8!=null && t9!=null && t10!=null && t11!=null && t12!=null &&
		(!t1.isEmpty() && !t2.isEmpty() && !t3.isEmpty() && !t5.isEmpty() && !t6.isEmpty() && !t7.isEmpty() && !t8.isEmpty() && !t9.isEmpty() && !t10.isEmpty() && !t11.isEmpty() && !t12.isEmpty())))
	{
		try {
			Integer t1int = Integer.parseInt(t1);
			DBManager.setATHLETE(t1int, t2, t3, t4, t5, t6, t7, t8, t9, t10, t11, t12, t13);
			t1 = null; //Pour faire entrer un nouveau athlète
		} catch(java.lang.NumberFormatException e) {
			System.out.println("Exception : " + e.getMessage());
		}
	}
	else
	{
%>
	<a href="javascript:alert('Message d\'alerte \nAu feu!!');">Test</a>
		Données manquantes!!!
<%
	}

	if (t1==null) t1 = DBManager.getFreeAthleteID().toString();
	java.util.Date date = new java.util.Date();
	String d = String.valueOf(date.getYear()+1900)+"-"+String.valueOf(date.getMonth()+1)+"-"+String.valueOf(date.getDate());
	ATHLETE myAthlete = new ATHLETE(t1, "_", "_", "1990-01-01", "_", "_", "_", d, "_", "_", "_", "_", "_");
	Integer day = null;
	Integer month = null;
	Integer year = null;
	Integer idInt = null;
	if (t1 == null)
		idInt = 0;
	else {
		try {
			idInt = Integer.parseInt(t1);
		} catch(java.lang.NumberFormatException e) {
			System.out.println("Exception : " + e.getMessage());
		}
	}
	if (t1 != null) {
		ArrayList athletes = DBManager.getATHLETE(idInt, "", "");
		if (athletes.size() > 0){
			List ligne1 = (List)(athletes.get(0));
			myAthlete.ID =					ligne1.get(0).toString();
			myAthlete.NOM =					ligne1.get(1).toString();
			myAthlete.PRENOM =				ligne1.get(2).toString();
			myAthlete.DATE_NAIS =			ligne1.get(3).toString();
			myAthlete.LIEU_NAIS =			ligne1.get(4).toString();
			myAthlete.prenomPere =			ligne1.get(5).toString();
			myAthlete.profPere =			ligne1.get(6).toString();
			myAthlete.nomMere =				ligne1.get(7).toString();
			myAthlete.prenomMere =			ligne1.get(8).toString();
			myAthlete.profMere =			ligne1.get(9).toString();
			myAthlete.ADRESSE =				ligne1.get(10).toString();
			myAthlete.NUM_TEL =				ligne1.get(11).toString();
			myAthlete.DATE_INSCRIPTION =	ligne1.get(12).toString();
		}
	}
%>
	<form name="athleteForm" method="get"
             style="width:50%;margin:auto;background-color:#c1d9fc;padding-bottom:15px;">
	<p align="center"><B>Information de l'athlète</B></p>
	<table>
		<tr>
			<th>
				<p align="left">Identifiant :</p>
			</th>
			<th>
				<p><input type="text" name="ID" style=color:graytext value="<%=myAthlete.ID%>" size=25 align="right" /></p>
			</th>
		</tr>
		<tr>
			<th>
				<p align="left">Nom de l'athlète :</p>
			</th>
			<th>
				<p><input type="text" name="Nom" style=color:graytext value="<%=myAthlete.NOM%>" size=25 align="right" /></p>
			</th>
		</tr>
		<tr>
			<th>
				<p align="left">Prénom de l'athlète :</p>
			</th>
			<th>
				<p><input type="text" name="Prenom" style=color:graytext value="<%=myAthlete.PRENOM%>" size=25 align="right" /></p>
			</th>
		</tr>
		<tr>
			<th>
				<p align="left">Date de naissance :</p>
			</th>
			<th>
			    Jour :
<%
			StringTokenizer st1 = new StringTokenizer(myAthlete.DATE_NAIS, "-");
			if (st1.hasMoreTokens()) year = Integer.valueOf(st1.nextToken());
			if (st1.hasMoreTokens()) month = Integer.valueOf(st1.nextToken());
			if (st1.hasMoreTokens()) day = Integer.valueOf(st1.nextToken());
%>
				<select name = "Day_naissance">
<%
for (int i=0; i<dayList.size(); i++)
{
	if (day.equals(dayList.get(i)))
	{
%>
					<option value=<%=i+1%> selected><%=dayList.get(i)%></option>
<%	
	}
	else
	{
%>
					<option value=<%=i+1%>><%=dayList.get(i)%></option>
<%	
	}
}
%>
				</select>
				Mois :
				<select name = "Month_naissance">
<%
for (int i=0; i<monthList.size(); i++)
{
	if (month.equals(monthList.get(i)))
	{
%>
					<option value=<%=i+1%> selected><%=monthList.get(i)%></option>
<%
	}
	else
	{
%>
					<option value=<%=i+1%>><%=monthList.get(i)%></option>
<%
	}
}
%>
				</select>
				Année :
				<select name = "Year_naissance">
<%
for (int i=0; i<yearList.size(); i++)
{
	if (year.equals(yearList.get(i)))
	{
%>
					<option value=<%=1990+i%> selected><%=yearList.get(i)%></option>
<%
	}
	else
	{
%>
					<option value=<%=1990+i%>><%=yearList.get(i)%></option>
<%
	}
}
%>
				</select>
			</th>
		</tr>
		<tr>
			<th>
				<p align="left">Lieu de naissance :</p>
			</th>
			<th>
				<p><input type="text" name="LieuNais" style=color:graytext value="<%=myAthlete.LIEU_NAIS%>" size=25 align="right" /></p>
			</th>
		</tr>
		<tr>
			<th>
				<p align="left">Prénom du père :</p>
			</th>
			<th>
				<p><input type="text" name="PrenomPere" style=color:graytext value="<%=myAthlete.prenomPere%>" size=25 align="right" /></p>
			</th>
		</tr>
		<tr>
			<th>
				<p align="left">Profession du père :</p>
			</th>
			<th>
				<p><input type="text" name="ProfPere" style=color:graytext value="<%=myAthlete.profPere%>" size=25 align="right" /></p>
			</th>
		</tr>
		<tr>
			<th>
				<p align="left">Nom de la mère :</p>
			</th>
			<th>
				<p><input type="text" name="NomMere" style=color:graytext value="<%=myAthlete.nomMere%>" size=25 align="right" /></p>
			</th>
		</tr>
		<tr>
			<th>
				<p align="left">Prénom de la mère :</p>
			</th>
			<th>
				<p><input type="text" name="PrenomMere" style=color:graytext value="<%=myAthlete.prenomMere%>" size=25 align="right" /></p>
			</th>
		</tr>
		<tr>
			<th>
				<p align="left">Profession de la mère :</p>
			</th>
			<th>
				<p><input type="text" name="ProfMere" style=color:graytext value="<%=myAthlete.profMere%>" size=25 align="right" /></p>
			</th>
		</tr>
		<tr>
			<th>
				<p align="left">Adresse :</p>
			</th>
			<th>
				<p><input type="text" name="Adresse" style=color:graytext value="<%=myAthlete.ADRESSE%>" size=25 align="right" /></p>
			</th>
		</tr>
		<tr>
			<th>
				<p align="left">Téléphone :</p>
			</th>
			<th>
				<p><input type="text" name="Tel" style=color:graytext value="<%=myAthlete.NUM_TEL%>" size=25 align="right" /></p>
			</th>
		</tr>
		<tr>
			<th>
				<p align="left">Date d'inscription :</p>
			</th>
			<th>
			    Jour :
<%
			st1 = new StringTokenizer(myAthlete.DATE_INSCRIPTION, "-");
			if (st1.hasMoreTokens()) year = Integer.valueOf(st1.nextToken());
			if (st1.hasMoreTokens()) month = Integer.valueOf(st1.nextToken());
			if (st1.hasMoreTokens()) day = Integer.valueOf(st1.nextToken());
%>
				<select name = "Day_inscription">
<%
for (int i=0; i<dayList.size(); i++)
{
	if (day.equals(dayList.get(i)))
	{
%>
					<option value=<%=i+1%> selected><%=dayList.get(i)%></option>
<%
	}
	else
	{
%>
					<option value=<%=i+1%>><%=dayList.get(i)%></option>
<%
	}
}
%>
				</select>
				Mois :
				<select name = "Month_inscription">
<%
for (int i=0; i<monthList.size(); i++)
{
	if (month.equals(monthList.get(i)))
	{
%>
					<option value=<%=i+1%> selected><%=monthList.get(i)%></option>
<%
	}
	else
	{
%>
					<option value=<%=i+1%>><%=monthList.get(i)%></option>
<%
	}
}
%>
				</select>
				Année :
				<select name = "Year_inscription">
<%
for (int i=0; i<yearList.size(); i++)
{
	if (year.equals(yearList.get(i)))
	{
%>
					<option value=<%=1990+i%> selected><%=yearList.get(i)%></option>
<%
	}
	else
	{
%>
					<option value=<%=1990+i%>><%=yearList.get(i)%></option>
<%
	}
}
%>
				</select>
			</th>
		</tr>
	</table>
    <p style="width:50%;margin:auto;" align="center">
    	<INPUT type="submit" name="OK" value="OK"/>
    	<INPUT type="reset">
    </p>
	</form>
	<a href="index.jsp">Retour à la page d'acceuil</a><br/>
	<a href="liste_athletes.jsp">Liste des athlètes</a><br/>
	<a href="liste_entraineurs.jsp">Liste des entraineurs</a><br/>
<%
	if (!myAthlete.ID.equals(DBManager.getFreeAthleteID().toString()))
	{
%>
		<a href="athlete.jsp?ID=<%=Integer.parseInt(myAthlete.ID)+1%>">Suivant --></a><br/>
<%
	}
%>
</body>
</html>