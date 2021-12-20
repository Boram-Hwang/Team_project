<%@page import="member.MemberDTO"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// jQuery/idCheck2.jsp
//  'id':$('#id').val()
//  http://localhost:8080/FunWeb/jQuery/idCheck2.jsp?id=kim
//  http://localhost:8080/FunWeb/jQuery/idCheck2.jsp?id=kim123
// id 파라미터 값 가져오기
String id=request.getParameter("id");
//MemberDAO 객체 생성 
MemberDAO memberDAO=new MemberDAO();
//리턴할형 MemberDTO  getMember(String id) 메서드 호출
MemberDTO memberDTO=memberDAO.getMember(id);
if(memberDTO==null){
	//아이디 같은게 없음, 아이디 중복 아님, 아이디 사용가능
	%>아이디 사용가능<%
}else{
	// 아이디 같은게 있음 , 아이디 중복
	%>아이디 중복<%
}
%>