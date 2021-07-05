<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport"
   content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>Bootstrap CRUD Data Table for Database with Modal Form</title>
<link rel="stylesheet"
   href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
<link rel="stylesheet"
   href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
<link rel="stylesheet"
   href="https://fonts.googleapis.com/icon?family=Material+Icons">
<link rel="stylesheet"
   href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script
   src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<script
   src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet"> 
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
<script src=" https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/lang/summernote-ko-KR.min.js"></script>
<style>
body {
   color: #566787;
   background: #f5f5f5;
   font-family: 'Varela Round', sans-serif;
   font-size: 13px;
}

.table-responsive {
   margin: 30px 0;
}

.table-wrapper {
   background: #fff;
   padding: 20px 25px;
   border-radius: 3px;
   min-width: 1000px;
   box-shadow: 0 1px 1px rgba(0, 0, 0, .05);
}

.table-title {
   padding-bottom: 15px;
   background: #435d7d;
   color: #fff;
   padding: 16px 30px;
   min-width: 100%;
   margin: -20px -25px 10px;
   border-radius: 3px 3px 0 0;
}

.table-title h2 {
   margin: 5px 0 0;
   font-size: 24px;
}

.table-title .btn-group {
   float: right;
}

.table-title .btn {
   color: #fff;
   float: right;
   font-size: 13px;
   border: none;
   min-width: 50px;
   border-radius: 2px;
   border: none;
   outline: none !important;
   margin-left: 10px;
}

.table-title .btn i {
   float: left;
   font-size: 21px;
   margin-right: 5px;
}

.table-title .btn span {
   float: left;
   margin-top: 2px;
}

table.table tr th, table.table tr td {
   border-color: #e9e9e9;
   padding: 12px 15px;
   vertical-align: middle;
}

table.table tr th:first-child {
   width: 60px;
}

table.table tr th:last-child {
   width: 100px;
}

table.table-striped tbody tr:nth-of-type(odd) {
   background-color: #fcfcfc;
}

table.table-striped.table-hover tbody tr:hover {
   background: #f5f5f5;
}

table.table th i {
   font-size: 13px;
   margin: 0 5px;
   cursor: pointer;
}

table.table td:last-child i {
   opacity: 0.9;
   font-size: 22px;
   margin: 0 5px;
}

table.table td a {
   font-weight: bold;
   color: #566787;
   display: inline-block;
   text-decoration: none;
   outline: none !important;
}

table.table td a:hover {
   color: #2196F3;
}

table.table td i {
   font-size: 19px;
}

table.table .avatar {
   border-radius: 50%;
   vertical-align: middle;
   margin-right: 10px;
}

.pagination {
   float: right;
   margin: 0 0 5px;
}

.pagination li a {
   border: none;
   font-size: 13px;
   min-width: 30px;
   min-height: 30px;
   color: #999;
   margin: 0 2px;
   line-height: 30px;
   border-radius: 2px !important;
   text-align: center;
   padding: 0 6px;
}

.pagination li a:hover {
   color: #666;
}

.pagination li.active a, .pagination li.active a.page-link {
   background: #03A9F4;
}

.pagination li.active a:hover {
   background: #0397d6;
}

.pagination li.disabled i {
   color: #ccc;
}

.pagination li i {
   font-size: 16px;
   padding-top: 6px
}

.hint-text {
   float: left;
   margin-top: 10px;
   font-size: 13px;
}
/* Custom checkbox */
.custom-checkbox {
   position: relative;
}

.custom-checkbox input[type="checkbox"] {
   opacity: 0;
   position: absolute;
   margin: 5px 0 0 3px;
   z-index: 9;
}

.custom-checkbox label:before {
   width: 18px;
   height: 18px;
}

.custom-checkbox label:before {
   content: '';
   margin-right: 10px;
   display: inline-block;
   vertical-align: text-top;
   background: white;
   border: 1px solid #bbb;
   border-radius: 2px;
   box-sizing: border-box;
   z-index: 2;
}

