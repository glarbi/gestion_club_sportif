<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="org.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<!--
<meta http-equiv="refresh" content="0;url=index.jsp">
 -->
<title>Création des tables</title>
</head>
<body>
<%
int ret = DBManager.creatTables();
if (ret == 0)
{
%>
	<font color="blue", size="5">
		Tables crées avec succès dans la base de données.
		<br/><br/>
	</font>
	<a href="index.jsp">Retour à la page d'acceuil</a>
<%
}
else
{
%>
	<font color="red", size="5">
		Problème de cération des tables dans la base de données.<br/>
		<br/><br/>
	</font>
	<a href="index.jsp">Retour à la page d'acceuil</a>
<%
}
%>
</body>
</html>