<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

 <%@ include file = "header.jsp" %>
<title>회원 가입</title>

<h2>회원 가입</h2>
<form method = "post" action = "insertMemberPro.jsp" name = "regForm"> <!-- insertMemberPro 로 넘어감 -->
<table border = "1" style = "width:400"> <!-- border 1 에 크기 width 400으로 설정 -->
<tr><td colspan = "2" align = "center">
<b>회원가입 정보 입력</b>
</td>
</tr>
<tr><th>이름</th><td><input type = "text" name = "name" value = "강길동"></td> <!-- 강길동 기본값으로 넣어줌 -->
</tr>
<tr><th>아이디</th>
<td><input type = "text" name = "id">
<input type = "button" value = "중복확인" onclick = "idCheck(this.form.id.value)">  <!-- idCheck에서 중복확인을 해본다 -->
</td>
</tr>
<tr><th>비밀번호</th><td><input type = "password" name = "pass" value = "1234"></td> <!-- 1234 을 기본값으로 넣어준다  -->
</tr>
<tr><th>생년(4자리)</th>
<td><select name = "birth">
<% for(int i = 2001; i <= 2010; i++){ %> <!-- 2001년에서 2010년 생년을 설정할 수 있게 함 -->
<option value = "<%= i %>"> <%= i %></option>
<% } %>
</select>
</td>
</tr>
<tr><th>성별</th>
<td><input type = "radio" name = "gender" value = "남자" checked>남자 <!-- 성별 고르기 -->
	<input type = "radio" name = "gender" value = "여자">여자  <!-- type을 radio로 설정하여서 하나만 선택하게끔 함 -->
	</td>
	</tr>
	<tr><th>직업</th><td><input type = "text" name = "job" value = "학생"></td> <!-- 직업 입력 -->
	</tr>
	<tr><th>도시</th><td><input type = "text" name = "city" value = "성남"></td> <!-- 도시 입력 -->
	</tr>
	<tr><td colspan = "2" align = "center">
	<input type = "submit" value = "가입"><input type = "reset" value = "재작성">
	</td>
	</tr>
</table>
</form>
<script type = "text/javascript">
	function idCheck(id){
		if(id == ""){
				alert("아이디를 입력해 주세요.");
				document.regForm.id.focus();
			}else{
				url = "idCheck.jsp?id="+id;
				window.open(url,"post","width=400,height=200");
		}
		}
</script>
 <%@ include file = "footer.jsp" %>