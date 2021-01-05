<%@page import="member.MemberVO"%>
<%@page import="java.sql.*"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
	request.setCharacterEncoding("utf-8"); // utf-8
    /* int memno = Integer.parseInt(request.getParameter("memno")); */
	String name = request.getParameter("name"); //불러오기
	String id = request.getParameter("id");
	String pass = request.getParameter("pass");
	int birth = Integer.parseInt(request.getParameter("birth"));
	String gender = request.getParameter("gender");
	String job = request.getParameter("job");
	String city = request.getParameter("city");
	
	MemberDAO instance = MemberDAO.getInstance(); //DAO 생성자
	Connection conn = instance.getConnection(); //커넥션
	/*	String getNoSql = "SELECT MAX(MEMNO) FROM MEMBER_TBL";
	int memno = 0;
	PreparedStatement pstmt = conn.prepareStatement(getNoSql);
	ResultSet rs = pstmt.executeQuery();
	if(rs.next()){
		memno = rs.getInt(1) + 1;
	} 
	*/
	int memno = instance.getMaxNo(); //DAO의 getMaxNo 매서드 실행 해서 최댓값 구하기  
	//밑에 것들 DAO 의 publc int insertMember(MemberVO vo)로 가져가기.
	MemberVO vo = new MemberVO(memno,name,id,pass,birth,gender,job,city,null); // joinDate는 dao에서 insert문에서 sysdate로 넘겨줘서 null 
	int cnt = instance.insertMember(vo); //insertMember여부에서 cnt 가져와서 성공 여부 가져오기
	String msg = null;
	if(cnt > 0){ 
		msg = "회원 가입 성공";  }
	else msg = "회원 가입 실패";
	//instance.close(rs, pstmt, conn);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 가입</title>
</head>
<body>
	<script type = "text/javascript">
	alert('<%= msg %>'); /* 메시지 띄우기 */
	location.href('selectMember.jsp'); /* selectMember.jsp로 돌아간다. */
	</script>
</body>
</html>