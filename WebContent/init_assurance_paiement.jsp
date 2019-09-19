<%@ page import="org.*"%>


<!DOCTYPE HTML>
<!--
	Verti by HTML5 UP
	html5up.net | @ajlkn
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->
<html>
<head>
	<title>INITIALISATION DES ASSURANCES ET PAIEMENT DES ATHLETES</title>
	<meta charset="utf-8" />
	<meta name="viewport"
		content="width=device-width, initial-scale=1, user-scalable=no" />
	<link rel="stylesheet" href="assets/css/main.css" />
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
								<li><a href="init_assurance_paiement.jsp">Réinitialiser les assurances et paiement des athlètes</a></li>
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
					Cette page permet d'initialiser les assurances et les paiements des athlètes. C'est util au début de la saison sportive.<br>
					<button type="button" onclick=<%DBManager.init_for_all_ASSURANCE_PAIEMENT();%>>Réinitialiser</button>
				</div>
			</div>
		</div>
	</div>

</body>
</html>