.custom-checkbox input[type="checkbox"]:checked+label:after {
   content: '';
   position: absolute;
   left: 6px;
   top: 3px;
   width: 6px;
   height: 11px;
   border: solid #000;
   border-width: 0 3px 3px 0;
   transform: inherit;
   z-index: 3;
   transform: rotateZ(45deg);
}

.custom-checkbox input[type="checkbox"]:checked+label:before {
   border-color: #03A9F4;
   background: #03A9F4;
}

.custom-checkbox input[type="checkbox"]:checked+label:after {
   border-color: #fff;
}

.custom-checkbox input[type="checkbox"]:disabled+label:before {
   color: #b8b8b8;
   cursor: auto;
   box-shadow: none;
   background: #ddd;
}
/* Modal styles */
.modal .modal-dialog {
   max-width: 400px;
}

.modal .modal-header, .modal .modal-body, .modal .modal-footer {
   padding: 20px 30px;
}

.modal .modal-content {
   border-radius: 3px;
   font-size: 14px;
}

.modal .modal-footer {
   background: #ecf0f1;
   border-radius: 0 0 3px 3px;
}

.modal .modal-title {
   display: inline-block;
}

.modal .form-control {
   border-radius: 2px;
   box-shadow: none;
   border-color: #dddddd;
}

.modal textarea.form-control {
   resize: vertical;
}

.modal .btn {
   border-radius: 2px;
   min-width: 100px;
}

.modal form label {
   font-weight: normal;
}

/* Content Area
--------------------------------------------------------------------------------------------------------------- */
.container{padding:80px 0;}

/* Content */
.container .content{}

.sectiontitle{display:block; max-width:55%; margin:0 auto 80px; text-align:center;}
.sectiontitle *{margin:0;}

.ringcon{display:inline-block; border:1px solid; border-radius:50%;}
.ringcon i{display:block; width:160px; height:160px; line-height:160px; font-size:56px;}

.overview{}
.overview > li{margin-bottom:30px;}
.overview > li:nth-last-child(-n+3){margin-bottom:0;}/* Removes bottom margin from the last three items - margin is restored in the media queries when items stack */
.overview > li:nth-child(3n+1){margin-left:0; clear:left;}/* Removes the need to add class="first" */
.overview > li figure{position:relative; max-width:348px;}/* Uses the one_third width in pixels */
.overview > li figure a::after{position:absolute; top:0; right:0; bottom:0; left:0; content:"";}
.overview > li figure figcaption{display:block; position:absolute; bottom:0; width:100%; padding:15px;}
.overview > li figure a::after, .overview > li figure figcaption{}
.overview > li figure:hover a::after, .overview > li figure:hover figcaption{opacity:0; visibility:hidden;}
.overview > li figure figcaption *{margin:0;}
.overview > li figure .heading{margin-bottom:10px; font-size:1.2rem;}

/* Comments */
#comments ul{margin:0 0 40px 0; padding:0; list-style:none;}
#comments li{margin:0 0 10px 0; padding:15px;}
#comments .avatar{float:right; margin:0 0 10px 10px; padding:3px; border:1px solid;}
#comments address{font-weight:bold;}
#comments time{font-size:smaller;}
#comments .comcont{display:block; margin:0; padding:0;}
#comments .comcont p{margin:10px 5px 10px 0; padding:0;}

#comments form{display:block; width:100%;}
#comments input{width:100%; padding:10px; border:1px solid;}
#comments textarea{width:90%; padding:10px; border:1px solid; float:left;}
#comments textarea{overflow:auto;}
#comments input[type="submit"], #comments input[type="reset"]{display:inline-block; width:auto; min-width:95px; margin:5px; padding:8px 5px; cursor:pointer;}

