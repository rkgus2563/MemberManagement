<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import = "java.sql.*" %>
    <%@page import = "member.MemberDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%
	request.setCharacterEncoding("UTF-8"); //utf-8
	MemberDAO instance = MemberDAO.getInstance(); //DAO 생성자
	
	String id = request.getParameter("id"); //id 체크를 해야하니까 아이디를 가져옴
	/* Connection conn = instance.getConnection();
	String checkSql = "SELECt * FROM MEMBER_TBL WHERE id = ?"; 
	PreparedStatement pstmt = conn.prepareStatement(checkSql);
	pstmt.setString(1,id);
	*/
	boolean result = instance.idAvailChk(id); // 아이디 입력 후 넣어서 중복이 되는지 안되는지 확인한다. 
	
%>
<title>중복 아이디 확인</title>
</head>
<body bgcolor = "white">
<div align = "center">
	<b><%= id %></b>는
	<%
		if(result){
			//중복이 되지 않으면
		%><font color = "blue">사용 가능</font> 합니다.
		<% } else { 
			//중복이 되면
		%><font color = "red">사용 불가능</font> 합니다.
		<% }
	%>
	<hr>
	<a href = "javascript:self.close()">창 닫기</a> <!-- 창 닫기를 누르면 팝업창이 닫 -->
	</div>
</body>
</html>