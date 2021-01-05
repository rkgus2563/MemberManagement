'<%@page import="member.MemberVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="member.MemberDAO"%>
<%@page import="java.sql.Connection"%>
<%@ page import = "java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file = "header.jsp" %> <!-- 기본 있던 것들을 모두 지워주고 header를 계속 위에 띄워준다.--!>
	<%
	//하나하나 다 주석 달아주기 (밑에문장)
	MemberDAO instance = MemberDAO.getInstance(); //MemberDAO 불러오기
	ArrayList<MemberVO> list = instance.selectMembers(); //DAO의 selectMembers 가져오기
	
	%>
	<h2>회원 목록</h2>
	<table border = "1"> <!-- 테이블생성 -->
	<tr align = "center">
	<th width = "100">회원번호</th>
	<th width = "100">이름</th><th width = "100">아이디</th>
	<th width = "100">비밀번호</th><th width = "100">생년(4자리)</th>
	<th width = "50">성별</th><th width = "100">직업</th>
	<th width = "100">도시</th><th width = "100">가입일자</th>
	<th width = "50">탈퇴</th>
	</tr>
	<%
	for(int i = 0; i < list.size(); i++){
		MemberVO vo = list.get(i); //for문 돌면서 MemberVO 사용
		int memno = vo.getMemno();
		String name = vo.getName();
		String id = vo.getId();
		String pass = vo.getPass();
		int birth = vo.getBirth();
		String gender =vo.getGender();
		String job = vo.getJob();
		String city = vo.getCity();
		Date joinDate = vo.getJoindate(); 
	%>
	<tr align = "center">
	<td width = "100"><a href = "updateMember.jsp?memno=<%= vo.getMemno() %>"><%= vo.getMemno() %></a></td> <!-- 수정 할 수 있는 기능 -->
	<td width = "100"><%= vo.getMemno() %></td><td width = "100"><%= vo.getId() %></td> <!-- 이름 , 아이디  -->
	<td width = "100"><%= vo.getPass() %></td><td width = "100"><%= vo.getBirth() %></td> <!-- 비밀번호 , 생일  -->
	<td width = "50"><%= vo.getGender() %></td><td width = "100"><%= vo.getJob() %></td> <!-- 성별 , 직업  -->
	<td width = "100"><%= vo.getCity() %></td><td width = "100"><%= vo.getJoindate() %></td> <!-- 도시, 가입일자 -->
	<td width = "100"><a href = "deleteMember.jsp?memno=<%= vo.getMemno() %>">탈퇴</a></td> <!-- 탈퇴 할 수 있는 기능 -->
	</tr>
	<% }
	%>
	</table>
<%@ include file = "footer.jsp" %> <!-- 기본 있던 것들을 모두 지워주고 footer 를 계속 밑에 띄워준다. -->