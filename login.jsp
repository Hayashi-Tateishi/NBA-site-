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
  .log{
	  font-size:large;
  }
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
<%--
  詳細情報を出力する
--%>

<center>
	<FORM action="login2.jsp" method="POST">
<div class="log">
Login ID：<input type="text" name="customerID" size="30" maxlength="30">
<BR><br>
 Password：<input type="text" name="customerPassword" size="30" maxlength="30">
 </div>
<BR>
<INPUT type="submit" name="buttonBuy" value="ログインする">
	</FORM><BR>
	<FORM action="list2.jsp" method="POST">
	<input type="submit" name="buttongo" value="ログインせずにトップページへ">
	</FORM>
   <br><br>
  ~新しいお客様ですか～
	<FORM action=loginmade.jsp method="POST">
			<input type="submit" name="buttonmade" value="新規作成">
		</FORM>	<br>
</center>
 

</BODY>
</HTML>
