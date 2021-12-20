<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<header>
<%
// 세션값 가져오기 
String id=(String)session.getAttribute("id"); // object 형으로 변환되어있으니 다운캐스팅하여 스트링형으로 바꿔줘야함(참조형 형변환)
// 세션값이 없으면 (로그인 안된 상태)
// 세션값이 있으면 (로그인한 상태)
if(id==null){
	// 세션값이 없으면 (로그인 안된 상태)
	%>
	<div id="login"><a href="../member/login.jsp">로그인</a> | 
	<a href="../member/join.jsp">회원가입</a></div>
	<%
}else{
	// 세션값이 있으면 (로그인한 상태)
	%>
	<div id="login"><%=id %>님 | <a href="../member/logout.jsp">로그아웃</a> | 
	<a href="../member/update.jsp">회원수정</a></div>
	<%
}
%>


<div class="clear"></div>
<!-- 로고들어가는 곳 -->

<div id="logo"><img src="../images/disneylogo.gif" width="265" height="50" alt="Fun Web"></div>
<!-- 로고들어가는 곳 -->

<nav id="top_menu">
<ul>

	<li><a href="../main/main.jsp">홈</a></li>
	<li><a href="../company/welcome.jsp">회사소개</a></li>
	<li><a href="#">SOLUTIONS</a></li>
	<li><a href="../center/notice.jsp">고객센터</a></li>
	<li><a href="#">CONTACT US</a></li>
</ul>
</nav>
<br><br><br>
</header>