<!-- 商品　カテゴリ選択-->
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%--

  パラメータの取得

  kadai.html で入力した文字列を取得し、変数 formMakerName に格納する

--%>
<fmt:requestEncoding value="utf-8" />
<%-- (1)ここに表示処理を追加する --%>

<c:set var="formMakerNames" value="${paramValues.makerName}"/>
<c:set var="formPlayerNames" value="${paramValues.playerName}"/>
<c:set var="formId" value="${param.hiddenId}"/>
<%--

  データベースへのコネクションを取得

--%>
<sql:setDataSource driver="org.h2.Driver" url="jdbc:h2:sdev" />
<c:choose>
<%--どちらも選択されていないとき--%>
<c:when test="${empty formMakerNames and empty formPlayerNames}">
 <sql:query var="rs">
SELECT*FROM PRODUCT_INFO
</sql:query>
</c:when>

<%--メーカー名だけ選択されているとき--%>
<c:when test="${not empty formMakerNames and empty formPlayerNames}">
<sql:query var="rs">
SELECT*FROM PRODUCT_INFO
 WHERE MAKER_NAME='${fn:join(formMakerNames,"'OR MAKER_NAME='")}';       
</sql:query>
</c:when>

<%--選手名だけ選択されているとき--%>
<c:when test="${empty formMakerNames and not empty formPlayerNames}">
 <sql:query var="rs">
SELECT*FROM PRODUCT_INFO
WHERE PLAYER_NAME='${fn:join(formPlayerNames,"'OR PLAYER_NAME='")}';       
</sql:query>
</c:when>

<%--どちらも選択されているとき--%>
<c:otherwise>
<sql:query var="rs">
SELECT*FROM PRODUCT_INFO    
WHERE PLAYER_NAME='${fn:join(formPlayerNames,"'OR PLAYER_NAME='")}'
and  MAKER_NAME='${fn:join(formMakerNames,"'OR MAKER_NAME='")}'; 
</sql:query>
</c:otherwise>
</c:choose>
<HTML>
<HEAD>
	<META http-equiv="Content-Language" content="ja">
	<META http-equiv="Content-Type" content="text/html; charset=utf-8">
	<TITLE>課題-検索結果-</TITLE>

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
img {vertical-align: middle;}
.name{
  font-family:Monotype Corsiva;
  font-size:120px;
  font-weight: 700;
  font-stretch: expanded;
  color:#000080;
}
</STYLE>
</HEAD>
<BODY>
		<H2>NBAグッズ通販サイト</H2>
		<CENTER>
			<span class="name">D4C</span>
			   <p style="text-align: right" >
				<font size="5">
			~NBAをもっと身近に~ &ensp;
				</font>
			</p>
			<c:choose>
					<c:when test="${not empty formId}">
					<p style="text-align: right" >ようこそ${formId}さん</p>
					</c:when>
				  </c:choose>
			</CENTER>	
<CENTER> 
<H2>検索結果</H2>

<TABLE>
	<TR>
					<TH>イメージ</TH>
					<TH>製品名</TH>
					<TH>メーカー</TH>
	</TR>

<%--
  検索結果レコードの表示処理
--%>
<c:forEach var="row" items="${rs.rows}">


<TR>
<%-- (3)ここに表示処理を追加する --%>
<TD>
<img src="image/${row.IMAGE}" height="60" />
</TD>
<%-- 商品名 --%>
    <TD><a href="detail.jsp?selectedProductCode=${row.PRODUCT_CODE}">${row.PRODUCT_NAME}
    </a></TD>
<TD>${row.MAKER_NAME}</TD>

</TR>
</c:forEach> <%-- rsのループ --%>

</TABLE>

</CENTER>
</BODY>
</HTML>
