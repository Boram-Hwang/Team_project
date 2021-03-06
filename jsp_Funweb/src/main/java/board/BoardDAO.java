package board;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BoardDAO {
	Connection con=null;
	PreparedStatement pstmt=null;
	String sql =null;
	ResultSet rs =null;
	
	public Connection getConnection() throws Exception {
		// 1단계 설치한 JDBC 프로그램 불러오기
		// com폴더 mysql폴더 jdbc폴더 Driver.class
//		Class.forName("com.mysql.jdbc.Driver");
//		
//		// 2단계 디비연결(디비주소, 디비아이디, 디비 비밀번호) => 연결정보 저장
//		String dbUrl="jdbc:mysql://localhost:3306/jspdb3";
//		String dbUser="root";
//		String dbPass="1234";
//		con = DriverManager.getConnection(dbUrl, dbUser, dbPass);
//		
//		return con;
		
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
	
	// 함수는 결과를 하나만 리턴할수있어서 list배열 사용
	// 리턴할형 List<BoardDTO> getBoardList(int startRow, int pageSize)메서드 정의
	public List<BoardDTO> getBoardList(int startRow, int pageSize){
		List<BoardDTO> boardList =new ArrayList<BoardDTO>();
		
		try {
			con=getConnection();
			
//			sql="SELECT * FROM board ORDER BY num DESC";
			// limit는 Mysql에서만 오라클은 다른거 해야함 limit 시작행번호 -1,몇개를 뽑아올건지
			sql="SELECT * FROM board ORDER BY num DESC limit ?,?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, startRow-1);
			pstmt.setInt(2, pageSize);
			// 4단계 4s = 실행
			rs=pstmt.executeQuery();
			// 5 rs 저장된 내용 접근 => true => 게시글 한개(하나의 행) BoardDTO => 배열 boardList
			while(rs.next()) {
				// 한개의 글을 BoardDTO 저장하기 위해 객체생성
				BoardDTO boardDTO=new BoardDTO();
				// boardDTO set 호출 열데이터 가져와서 멤버변수 저장
				boardDTO.setNum(rs.getInt("num"));
				boardDTO.setName(rs.getString("name"));
				boardDTO.setPass(rs.getString("pass"));
				boardDTO.setSubject(rs.getString("subject"));
				boardDTO.setContent(rs.getString("content"));
				boardDTO.setReadcount(rs.getInt("readcount"));
				boardDTO.setDate(rs.getTimestamp("date"));
				// 배열 한칸에 저장
				boardList.add(boardDTO);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			//마무리
			dbClose();
		}
		
		return boardList;
	}//getBoardList
	
	//리턴할형 BoardDTO  getBoard(int num) 메서드 정의 (넘버에 대한 게시판글 하나를 들고오기)
	public BoardDTO getBoard(int num) {
		BoardDTO boardDTO=null; // 넘버값이 없을 경우를 대비해 null값 준비
		// 값이 있을경우 try
		try {
			con=getConnection();
			
			sql="SELECT * FROM board WHERE num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			// 4단계 rs=실행
			rs=pstmt.executeQuery();
			// 5 rs 저장된 내용 접근 => true => 게시글 한개(하나의 행) BoardDTO
			while(rs.next()) {
				// 한개의 글을 BoardDTO 저장하기 위해 객체생성
				boardDTO=new BoardDTO();
				// boardDTO set 호출 열데이터 가져와서 멤버변수 저장
				boardDTO.setNum(rs.getInt("num"));
				boardDTO.setName(rs.getString("name"));
				boardDTO.setPass(rs.getString("pass"));
				boardDTO.setSubject(rs.getString("subject"));
				boardDTO.setContent(rs.getString("content"));
				boardDTO.setReadcount(rs.getInt("readcount"));
				boardDTO.setDate(rs.getTimestamp("date"));
				// 첨부파일
				boardDTO.setFile(rs.getString("file"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			//마무리
			dbClose();
		}
		return boardDTO;
		
	} //getBoard
	
	// 리턴할형 없음 insertBoard(BoardDTO boardDTO)
	public void insertBoard(BoardDTO boardDTO) {
		try {
			// 1, 2 단계 db연결
			con=getConnection();
			// 3단계 sql MAX(num)
			sql="SELECT MAX(num) FROM board";
			pstmt=con.prepareStatement(sql);
			// 4단계 실행 => 결과 rs 저장
			rs=pstmt.executeQuery();
			// 5 rs 첫행 접근 MAX(num) +1
			int num=0;
			if(rs.next()) {
				num=rs.getInt("MAX(num)")+1;
			}
			//3 sql insert
			sql="INSERT INTO board(num,name,pass,subject,content,readcount,date,file) VALUES(?,?,?,?,?,?,?,?)";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setString(2, boardDTO.getName());
			pstmt.setString(3, boardDTO.getPass());
			pstmt.setString(4, boardDTO.getSubject());
			pstmt.setString(5, boardDTO.getContent());
			pstmt.setInt(6, boardDTO.getReadcount());
			pstmt.setTimestamp(7, boardDTO.getDate());
			// 첨부파일
			pstmt.setString(8, boardDTO.getFile());
			
			//4 실행
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			//마무리
			dbClose();
		}
		
	}// insertBoard
	
	public void updateBoard(BoardDTO boardDTO) {
		try {
			// 1, 2 단계 db연결
			con=getConnection();
			
			//3 sql insert
			sql="UPDATE board SET subject=?, content=?, file=? WHERE num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, boardDTO.getSubject());
			pstmt.setString(2, boardDTO.getContent());
			pstmt.setString(3, boardDTO.getFile());
			pstmt.setInt(4, boardDTO.getNum());
			//4 실행
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			//마무리
			dbClose();
		}
	}// updateBoard
	

	// 리턴할형없음 deleteBoard(int num) 메서드 정의
	public void deleteBoard(int num) {
		try {
			// 1, 2 단계 db연결
			con=getConnection();
			
			//3 sql insert
			sql="DELETE FROM board WHERE num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);

			//4 실행
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			//마무리
			dbClose();
		}
	}// deleteBoard
	
	
	// 리턴할형 int getBoardCount() 메서드 정의
	public int getBoardCount() {
		int count=0;
		try {
			con=getConnection();
			// 3 sql COUNT(num) COUNT(*) (게시판 갯수니까 count 사용)
			sql="SELECT COUNT(*) FROM board";
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				count=rs.getInt("COUNT(*)");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// 마무리
			dbClose();
		}
		
		return count;
	} // getBoardCount
	
	// 리턴할형 없음 updateReadcount(int num) 메서드 정의
	public void updateReadcount(int num) {
		try {
			//1,2 디비 연결
			con = getConnection();
			//3 sql insert
			sql = "UPDATE board SET readcount=readcount+1 WHERE num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);

			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbClose();
		}
	}//updateReadcount
	
	
	
}//클래스
