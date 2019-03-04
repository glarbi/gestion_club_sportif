<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="org.*"%>

<!DOCTYPE HTML>
<!--
	Verti by HTML5 UP
	html5up.net | @ajlkn
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->
<html>
<head>
<title>CREATION DES TABLES</title>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, user-scalable=no" />
<link rel="stylesheet" href="assets/css/main.css" />
<script type="text/javascript" src="jszip.js"></script>
<script type="text/javascript" src="FileSaver.js"></script>
<script type="text/javascript" src="myexcel.js"></script>
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
					<span>Chabab Riadhi M�dine de Batna</span>
				</div>

				<!-- Nav -->
				<nav id="nav">
					<ul>
						<li class="current"><a href="index.html">Principale</a></li>
						<li><a href="#">Athl�tes</a>
							<ul>
								<li><a href="liste_athletes.jsp">Liste des athl�tes</a></li>
								<li><a href="liste_athletes_non_assures.jsp">Liste des
										athl�tes non assur�s</a></li>
								<li><a href="liste_athletes_non_payes.jsp">Liste des
										athl�tes en retard de paiement</a></li>
								<li><a href="athlete.jsp">Cr�er un nouveau dossier
										d'athl�te</a></li>
							</ul></li>
						<li><a href="#">Entraineurs</a>
							<ul>
								<li><a href="liste_entraineurs.jsp">Liste des
										entraineurs</a></li>
								<li><a href="liste_entraineurs_non_assures.jsp">Liste
										des entraineurs non assur�s</a></li>
								<li><a href="entraineur.jsp">Cr�er un nouveau dossier
										d'entraineurs</a></li>
							</ul></li>
						<li><a href="create_tables.jsp">Cr�ation de la BDD</a></li>
					</ul>
				</nav>
			</header>
		</div>

		<!-- Main -->
		<div id="main-wrapper">
			<div class="container">
				<div id="content">
					<%
						int ret = DBManager.creatTables();
						if (ret == 0) {
					%>
					<font color="blue" , size="5"> Tables cr��es avec succ�s dans
						la base de donn�es ou d�j� cr��es. <br /> <br />
					</font> <a href="index.html">Retour � la page d'acceuil</a>
					<%
						} else {
					%>
					<font color="red" , size="5"> Tables d�j� cr��es ou Probl�me
						de c�ration des tables dans la base de donn�es.<br /> <br /> <br />
					</font> <a href="index.html">Retour � la page d'acceuil</a>
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