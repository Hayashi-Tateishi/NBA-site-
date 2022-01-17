<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%--

  データベースへのコネクションを取得

--%>
<sql:setDataSource driver="org.h2.Driver" url="jdbc:h2:sdev" />

<fmt:requestEncoding value="utf-8" />
<%-- リンクで渡されたパラメータを、変数 formCode に格納する --%>
<%-- (1) --%>
<c:set var="formCode" value="${param.productCode}"/>
<%--

  口コミテーブルからのデータの取得

  [PRODUCT_REVIEW]テーブルから前ページで選択したリンクと一致する商品の
  [COMMENT],[SCORE]を検索するSQL文

--%>
<sql:query var="rs">
<%-- (2) --%>
SELECT COMMENT,SCORE
 FROM PRODUCT_REVIEW WHERE PRODUCT_Code=?;
<sql:param value="${formCode}"/>
</sql:query>
<%-- 一行目を変数rowに代入 --%>
<c:set var="row" value="${rs.rows[0]}" />

<sql:query var="po">
  SELECT IMAGE
   FROM PRODUCT_INFO WHERE PRODUCT_CODE=?;
   <sql:param value="${formCode}"/>
</sql:query>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<TITLE>口コミ</TITLE>
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
  .image{
    width:600px;
    float: left;
  }
.review{
  float:left;
  width:600px;
}
.comm{
  float:right;
  width:600px;
  font-size:x-large;
}
</STYLE>
</head>
<BODY bgcolor="#FFFFFF">
    <H2>NBAグッズ通販サイト</H2>
    <CENTER>
      <span class="name">D4C</span>
         <p style="text-align: right" >
          <font size="5">
      ~NBAをもっと身近に~ &ensp;
          </font>
      </p>
      <br><BR>
      </CENTER>
  <CENTER>
    
    <%--商品画像--%>
    <div class="image">
    <img src="image/${po.rows[0].IMAGE}" />
  </div>

<div class="review">
商品コード：${formCode}
		<TABLE>
			<TR>
				<TH>口コミ</TH>
				<TH>採点</TH>
			</TR>
<c:forEach var="row" items="${rs.rows}">
  <TR>
    <%-- (3) --%>
<TD>${row.COMMENT}</TD>
<TD>${row.SCORE}</TD>
  </TR>
</c:forEach>
</TABLE>
   </CENTER>
  </div>
  <BR>
    <div class="comm">
  <FORM action="comment.jsp" method="POST">
    <%-- 製品コードのデータ --%>
    <input type="hidden" name="hiddenCode" value="${formCode}" />
    <BR>
  レビュー<BR>
  コメント:<input type="text" name="customerComment" value=""> <BR>
  スコア  ：<input type="text" name="customerScore" value=""><BR>
    
    <INPUT type="submit" name="buttonComment" value="レビューを送信">
    </FORM> 
  </div>
</BODY>
</html>
