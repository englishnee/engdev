<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 창 만들기</title>
<style>
	.center {
		position:absolute;
		top:25%;
		left:40%;
	}
	table {
		font-size:11pt;
	}
</style>
</head>
<body>
<!-- 회원가입 폼 -->
<form action="MemberJoinAction.me" name="joinform" method="post" class="center">
	<table>
		<tr>
			<td>아이디</td>
		</tr>
		<tr>
			<td>
				<input type="text" name="M_ID" size="25">
				<input type="button" value="아이디 중복 확인">
			</td>
		</tr>
		
		<tr>
			<td>비밀번호</td>
		</tr>
		<tr>
			<td>
				<input type="password" name="M_PW" size="25">
			</td>
		</tr>
		
		<tr>
			<td>비밀번호 확인</td>
		</tr>
		<tr>
			<td>
				<input type="password" name="M_PW" size="25">
			</td>
		</tr>
		
		<tr>
			<td>이름</td>
		</tr>
		<tr>
			<td>
				<input type="text" name="M_NAME" size="25">
			</td>
		</tr>
		
		<tr>
			<td>휴대전화</td>
		</tr>
		<tr>
			<td>
				<input type="text" name="M_TEL" size="25" placeholder="'-'을 제외한 숫자만 입력하세요.">
			</td>
		</tr>
		
		<tr>
			<td>이메일</td>
		</tr>
		<tr>
			<td>
				<input type="text" name="M_EMAIL" size="25" value="">
			</td>
		</tr>

		<tr>
			<td>
				<a href="javascript:joinform.submit()">회원가입</a>
				<a href="javascript:history.go(-1)">취소</a>
			</td>
		</tr>
	</table>
</form>
</body>
</html>