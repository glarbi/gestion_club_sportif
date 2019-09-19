<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%@ page import="org.*"%>
<%@ page import="java.time.*"%>

<!DOCTYPE HTML>
<!--
	Verti by HTML5 UP
	html5up.net | @ajlkn
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->
<html>
<head>
<title>LISTE DES ENTRAINEURS NON ASSURES</title>
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
					<h2
						style="color: white; background-color: #6683b1; text-align: center">Liste
						des entraineurs non assurés</h2>
					<table border="1">
						<tr>
							<!-- ligne1 -->
							<th>Identifiant</th>
							<!-- case 1 -->
							<th>Nom</th>
							<!-- case 2 -->
							<th>Prénom</th>
							<!-- case 3 -->
							<th>Depuis</th>
							<!-- case 4 -->
							<th>Jusqu'au</th>
							<!-- case 5 -->
						</tr>
						<%
							ENTRAINEUR myEntraineur = null;
							ArrayList<ArrayList<Object>> entraineurs = null;
							ArrayList<Object> ligne1 = null;
							String debut = "";
							String fin = "";
							entraineurs = DBManager.getENTRAINEUR_non_assures();
							for (int i = 0; i < entraineurs.size(); i++) {
								ligne1 = entraineurs.get(i);
								myEntraineur = DBManager.getENTRAINEUR(Integer.valueOf(ligne1.get(0).toString()));
								debut = ligne1.get(1).toString();
								fin = ligne1.get(2).toString();

								String link_entraineur_assurance = "assurance.jsp?ID=" + myEntraineur.ID;

								//java.util.Date d = new java.util.Date();
								LocalDate d = LocalDate.now();
								String assurance = "";
								try {
									if (DBManager.check_ASSURANCE(Integer.parseInt(myEntraineur.ID), d))
										assurance = "OK";
									else
										assurance = "<font color=\"red\">Non assuré</font>";
								} catch (java.lang.NumberFormatException e) {
									System.out.println("Exception : " + e.getMessage());
								}
						%>
						<tr>
							<!-- ligne i -->
							<th><a href=<%=link_entraineur_assurance%>><%=myEntraineur.ID%></a>
							</th>
							<!-- case 1 -->
							<th><%=myEntraineur.NOM%></th>
							<!-- case 2 -->
							<th><%=myEntraineur.PRENOM%></th>
							<!-- case 3 -->
							<th><%=debut%></th>
							<!-- case 4 -->
							<th><%=fin%></th>
							<!-- case 5 -->
						</tr>
						<%
							}
						%>
					</table>
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