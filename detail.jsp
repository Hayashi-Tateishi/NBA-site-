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
  販売画面で選択した衣料品の情報を取得する
  商品コードを取得し、変数[formProductCode]に格納する
--%>
<fmt:requestEncoding value="utf-8" />
<c:set var="formProductCode" value="${param.selectedProductCode}" />

<%--
  商品の在庫を検索する
  [PRODUCT_STOCK]テーブルから[PRODUCT_CODE], [MAKER_ID], [PC_NAME],
   [PC_TYPE], [SAL_VALUE], [SPEC], [STOCK_NUM]を検索するSQL文
--%>
<sql:query var="rs">
SELECT STOCK_NUM
  FROM PRODUCT_STOCK WHERE PRODUCT_CODE = ?;
<sql:param value="${formProductCode}" />
</sql:query>

<%-- 在庫数を変数[stockNum]に、格納する --%>
<c:choose>
  <c:when test="${rs.rowCount == 0}">
    <c:set var="stockNum" value="0" />
  </c:when>
  <c:otherwise>
    <c:set var="row" value="${rs.rows[0]}" />
    <c:set var="stockNum" value="${row.STOCK_NUM}" />
  </c:otherwise>
</c:choose>

<%--
  商品の情報を検索する
  [PRODUCT_INFO]テーブルから [PRODUCT_CODE], [PRODUCT_NAME],
  [CATEGORY_NAME], [MAKER_NAME], [DETAIL],  [SIZE], [IMAGE],
  [PRICE],[PLAYER_NAME]を [PRODUCT_CODE]の昇順で検索するSQL文。
--%>
<sql:query var="rs">
SELECT PRODUCT_CODE, PRODUCT_NAME, CATEGORY_NAME, MAKER_NAME, DETAIL,SIZE, IMAGE, PRICE,PLAYER_NAME
  FROM PRODUCT_INFO WHERE PRODUCT_CODE=? ORDER BY PRODUCT_CODE;
<sql:param value="${formProductCode}" />
</sql:query>

<%-- 一行目を変数rowに代入 --%>
<c:set var="row" value="${rs.rows[0]}" />

<sql:query var="po">
  SELECT IMAGE,PRODUCT_NAME,PLAYER_NAME
   FROM PRODUCT_INFO WHERE PLAYER_NAME=? ORDER BY PRODUCT_CODE;
   <sql:param value="${row.PLAYER_NAME}"/>
</sql:query>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<TITLE>詳細情報</TITLE>
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
    width:700px;
    float: left;
  }
  .detail{
    float: left;
    width:200;
    font-size: x-large;
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
        <br>
        </CENTER>

<%--

  詳細情報を出力する

--%>
<div class="image">
<%-- 画像を出力 --%>
<img src="image/${row.IMAGE}" />
</div>

<div class="detail">
  <br><br><br>
<%-- メーカーを出力 --%>
メーカー：${row.MAKER_NAME}<BR>
<%-- 製品名を出力 --%>
製品名：${row.PRODUCT_NAME}<BR>
<%-- カテゴリを出力 --%>
カテゴリ：${row.CATEGORY_NAME}<BR>
<%-- 説明を出力 --%>
説明：${row.DETAIL}<BR><BR>
<%-- 販売価格を出力 --%>
販売価格：${row.PRICE}<BR>

<%--

  在庫数を確認して結果を表示する
  在庫数が1より少ないかどうかで在庫の確認を行っている

--%>
<c:choose>
  <c:when test="${stockNum < 1}">
<%-- 商品の在庫が存在しない場合は、品切れの情報を出力する --%>
申し訳ございません。${row.PRODUCT_NAME} は品切れです。<BR>
  </c:when>
  <c:otherwise>

	<FORM action="buy.jsp" method="POST">
<%--
  次の購入のページに製品コードを渡すための処理　
  画面上には出力されない
--%>
<%-- 製品コードのデータ --%>
<input type="hidden" name="hiddenCode" value="${row.PRODUCT_CODE}" />
<input type="hidden" name="hiddenPrice" value="${row.PRICE}" />

購入者氏名:<input type="text" name="customerName" value="">
<BR>
購入者住所:<input type="text" name="customerAddress" value="">
<br>
<INPUT type="submit" name="buttonBuy" value="購入する">
  </FORM>
  <br>
  <%--トップページに戻る--%>
<FORM action="list2.jsp" method="POST">
       <INPUT type="submit" value="トップページに戻る" name="modol">
     </FORM>

</c:otherwise>
</c:choose>
</div>

</BODY>
</HTML>
