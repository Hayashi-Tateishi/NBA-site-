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
<%--
  詳細画面で入力した値を取得する
--%>
<fmt:requestEncoding value="utf-8" />
<c:set var="formCustomerId" value="${param.customerID}" />
<c:set var="formCustomerPass" value="${param.customerPassword}"/>
<%-- IDからパスワードを検索する--%>
<sql:query var="rs">
	SELECT CUSTOMER_PASSWORD
	  FROM CUSTOMER_LOGIN WHERE CUSTOMER_ID=?;
	  <sql:param value="${formCustomerId}"/>
</sql:query>
<c:set var="dbPass" value="${rs.rows[0].CUSTOMER_PASSWORD}"/>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<TITLE>ログイン画面</TITLE>
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
.fault{
	font-size:xx-large;
	color:red;
}
.success{
	font-size:xx-large;
	color:blue;
}
input{font-size:80%;}
</STYLE>
</head>
<BODY>
	<H2>NBAグッズ通販サイト</H2>
		<CENTER>
			<span class="name">D4C</span>
			   <p style="text-align: right" >
				<font size="5">
			~NBAをもっと身近に~ &ensp;
				</font>
			</p>
			<br><br><br>
		</CENTER>
<c:choose>
<c:when test="${formCustomerPass== dbPass}">
  <center>
  <div class="success">
	ログインに成功しました。
 <FORM action="list2.jsp" method="POST">
	<input type="hidden" name="hiddenId" value="${formCustomerId}"/>
	<BR>
	<INPUT type="submit" name="buttonBuy" value="トップページに行く">
	</FORM>
</div>
</center>
</c:when>
<c:otherwise>
 <center>
 <div class="fault">
	ログインに失敗しました。
	<meta http-equiv="refresh" content="1;URL=login.jsp">
</div>
</center>
</c:otherwise>
</c:choose>
</BODY>
</HTML>
