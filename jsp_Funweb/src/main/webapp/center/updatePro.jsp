<%@page import="board.BoardDAO"%>
<%@page import="board.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>center/updatePro.jsp</title>
</head>
<body>
<%
//한글
request.setCharacterEncoding("utf-8");
//request 파라미터 num name subject content 가져오기
int num=Integer.parseInt(request.getParameter("num"));
String name=request.getParameter("name");
String subject=request.getParameter("subject");
String content=request.getParameter("content");
// BoardDTO 객체생성
BoardDTO boardDTO =new BoardDTO();
// set 메서드 파라미터 저장
boardDTO.setNum(num);
boardDTO.setName(name);
boardDTO.setSubject(subject);
boardDTO.setContent(content);

// BoardDAO 객체 생성
BoardDAO boardDAO=new BoardDAO();
// 리턴할형없음  updateBoard(BoardDTO boardDTO) 메서드 정의

// updateBoard(boardDTO) 메서드 호출
boardDAO.updateBoard(boardDTO);
// notice.jsp
response.sendRedirect("notice.jsp");

%>
</body>
</html>