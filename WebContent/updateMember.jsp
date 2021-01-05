<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
 <%@ include file = "header.jsp" %>
<title>회원 정보 수정</title>

<%
	request.setCharacterEncoding("utf-8"); //utf-8
	int memno = Integer.parseInt(request.getParameter("memno")); //memno 
	MemberDAO instance = MemberDAO.getInstance(); //DAO 생성자
	Connection conn = instance.getConnection(); // 커넥션
	String selectSql = "SELECT * FROM MEMBER_TBL WHERE memno = ?"; //selectSql문
	PreparedStatement pstmt = conn.prepareStatement(selectSql); 
	pstmt.setInt(1, memno);
	ResultSet rs = pstmt.executeQuery();
	if(rs.next()){
%>
<form action = "updateMemberPro.jsp" method = "post"> <!-- updateMemberPro로 넘어감 -->
	<table border = "1" style = "width:400"> <!-- border 1에 width 크기 400으로 설정  -->
	<tr><td colspan = "2" align = "center"><b>회원 수정 정보 입력</b></td></tr>
	<tr><th>회원번호</th><td><input type = "text" name = "memno" value = "<%= rs.getInt("memno") %>" readonly></td>
	</tr>
	<tr><th>이름</th><td><input type = "text" name = "name" value = "<%= rs.getString("name") %>" disabled></td>
	</tr>
	<tr><th>아이디</th><td><input type = "text" name = "id" value = "<%= rs.getString("id") %>" disabled></td>
	</tr>
	<tr><th>비밀번호</th><td><input type = "password" name = "pass" value = "<%= rs.getString("pass") %>" ></td>
	</tr>
	<tr><th>생년(4자리)</th>
	<td><select name = "birth">
<% 	for(int i = 2001; i <= 2010; i++){ /* 생년 2001년부터 2010년 까지 선택 할 수 있도록 설정 */
	if(rs.getInt("birth") == i){
		%>
	<option value = "<%= i %>" selected><%= i %></option>
<% 	}else{
%>		<option value = "<%= i %>"> <%= i %></option>
<% 	}
	}
%>
	</select></td>
	</tr>
	<tr><th>성별</th>
	<td>
	<%
	if(rs.getString("gender").equals("남자")){ //gender에 남자가 들어가면 
%>	<input type = "radio" name = "gender" value = "남자" checked>남자 <!-- 남자에 체크 --> 
	<input type = "radio" name = "gender" value = "여자">여자
<% 	}else{ // 아니면 = 여자가 들어가면
%>	<input type = "radio" name = "gender" value = "남자">남자
	<input type = "radio" name = "gender" value = "여자">여자 <!-- 여자에 체크  -->
<% 	}
%>	</td>
	</tr>
	<tr><th>직업</th>		<td><input type = "text" name = "job" value = "<%= rs.getString("job") %>"></td>
	</tr>
	<tr><th>도시</th>		<td><input type = "text" name = "city" value = "<%= rs.getString("city") %>"></td>
	</tr>
	<tr>
		<td colspan = "2" align = "center">
			<input type = "submit" value = "수정"> <input type = "reset" value = "취소">
			</td>
			</tr>
			</table>
</form>
<% } instance.close(null, pstmt, conn); %>
 <%@ include file = "footer.jsp" %>