<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="board.BoardDAO"%>
<%@page import="board.BoardDTO"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>center/writePro.jsp</title>
</head>
<body>
<%
// 한글처리
request.setCharacterEncoding("utf-8");
// upload폴더에 파일 업로드
// 프로그램 설치  www.servlets.com - COS File upload Library   cos-20.08.zip
// WEB_INF - lib - cos.jar 파일 넣기

// MultipartRequest multi=new MultipartRequest(request,upload폴더 물리적경로, 파일최대크기, 한글처리, 파일이름 중복일때 변경);

// upload폴더 물리적경로 (upload 폴더만들기)
String uploadPath=request.getRealPath("/upload");
System.out.println(uploadPath); // 물리적크기가 어디있는지 모르니 일단 출력
// 파일최대크기
int maxSize=10*1024*1024; // 10Mb로 최대크기 지정

MultipartRequest multi=
new MultipartRequest(request,uploadPath,maxSize,"utf-8",new DefaultFileRenamePolicy());



// 파라미터 가져오기 name pass subject content (request값이 multi로 바꼈기때문에 바꿔줘야함)
String name=multi.getParameter("name");
String pass=multi.getParameter("pass");
String subject=multi.getParameter("subject");
String content=multi.getParameter("content");
// 글쓴날짜 date
Timestamp date=new Timestamp(System.currentTimeMillis());
// 조회수 0으로 세팅
int readcount =0;

// 첨부파일 이름
String file=multi.getFilesystemName("file");


// BoardDTO 객체생성
BoardDTO boardDTO = new BoardDTO();
// 멤버변수 <= 파라미터 저장
boardDTO.setName(name);
boardDTO.setPass(pass);
boardDTO.setSubject(subject);
boardDTO.setContent(content);
boardDTO.setReadcount(readcount);
boardDTO.setDate(date);
// 첨부파일
boardDTO.setFile(file);

// BoardDAO 객체생성
BoardDAO boardDAO = new BoardDAO();
// 리턴할형 없음 insertBoard(BoardDTO boardDTO)
//  SELECT MAX(num) FROM board 	=>	MAX(num)+1   => num 구하기 // 게시판의 번호를 몇번으로 할지
// insertBoard(boardDTO) 메서드 호출
boardDAO.insertBoard(boardDTO);

// notice.jsp 이동
response.sendRedirect("fnotice.jsp");
%>
</body>
</html>