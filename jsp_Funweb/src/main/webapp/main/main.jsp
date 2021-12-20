<%@page import="java.text.SimpleDateFormat"%>
<%@page import="board.BoardDTO"%>
<%@page import="java.util.List"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/front.css" rel="stylesheet" type="text/css">

<!--[if lt IE 9]>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/IE9.js" type="text/javascript"></script>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/ie7-squish.js" type="text/javascript"></script>
<script src="http://html5shim.googlecode.com/svn/trunk/html5.js" type="text/javascript"></script>
<![endif]-->

<!--[if IE 6]>
 <script src="../script/DD_belatedPNG_0.0.8a.js"></script>
 <script>
   /* EXAMPLE */
   DD_belatedPNG.fix('#wrap');
   DD_belatedPNG.fix('#main_img');   

 </script>
 <![endif]--> 
<script type="../script/jquery-3.6.0.js"></script>
<script type="text/javascript"></script>


</head>
<body>
<div id="wrap">
<!-- 헤더파일들어가는 곳 -->
<jsp:include page="../inc/top.jsp"></jsp:include>
<!-- 헤더파일들어가는 곳 -->
<!-- 메인이미지 들어가는곳 -->
<div class="clear"></div>
<div id="main_img"><img src="../images/main_img.jpg"
 width="971" height="282"></div>
<!-- 메인이미지 들어가는곳 -->
<!-- 메인 콘텐츠 들어가는 곳 -->
<article id="front">
<div id="solution">
<div id="hosting">
<h3>알라딘</h3>
<p>알라딘(Aladdin)은 월트 디즈니가 1992년 개봉한 작품으로 『천일야화』 중 ｢알라딘과 이상한 램프｣의 이야기를 
각색하여 애니메이션으로 만든 것이다.
</p>
</div>
<div id="security">
<h3>백설공주</h3>
<p>디즈니 스튜디오의 백설공주와 일곱 난쟁이는 그림형제의 동화를 원작으로 한 최초의 장편애니메이션이다. 
</p>
</div>
<div id="payment">
<h3>신데렐라</h3>
<p>1950년 월트 디즈니 스튜디오에서 제작한 로맨틱 판타지 애니메이션. 
</p>
</div>
</div>
<div class="clear"></div>
<div id="sec_news">
<h3><span class="orange">Security</span> News</h3>
<dl>
<dt>디즈니+</dt>
<dd>디즈니+ 최고의 스토리들이 한 곳에</dd>
</dl>
<dl>
<dt>마블</dt>
<dd>마블 시네마틱 유니버스</dd>
</dl>
</div>
<div id="news_notice">
<h3 class="brown">News &amp; Notice</h3>
<table>

<%
//BoardDAO 객체생성
BoardDAO boardDAO=new BoardDAO();
int startRow=1;
int pageSize=5;
//List<BoardDTO> boardList =   getBoardList(startRow, pageSize) 메서드 호출
List<BoardDTO> boardList=boardDAO.getBoardList(startRow, pageSize);
SimpleDateFormat dataFormat=new SimpleDateFormat("yyyy.MM.dd");
for(int i=0; i<boardList.size();i++){
	BoardDTO boardDTO=boardList.get(i);
	%>
	<tr><td class="contxt"><a href="#"><%=boardDTO.getSubject() %></a></td>
    <td><%=dataFormat.format(boardDTO.getDate()) %></td></tr>
	<%
}
%>
</table>
</div>
</article>
<!-- 메인 콘텐츠 들어가는 곳 -->
<div class="clear"></div>
<!-- 푸터 들어가는 곳 -->
<jsp:include page="../inc/bottom.jsp"></jsp:include>
<!-- 푸터 들어가는 곳 -->
</div>
</body>
</html>