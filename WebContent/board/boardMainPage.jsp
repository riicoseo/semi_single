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
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">

<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"></script>


<style>

/* tbody tr:nth-child(2n){ */
/*    background-color: #FFFFFF; */
/* } */
/* tbody tr:nth-child(2n-1){ */
/*    background-color: #E6E6FA; */
/* } */
.table-striped>tbody>tr:nth-child(odd) {
    background-color: LemonChiffon;
}
.table-hover tbody tr:hover {
/*     background-color: #E6E6FA; */
    background-color: #D3D3D3;
}




body {
	color: #566787;
	background: #f5f5f5;
	font-family: 'Varela Round', sans-serif;
	font-size: 13px;
} 
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

/* 1??? ????????? ????????? */
/* .form-control-inline { */
/*     min-width: 0; */
/*     width: 80px; */
/*     display: inline;  */
/* } */
/* .searchWord{ */
/* 	width: 350px; */
/* 	display: inline; */
/* } */


/* 2??? ????????? ?????????    ??????*/   
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
	
	$("#writeBtn").on("click",function(){
		location.href ="${pageContext.request.contextPath}/write.bor"
	})
	
	
	
	
})
</script>

</head>
<body>

	<div class ="container">
		<div class="table-wrapper">
		<div class="row">
			<div class="table-title col-12">
				<h2><b>?????? ?????????</b></h2>
			</div>			
		</div>

		<div class="row">
			<table class="table table-striped table-hover" id="table">
			<thead>
			<tr>
				<th class="d-sm-table-cell" style="width:7%">?????????</th>
				<th class="d-sm-table-cell" style="width:50%">??????</th>
				<th class="d-sm-table-cell" style="width:13%">?????????</th>
				<th class="d-none d-md-table-cell" style="width:20%">?????????</th>
				<th class="d-none d-md-table-cell" style="width:10%">?????????</th>
			</tr>
			</thead>
			<tbody>
			
<!-- 			<i class="fa fa-bullhorn" aria-hidden="true" style="font-size:25px"></i> -->
			
			<!-- ????????? ????????? ????????????  -->
			<c:choose>
				<c:when test="${list != null}" >
					<c:forEach var="list" items="${list}">
						
						
						<c:choose>
						<c:when test="${list.notice eq 'Y'}">
						<tr style="background-color:#FFFACD" onMouseOver="this.style='background-color:#D3D3D3'" onMouseOut="this.style='background-color:#FFFACD'">
							<td class="d-sm-table-cell"><i class="fa fa-bullhorn" aria-hidden="true" style="font-size:11px"> ??????</i></td>
							<td class="d-sm-table-cell" style="width:50%"><a href="${pageContext.request.contextPath}/detail.bor?board_seq=${list.board_seq}">${list.title}</a></td>
							<td class="d-sm-table-cell" style="width:13%">${list.id}</td>
							<td class="d-none d-md-table-cell" style="width:20%">${list.write_date}</td>
							<td class="d-none d-md-table-cell" style="width:10%">${list.view_count}</td>
						</tr>
						</c:when>
						
						<c:otherwise>
						<tr>
							<td class="d-sm-table-cell" style="width:7%">${list.board_seq}</td>
							<td class="d-sm-table-cell" style="width:50%"><a href="${pageContext.request.contextPath}/detail.bor?board_seq=${list.board_seq}">${list.title}</a></td>
							<td class="d-sm-table-cell" style="width:13%">${list.id}</td>
							<td class="d-none d-md-table-cell" style="width:20%">${list.write_date}</td>
							<td class="d-none d-md-table-cell" style="width:10%">${list.view_count}</td>
						</tr>
						</c:otherwise>
						</c:choose>
							
						
					</c:forEach>
				</c:when>
		
		
				<c:otherwise>
					<c:forEach var="searchlist" items="${searchList}">
					<tr>
					<td class="d-sm-table-cell" style="width:7%">${searchlist.board_seq}</td>
					<td class="d-sm-table-cell" style="width:50%"><a href="${pageContext.request.contextPath}/detail.bor?seq=${searchlist.board_seq}">${searchlist.title}</a></td>
					<td class="d-sm-table-cell" style="width:13%">${searchlist.id}</td>
					<td class="d-none d-md-table-cell" style="width:20%">${searchlist.write_date}</td>
					<td class="d-none d-md-table-cell" style="width:10%">${searchlist.view_count}</td>
					</tr>
					</c:forEach>
				</c:otherwise>
			</c:choose>


			
			</tbody>
			</table>
		</div>
		</div>
		
		<div class="row">
		<div class="col-12" id="writeBtnDiv">
			<button class="btn btn-info" type="button" id="writeBtn" style="float:right">?????????</button>
		</div>
		</div>


		<div class="row" style="text-align: center;">
		<div class="col-12" >
			<ul class="pagination">
				<c:forEach var="i" items="${navi}" varStatus="s">
					<c:choose>
						<c:when test="${i == '>'}">
							<li class="page-item"><a href="${pageContext.request.contextPath}/list.bor?cpage=${navi[s.index-1]+1}&category=${category}&searchWord=${searchWord}">Next</a>
						</c:when>
						<c:when test="${i == '<'}">
							<li class="page-item"><a href="${pageContext.request.contextPath}/list.bor?cpage=${navi[s.index+1]-1}&category=${category}&searchWord=${searchWord}">Previous</a>
						</c:when>
						<c:otherwise>
							<li class="page-item"><a href="${pageContext.request.contextPath}/list.bor?cpage=${i}&category=${category}&searchWord=${searchWord}">${i}</a>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			
<!-- 				<li class="page-item"><a href="#" class="page-link">Previous</a></li> -->
<!-- 				<li class="page-item"><a href="#" class="page-link">1</a></li> -->
<!-- 				<li class="page-item"><a href="#" class="page-link">2</a></li> -->
<!-- 				<li class="page-item active"><a href="#" class="page-link">3</a></li> -->
<!-- 				<li class="page-item"><a href="#" class="page-link">4</a></li> -->
<!-- 				<li class="page-item"><a href="#" class="page-link">5</a></li> -->
<!-- 				<li class="page-item"><a href="#" class="page-link">Next</a></li> -->
			</ul>
		</div>
		

		
		
		
		<div class="controls col-12 search">
		<form action="${pageContext.request.contextPath}/list.bor?cpage=1" method="post" style="display: inline-block;">
			<div class="float1">
			<select name="category" class="form-control form-control-inline">
				<option value="title">??????</option>
				<option value="id">?????????</option>
				<option value="content">??????</option>
			</select>
			</div>
			<div class="input-group controls float2">
			  <input type="text" class="form-control searchWord" style="width:100px; display: inline-block;" placeholder="???????????? ???????????????" name="searchWord">
			  <div class="input-group-btn" style="display: inline;">
				<button class="btn btn-info" type="submit">
				  <i class="glyphicon glyphicon-search"></i> ??????
				</button>
			  </div>
			</div>
		</form>
		</div>
		
		</div>
		

		</div>



	

</body>
</html>