<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  

<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org"
	xmlns:layout="http://www.ultraq.net.nz/thymeleaf/layout"
	data-layout-decorate="~{sample/layout/sampleLayout}"
	>
	
<head>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script th:inline="javascript">
/*<![CDATA[*/
$(function () {

	$(".fileDrop").on("dragenter dragover", function(event){
		event.preventDefault();
	});
	
	$(".fileDrop").on("drop", function(event){
		event.preventDefault();
		
		var files = event.originalEvent.dataTransfer.files;
		
		var file = files[0];
		
		//console.log(file);
		
		var formData = new FormData(); // HTML5
		formData.append("file", file);
		$.ajax({
			url: '/home/sample/upload/uploadAjax',
			data: formData,
			dataType: 'text',
			processData: false,
			contentType: false,
			type: 'POST',
			success: function(data){
				alert(data);			
						
				var data = replace(data);
				//이미지 인경우 썸네일을 보여준다.
				if(checkImageType(data)){
					str = "<div>"
						+ "<a href='/home/sample/upload/displayFile?fileName=" + getImageLink(data) + "'>"
						+ "<img src='/home/sample/upload/displayFile?fileName=" + data + "'/>"
						+ "</a>"
						+ "<small data-src='" + data + "'>X</small></div>";
				}else {
					str = "<div>"
						+ "<a href='/home/sample/upload/displayFile?fileName=" + data + "'>"
						+ getOriginalName(data) + "</a>"
						+ "<small data-src='" + data + "'>X</small></div>";
				}//else
					
				$(".uploadedList").append(str);	
			},
		});// ajax
		
	});
	//https://118k.tistory.com/42 get 방식으로 전송시 &,+ 기호 수정
	function replace(inum) { // 정규식을 이용한 문자 변경 
		inum = inum.replace(/&/g, "%26"); 
	    inum = inum.replace(/\+/g, "%2B"); 
	    return inum; 
	}

	/* 컨트롤러로 부터 전송받은 파일이 이미지 파일인지 확인하는 함수 */
	function checkImageType(fileName){
		var pattern = /jpg$|gif$|png$|jpeg$/i;
		return fileName.match(pattern);
	}//checkImageType
	
	//파일 이름 처리 : UUID 가짜 이름 제거
	function getOriginalName(fileName){
		if(checkImageType(fileName)){
			return;
	}
		
		var idx = fileName.indexOf("_") + 1;
		return fileName.substr(idx);
			
	}//getOriginalName
	
	//이미지 원본 링크 제공
	function getImageLink(fileName){
		
		if(!checkImageType(fileName)){
			return;
		}//if
		
		var front = fileName.substr(0, 12);
		var end = fileName.substr(14);
		
		return front + end;
		
	}//getImageLink
	
	
	//업로드 파일 삭제 처리
	$(".uploadedList").on("click", "small", function(event){
		
		var that = $(this);
		
		alert($(this).attr("data-src"));
		
		$.ajax({
			url: "/home/sample/upload/deleteFile",
			type: "post",
			data: {fileName:$(this).attr("data-src")},
			dataType: "text",
			success : function(result){
				if(result == 'deleted'){
					//alert("deleted");
					that.parent("div").remove();
				}//
			},
		});
		
	});//uploadedList
	
});
</script>
<style>

.fileDrop{
	width: 100%;
	height: 200px;
	border: 1px dotted blue;
}

small {
	margin-left: 3px;
	font-weight: bold;
	color: gray;
}

</style>
</head>

<div layout:fragment="content">
	<!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
       Ajax 파일 업로드
        <small>Optional description</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> 예제</a></li>
        <li class="active">read</li>
      </ol>
    </section>

    <!-- Main content -->
    <section class="content container-fluid">

      <!--------------------------
        | Your Page Content Here |
        -------------------------->
        
        <div class="box box-primary">
            <div class="box-header with-border">
              <h3 class="box-title">Ajax File Upload</h3>
            </div>
            <!-- /.box-header -->
            <!-- form start -->
            <!-- <form id="form1" action="/sample/upload/uploadForm" method="post" enctype="multipart/form-data"> -->
            <form id="form" action="/home/sample/upload/uploadForm" method="post" enctype="multipart/form-data">
              <div class="box-body">
                <div class="form-group">
				  <div class="fileDrop"></div>	
                </div>
              </div>
              <!-- /.box-body -->

              <div class="box-footer">
                <!-- <button type="submit" class="btn btn-warning">제출</button> -->
                <div class="uploadedList"></div>
              </div>
            </form>
          </div>
          <!-- /.box -->

    </section>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->
</div>
</html>