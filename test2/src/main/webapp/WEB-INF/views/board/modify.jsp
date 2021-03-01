<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>상세내용</h2>
	<form action="<%=request.getContextPath()%>/board/modify" enctype="multipart/form-data" method="post" id="attachForm">
		<input type="hidden" name="bno" value="${map.board.bno}"/>
		<input type="hidden" name="id" value="${map.board.id}"/>
		<input type="hidden" name="curPage" value="${map.curPage}"/>
		<input type="hidden" name="search_option" value="${map.search_option}"/>
		<input type="hidden" name="keyword" value="${map.keyword}"/>
		<table border="1">
			<tr>
				<td>글번호</td>
				<td>${map.board.bno}</td>
			</tr>
			<tr>
				<td>제목</td>
				<td>
					<input type="text" name="title" id="title" value="${map.board.title}"/>
				</td>
			</tr>
			<tr>
				<td>내용</td>
				<td>
					<textarea name="content" id="content" cols="30" rows="10">${map.board.content}</textarea>
				</td>
			</tr>
			<tr>
				<td>아이디</td>
				<td>${map.board.id}</td>
			</tr>
			<tr>
				<td colspan="3">
					<span id="addFile">파일추가:+</span> &nbsp;&nbsp;&nbsp; <span id="deleteFile">파일삭제:-</span>
				</td>
			</tr>
			<tr>
				<td id="fileArea" colspan="3">
					
				</td>
			</tr>
			<tr>
				<td colspan="3">
					<c:forEach var="attach" items="${map.board.attach}">
						<div id="attachDiv">
							첨부파일: <a href="#">${attach.originFileName}</a><span onclick="cancel('${attach.ano}',this)" style="color:red;cursor:pointer;">X</span><br />
						</div>
					</c:forEach>
				</td>
			</tr>
				<input type="button" name="modify" id="modify" value="수정"/>
		</table>
	</form>
</body>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script>
	$(function(){
		var index = 0;
		$('#modify').on('click',function(){
			var form = $('#attachForm');
			form.submit();
		});
		
		$('#addFile').on('click',function(){
			index++;
			$('#fileArea').append('<div id="fileDiv'+index+'"><input type="file" name="file" id="file'+index+'"/> <br /></div>');
			
		});
		$('#deleteFile').on('click',function(){
			$('#fileArea #fileDiv'+index).remove();	
			index--;
			
		});
	});
	function cancel(ano,t){
		
		$(t).parent().remove();
		$('#attachForm').append('<input type="text" name="ano" value="'+ano+'"/>');
	}
</script>
</html>