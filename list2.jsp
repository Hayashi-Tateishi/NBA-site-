<!--商品選択-->
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
<c:set var="formId" value="${param.hiddenId}"/>
<%--
  データベースからデータを取得して、変数rsに結果を入れる。

  [PRODUCT_INFO]テーブルから [PRODUCT_CODE], [PRODUCT_NAME],
  [CATEGORY_NAME], [MAKER_NAME], [DETAIL], [SIZE], [IMAGE],
  [PRICE],[PLAYER_NAME]を [PRODUCT_CODE]の昇順で検索するSQL文。
--%>
<sql:query var="rs">
SELECT PRODUCT_CODE, PRODUCT_NAME, CATEGORY_NAME, MAKER_NAME, DETAIL,SIZE, IMAGE, PRICE,PLAYER_NAME
  FROM PRODUCT_INFO ORDER BY PRODUCT_CODE;
</sql:query>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<TITLE>トップページ</TITLE>
<%--

  表示方法の設定

--%>
<STYLE type="text/css">
body { background-color: #FFDAB9;
background-image: url("https://www.transparenttextures.com/patterns/dark-exa.png");
}
table {border-collapse:separate; border-spacing:2px; width:100%;}
th {background-color:#000000; align:center; font-size:large; font-weight:bold; color:white;}
td {background-color:#ffffff; font-size:normal; color:black;}
img {vertical-align: middle;}
.box1{
  float:left;
  width:200px;
}
.box2{
    width: 1040px;
    float:left;
}
.name{
  font-family:Monotype Corsiva;
  font-size:12ex;
  font-weight: 700;
  font-stretch: expanded;
  color:#000080;
}
</STYLE>
</head>
<BODY>
    <H2>NBAグッズ通販サイト</H2>
	<CENTER>
    <span class="name">D4C</span><br>
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
    <br>
    </CENTER>
     
    <div class="box1">
     メーカー
    <FORM action="list4.jsp" method="POST">
      <input type="hidden" name="hiddenId" value="${formId}"/>
      <input type="checkbox" value="Nike"  name="makerName">Nike
      <br>
      <input type="checkbox" value="Fathead" name="makerName">Fathead
      <br>
      <input type="checkbox" value="Dreamers"  name="makerName">Dreamers
      <br>
      <input type="checkbox" value="NewEra"  name="makerName">NewEra
      <br>
      <input type="checkbox" value="Stance" name="makerName">Stance
      <br>
      <input type="submit" value="検索" name="search">
    </FORM> 
    <BR> <BR>

    <FORM action="list4.jsp" method="POST">
      選手 <BR>
      <input type="hidden" name="hiddenId" value="${formId}"/>
      <input type="checkbox" value="LEBRON JAMES"  name="playerName">LEBRON JAMES<br>
      <input type="checkbox" value="JAMES HARDEN"  name="playerName">JAMES HARDEN<BR>
      <input type="checkbox" value="ANTHONY DAVIS"  name="playerName">ANTHONY DAVIS<BR>
      <input type="checkbox" value="CHRIS PAUL" name="playerName">CHRIS PAUL<BR>
      <input type="submit" value="検索" name="search">
     </FORM>
    </div>

    <%--商品表示--%>
  <div class="box2">
      <center>
      
			<TABLE>
				<TR>
					<TH>イメージ</TH>
					<TH>製品名</TH>
					<TH>販売価格</TH>
					<TH>口コミ</TH>
				</TR>
<%--
  検索結果レコードの表示処理。
  c:forEachタグは、itemsの行数分ループを行う。
--%>

<c:forEach var="row" items="${rs.rows}">
  <TR>
    <TD>
      <img src="image/${row.IMAGE}" height="60" />
    </TD>
    <%-- 商品名 --%>
    <TD><a href="detail.jsp?selectedProductCode=${row.PRODUCT_CODE}">${row.PRODUCT_NAME}
    </a></TD>
    <TD>${row.PRICE}円</TD>
    <TD><a href="review.jsp?productCode=${row.PRODUCT_CODE}">
口コミ</a></TD>
  </TR>
</c:forEach>
      </TABLE>
  <br>

    </center>
 </div>	
</BODY>
</HTML>
