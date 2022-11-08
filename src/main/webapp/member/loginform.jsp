<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 페이지</title>
<style>
	.center{
    	position: absolute;
    	top: 35%;
    	left: 43%;
	}
	table {
		font-size:11pt;
	}

</style>
</head>
<body>
<!-- 로그인 폼 -->
<form action="MemberLoginAction.me" name="loginform" method="post" class="center">
	<table>
		<tr>
			<td>아이디 </td>
			<td>
				<input type="text" name="M_ID"/>
			</td>
		</tr>
		
		<tr>
			<td>비밀번호 </td>
			<td>
				<input type="password" name="M_PW"/>
			</td>
		</tr>
		
		<tr>
			<td colspan="4" align="right">
				<a href="javascript:loginform.submit()">로그인</a>
				<a href="MemberJoin.me">회원가입</a>
			</td><br>
		</tr>
		
		<tr>
			<td colspan="4" align="center">
				<a href="FindID.me">아이디 찾기</a>
				<span> / </span>
				<a href="FindPW.me">비밀번호 찾기</a>
			</td>
		</tr>
	</table>
</form>
</body>
</html>