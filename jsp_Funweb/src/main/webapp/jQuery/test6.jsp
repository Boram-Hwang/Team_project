<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="member.MemberDTO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// jQuery/test6.jsp
// JSON 데이터로 변경하는 프로그램 설치
// WEB-INF   -lib - json-simple-1.1.1.jar 설치


// member 테이블에 데이터를 => JSON 변경
//1단계 설치한 JDBC 프로그램 불러오기
Class.forName("com.mysql.jdbc.Driver");
//2단계 디비연결(디비주소, 디비아이디,디비 비밀번호) => 연결정보저장
String dbUrl="jdbc:mysql://localhost:3306/jspdb3";
String dbUser="root";
String dbPass="1234";
Connection con =DriverManager.getConnection(dbUrl, dbUser, dbPass); 
//3단계 연결정보를 이용해서 sql구문 만들고 실행할 준비
String sql="SELECT * FROM member";
PreparedStatement pstmt=con.prepareStatement(sql);
//4단계 실행 => 실행 결과 저장 (select)
ResultSet rs =pstmt.executeQuery();
//5단계 while 다음행 이동 데이터있으면 true => 열접근 출력
// 배열변수
// List memberList = new ArrayList();
JSONArray memberList = new JSONArray(); // 여러명 배열
while(rs.next()){
	// 한사람의 정보를 MemberDTO에 저장
// 	MemberDTO memberDTO=new MemberDTO();
	JSONObject memberDTO=new JSONObject();
	
// 	memberDTO.setId(rs.getString("id"));
// 	memberDTO.setPass(rs.getString("pass"));
// 	memberDTO.setName(rs.getString("name"));
// 	memberDTO.setDate(rs.getTimestamp("date"));
	memberDTO.put("id",rs.getString("id"));
	memberDTO.put("pass",rs.getString("pass"));
	memberDTO.put("name",rs.getString("name"));
	memberDTO.put("date",rs.getString("date")); // json은 모두 문자라서 String
	
	// 배열 한칸에 저장
	memberList.add(memberDTO);
}

%>
<%=memberList %>