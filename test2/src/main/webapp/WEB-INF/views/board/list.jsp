<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
</head>
<style>
	body,ul,li{
		margin: 0;
		padding: 0;
		list-style: none;
	}
	.pagenation ul li{
		display: inline-block;
	}
	.pagenation ul li a{
		display:block;
		padding:10px;
	}
</style>
<body>
<div style="text-align: left;">
<h2>게시판</h2>
	<form action="<%=request.getContextPath()%>/board/list" method="get">
		<c:choose>
			<c:when test="${map.search_option =='all'}">
				<select name="search_option">
					<option value="all" selected="selected">전체</option>
					<option value="title">제목</option>
					<option value="content">내용</option>				
				</select>
			</c:when>
			<c:when test="${map.search_option =='title'}">
				<select name="search_option">
					<option value="all">전체</option>
					<option value="title" selected="selected">제목</option>
					<option value="content">내용</option>				
				</select>
			</c:when>
			<c:when test="${map.search_option =='content'}">
				<select name="search_option">
					<option value="all">전체</option>
					<option value="title">제목</option>
					<option value="content" selected="selected">내용</option>				
				</select>
			</c:when>
		</c:choose>
		<input type="text" name="keyword" value="${map.keyword}"/>
		<input type="submit" value="검색"/>
	</form>


	<table border="1" style="width:500px;">
		<tr>
			<th>글번호</th>
			<th>제목</th>
			<th>아이디</th>
			<th>날짜</th>
		</tr>
		<c:forEach var="board" items="${map.board}">
			<tr>
				<td>${board.bno}</td>
				<td><a href="#" onclick="detail('${board.bno}')">${board.title}</a></td>
				<td>${board.id}</td>
				<td>${board.regdate}</td>
			</tr>
		</c:forEach>	
		
	</table>
	<div style="clear:both;"></div>
		<div style="text-align: left;">
			<form action="<%=request.getContextPath()%>/board/writeForm" method="post">
				<input type="hidden" name="id" value="아이디"/>
				<button type="submit">글쓰기</button>
			</form>
		</div>	
	<div class="pagenation">
		<ul>
			<li><a href="#" onclick="list('1')">처음</a></li>
			<li><a href="#" onclick="list('${map.pager.prevPage}')">이전</a></li>
			<c:forEach var="num" begin="${map.pager.blockBegin}" end="${map.pager.blockEnd}">
				<c:choose>
					<c:when test="${map.pager.curPage == num}">
						[<a href="#" style="color:red;" onclick="list('${num}')">${num}</a>]
					</c:when>
					<c:otherwise>
						<a href="#" onclick="list('${num}')">${num}</a>					
					</c:otherwise>
				</c:choose>
			</c:forEach>
			<li><a href="#" onclick="list('${map.pager.nextPage}')">다음</a></li>
			<li><a href="#" onclick="list('${map.pager.totPage}')">끝</a></li>
		</ul>
		
	</div>
</div>
</body>
 <script src="<%=request.getContextPath()%>/resources/js/board.js"></script>
<script>
function list(page){
	location.href="/home/board/list?curPage="+page+"&search_option=${map.search_option}&keyword=${map.keyword}";
}
function detail(bno){
	location.href="<%=request.getContextPath()%>/board/detail?bno="+bno+"&search_option=${map.search_option}&keyword=${map.keyword}&curPage=${map.pager.curPage}";	
}
</script>
</html>