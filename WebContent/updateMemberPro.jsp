<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ page import="member.MemberDAO" %>
<%@ page import="member.MemberVO" %>
<%@ page import="java.sql.*" %>
<%
	request.setCharacterEncoding("utf-8"); //utf-8
	MemberDAO instance = MemberDAO.getInstance();   //MemberDAO 생성자
	MemberVO vo = new MemberVO(); //MemberVO 생성자 
	//memno,name,id,pass,birth,gender,job,city를 다 넣어줌
	vo.setMemno(Integer.parseInt(request.getParameter("memno"))); // 받아오기
	vo.setName(request.getParameter("name"));
	vo.setId(request.getParameter("id"));
	vo.setPass(request.getParameter("pass"));
	vo.setBirth(Integer.parseInt(request.getParameter("birth"))); 
	vo.setGender(request.getParameter("gender"));
	vo.setJob(request.getParameter("job"));
	vo.setCity(request.getParameter("city"));

	String msg = null; //msg 만들어주기
	int cnt = instance.updateMember(vo); //updateMember cnt
	if(cnt > 0){
		msg = "회원 정보 수정 성공";//성공 메시지를 띄워준 후 정보 수정
	}else{		
		msg = "회원 정보 수정 실패";// 실패메시지를 띄워준
		//instance.close(rs,pstmt,conn);
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>레코드 수정</title>
</head>
<body>
	<script type="text/javascript">
		alert('<%= msg %>');    
		location.href('selectMember.jsp');  /* selectMember.jsp로 돌아감 */
	</script>
</body>
</html>