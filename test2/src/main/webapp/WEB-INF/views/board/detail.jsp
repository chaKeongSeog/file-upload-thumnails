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
	<table border="1">
		<tr>
			<td>글번호</td>
			<td>${board.bno}</td>
		</tr>
		<tr>
			<td>제목</td>
			<td>${board.title}</td>
		</tr>
		<tr>
			<td>내용</td>
			<td>${board.content}</td>
		</tr>
		<tr>
			<td>아이디</td>
			<td>${board.id}</td>
		</tr>
		<tr>
			<td>첨부파일</td>
			<td>
				<c:forEach var="attach" items="${board.attach}">
					첨부파일: <a href="#">${attach.originFileName}</a> <span>X</span>
				</c:forEach>
			</td>
		</tr>
		<form action="<%=request.getContextPath()%>/board/modifyForm" method="post">
			<input type="hidden" name="bno" value="${board.bno}"/>
			<input type="hidden" name="curPage" value="${curPage}"/>
			<input type="hidden" name="search_option" value="${search_option}"/>
			<input type="hidden" name="keyword" value="${keyword}"/>
			<input type="submit" value="수정"/>
		</form>
	</table>
	
</body>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script>
	$(function(){
		
	});
</script>
</html>