<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%@ page import="org.*"%>

<!DOCTYPE HTML>
<!--
	Verti by HTML5 UP
	html5up.net | @ajlkn
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->
<html>
<head>
<title>LISTE DES ATHLETES EN RETARD DE PAIEMENT</title>
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

					<script src="assets/js/scriptExcel_Liste_Athletes_non_Payes.js"></script>
					<h2
						style="color: white; background-color: #6683b1; text-align: center">Liste
						des athlètes en retard de paiement</h2>
					<table border="1">
						<tr>
							<!-- ligne1 -->
							<th>Identifiant</th>
							<!-- case 1 -->
							<th>Nom</th>
							<!-- case 2 -->
							<th>Prénom</th>
							<!-- case 3 -->
						</tr>
						<%
							ATHLETE myAthlete = null;
							ArrayList<Object> athletes = DBManager.getATHLETE_non_payes();
							int athletesSize = athletes.size();
						%>
							<script>
							for (var i=1;i < <%=athletesSize%>;i++) excel_Athletes_non_Payes.set({row:i, style: i%2==0 ? evenRow: oddRow  });
							</script>
						<%
							for (int i = 0; i < athletes.size(); i++) {
								myAthlete = DBManager.getATHLETE((Integer) (athletes.get(i)));

								String link_athlete_paiement = "paiement.jsp?ID=" + myAthlete.ID;
						%>
						<tr>
							<!-- ligne i -->
							<th><a href=<%=link_athlete_paiement%>><%=myAthlete.ID%></a>
							</th>
							<!-- case 1 -->
							<th><%=myAthlete.NOM%></th>
							<!-- case 2 -->
							<th><%=myAthlete.PRENOM%></th>
							<!-- case 3 -->
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
					<br /> <br /> <input type="button" id="exportbtn" value="Exporter la liste"
						onclick="download_Athletes_non_Payes('Liste_Athletes_non_Payes.xlsx');" />
					<script src="assets/js/myScripts.js"></script>

					<br /> <br /> <br />
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