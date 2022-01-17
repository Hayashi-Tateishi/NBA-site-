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
<c:set var="formID" value="${param.customerID}"/>
<c:set var="formPass" value="${param.customerPassword}"/>

<%--新規idをデータベースに登録する--%>
<sql:update>
INSERT INTO CUSTOMER_LOGIN (CUSTOMER_ID,CUSTOMER_PASSWORD) VALUES(?,?);
<sql:param value="${formID}" />
<sql:param value="${formPass}" />
</sql:update>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<TITLE>新規作成完了画面</TITLE>
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
.detail{
   font-size:xx-large;
}
.mo{
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
<center>
	<div class="detail">
	<font color="blue"> <B>新規作成出来ました。</B> </font>
	 <BR><BR>
	</div>
	<div class="mo">
	 Login ID:${formID}<BR>
	 Password:${formPass}<BR>
	</div>
	 <FORM action="login.jsp" method="POST">
	 <INPUT type="submit" value="ログイン画面に戻る" name="modol">
	</FORM>
</center>
 

</BODY>
</HTML>
