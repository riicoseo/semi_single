<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>BoardMainPage</title>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.5.1.min.js" ></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"></script>


<style>
/* body {
	color: #566787;
	background: #f5f5f5;
	font-family: 'Varela Round', sans-serif;
	font-size: 13px;
} */
/* .table-wrapper {
    margin: 30px 0;
}*/
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


/* .pagination {
	float: right; 
	left:-39%;
	position: relative;
	margin: 0 0 5px;
} */
.pagination {
	justify-content: center;
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
	background: #435d7d;
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

/* .search{
	float:right;
	left:30%;
	position: relative;
	margin-top: 55px;
	justify-content: center;
} */
/* #search{
	background: #03A9F4;
} */

/* 1번 스타일 검색바 */
.form-control-inline {
    min-width: 0;
    width: 80px;
    display: inline; 
}
.searchWord{
	width: 350px;
	display: inline;
}


/* 2번 스타일 검색바 */
.search{
	overflow: hidden;
	margin-top: 45px;
	padding:2px;
}
.float1{
	float:left;
	width:90px
}
.float2{
	float:left;
	width:320px
}

#writeBtnDiv{
padding:0;
}
#writeBtn{
float:right;
}

</style>

<script>
$(function(){
	
	$.ajax({
		url:"boardlist.bor",
		type:"post",
		dataType:"json"
	}).done(function(resp){
		
		for(i=0; i<resp.length;i++){
			
			let tr = $("<tr>");
			
			let td1= $("<td>");
			td1.append(resp[i].board_seq);
			td1.attr("class","d-sm-table-cell");
			td1.attr("style","width:7%");
			
			let td2= $("<td>");
			let td2a=$("<a>");
			td2a.attr("href","showContents.bor?board_seq="+resp[i].board_seq);
			td2a.append(resp[i].title);
			td2.append(td2a);
			td2.attr("class","d-sm-table-cell");
			td2.attr("style","width:50%");
			
			let td3= $("<td>");
			td3.append(resp[i].id);
			td3.attr("class","d-sm-table-cell");
			td3.attr("style","width:13%");
			
			let td4= $("<td>");
			td4.append(resp[i].write_date);
			td4.attr("class","d-none d-md-table-cell");
			td4.attr("style","width:20%");
			
			let td5= $("<td>");
			td5.append(resp[i].view_count);
			td5.attr("class","d-none d-md-table-cell");
			td5.attr("style","width:10%");
			
			tr.append(td1);
			tr.append(td2);
			tr.append(td3);
			tr.append(td4);
			tr.append(td5);
			
			$("#table").append(tr);
		}
		
	})
	
	
	
	
	$("#writeBtn").on("click",function(){
		location.href ="write.bor"
	})
	
	
	
	
})
</script>

</head>
<body>

	<div class ="container">
		<div class="table-wrapper">
		<div class="row">
			<div class="table-title col-12">
				<h2><b>자유 게시판</b></h2>
			</div>			
		</div>

		<div class="row">
			<table class="table table-striped table-hover" id="table">
			<thead>
			<tr>
				<th class="d-sm-table-cell" style="width:7%">글번호</th>
				<th class="d-sm-table-cell" style="width:50%">제목</th>
				<th class="d-sm-table-cell" style="width:13%">작성자</th>
				<th class="d-none d-md-table-cell" style="width:20%">작성일</th>
				<th class="d-none d-md-table-cell" style="width:10%">조회수</th>
			</tr>
			</thead>
			<tbody>
				<tr>
					<td class="d-sm-table-cell">1</td>
					<td class="d-sm-table-cell">가입인사 드려요</td>
					<td class="d-sm-table-cell">아이언맨</td>
					<td class="d-none d-md-table-cell ">2021.06.23</td>
					<td class="d-none d-md-table-cell ">5</td>
				</tr>	
				<tr>
					<td class="d-sm-table-cell">2</td>
					<td class="d-sm-table-cell">가입인사 드려요</td>
					<td class="d-sm-table-cell">아이언맨</td>
					<td class="d-none d-md-table-cell ">2021.06.23</td>
					<td class="d-none d-md-table-cell ">5</td>
				</tr>	
				<tr>
					<td class="d-sm-table-cell">3</td>
					<td class="d-sm-table-cell">가입인사 드려요</td>
					<td class="d-sm-table-cell">아이언맨</td>
					<td class="d-none d-md-table-cell ">2021.06.23</td>
					<td class="d-none d-md-table-cell ">5</td>
				</tr>	
			</tbody>
			</table>
		</div>
		</div>
		
		<div class="row">
		<div class="col-12" id="writeBtnDiv">
			<button class="btn btn-info" type="button" id="writeBtn">글쓰기</button>
		</div>
		</div>


		<div class="row" style="text-align: center;">
		<div class="col-12" >
			<ul class="pagination">
				<li class="page-item"><a href="#" class="page-link">Previous</a></li>
				<!-- <li class="page-item disabled"><a href="#">Previous</a></li> -->
				<li class="page-item"><a href="#" class="page-link">1</a></li>
				<li class="page-item"><a href="#" class="page-link">2</a></li>
				<li class="page-item active"><a href="#" class="page-link">3</a></li>
				<li class="page-item"><a href="#" class="page-link">4</a></li>
				<li class="page-item"><a href="#" class="page-link">5</a></li>
				<li class="page-item"><a href="#" class="page-link">Next</a></li>
			</ul>
		</div>
		

		<div class="controls col-12">
			<select name="category" class="form-control form-control-inline">
				<option value="title">제목</option>
				<option value="writer">작성자</option>
				<option value="contents">내용</option>
			</select>
			<input type="text" class="form-control searchWord" placeholder="검색어를 입력하세요" aria-label="Recipient's username" aria-describedby="button-addon2">
			<button class="btn btn-info" type="button" id="button-addon2">검색</button>
		</div>
	
		<hr>
		
		
		<div class="controls col-12 search">
			<form style="display: inline-block;">
			<div class="float1">
			<select name="category" class="form-control form-control-inline">
				<option value="title">제목</option>
				<option value="writer">작성자</option>
				<option value="contents">내용</option>
			</select>
			</div>
			<div class="input-group controls float2">
			  <input type="text" class="form-control searchWord" style="width:100px; display: inline-block;" placeholder="검색어를 입력하세요">
			  <div class="input-group-btn" style="display: inline;">
				<button class="btn btn-info" type="submit">
				  <i class="glyphicon glyphicon-search"></i>
				</button>
			  </div>
			</div>
		</form>
		</div>
		
		</div>


		</div>



	

</body>
</html>