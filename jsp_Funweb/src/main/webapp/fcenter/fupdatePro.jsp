<%@page import="java.sql.Timestamp"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="board.BoardDAO"%>
<%@page import="board.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>fcenter/fupdatePro.jsp</title>
</head>
<body>
<%
//한글처리
request.setCharacterEncoding("utf-8");
//upload폴더에 파일 업로드
//프로그램 설치  www.servlets.com - COS File upload Library   cos-20.08.zip
//WEB_INF - lib - cos.jar 파일 넣기

//MultipartRequest multi=new MultipartRequest(request,upload폴더 물리적경로, 파일최대크기, 한글처리, 파일이름 중복일때 변경);

//upload폴더 물리적경로 (upload 폴더만들기)
String uploadPath=request.getRealPath("/upload");
System.out.println(uploadPath); // 물리적크기가 어디있는지 모르니 일단 출력
// 파일최대크기
int maxSize=10*1024*1024; // 10Mb로 최대크기 지정

MultipartRequest multi=
new MultipartRequest(request,uploadPath,maxSize,"utf-8",new DefaultFileRenamePolicy());


//request 파라미터 num name subject content 가져오기
int num=Integer.parseInt(multi.getParameter("num"));
String name=multi.getParameter("name");
String subject=multi.getParameter("subject");
String content=multi.getParameter("content");
//글쓴날짜 date
Timestamp date=new Timestamp(System.currentTimeMillis());
//조회수 0으로 세팅
int readcount =0;
//첨부파일 이름
String file=multi.getFilesystemName("file");

// BoardDTO 객체생성
BoardDTO boardDTO =new BoardDTO();
// set 메서드 파라미터 저장
boardDTO.setNum(num);
boardDTO.setName(name);
boardDTO.setSubject(subject);
boardDTO.setContent(content);
// 첨부파일
boardDTO.setFile(file);

// BoardDAO 객체 생성
BoardDAO boardDAO=new BoardDAO();
// 리턴할형없음  updateBoard(BoardDTO boardDTO) 메서드 정의

// updateBoard(boardDTO) 메서드 호출
boardDAO.updateBoard(boardDTO);
// notice.jsp
response.sendRedirect("fnotice.jsp");

%>
</body>
</html>