.ringcon{background-color:#FFFFFF; border-color:rgba(0,0,0,.2);}

.overview > li figure a::after{background-color:rgba(0,0,0,.5);}
.overview > li figure figcaption{color:#FFFFFF;}
table, th, td, #comments .avatar, #comments input, #comments{border-color:#D7D7D7;}
#comments input:focus, #comments textarea:focus, #comments *:required:focus{border-color:#F7A804;}
th{color:#FFFFFF; background-color:#373737;}
tr, #comments li, #comments input[type="submit"], #comments input[type="reset"]{color:inherit; background-color:#FBFBFB;}
input #sign{float:right;}
tr:nth-child(even), #comments li:nth-child(even){color:inherit; background-color:#F7F7F7;}
table a, #comments a{background-color:inherit;}
#comments li a.edit{color: #FFC107; align:rigth;} #comments li a.delete{color: #F44336;}
.comcont_btn {text-align: right;}
.btn_wrap {padding-top: 50px; border-top: 1px solid #ddd;}
.contents {padding: 20px; min-height: 300px; background-color: #FBFBFB;}
.title {overflow: hidden; padding-bottom: 10px; border-bottom: 1px solid #ddd;}
.title ul {overflow:hidden; float:right; padding: 0; margin: 0;}
.title ul li {list-style: none; font-size: 13px; float: left; position: relative; margin-right: 11px; color: #666;}
.title ul li:last-child {margin-right: 0;}
.title ul li:after {display: block; width: 1px; height: 12px; background-color: #ddd; content: ''; position: absolute; top: 50%; margin-top: -6px; margin-left: -5px;}
.files{border-bottom: 1px solid #ddd;}
.btn_wrap {
    margin-top: 10px;
    padding-top: 30px;
}

</style>
<script>
$(document).ready(function(){
   // Activate tooltip
   $('[data-toggle="tooltip"]').tooltip();
   
   // Select/Deselect checkboxes
   var checkbox = $('table tbody input[type="checkbox"]');
   $("#selectAll").click(function(){
      if(this.checked){
         checkbox.each(function(){
            this.checked = true;                        
         });
      } else{
         checkbox.each(function(){
            this.checked = false;                        
         });
      } 
   });


// Comments delete
$("#delete").on("click",function(){

   $(this).next().attr("name","board_seq");
   $(this).next().next().attr("name","cmt_seq");
   $(this).attr("action","${pageContext.request.contextPath}/delete.cmt");
   
   $.ajax({
      url : "${pageContext.request.contextPath}/delete.cmt",
      type : "get",
      dataType:"json"
   }).done(function(resp){
      for(let i =0; i<resp.length; i++){
         
         console.log(resp)
         let address = $("<address>");
         
         address.append("<a>"+resp[i].id);
         address.append("<time>"+resp[i].cmt_date);
         
         $("#commentsList").append(address);
         
      }
         })
      
   });

// Ajax comments 데이터 전송
$("#sign").click(function(){
   if($("#comment").val().trim() === ""){
      alert("댓글을 입력하세요.");
      $("#comment").val("").focus();
   }else{
	  
      $.ajax({
         url: "${pageContext.request.contextPath}/write.cmt",
            type: "post",
            data: {
                cmt_content: $("#comment").val(),
                board_seq: $("#board_seq").val()
            },
            success: function () {
              
               alert("댓글 등록 완료");
               
               $("#comment").val("");
               getReply();
            }
      })
   }
})

// 댓글 등록 시, ajax로 데이서 받기
$("#sign").click(function(){
    $.ajax({
      url: "${pageContext.request.contextPath}/write.cmt", //데이터를 가지고올  url
        type: "post", // post 방식
        data: "json"
    }).done(function(resp){
    
          let div1 = $("<div>");
          let div2 = $("<div>");
          div2.attr("class","comcont");
          let ul = $("<ul>");
          let li = $("<li>");
          let article = $("<article>");
          let header = $("<header>");
          let address = $("<address>");
          let a = $("<a>");
          let time = $("<time>");
          
          div1.append(ul);
          ul.append(li);
          li.append(article);
          article.append(header);
          header.append(div1);
          div1.append(address);
          address.append("By"+ a + resp.id + time + resp.cmt_date);
          div2.append(resp.cmt_content);
          
          $("#cmt").prepend(div1);
    })
           
   })

});



</script>
</head>
<body>
   <div class="container-xl">
      <div class="table-responsive">
         <div class="table-wrapper">
            <div class="table-title">
               <div class="row">
                  <div class="col-sm-6">
                     <h2>
                        ${list.title}
                     </h2>
                  </div>
               </div>
            </div>
               <div class="title">
                  <ul>
                     <li class="view_cnt">${list.id}</li>
                     <li class="write_date">${list.write_date}</li>
                     <li class="view_cnt">${list.view_count}</li>
                  </ul>
               </div>
                <div class="files">
                  <h4>Files</h4>
                 <c:forEach var="f" items="${flist}">
                    <a href="${pageContext.request.contextPath}/download.file?file_seq=${f.file_seq}&oriName=${f.oriName}&sysName=${f.sysName}">${f.oriName}</a>
                    <br>
                 </c:forEach>
               </div>
         <h4>Contents</h4>
         <div class="contents">
         ${list.content}
         </div>
         
         
                  <div id="comments">
                  <h4>Comments</h4>
                  <c:forEach var="i" items="${cmt}">
                  <div>
                  <ul>
                  <li>
                  <article>
                  <header>
                  <address>
                  By <a href="">${i.id}</a>                                    
                  <time deatetme=""></time>
                  ${i.cmt_date}               
                  <!-- <time datetime="2045-04-06T08:15+00:00">Friday, 6<sup>th</sup> April 2045 @08:15:00</time> -->
                  </address>
                  </header>
                  <div class="comcont">
                  ${i.cmt_content}
                  </div>
                  <div class="comcont_btn">
                  
                  <c:if test="${i.id eq login}">
                  <a href="" class="edit" data-toggle="modal">
                  <i class="material-icons" data-toggle="tooltip" title="Edit">&#xE254;</i></a>
                  <a href="#deleteEmployeeModal" class="delete" data-toggle="modal">
                  <i class="material-icons" data-toggle="tooltip" title="Delete">&#xE872;</i></a>
                  </c:if>
                  
                  </div>
                  </article>
                  </li>
                  </ul>
                  </div>
                  </c:forEach>
                  
                  
                  
                  
                     <h4>Write A Comment</h4>
                     <form action="" method="post">
                        <input type="hidden" value="${list.board_seq}" name="${list.board_seq}" id="board_seq">
                        <div class="block clear">
                           <label for="comment">Your Comment</label>
                           <br>
                           <textarea name="cmt_content" id="comment" cols="25" rows="3" placeholder="댓글 내용을 작성하세요."></textarea>
                           <div>
                           <input type="submit" name="submit" id="sign" value="등록">
                        </div>
                        </div>
                     </form>
                  </div>
            <div class="btn_wrap" align="left">
            <c:choose>
               <c:when test="${login eq list.id}">
                  <a href="${pageContext.request.contextPath}/modifyPage.bor?board_seq=${list.board_seq}" class="btn btn-primary">수정하기</a>
                  <a href="${pageContext.request.contextPath}/delete.bor?board_seq=${list.board_seq}" class="btn btn-danger">삭제하기</a>
               </c:when>
            </c:choose>
            </div>
            <div align="right">
            <a href="javascript:history.back()" class="btn btn-secondary">목록으로</a>
         </div>
         </div>
      </div>
   </div>
   <!-- Delete Modal HTML -->
   <div id="deleteEmployeeModal" class="modal fade">
      <div class="modal-dialog">
         <div class="modal-content">
            <form>
               <div class="modal-header">
                  <h4 class="modal-title">Delete Employee</h4>
                  <button type="button" class="close" data-dismiss="modal"
                     aria-hidden="true">&times;</button>
               </div>
               <div class="modal-body">
                  <p>Are you sure you want to delete these Records?</p>
                  <p class="text-warning">
                     <small>This action cannot be undone.</small>
                  </p>
               </div>
               <div class="modal-footer">
                  <input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel">
                  <a href="${pageContext.request.contextPath}/delete.cmt?board_seq=${list.board_seq}"><input type="button" class="btn btn-danger" value="Delete"></a>
                  
<!--                   <input type="submit" class="btn btn-danger" value="Delete"> -->
<%--                   <input type="hidden" name="${list.board_seq}"> --%>
<%--                   <input type="hidden" name="${i.cmt_seq}"> --%>
               </div>
            </form>
         </div>
      </div>
   </div>
</body>
</html>