<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
<meta charset="UTF-8">
<title>board write</title>
<style>
	.chk input[type='radio'] {
		display:none;
	}
	.chk input[type='radio']+span {
		display:inline-block;
		padding:5px 5px;
		border:1px solid #AEB6BF;
		border-radius:10px;
		background-color:white;
		text-align:center;
		cursor:pointer;
	}
	.chk input[type='radio']:checked+span {
		background-color:#8E9091;
		color:white;
		border-radius:10px;
	}
	.container {
		width: 100%;
  		min-width: 1000px;
  		max-width: 1000px;
  		margin: 0 auto 0 auto;
	}
	.mcont {
 		margin: 0 auto;
  		padding: 15px 20px 50px 20px;
 		box-sizing: border-box;
}
</style>
<script src="//cdn.ckeditor.com/4.19.0/standard/ckeditor.js"></script>
</head>
<body>

<div>
	<jsp:include page="../includes/nav.jsp"/>
	<jsp:include page="../includes/header.jsp"/>
</div>

<section class="container">
<form name="writeForm" method="post" action="/a_board/write" class="mcont">
<table>
		<tr>
			<td>
				<label class="chk"><input type="radio" id="life" name="a_type" value="1"/><span>동네 생활</span></label>
				<label class="chk"><input type="radio" id="food" name="a_type" value="2"/><span>동네 맛집</span></label>
				<label class="chk"><input type="radio" id="with" name="a_type" value="3"/><span>같이 해요</span></label>
			</td>
		</tr>
		
		<tr>
			<td>
				<label for="title">제목</label><br>
				<input type="text" id="title" name="a_title" placeholder="제목을 입력하세요."/>
			</td>
		</tr>
		
		<tr>
			<td>
				<label for="content">내용</label><br>
				<textarea id="content" name="a_content" rows="15" cols="50" placeholder="내용을 입력하세요."></textarea>
				<script type="text/javascript">
					CKEDITOR.replace('content', {filebrowserUploadUrl: '/a_board/fileUpload', 
						enterMode: CKEDITOR.ENTER_BR,
						shiftEnterMode: CKEDITOR.ENTER_P,
						width:950, height:300});
				</script>
			</td>
		</tr>
		
		<tr>
			<td>
				<label for="id">작성자</label><br>
				<input type="text" id="id" name="id" value="${member.id}" readonly/>
			</td>
		</tr>
		
		<tr>
			<td>
				<button type="submit">등록</button>
				<button type="reset" onclick="javascript:history.go(-1)">취소</button>
			</td>
		</tr>
</table>
</form>
</section>

<div>
	<jsp:include page="../includes/footer.jsp" />
</div>
</body>
</html>
