<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>WritePage</title>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

<!-- include libraries(jQuery, bootstrap) -->
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">

<!-- include summernote css/js -->
<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote.js"></script>

<!-- include summernote-ko-KR -->
<script src="lang/summernote-ko-KR.js"></script>

<style>
.table-title {        
	/* padding-bottom: 15px; */
	background: #435d7d;
	color: #fff;
	padding: 16px 30px;
	/* min-width: 100%; */
	/* margin: -20px -25px 10px; */
	border-radius: 3px 3px 0 0;
}
.table-title h2 {
	margin: 5px 0 0;
	font-size: 24px;
} 
label{
  padding:3px;
  margin-top: 2px;
  vertical-align: center;
}
.writeDiv{
  padding:0px;
}
.pull-left{
  margin:15px;
}
.pull-right{
  margin-top:15px;
}

input[type=file]{
width:450px;
height:35px;
display:inline;
}
/* button[type=button]{ */
/* font-size:12px; */
/* height:25px; */
/* width:40px; */
/* padding:3px; */
/* margin-bottom:10px; */
/* } */

#summernoteContent{
}

</style>


<script>
$(function(){
	$("#backBtn").on("click",function(){
		//location.href =	"javascript:history.back()";
		location.href = "${pageContext.request.contextPath}/list.bor?cpage=1";
	})
	
	
	$("#saveBtn").on("click",function(){
		$("#summernoteContent").val($(".note-editable").text());
		
		let title = $("#bbs_title").val();
		let content = $("#summernoteContent").val();
		
		let regex = /\S/;
		let result1 = regex.test(title);
		let result2 = regex.test(content);
		if(!result1){
			alert("제목을 반드시 입력해주세요!");
		}else if(!result2){
			alert("내용을 입력해주세요!");
		}else{
			$("#frm").submit();
		}
	})
	
	$("#btn1").on("click",function(){
		$("#file1").val("");
	})
	$("#btn2").on("click",function(){
		$("#file2").val("");
	})
	$("#btn3").on("click",function(){
		$("#file3").val("");
	})	
	
	
	
	
	$('#summernote').summernote({
        placeholder: 'Write contents',
        height: 400,
        minHeight: 300,             // set minimum height of editor
        maxHeight: 300,             // set maximum height of editor
        lang: 'ko-KR'
      });
	
})







// $(document).ready(function(){
   
   
// })

// $(function() {
//   $('#summernote').summernote({
//     height: 300,
//     lang: 'ko-KR' // 언어 세팅
//   });
// });



// get
//var markupStr = $('#summernote').summernote('code');

// set
// var markupStr = 'hello world';
// $('#summernote').summernote('code', markupStr);

// 페이지를 렌더링 할 때 textarea 태그에 값을 넣어서 바로 불러올 수도 있는 것 같다.
// PHP코드라면...
// <textarea id="summernote"><?= $contents ?></textarea>

</script>

</head>
<body>

 <div class ="container">
		
    <div class="table-wrapper">
		<div class="row">
			<div class="table-title col-12">
				<h2><b>Write Contents</b></h2>
			</div>			
		</div>
    </div>

	
    <div class="row">
    <form id="frm" action="${pageContext.request.contextPath}/save.bor" method="post" enctype="multipart/form-data">
      <div class="form-group">
        <label for="inputEmail3" class="col-sm-2 control-label">Title</label>
        <div class="col-sm-10 writeDiv">
          <input type="text" class="form-control" id="bbs_title" name="title" placeholder="Title">
        </div>
      </div>
 
      <div class="form-group">
        <label for="inputPassword3" class="col-sm-2 control-label">contents</label>
        <div class="col-sm-10 writeDiv">
          <div id="summernote" name="content"></div>
        </div>
      </div>
       
       <div class="form-group">
        <label for="inputEmail3" class="col-sm-2 control-label">첨부파일</label>
        <div class="col-sm-10 writeDiv">
<!--           <input type="file" class="form-control" id="file1"  name="file1"><button id="btn1" type="button" class="btn btn-danger btn-sm">삭제</button> -->
<!--           <input type="file" class="form-control" id="file2"  name="file2"><button id="btn2" type="button" class="btn btn-danger">삭제</button> -->
<!--           <input type="file" class="form-control" id="file3"  name="file3"><button id="btn3" type="button" class="btn btn-danger">삭제</button> -->
       
        <div class="input-group" >
			  <input type="file" class="form-control" id="file1"  name="file1" style="display:inline; width:430px">
			  <div class="input-group-btn" style="display: inline;">
				<button class="btn btn-danger" type="button" id="btn1">삭제</button>
			  </div>
		</div>
		<div class="input-group" >
			  <input type="file" class="form-control" id="file2"  name="file2" style="display:inline; width:430px" >
			  <div class="input-group-btn" style="display: inline;">
				<button class="btn btn-danger" type="button" id="btn2">삭제</button>
			  </div>
		</div>
		<div class="input-group" >
			  <input type="file" class="form-control" id="file3"  name="file3" style="display:inline; width:430px">
			  <div class="input-group-btn" style="display: inline;">
				<button class="btn btn-danger" type="button" id="btn3">삭제</button>
			  </div>
		</div>
       
        </div>
          
  </div>
</div>
<!--         <div class="col-sm-10"> -->
<!--           <div id="fine-uploader"></div> -->
<!--           Fine Uploader -->
<%--           <jsp:include page="/resources/fileUpload/all.fine-uploader/lee/division_script.jsp" flush="true" /> --%>
<!--         </div> -->

<!--       </div> -->
      

  
  
  
<!--   관리자 모드 일때만, 나타나는 공지 등록 여부 항목 -->
<%-- <c:choose> --%>
<%-- 	<c:when test="${login.id eq admin}"> --%>
<!-- 		나중에 여기에 밑에 써놓은 '공지 등록 여부 row' 넣기!!!! -->
<%-- 	</c:when> --%>
<%-- 	<c:otherwise> --%>
<!-- 		<input type="hidden" name="notice" value="N"> -->
<%-- 	</c:otherwise> --%>
<%-- </c:choose> --%>


	<div class="row" style="margin-top:15px">
		<label class="col-sm-2 control-label">공지 등록 여부</label>
        <div class="col-sm-10 writeDiv" >
          <input type="radio" name="notice" value="Y" style="margin-left:8px">등록  &nbsp; &nbsp; &nbsp;<input type="radio" name="notice" value="N" checked>등록안함
        </div>
	</div> 



		


    <div class="row">
      <hr>
      <div class="col-12">
        <button type="button" id="backBtn" class="btn btn-default pull-left" style="background-color: #00285b; color:white">목록</button>
        <textarea cols="3" name="content" id="summernoteContent" style="display:none"></textarea>
        <div class="pull-right"><a id="saveBtn" class="btn btn-info boardAddBtn"><span class="glyphicon glyphicon-pencil"></span> 등록</a></div>
      </div> 
    </div>

    </div>

</form>
</div>


</body>
</html>