<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="org.*" %>

<html>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Page d'assurance</title>
</head>
<body>
<%
	List<Integer> dayList = new ArrayList<Integer>();
	for (int i=0; i<31; i++)
		dayList.add(i, Integer.valueOf(i+1));
	
	List<Integer> monthList = new ArrayList<Integer>();
	for (int i=0; i<12; i++)
		monthList.add(i, Integer.valueOf(i+1));
	
	List<Integer> yearList = new ArrayList<Integer>();
	for (int i=0; i<30; i++)
		yearList.add(i, Integer.valueOf(i+1990));

	PERSONNE myPersonne = new PERSONNE("_", "_", "_", "01/01/1990", "_", "_", "_", "01/01/1990");
	String idStr = request.getParameter("ID");
	Integer idInt = null;
	if (idStr == null)
		idInt = 0;
	else {
		try {
			idInt = Integer.parseInt(idStr);
		} catch(java.lang.NumberFormatException e) {
			System.out.println("Exception : " + e.getMessage());
		}
	}
	
	Integer day_begin = 1;
	Integer month_begin = 1;
	Integer year_begin = 1990;
	Integer day_end = 1;
	Integer month_end = 1;
	Integer year_end = 1990;

	if (idInt > 0) {
		ArrayList<Object> assurance = DBManager.get_ASSURANCE(idInt);
		if (assurance.size() > 0)
		{
			String debut = (String)assurance.get(0);
			year_begin = Integer.valueOf(debut.substring(0,4));
			month_begin = Integer.valueOf(debut.substring(5,7));
			day_begin = Integer.valueOf(debut.substring(8,10));
			String fin = (String)assurance.get(1);
			year_end = Integer.valueOf(fin.substring(0,4));
			month_end = Integer.valueOf(fin.substring(5,7));
			day_end = Integer.valueOf(fin.substring(8,10));
		}
	}

	String tmp = null;
	
	tmp = request.getParameter("Day_begin");
	if (tmp != null) day_begin = Integer.valueOf(tmp);
	tmp = request.getParameter("Month_begin");
	if (tmp != null) month_begin = Integer.valueOf(tmp);
	tmp = request.getParameter("Year_begin");
	if (tmp != null) year_begin = Integer.valueOf(tmp);
	tmp = request.getParameter("Day_end");
	if (tmp != null) day_end = Integer.valueOf(tmp);
	tmp = request.getParameter("Month_end");
	if (tmp != null) month_end = Integer.valueOf(tmp);
	tmp = request.getParameter("Year_end");
	if (tmp != null) year_end = Integer.valueOf(tmp);
	
	if (!(day_begin == 1 && month_begin == 1 && year_begin == 1990 &&
		day_end == 1 && month_end == 1 && year_end == 1990))
	{
		DBManager.set_ASSURANCE(idInt, year_begin.toString()+"/"+month_begin.toString()+"/"+day_begin.toString(),
				year_end.toString()+"/"+month_end.toString()+"/"+day_end.toString());
	}

	if (idStr != null) {
		ArrayList<ArrayList<Object>> myList = null;
		if (idInt <= 10)
		{
			myList = DBManager.getENTRAINEUR(idInt, "", "");
			if (myList.isEmpty())
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
			ArrayList<Object> ligne1 = myList.get(0);
			myPersonne.ID =		ligne1.get(0).toString();
			myPersonne.NOM =	ligne1.get(1).toString();
			myPersonne.PRENOM =	ligne1.get(2).toString();
		}
	}
	ArrayList<Object> assurance = DBManager.get_ASSURANCE(idInt);
	if (assurance.size() > 0)
	{
		String debut = (String)assurance.get(0);
		year_begin = Integer.valueOf(debut.substring(0,4));
		month_begin = Integer.valueOf(debut.substring(5,7));
		day_begin = Integer.valueOf(debut.substring(8,10));
		String fin = (String)assurance.get(1);
		year_end = Integer.valueOf(fin.substring(0,4));
		month_end = Integer.valueOf(fin.substring(5,7));
		day_end = Integer.valueOf(fin.substring(8,10));
	}
%>
	<form name="AssuranceForm" method="get"
             style="width:50%;margin:auto;background-color:#c1d9fc;padding-bottom:15px;">
<%
	if (idInt<=10)
	{
%>
	<p align="center"><B>Information sur l'assurance de l'entraineur</B></p>
<%
	}
	else
	{
%>
	<p align="center"><B>Information sur l'assurance de l'athlète</B></p>
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
				<p align="left">Date début : </p>
			</th>
			<th>
			    Jour :
				<select name = "Day_begin">
<%
for (int i=0; i<dayList.size(); i++)
{
	if (day_begin.equals(dayList.get(i)))
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
				<select name = "Month_begin">
<%
for (int i=0; i<monthList.size(); i++)
{
	if (month_begin.equals(monthList.get(i)))
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
				<select name = "Year_begin">
<%
for (int i=0; i<yearList.size(); i++)
{
	if (year_begin.equals(yearList.get(i)))
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
				<p align="left">Date fin : </p>
			</th>
			<th>
			    Jour :
				<select name = "Day_end">
<%
for (int i=0; i<dayList.size(); i++)
{
	if (day_end.equals(dayList.get(i)))
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
				<select name = "Month_end">
<%
for (int i=0; i<monthList.size(); i++)
{
	if (month_end.equals(monthList.get(i)))
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
				<select name = "Year_end">
<%
for (int i=0; i<yearList.size(); i++)
{
	if (year_end.equals(yearList.get(i)))
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
		<a href="assurance.jsp?ID=<%=idInt+1%>">Suivant --></a><br/>
<%
	}
%>
</body>
</html>