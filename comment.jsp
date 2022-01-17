<!-- 口コミ受付画面-->
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%--
  データベースへのコネクションを取得
--%>
<sql:setDataSource driver="org.h2.Driver" url="jdbc:h2:sdev" />

<fmt:requestEncoding value="utf-8" />
<%-- リンクで渡されたパラメータを、変数 formCode に格納する --%>
<c:set var="formCode" value="${param.hiddenCode}"/>
<%-- コメントを変数[formComment]に格納する --%>
<c:set var="formComment" value="${param.customerComment}" />
<%-- スコアを変数[formScore]に格納する --%>
<c:set var="formScore" value="${param.customerScore}" />
<%--
商品の情報を検索
%-->
<sql:query var="rs">
SELECT PRODUCT_CODE, PRODUCT_NAME, CATEGORY_NAME, MAKER_NAME, DETAIL, MATERIAL, SIZE, IMAGE, PRICE
  FROM PRODUCT_INFO WHERE PRODUCT_CODE=? ORDER BY PRODUCT_CODE;
<sql:param value="${formCode}"/>
</sql:query>
<%-- 一行目を変数rowに代入 --%>
<c:set var="row" value="${rs.rows[0]}" />

<%--
  レビューをデータベースに登録するSQL文を実行する
  [PRODUCT_REVIEW]テーブルに、 [PRODUCT_CODE],
  [COMMENT], [SCORE],
--%>
<sql:update>
INSERT INTO PRODUCT_REVIEW (PRODUCT_CODE,COMMENT,SCORE) VALUES(?,?,?);
<sql:param value="${formCode}" />
<sql:param value="${formComment}" />
<sql:param value="${formScore}" />
</sql:update>
<%--画像の検索--%>
<sql:query var="po">
  SELECT IMAGE
   FROM PRODUCT_INFO WHERE PRODUCT_CODE=?;
   <sql:param value="${formCode}"/>
</sql:query>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<TITLE>レビューを受け取りました</TITLE>
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
  width:800px;
  float: left;
  }
  .detail{
  width:400px;
  float: left;
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

  <div class="image">
      <%-- 画像を出力 --%>
      <img src="image/${po.rows[0].IMAGE}"/>
      </div>
  <div class="detail">
  <font color="red"> <B>レビューを受け付けました。</B> </font>
<BR><BR>
コメント:${formComment}<BR>
スコア:${formScore}
<BR>
     <FORM action="list2.jsp" method="POST">
       <INPUT type="submit" value="トップページに戻る" name="modol">

     </FORM>
</CENTER>
</div>
</BODY>
</html>
