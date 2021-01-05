<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 탈퇴</title>
</head>
<body>
<%
   request.setCharacterEncoding("utf-8"); //utf-8
   MemberDAO instance = MemberDAO.getInstance(); //dao생성자
   int memno = Integer.parseInt(request.getParameter("memno"));
   String pass = request.getParameter("pass");

   int cnt = instance.deleteMember(memno, pass); //dao 의 deleteMember
   String msg = "";
   if(cnt > 0){ 
	   //비밀번호가 맞다면 
	   //회원탈퇴 메시지 띄워줌
      msg = "회원 탈퇴 완료";
   }else{
	   // 아니라면 비밀번호 오류 메시지 띄워줌
      msg = "비밀번호 오류"; 
   }
         
%>
   <script>
      alert('<%= msg %>'); 
      location.href('selectMember.jsp'); //selectMember.jsp 로 돌아감
   </script>
</body>
</html>