<%@page import="com.mysql.fabric.proto.xmlrpc.ResultSetParser"%>
<%@page import="board.BoardDTO"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>fcenter/fdeletePro.jsp</title>
</head>
<body>
<%
// num 파라미터 값 가져오기
int num=Integer.parseInt(request.getParameter("num"));

// BoardDAO 객체생성
BoardDAO boardDAO = new BoardDAO();

// 리턴할형없음 deleteBoard(int num) 메서드 정의
// deleteBoard(num) 메서드 호출
boardDAO.deleteBoard(num);
// notice.jsp 이동
response.sendRedirect("fnotice.jsp");
%>
</body>
</html>