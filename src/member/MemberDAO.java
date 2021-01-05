package member;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class MemberDAO {
	private static MemberDAO instance = new MemberDAO();
	ArrayList<MemberVO> list = new ArrayList<MemberVO>(); // MemberVO 불러옴

	private MemberDAO() {
	}

	public static MemberDAO getInstance() {
		return instance;
	}
//	public ArrayList<MemberVO> getAllList(){
//		return list;
//	}
//	

	public Connection getConnection() { // 오라클 커넥션 객체생성
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		String user = "hr"; // db 사용자
		String password = "hr"; // db 비밀번호
		Connection conn = null;
		try {
			// 오라클 접속에 성공하면
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection(url, user, password);
			System.out.println("오라클 접속 성공");
		} catch (Exception e) {
			// 오라클 접속에 실패하면
			e.printStackTrace();
			System.out.println("오라클 접속 실패");
		}
		return conn;
	}

	public int getMaxNo() {
		int memno = 0;
		try {
			String getNoSql = "SELECT MAX(MEMNO) FROM MEMBER_TBL"; // 최댓값 구하는 sql문
			Connection conn = getConnection();
			PreparedStatement pstmt = conn.prepareStatement(getNoSql);
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				memno = rs.getInt(1) + 1;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return memno; // Memno 리턴
	}

	public ArrayList<MemberVO> selectMembers() {
		ArrayList<MemberVO> list = new ArrayList<MemberVO>(); // 학생 목록 리스트
		try {
			Connection conn = getConnection(); // 오라클 연동
			String selectSql = "SELECT * FROM MEMBER_TBL ORDER BY MEMNO"; // sql문 작성
			PreparedStatement pstmt = conn.prepareStatement(selectSql); // sql 실행시켜주는 것
			ResultSet rs = pstmt.executeQuery(); // 명령에 대한 반환
			while (rs.next()) { // ResultSet에 넘겨줌
				// selectMember 에서 가져옴
				int memno = rs.getInt("MEMNO");
				String name = rs.getString("NAME");
				String id = rs.getString("ID");
				String pass = rs.getString("PASS");
				int birth = rs.getInt("BIRTH");
				String gender = rs.getString("GENDER");
				String job = rs.getString("JOB");
				String city = rs.getString("CITY");
				Date joinDate = rs.getDate("JOINDATE");
				MemberVO vo = new MemberVO(memno, name, id, pass, birth, gender, job, city, joinDate); // 객체 정보 담아주기
				list.add(vo);
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		return list; // 리스트 리턴
	}

	public int insertMember(MemberVO vo) {
		int cnt = 0; // 성공했는지 체크하기 위하여
		try {
			Connection conn = getConnection(); // 오라클 연동
			String insertSql = "INSERT INTO MEMBER_TBL(memno, name, id, pass, birth, gender, job, city, joindate) "
					+ " VALUES(?, ?, ?, ?, ?, ?, ?, ?, SYSDATE)";
			PreparedStatement pstmt = conn.prepareStatement(insertSql);
			// insertMemberPro 에서 가져와서 vo.getXXX로 바꿔주기
			pstmt.setInt(1, vo.getMemno());
			pstmt.setString(2, vo.getName());
			pstmt.setString(3, vo.getId());
			pstmt.setString(4, vo.getPass());
			pstmt.setInt(5, vo.getBirth());
			pstmt.setString(6, vo.getGender());
			pstmt.setString(7, vo.getJob());
			pstmt.setString(8, vo.getCity());
			cnt = pstmt.executeUpdate();
			close(null, pstmt, conn);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return cnt;
	}

	public int updateMember(MemberVO vo) {
		int um = 0;
		try {
			Connection conn = getConnection(); // 오라클 연동
			String updateSql = "UPDATE MEMBER_TBL SET PASS=?, BIRTH=?, GENDER=?, JOB=?, CITY=? WHERE MEMNO = ?";
			PreparedStatement pstmt = conn.prepareStatement(updateSql);
			// updateMemberPro 에서 가져와서 vo.getXXX로 바꿔주기
			pstmt.setString(1, vo.getPass());
			pstmt.setInt(2, vo.getBirth());
			pstmt.setString(3, vo.getGender());
			pstmt.setString(4, vo.getJob());
			pstmt.setString(5, vo.getCity());
			pstmt.setInt(6, vo.getMemno());
			um = pstmt.executeUpdate();
			close(null, pstmt, conn);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return um;
	}


	public MemberVO getAMember(int memno) { // select에 사용
		MemberVO vo = null;
		try {
			Connection conn = instance.getConnection(); // 오라클 연동
			String selectSql = "SELECT * FROM MEMBER_TBL WHERE memno =?";
			PreparedStatement pstmt = conn.prepareStatement(selectSql);
			pstmt.setInt(1, memno); // memno
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				vo = new MemberVO(memno, rs.getString("name"), rs.getString("id"), rs.getString("pass"),
						rs.getInt("birth"), rs.getString("gender"), rs.getString("job"), rs.getString("city"),
						rs.getDate("joinDate"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return vo;
	}

	//deleteSql실행
	public int deleteMember(int memno, String pass) { //delete를 실행해주려면 memno와, pass가 필요하기때문에 pass도 추가로 넣었다.
		int dm = 0;
		try {
			Connection conn = getConnection(); // 오라클 생성
			String deleteSql = "DELETE FROM MEMBER_TBL WHERE MEMNO = ?"; // deleteSql문
			PreparedStatement pstmt = conn.prepareStatement(deleteSql);
			MemberVO member = getAMember(memno); // 위의 getAMember 가져옴
			String dbPass = member.getPass();
			if (member != null) { //memno와 null 이 같지 않으면
				if (pass.equals(dbPass)) { //db에 들어가있는 Pass와 입력한 pass가 같다면
					pstmt.setInt(1, memno);
					dm = pstmt.executeUpdate();
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dm;
	}
	
	// idCheck.jsp의 checkSql 실행
	public boolean idAvailChk(String id) {
		try {
			Connection conn = getConnection();
			String checkSql = "SELECT * FROM MEMBER_TBL WHERE id = ?";
			PreparedStatement pstmt = conn.prepareStatement(checkSql);
			pstmt.setString(1, id); // id
			ResultSet rs = pstmt.executeQuery();

			if (rs.next()) {
				// 아이디가 중복되면
				close(rs, pstmt, conn);
				System.out.println("중복됩니다.");
				return false;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		// 아이디가 중복되지 않으면
		System.out.println("중복되지 않는 아이디 입니다.");
		return true;
	}

	// jdbc에 활용한 객체들을 역순으로 자원반환
	public void close(ResultSet rs, PreparedStatement pstmt, Connection conn) {
		if (rs != null)
			try {rs.close();} catch (Exception e) {	e.printStackTrace();}
		if (pstmt != null)
			try {pstmt.close();} catch (Exception e) { e.printStackTrace();
			}
		if (conn != null)
			try { conn.close(); } catch (Exception e) { e.printStackTrace();
			}
	}
}
