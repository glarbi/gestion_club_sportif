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
<title>Cr�ation des tables</title>
</head>
<body>
<%
int ret = DBManager.creatTables();
if (ret == 0)
{
%>
	<font color="blue", size="5">
		Tables cr�es avec succ�s dans la base de donn�es.
		<br/><br/>
	</font>
	<a href="index.jsp">Retour � la page d'acceuil</a>
<%
}
else
{
%>
	<font color="red", size="5">
		Probl�me de c�ration des tables dans la base de donn�es.<br/>
		<br/><br/>
	</font>
	<a href="index.jsp">Retour � la page d'acceuil</a>
<%
}
%>
</body>
</html>