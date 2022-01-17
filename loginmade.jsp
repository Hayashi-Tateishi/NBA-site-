<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" import="java.sql.*"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%--

  データベースへのコネクションを取得

--%>
<sql:setDataSource driver="org.h2.Driver" url="jdbc:h2:sdev" />



<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<TITLE>新規作成画面</TITLE>
<%--

  表示方法の設定

--%>
<STYLE type="text/css">
body {background-color: #FFDAB9;
background-image: url("https://www.transparenttextures.com/patterns/dark-exa.png");
}
table {border-collapse:separate; border-spacing:2px; width:100%;}
th {background-color:#333333; align:center; font-size:large; font-weight:bold; color:white;}
td {background-color:#EFEFEF; font-size:normal; color:black;}
.name{
  font-family:Monotype Corsiva;
  font-size:120px;
  font-weight: 700;
  font-stretch: expanded;
  color:#000080;
}
.ho{
	font-size:x-large;
}
</STYLE>
</head>
<BODY>
		<H2>NBAグッズ通販サイト</H2>
		<CENTER>
		  <span class="name">D4C</span>
			<p style="text-align: right">
			 <font size="5">
				~NBAをもっと身近に~ &ensp;
			 </font>
			 </p>
		  <BR><BR>
		</CENTER>

<%--

  詳細情報を出力する

--%>

<center>
<div class="ho">
	<FORM action="loginmade2.jsp" method="POST">
Login ID：<input type="text" name="customerID" value="">
<br>
 Password：<input type="text" name="customerPassword" value="">
<BR>
</div>
<INPUT type="submit" name="made" value="新規作成する">
	</FORM><BR>
</center>
 

</BODY>
</HTML>
