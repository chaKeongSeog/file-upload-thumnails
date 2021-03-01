<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@include file="registHeader.jsp" %>
<title>Insert title here</title>
</head>
<body>
	<h2>글쓰기</h2>
	<form action="<%=request.getContextPath()%>/board/write" method="post" enctype="multipart/form-data" id="boardWriteForm">
		<table>
			<tr>
				<td>
					<input type="hidden" name="id" value="${id}"/>
				</td>
			</tr>
			<tr>
				<td>
					<input type="text" name="title" placeholder="제목"/>
				</td>
			</tr>
			<tr>
				<td>
					<textarea name="content" id="content" cols="30" rows="10" placeholder="내용"></textarea>
				</td>
			</tr>
			<tr>
				<td>
					<span id="addFile">파일추가:+</span> &nbsp;&nbsp;&nbsp; <span id="deleteFile">파일삭제:-</span>
				</td>
			</tr>
			<tr>
				<td id="fileArea">
					
				</td>
			</tr>
			<tr>
				<td>
					<button type="submit" name="write" id="write">작성</button>
				</td>
			</tr>
		</table>
	</form>
</body>
<script>
	$(function(){
		$('#content').summernote({
			height:300,
			width:1000
		});
		
		$('#write').on('click',function(){
			var form = $('#boardWriteForm');
			form.submit();
			
		});
		
		
		var index = 0;
		$('#addFile').on('click',function(){
			index++;
			$('#fileArea').append('<div id="fileDiv'+index+'"><input type="file" name="file" id="file'+index+'"/> <br /></div>');
			
		});
		$('#deleteFile').on('click',function(){
			$('#fileArea #fileDiv'+index).remove();	
			index--;
			
		});
	});
</script>
</html>