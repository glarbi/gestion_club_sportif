<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%@ page import="org.*"%>
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
<title>LISTE DES ENTRAINEURS</title>
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
					<form name="entraineurForm" method="get"
						style="width: 50%; margin: auto; background-color: #c1d9fc; padding-bottom: 15px;">
						<div>
							<h2 style="color: white; background-color: #6683b1; text-align: center">CHERCHER UN ENTRAINEUR</h2>
							Nom : <input type="text" name="nom" style="color: graytext" align="right" />
							Prenom : <input type="text" name="prenom" style="color: graytext" align="right" />
							ID : <input type="text" name="id" style="color: graytext" value="0" align="right" />
							</br>
							<div style="width: 50%; margin: auto;">
								<input type="submit" name="OK" value="OK" />&emsp;&emsp;&emsp;&emsp;
								<input type="reset">
							</div>
						</div>
					</form>
					<br />
					<input type="button" id="exportbtn" value="Exporter la liste" onclick="download_Entraineur('Liste_Antraineurs.xlsx');" />
					<script src="assets/js/myScripts.js"></script>
					<script src="assets/js/scriptExcel_Liste_Entraineurs.js"></script>
					<br /> <br />

					<table border="1">
						<caption>
							<h2
								style="color: white; background-color: #6683b1; text-align: center">Liste
								des entraineurs</h2>
						</caption>
						<tr>
							<!-- ligne1 -->
							<th>Identifiant</th>
							<!-- case 1 -->
							<th>Nom</th>
							<!-- case 2 -->
							<th>Prénom</th>
							<!-- case 3 -->
							<th>Paiement</th>
							<!-- case 4 -->
							<th>Assurance</th>
							<!-- case 5 -->
							<th>Date de naissance</th>
							<!-- case 6 -->
							<th>Lieu de naissance</th>
							<!-- case 7 -->
							<th>Adresse</th>
							<!-- case 8 -->
							<th>Téléphone</th>
							<!-- case 9 -->
							<th>Date d'inscription</th>
							<!-- case 10 -->
						</tr>
						<%
							ENTRAINEUR myEntraineur = new ENTRAINEUR();

							String t1 = request.getParameter("id");
							String t2 = request.getParameter("nom");
							String t3 = request.getParameter("prenom");
							if (t1 == null && t2 == null && t3 == null) {
								myEntraineur.ID = "0";
								myEntraineur.NOM = "";
								myEntraineur.PRENOM = "";
							} else {
								if (t1 != null)
									myEntraineur.ID = t1;
								if (t2 != null)
									myEntraineur.NOM = t2;
								if (t3 != null)
									myEntraineur.PRENOM = t3;
							}

							ArrayList<ArrayList<Object>> entraineurs = null;
							if (myEntraineur.ID == "0" && myEntraineur.NOM.isEmpty() && myEntraineur.PRENOM.isEmpty())
								entraineurs = DBManager.getENTRAINEUR(0, "", "");
							else {
								try {
									entraineurs = DBManager.getENTRAINEUR(Integer.parseInt(myEntraineur.ID), myEntraineur.NOM,
											myEntraineur.PRENOM);
								} catch (java.lang.NumberFormatException e) {
									System.out.println("Exception : " + e.getMessage());
								}
							}
							int entraineursSize = entraineurs.size();
						%>
						<script>
						for (var i=1;i < <%=entraineursSize%>;i++) excel_Entraineurs.set({row:i,style: i%2==0 ? evenRow: oddRow  });
						</script>
						<%
							ArrayList<Object> ligne1 = null;
							for (int i = 0; i < entraineursSize; i++) {
								ligne1 = entraineurs.get(i);
								myEntraineur.ID = ligne1.get(0).toString();
								myEntraineur.NOM = ligne1.get(1).toString();
								myEntraineur.PRENOM = ligne1.get(2).toString();
								myEntraineur.DATE_NAIS = ligne1.get(3).toString();
								myEntraineur.LIEU_NAIS = ligne1.get(4).toString();
								myEntraineur.ADRESSE = ligne1.get(5).toString();
								myEntraineur.NUM_TEL = ligne1.get(6).toString();
								myEntraineur.DATE_INSCRIPTION = ligne1.get(7).toString();

								String link_entraineur = "entraineur.jsp?ID=" + myEntraineur.ID;
								String link_entraineur_paiement = "paiement.jsp?ID=" + myEntraineur.ID;
								String link_entraineur_assurance = "assurance.jsp?ID=" + myEntraineur.ID;

								LocalDate d = LocalDate.now();
								DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-");

								String paiement = "";
								String paiementToExcel = "";
								try {
									String date = d.format(formatter);
									if (DBManager.check_PAIEMENT(Integer.parseInt(myEntraineur.ID), date + "01")) {
										paiement = "OK";
										paiementToExcel = "OK";
									} else {
										paiement = "<font color=\"red\">Non payé</font>";
										paiementToExcel = "no OK";
									}
								} catch (java.lang.NumberFormatException e) {
									System.out.println("Exception : " + e.getMessage());
								}
								String assurance = "";
								String assuranceToExcel = "";
								try {
									if (DBManager.check_ASSURANCE(Integer.parseInt(myEntraineur.ID), d)) {
										assurance = "OK";
										assuranceToExcel = "OK";
									} else {
										assurance = "<font color=\"red\">Non assuré</font>";
										assuranceToExcel = "no OK";
									}
								} catch (java.lang.NumberFormatException e) {
									System.out.println("Exception : " + e.getMessage());
								}
						%>
						<tr>
							<!-- ligne i -->
							<th><a href=<%=link_entraineur%>><%=myEntraineur.ID%></a></th>
							<!-- case 1 -->
							<th><%=myEntraineur.NOM%></th>
							<!-- case 2 -->
							<th><%=myEntraineur.PRENOM%></th>
							<!-- case 3 -->
							<th><a href=<%=link_entraineur_paiement%>><%=paiement%></a>
							</th>
							<!-- case 4 -->
							<th><a href=<%=link_entraineur_assurance%>><%=assurance%></a>
							</th>
							<!-- case 5 -->
							<th><%=myEntraineur.DATE_NAIS%></th>
							<!-- case 4 -->
							<th><%=myEntraineur.LIEU_NAIS%></th>
							<!-- case 5 -->
							<th><%=myEntraineur.ADRESSE%></th>
							<!-- case 6 -->
							<th><%=myEntraineur.NUM_TEL%></th>
							<!-- case 7 -->
							<th><%=myEntraineur.DATE_INSCRIPTION%></th>
							<!-- case 8 -->
						</tr>
						<script>
						excel_Entraineurs.set(0,0,<%=i%>+1,"<%=myEntraineur.ID%>");
						excel_Entraineurs.set(0,1,<%=i%>+1,"<%=myEntraineur.NOM%>");
						excel_Entraineurs.set(0,2,<%=i%>+1,"<%=myEntraineur.PRENOM%>");
						excel_Entraineurs.set(0,3,<%=i%>+1,"<%=paiementToExcel%>");
						excel_Entraineurs.set(0,4,<%=i%>+1,"<%=assuranceToExcel%>");
						excel_Entraineurs.set(0,5,<%=i%>+1,"<%=myEntraineur.DATE_NAIS%>");
						excel_Entraineurs.set(0,6,<%=i%>+1,"<%=myEntraineur.LIEU_NAIS%>");
						excel_Entraineurs.set(0,7,<%=i%>+1,"<%=myEntraineur.ADRESSE%>");
						excel_Entraineurs.set(0,8,<%=i%>+1,"<%=myEntraineur.NUM_TEL%>");
						excel_Entraineurs.set(0,9,<%=i%>+1,"<%=myEntraineur.DATE_INSCRIPTION%>");
	    				</script>
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