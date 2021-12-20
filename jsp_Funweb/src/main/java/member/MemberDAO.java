package member;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MemberDAO {
	// member 관련 데이터베이스 접근해서 작업하는
	// 
	Connection con =null;
	PreparedStatement pstmt=null;
	String sql =null;
	ResultSet rs = null;
	
	
	public Connection getConnection() throws Exception {
//		// 1단계 설치한 JDBC 프로그램 불러오기
//		// com폴더 mysql폴더 jdbc폴더 Driver.class
//		Class.forName("com.mysql.jdbc.Driver");
//		
//		// 2단계 디비연결(디비주소, 디비아이디, 디비 비밀번호) => 연결정보 저장
//		String dbUrl="jdbc:mysql://localhost:3306/jspdb3";
//		String dbUser="root";
//		String dbPass="1234";
//		con = DriverManager.getConnection(dbUrl, dbUser, dbPass);
//		
//		return con;
		
		// ConnectionPool => 서버단에서 디비연결한 후에 연결정보를 불러서 사용함
		// DBCP (DataBase ConnectionPool) 프로그램 이용 => 웹서버에 내장
		// 1. META-INF context.xml 파일 만들기(1,2단계 디비연결 이름으로 저장)
		// 2. DAO => 연결된 정보의 이름을 가져와서 사용
		// => 속도가 빨라짐, 디비정보 수정을 한군데 (context.xml)하면 모든 DAO 변경
		
		Context init = new InitialContext();//import javax.naming.Context;
//		init.lookup("장소jdbc/MysqlDB");
		DataSource ds=(DataSource)init.lookup("java:comp/env/jdbc/MysqlDB");
		con=ds.getConnection();
		
		return con;
	}
	
	// 객체생성 => 기억장소 해제
	public void dbClose() {
		if(rs!=null) {try {rs.close();} catch (Exception e2) {}}
		if(pstmt!=null) {try {pstmt.close();} catch (Exception e2) {}}
		if(con!=null) {try {con.close();} catch (Exception e2) {}}
	}
	
	// 리턴할형 없음 insertMember(데이터를 담음 주소 저장하는 변수) 메서드 정의
	public void insertMember(MemberDTO memberDTO) {
		//id pass name email address phone mobile
		try {
			//1,2단계 DB 연결
			con=getConnection();
			
			//3단계 sql(insert)작성
			sql="INSERT INTO member(id,pass,name,date,email,postcode,address,phone,mobile) VALUES (?,?,?,?,?,?,?,?,?)";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, memberDTO.getId());
			pstmt.setString(2, memberDTO.getPass());
			pstmt.setString(3, memberDTO.getName());
			pstmt.setTimestamp(4, memberDTO.getDate());
			pstmt.setString(5, memberDTO.getEmail());
			pstmt.setString(6, memberDTO.getPostcode());
			pstmt.setString(7, memberDTO.getAddress());
			pstmt.setString(8, memberDTO.getPhone());
			pstmt.setString(9, memberDTO.getMobile());
			
			
			// 4단계 실행(insert,update, delete)
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			//마무리
			dbClose();
		}
	} //insertMember
	
	
	// 리턴할형 MemberDTO userCheck(String id, String pass) 메서드 정의
	public MemberDTO userCheck(String id, String pass) {
		// 빈 바구니(빈 기억장소)를 선언(아이디 비밀번호 일치하지 않으면)
		//초기값으로 null id,pass 틀리면 적용
		MemberDTO memberDTO=null;
		try {
			//1,2단계 DB 연결
			con=getConnection();
			
			//3단계 연결정보를 이용해서 sql 구문 만들고 실행할 준비
			sql="SELECT *FROM member WHERE id=? AND pass=?";
			pstmt=con.prepareStatement(sql); // String 타입을 sql 타입으로 바꿔줌(prepareStatement)
			pstmt.setString(1, id);
			pstmt.setString(2, pass);
			
			//4단계 실행 => 실행 내용 저장(select)
			rs = pstmt.executeQuery();
			
			//5단계 저장된 내용 접근 다음행으로 next() 결과가 있으면 true (아이디 비밀번호 일치)
			// 결과를 memberDTO에 담는과정
			if(rs.next()) {
				// true => 아이디 비밀번호 일치 => 열접근
				// 객체생성 기억장소 할당
				memberDTO=new MemberDTO();
				// 기억장소 id 변수에 rs 열을 가져와서 저장
				// set메서드 호출 열접근 => 멤버변수 저장
				memberDTO.setId(rs.getString("id"));
				memberDTO.setPass(rs.getString("pass"));
				memberDTO.setName(rs.getString("name"));
				memberDTO.setDate(rs.getTimestamp("date"));
				memberDTO.setEmail(rs.getString("email"));
				memberDTO.setPostcode(rs.getString("postcode"));
				memberDTO.setAddress(rs.getString("address"));
				memberDTO.setPhone(rs.getString("phone"));
				memberDTO.setMobile(rs.getString("mobile"));
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			//마무리
			dbClose();
		}
		
		
		return memberDTO;
	}//userCheck
	
	
	// 리턴할형 MemberDTO  getMember(String id) 메서드 정의
	public MemberDTO getMember(String id) {
		MemberDTO memberDTO=null;
		
		try {
			// 1,2 디비연결
			con=getConnection();
			// 3 sql
			sql="SELECT *FROM member WHERE id=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			//4 실행
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				// true => 아이디 비밀번호 일치 => 열접근
				// 객체생성 기억장소 할당
				memberDTO=new MemberDTO();
				// 기억장소 id 변수에 rs 열을 가져와서 저장
				// set메서드 호출 열접근 => 멤버변수 저장
				memberDTO.setId(rs.getString("id"));
				memberDTO.setPass(rs.getString("pass"));
				memberDTO.setName(rs.getString("name"));
				memberDTO.setDate(rs.getTimestamp("date"));
				memberDTO.setEmail(rs.getString("email"));
				memberDTO.setPostcode(rs.getString("postcode"));
				memberDTO.setAddress(rs.getString("address"));
				memberDTO.setPhone(rs.getString("phone"));
				memberDTO.setMobile(rs.getString("mobile"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			//마무리
			dbClose();
		}
		
		
		return memberDTO;
	}//getMember
	
//	리턴할형없음	updateMember(updateDTO주소)		메서드 정의
	public void updateMember(MemberDTO updateDTO) {
		try {
			// 1,2 단계 db 연결
			con=getConnection();
			//3단계 sql 구문
//			수정할내용 name email address phone mobile 조건 id
			sql="UPDATE member SET name=?,email=?,postcode=?,address=?,phone=?,mobile=? WHERE id=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, updateDTO.getName());
			pstmt.setString(2, updateDTO.getEmail());
			pstmt.setString(3, updateDTO.getPostcode());
			pstmt.setString(4, updateDTO.getAddress());
			pstmt.setString(5, updateDTO.getPhone());
			pstmt.setString(6, updateDTO.getMobile());
			pstmt.setString(7, updateDTO.getId());
			//4. 실행
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			//마무리
			dbClose();
		}
	}//updateMember
	
}//클래스
