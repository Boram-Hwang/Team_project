<%@page import="member.MemberDTO"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	function ok() {
		// join.jsp 아이디상자 <= idCheck.jsp 찾은 아이디 
		opener.fr.id.value = document.wfr.id.value;
		// 창닫기
		window.close();
	}
</script>
</head>
<body>
<h1>member/idCheck.jsp</h1>
<%
// http://localhost:8080/FunWeb/member/idCheck.jsp?id=kim
// id파라미터 서버 request에 저장 => 가져오기
String id=request.getParameter("id");
// MemberDAO 객체 생성 
MemberDAO memberDAO=new MemberDAO();
//리턴할형 MemberDTO  getMember(String id) 메서드 호출
MemberDTO memberDTO=memberDAO.getMember(id);
if(memberDTO==null){
	//아이디 같은게 없음, 아이디 중복 아님, 아이디 사용가능
	%>아이디 사용가능 <input type="button" value="아이디선택" onclick="ok()"><%
}else{
	// 아이디 같은게 있음 , 아이디 중복
	%>아이디 중복<%
}
%>
<form action="idCheck.jsp" method="get" name="wfr">
아이디 : <input type="text" name="id" value="<%=id%>">
<input type="submit" value="아이디 찾기">
</form>
</body>
</html>




