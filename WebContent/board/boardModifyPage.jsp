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
<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<!-- include summernote css/js -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>

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
	
	
	$("#modifyBtn").on("click",function(){
		
		//$("#summernote").val($(".note-editable").text());
		let title = $("#bbs_title").val();
		let content = $("#summernote").val();
		console.log(content);
		
		let blankRegex = /\S/;
		let titleLengthRegex = /^\S.{0,65}$/;
		let contentLengthRegex = /^\S.{0,1332}$/;
		
		let bresult1 = blankRegex.test(title);
		let bresult2 = blankRegex.test(content);
		
		let titleResult = titleLengthRegex.test(title);
		let contentResult = contentLengthRegex.test(content);
		
		if(!bresult1){
			alert("제목을 반드시 입력해주세요!");
		}else if(!bresult2){
			alert("내용을 입력해주세요!");
		}else if(!titleResult){
			alert("제목은 66글자 이내로 작성해주세요.")
		}else if(!contentResult){
			alert("내용은 1,333글자 이내로 작성해주세요.")
		}
		else{
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
	
	
	$(".delTarget").on("click",function(){
		let fileSeq=$(this).attr("seq");
		let del = $("<input type='hidden' name='delFiles'>");
		del.val(fileSeq);
		
		$("#fileDiv").append(del);
		
		$(this).parent().parent().remove();
	})
	
	
	
	
	
	$('#summernote').summernote({
        placeholder: 'Write contents',
        height: 400,
        minHeight: 300,             // set minimum height of editor
        maxHeight: 300,             // set maximum height of editor
        codeviewFilter: true,
        codeviewIframeFilter: true,
        callbacks:{
            onImageUpload:function(files) {
                
                
                 let editor = this;   // SummerNote 인스턴스의 주소를 Editor 변수에 저장
                 
                 let file = files[0];      //업로드 해야 하는 파일 인스턴스
               
                 let form = new FormData();     // <form> 태그 생성
                 form.append("file",file);    // form 태그 내부에 파일 인스턴스 append 하면 자동으로   <input type=file> 이란 코드 생성되고, name 값에는 "file" 이라고 내가 지정해준 것이다.
      
                 
                 $.ajax({
                    data:form,
                    type:"post",
                    url:"${pageContext.request.contextPath}/upload.file",
                    contentType:false,   //내가 보내는 데이터의 타입이 Multipart/form-data 라고 해주는 설정 같은 코드 
                    processData:false  //업로드 하는 파일을 get 방식이나 post 방식의 '텍스트'로 변경하는 작업을 안하겠다! 하는 코드 (텍스트화 하지 않고, 파일 그대로를 업로드하겟다!)
                 }).done(function(resp){
                   
                   $(editor).summernote('insertImage',"${pageContext.request.contextPath}"+resp); //editor 인스턴스의 insertImage 기능으로 이미지를 화면에 출력                 
                 });               
               }
           }       
      });
	
	
	
	
})



</script>

</head>
<body>

 <div class ="container">
		
    <div class="table-wrapper">
		<div class="row">
			<div class="table-title col-12">
				<h2><b>Modify Contents</b></h2>
			</div>			
		</div>
    </div>

	 <form id="frm" action="${pageContext.request.contextPath}/modify.bor" method="post" enctype="multipart/form-data">
    <div class="row">
   		<input type="hidden" name="board_seq" value=${dto.board_seq}>
      <div class="form-group">
        <label for="inputEmail3" class="col-sm-2 control-label">Title</label>
        <div class="col-sm-10 writeDiv">
          <input type="text" class="form-control" id="bbs_title" name="title" placeholder="Title" value=${dto.title} >
        </div>
      </div>
 
      <div class="form-group">
        <label for="inputPassword3" class="col-sm-2 control-label">contents</label>
        <div class="col-sm-10 writeDiv">
          <textarea cols="3" name="content" id="summernote">${dto.content}</textarea>
        </div>
      </div>
       
       <div class="form-group">
        <label for="inputEmail3" class="col-sm-2 control-label">첨부파일</label>
        
        <div class="col-sm-10 writeDiv" id="fileDiv">
  
			 <c:forEach var="f" items="${flist}">
			 	<div class="input-group">
                    <a href="${pageContext.request.contextPath}/download.file?file_seq=${f.file_seq}&oriName=${f.oriName}&sysName=${f.sysName}" style="margin:0 20px 0 5px">${f.oriName}</a>     
                    <div class="input-group-btn" style="display: inline;">
					<button class="btn btn-danger delTarget" type="button" seq=${f.file_seq} style="padding:0; margin:0; width:15px; height:16px">X</button>
			  		</div>
			  	</div>	
             </c:forEach>
  
       	<br>
       	
        <div class="input-group" >
			  <input type="file" class="form-control" id="file1"  name="file1" style="display:inline; width:430px">
			  <div class="input-group-btn" style="display: inline;">
				<button class="btn btn-danger" type="button" id="btn1">삭제</button>
			  </div>
		</div>
		<div class="input-group" >
			  <input type="file" class="form-control" id="file2"  name="file2" style="display:inline; width:430px">
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
        
        <div class="pull-right"><a id="modifyBtn" class="btn btn-info boardAddBtn"><span class="glyphicon glyphicon-pencil"></span> 수정</a></div>
      </div> 
    </div>
    
    
</form>


    </div>





</body>
</html>