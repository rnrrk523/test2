package Dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import Dto.MemberDto;

public class MemberDao {
	public Connection getConnection() throws Exception{
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		String id = "user1001";
		String pw = "pass1234";
		
		Class.forName(driver);
		Connection conn = DriverManager.getConnection(url, id, pw);
		
		return conn;
	}
	
	// 로그인check
	public boolean loginCheck(String id, String pw) throws Exception {
		String sql = "SELECT  COUNT(id)" + 
				" FROM    member" + 
				" WHERE   id = ?" + 
				" AND     pw = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		pstmt.setString(2, pw);
		ResultSet rs = pstmt.executeQuery();
		boolean ret = false;
		if(rs.next()) {
			ret = rs.getInt("COUNT(id)") == 1 ? true : false;
		}
		rs.close();
		pstmt.close();
		conn.close();
		return ret;
	}
	
	// 회원가입
	public void memberJoin(String id, String pw, String name) throws Exception {
		String sql = "INSERT INTO member(id, pw, name) VALUES(?, ?, ?)";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		pstmt.setString(2, pw);
		pstmt.setString(3, name);
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
	
//	회원 정보 가져오기
	public MemberDto getMemberInfo(String id) throws Exception {
		String sql = "SELECT  pw, name, point" + 
				" FROM    member" + 
				" WHERE   id = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		ResultSet rs = pstmt.executeQuery();
		MemberDto dto = null;
		if(rs.next()) {
			String pw = rs.getString("pw");
			String name = rs.getString("name");
			int point = rs.getInt("point");
			dto = new MemberDto(id, pw, name, point);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return dto;
	}
	
//	구입처리
	public void setPoint(String id, int result) throws Exception {
		String sql = "UPDATE member SET point = ? WHERE id = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, result);
		pstmt.setString(2, id);
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
	
//	멤버들의 정보 조회하기
	public ArrayList<MemberDto> getAllMembers() throws Exception {
		String sql = "SELECT id, pw, name, point FROM member";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		ArrayList<MemberDto> listRet = new ArrayList<MemberDto>();
		while(rs.next()) {
			String id = rs.getString("id");
			String pw = rs.getString("pw");
			String name = rs.getString("name");
			int point = rs.getInt("point");
			MemberDto dto = new MemberDto(id, pw, name, point);
			listRet.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}
	
//	멤버정보수정
	public void setMemberInfo(String id, String pw, String name, int point) throws Exception {
		String sql = "UPDATE member" + 
				" SET pw = ?," + 
				" name = ?," + 
				" point = ?" + 
				" WHERE   id = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, pw);
		pstmt.setString(2, name);
		pstmt.setInt(3, point);
		pstmt.setString(4, id);
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
	
//	멤버 삭제
	public void delMember(String id) throws Exception {
		String sql = "DELETE FROM member WHERE id = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setNString(1, id);
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
	
//	포인트 추가
	public void setMemberPoint() throws Exception {
		String sql = "SELECT id, pw, name, point" + 
				" FROM    member" +
				" ORDER BY id";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			String id = rs.getString("id");
			int point = rs.getInt("point") + 1;
			
			String sql2 = "UPDATE member" + 
					" SET point = ?" + 
					" WHERE   id = ?";
			PreparedStatement pstmt2 = conn.prepareStatement(sql2);
			pstmt2.setInt(1, point);
			pstmt2.setString(2, id);
			pstmt2.executeUpdate();
			pstmt2.close();
		}
		rs.close();
		pstmt.close();
		conn.close();
	}
	
	public static void main(String[] args) throws Exception {
		MemberDao mDao = new MemberDao();
		
//		멤버 삭제
//		mDao.delMember("SB");
		
//		멤버정보수정
//		mDao.setMemberInfo("YG", "123", "와이쥐", 500000);
		
//		멤버들의 정보 조회하기
//		ArrayList<MemberDto> memberlist = mDao.getAllMembers();
//		for(MemberDto dto : memberlist) {
//			System.out.println(dto.getId());
//			System.out.println(dto.getPw());
//			System.out.println(dto.getName());
//			System.out.println(dto.getPoint());
//			System.out.println("----------------------------");
//		}
		
//		구입처리하기
//		mDao.setPoint("YG", 1);
		
//		회원정보 가져오기
//		MemberDto memberInfo = mDao.getMemberInfo("YG");
//		System.out.println(memberInfo.getName());
		
//		회원가입
//		mDao.memberJoin("1", "2", "정");
		
//		로그인 체크
//		boolean check = mDao.loginCheck("YG", "1234");
//		System.out.println(check);
	}
}
