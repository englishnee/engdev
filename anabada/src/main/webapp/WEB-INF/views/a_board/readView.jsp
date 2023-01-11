<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 상세보기</title>
<style>
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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js""></script>
<script type="text/javascript">
	$(document).ready(function() {
		var formObj = $("form[name='readForm']");

		$(".update_btn").on("click", function() {
				formObj.attr("action", "/a_board/updateView");
				formObj.attr("method", "get");
				formObj.submit();
			})
			
			$(".delete_btn").on("click", function() {
				var deleteYN = confirm("삭제 하시겠습니까?");
				if(deleteYN == true) {
					formObj.attr("action", "/a_board/delete");
					formObj.attr("method", "get");
					formObj.submit();
				}
			})
			
		$(".list_btn").on("click", function() {
			location.href = "/a_board/list?page=${scri.page}" + "&perPageNum=${scri.perPageNum}" + 
					"&searchType=${scri.searchType}" + "&keyword=${scri.keyword}";
		});
	});
	
	$(document).ready(function() {
	var button = document.querySelector('.report_btn');
		
		button.addEventListener("click", function() {
			window.open("/a_board/report", "신고", "width=400, height=600, left=0, top=0");
		});
	});
	
	/* 좋아요 */
	$(document).ready(function() {
		
		var likeVal = ${Chk};
		
		if(likeVal > 0) {
			$("#heart").attr("src", "<c:url value='/images/heart.png'/>");
			$(".like").prop("name", likeVal);
		}
		else {
			$("#clear").attr("src", "<c:url value='/images/clear.png'/>");
			$(".like").prop("name", likeVal);
		}  
		
		if(likeVal > 0) {
			$("#heart").on("click", function() {
			$.ajax ({
				url: '/a_board/deleteLike',
				type: 'POST',
				dataType: 'text',				
				data: ({'id': '${sessionScope.id}', 'a_bno': '${read.a_bno}' }),
				success: function(data) {
					/* that.prop("name", data);
					if(data == 1) {
						$("#clear").attr("src", "<c:url value='/images/heart.png'/>");
					}
					else {
						$("#clear").attr("src", "<c:url value='/images/clear.png'/>");			
					} */
					alert("좋아요 취소 성공");
					$("#heart").attr("src", "<c:url value='/images/clear.png'/>");
				}
			});
		});
		} else {
			$("#clear").on("click", function() {
			$.ajax ({
				url: '/a_board/insertLike',
				type: 'POST',
				dataType: 'text',				
				data: ({'id': '${sessionScope.id}', 'a_bno': '${read.a_bno}' }),
				success: function(data) {
					/* that.prop("name", data);
					if(data == 1) {
						$("#clear").attr("src", "<c:url value='/images/heart.png'/>");
					}
					else {
						$("#clear").attr("src", "<c:url value='/images/clear.png'/>");			
					} */
					alert("좋아요 성공");
					$("#clear").attr("src", "<c:url value='/images/heart.png'/>");
				}
			});
		});
	}
});
</script>

</head>
<body>

<div>
	<jsp:include page="../includes/nav.jsp"/>
	<jsp:include page="../includes/header.jsp"/>
</div>
	<!-- 게시글 -->
<section class="container">
<div class="mcont">
	<form name="readForm" method="post" role="form">
		<input type="hidden" id="a_bno" name="a_bno" value="${read.a_bno }"/>
		<input type="hidden" id="page" name="page" value="${scri.page }"/>
		<input type="hidden" id="perPageNum" name="perPageNum" value="${scri.perPageNum }"/>
		<input type="hidden" id="searchType" name="searchType" value="${scri.searchType }"/>
		<input type="hidden" id="keyword" name="keyword" value="${scri.keyword }"/>
		<input type="hidden" id="cateType" name="cateType" value="${scri.cateType }"/>
	</form>

	<div>
		작성자 <input type="text" id="id" name="id" value="${read.id}" readonly/>
	</div>

	<div>
		제목 <input type="text" id="a_title" name="a_title" value="${read.a_title }" readonly/>
	</div>

	<div>
		<textarea id="a_content" name="a_content" readonly><c:out value="${read.a_content }"/></textarea>
		<script type="text/javascript">
			CKEDITOR.replace('a_content', {filebrowserUploadUrl: '/a_board/fileUpload', width:950, height:300});
		</script>
	</div>


	<div>
		<c:if test="${read.id eq member.id }">
			<button type="button" class="update_btn">수정</button>
			<button type="button" class="delete_btn">삭제</button>
		</c:if>
	</div>
		
	<div>	
		<button type="button" class="list_btn">목록</button>
	</div>
	
	<div>
		<button type="button" class="report_btn">신고</button>
	</div>
	
	<c:choose>
		<c:when test="${Chk == 0}"> 
			<img id="clear" src="<c:url value='/images/clear.png'/>" style="width:40px; height:40px;"/>
	 	</c:when>
		<c:otherwise>  
 			<img id="heart" src="<c:url value='/images/heart.png'/>" style="width:40px; height:40px;"/> 
	 	</c:otherwise>
	</c:choose> 
	
	<%-- <span id='likeCount'>${read.a_like_cnt }</span> --%>
	
<div>
	<%@include file="replyReadView.jsp" %>
</div>
</div>
</section>

<div>
	<jsp:include page="../includes/footer.jsp" />
</div>
</body>
</html>