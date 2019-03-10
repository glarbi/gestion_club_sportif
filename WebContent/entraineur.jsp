<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%@ page import="org.*"%>
<%@ page import="java.util.StringTokenizer"%>
<%@ page import="java.time.*"%>
<%@ page import="java.time.format.DateTimeFormatter"%>

<!DOCTYPE HTML>
<!--
	Verti by HTML5 UP
	html5up.net | @ajlkn
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->
<html>
<head>
<title>PAGE ENTRAINEUR</title>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, user-scalable=no" />
<link rel="stylesheet" href="assets/css/main.css" />
<script type="text/javascript" src="assets/js/jszip.js"></script>
<script type="text/javascript" src="assets/js/FileSaver.js"></script>
<script type="text/javascript" src="assets/js/myexcel.js"></script>
</head>
<body class="is-preload no-sidebar">
	<div id="page-wrapper">
		<!-- Header -->
		<div id="header-wrapper">
			<header id="header" class="container">

				<!-- Logo -->
				<div id="logo">
					<h1>
						<a href="index.html">CRMB</a>
					</h1>
					<span>Chabab Riadhi Médine de Batna</span>
				</div>

				<!-- Nav -->
				<nav id="nav">
					<ul>
						<li class="current"><a href="index.html">Principale</a></li>
						<li><a href="#">Athlètes</a>
							<ul>
								<li><a href="liste_athletes.jsp">Liste des athlètes</a></li>
								<li><a href="liste_athletes_non_assures.jsp">Liste des
										athlètes non assurés</a></li>
								<li><a href="liste_athletes_non_payes.jsp">Liste des
										athlètes en retard de paiement</a></li>
								<li><a href="athlete.jsp">Créer un nouveau dossier
										d'athlète</a></li>
							</ul></li>
						<li><a href="#">Entraineurs</a>
							<ul>
								<li><a href="liste_entraineurs.jsp">Liste des
										entraineurs</a></li>
								<li><a href="liste_entraineurs_non_assures.jsp">Liste
										des entraineurs non assurés</a></li>
								<li><a href="entraineur.jsp">Créer un nouveau dossier
										d'entraineurs</a></li>
							</ul></li>
						<li><a href="create_tables.jsp">Création de la BDD</a></li>
					</ul>
				</nav>
			</header>
		</div>

		<!-- Main -->
		<div id="main-wrapper">
			<div class="container">
				<div id="content">

					<%
						List<Integer> dayList = new ArrayList<Integer>();
						for (int i = 0; i < 31; i++)
							dayList.add(i, Integer.valueOf(i + 1));

						List<Integer> monthList = new ArrayList<Integer>();
						for (int i = 0; i < 12; i++)
							monthList.add(i, Integer.valueOf(i + 1));

						List<Integer> yearList = new ArrayList<Integer>();
						for (int i = 0; i < 90; i++)
							yearList.add(i, Integer.valueOf(i + 1940));

						Integer day_naissance = 1;
						Integer month_naissance = 1;
						Integer year_naissance = 1;
						Integer day_inscription = 1;
						Integer month_inscription = 1;
						Integer year_inscription = 1;
						String tmp = null;

						tmp = request.getParameter("Day_naissance");
						if (tmp != null)
							day_naissance = Integer.valueOf(tmp);
						tmp = request.getParameter("Month_naissance");
						if (tmp != null)
							month_naissance = Integer.valueOf(tmp);
						tmp = request.getParameter("Year_naissance");
						if (tmp != null)
							year_naissance = Integer.valueOf(tmp);
						tmp = request.getParameter("Day_inscription");
						if (tmp != null)
							day_inscription = Integer.valueOf(tmp);
						tmp = request.getParameter("Month_inscription");
						if (tmp != null)
							month_inscription = Integer.valueOf(tmp);
						tmp = request.getParameter("Year_inscription");
						if (tmp != null)
							year_inscription = Integer.valueOf(tmp);

						String t1 = request.getParameter("ID");
						String t2 = request.getParameter("Nom");
						String t3 = request.getParameter("Prenom");
						String t4 = year_naissance.toString() + "-" + month_naissance.toString() + "-" + day_naissance.toString();
						String t5 = request.getParameter("LieuNais");
						String t6 = request.getParameter("Adresse");
						String t7 = request.getParameter("Tel");
						String t8 = year_inscription.toString() + "-" + month_inscription.toString() + "-"
								+ day_inscription.toString();

						if ((t1 != null && t2 != null && t3 != null && t5 != null && t6 != null && t7 != null && (!t1.isEmpty()
								&& !t2.isEmpty() && !t3.isEmpty() && !t5.isEmpty() && !t6.isEmpty() && !t7.isEmpty()))) {
							try {
								Integer t1int = Integer.parseInt(t1);
								DBManager.setENTRAINEUR(t1int, t2, t3, t4, t5, t6, t7, t8);
								t1 = null; //Pour faire entrer un nouveau athlète
							} catch (java.lang.NumberFormatException e) {
								System.out.println("Exception : " + e.getMessage());
							}
						}

						if (t1 == null)
							t1 = DBManager.getFreeEntraineurID().toString();
						//java.util.Date date = new java.util.Date();
						LocalDate date = LocalDate.now();
						DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
						String d = date.format(formatter);
						//	String d = String.valueOf(date.getYear()+1900)+"-"+String.valueOf(date.getMonth()+1)+"-"+String.valueOf(date.getDate());
						ENTRAINEUR myEntraineur = new ENTRAINEUR(t1, "_", "_", "1940-01-01", "_", "_", "_", d);
						Integer day = null;
						Integer month = null;
						Integer year = null;
						Integer idInt = null;
						if (t1 == null)
							idInt = 0;
						else {
							try {
								idInt = Integer.parseInt(t1);
							} catch (java.lang.NumberFormatException e) {
								System.out.println("Exception : " + e.getMessage());
							}
						}
						if (t1 != null) {
							ArrayList<ArrayList<Object>> entraineurs = DBManager.getENTRAINEUR(idInt, "", "");
							if (entraineurs.size() > 0) {
								List<Object> ligne1 = entraineurs.get(0);
								myEntraineur.ID = ligne1.get(0).toString();
								myEntraineur.NOM = ligne1.get(1).toString();
								myEntraineur.PRENOM = ligne1.get(2).toString();
								myEntraineur.DATE_NAIS = ligne1.get(3).toString();
								myEntraineur.LIEU_NAIS = ligne1.get(4).toString();
								myEntraineur.ADRESSE = ligne1.get(5).toString();
								myEntraineur.NUM_TEL = ligne1.get(6).toString();
								myEntraineur.DATE_INSCRIPTION = ligne1.get(7).toString();
							}
						}
					%>
					<form name="entraineurForm" method="get"
						style="width: 50%; margin: auto; background-color: #c1d9fc; padding-bottom: 15px;">
						<p align="center">
						<h2>Informations de l'entraineur</h2>
						</p>
						<table>
							<tr>
								<th>
									<p align="left">Identifiant :</p>
								</th>
								<th>
									<p>
										<input type="text" name="ID" style="color: graytext"
											value="<%=myEntraineur.ID%>" size=25 align="right" />
									</p>
								</th>
							</tr>
							<tr>
								<th>
									<p align="left">Nom de l'entraineur :</p>
								</th>
								<th>
									<p>
										<input type="text" name="Nom" style="color: graytext"
											value="<%=myEntraineur.NOM%>" size=25 align="right" />
									</p>
								</th>
							</tr>
							<tr>
								<th>
									<p align="left">Prénom de l'entraineur :</p>
								</th>
								<th>
									<p>
										<input type="text" name="Prenom" style="color: graytext"
											value="<%=myEntraineur.PRENOM%>" size=25 align="right" />
									</p>
								</th>
							</tr>
							<tr>
								<th>
									<p align="left">Date de naissance :</p>
								</th>
								<th>Jour : <%
									StringTokenizer st1 = new StringTokenizer(myEntraineur.DATE_NAIS, "-");
									if (st1.hasMoreTokens())
										year = Integer.valueOf(st1.nextToken());
									if (st1.hasMoreTokens())
										month = Integer.valueOf(st1.nextToken());
									if (st1.hasMoreTokens())
										day = Integer.valueOf(st1.nextToken());
								%> <select name="Day_naissance">
										<%
											for (int i = 0; i < dayList.size(); i++) {
												if (day.equals(dayList.get(i))) {
										%>
										<option value=<%=i + 1%> selected><%=dayList.get(i)%></option>
										<%
											} else {
										%>
										<option value=<%=i + 1%>><%=dayList.get(i)%></option>
										<%
											}
											}
										%>
								</select> Mois : <select name="Month_naissance">
										<%
											for (int i = 0; i < monthList.size(); i++) {
												if (month.equals(monthList.get(i))) {
										%>
										<option value=<%=i + 1%> selected><%=monthList.get(i)%></option>
										<%
											} else {
										%>
										<option value=<%=i + 1%>><%=monthList.get(i)%></option>
										<%
											}
											}
										%>
								</select> Année : <select name="Year_naissance">
										<%
											for (int i = 0; i < yearList.size(); i++) {
												if (year.equals(yearList.get(i))) {
										%>
										<option value=<%=1940 + i%> selected><%=yearList.get(i)%></option>
										<%
											} else {
										%>
										<option value=<%=1940 + i%>><%=yearList.get(i)%></option>
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
									<p>
										<input type="text" name="LieuNais" style="color: graytext"
											value="<%=myEntraineur.LIEU_NAIS%>" size=25 align="right" />
									</p>
								</th>
							</tr>
							<tr>
								<th>
									<p align="left">Adresse :</p>
								</th>
								<th>
									<p>
										<input type="text" name="Adresse" style="color: graytext"
											value="<%=myEntraineur.ADRESSE%>" size=25 align="right" />
									</p>
								</th>
							</tr>
							<tr>
								<th>
									<p align="left">Téléphone :</p>
								</th>
								<th>
									<p>
										<input type="text" name="Tel" style="color: graytext"
											value="<%=myEntraineur.NUM_TEL%>" size=25 align="right" />
									</p>
								</th>
							</tr>
							<tr>
								<th>
									<p align="left">Date d'inscription :</p>
								</th>
								<th>Jour : <%
									st1 = new StringTokenizer(myEntraineur.DATE_INSCRIPTION, "-");
									if (st1.hasMoreTokens())
										year = Integer.valueOf(st1.nextToken());
									if (st1.hasMoreTokens())
										month = Integer.valueOf(st1.nextToken());
									if (st1.hasMoreTokens())
										day = Integer.valueOf(st1.nextToken());
								%> <select name="Day_inscription">
										<%
											for (int i = 0; i < dayList.size(); i++) {
												if (day.equals(dayList.get(i))) {
										%>
										<option value=<%=i + 1%> selected><%=dayList.get(i)%></option>
										<%
											} else {
										%>
										<option value=<%=i + 1%>><%=dayList.get(i)%></option>
										<%
											}
											}
										%>
								</select> Mois : <select name="Month_inscription">
										<%
											for (int i = 0; i < monthList.size(); i++) {
												if (month.equals(monthList.get(i))) {
										%>
										<option value=<%=i + 1%> selected><%=monthList.get(i)%></option>
										<%
											} else {
										%>
										<option value=<%=i + 1%>><%=monthList.get(i)%></option>
										<%
											}
											}
										%>
								</select> Année : <select name="Year_inscription">
										<%
											for (int i = 0; i < yearList.size(); i++) {
												if (year.equals(yearList.get(i))) {
										%>
										<option value=<%=1940 + i%> selected><%=yearList.get(i)%></option>
										<%
											} else {
										%>
										<option value=<%=1940 + i%>><%=yearList.get(i)%></option>
										<%
											}
											}
										%>
								</select>
								</th>
							</tr>
						</table>
						<p style="width: 50%; margin: auto;" align="center">
							<INPUT type="submit" name="OK" value="OK" /> <INPUT type="reset">
						</p>
					</form>
					<br />
					<%
						if (!myEntraineur.ID.equals(DBManager.getFreeEntraineurID().toString())) {
					%>
					<a
						href="entraineur.jsp?ID=<%=Integer.parseInt(myEntraineur.ID) + 1%>">Suivant
						--></a> <br />
					<%
						}
					%>
				</div>
			</div>
		</div>
		<!-- Scripts -->

		<script src="assets/js/jquery.min.js"></script>
		<script src="assets/js/jquery.dropotron.min.js"></script>
		<script src="assets/js/browser.min.js"></script>
		<script src="assets/js/breakpoints.min.js"></script>
		<script src="assets/js/util.js"></script>
		<script src="assets/js/main.js"></script>
</body>
</html>