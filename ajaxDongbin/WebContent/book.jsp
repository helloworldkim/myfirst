<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="css/bootstrap.css">
<title>ajax</title>
 <script src="http://code.jquery.com/jquery-latest.min.js"></script>
 <script src="js/bootstrap.js"></script>
 <style>
 ul{
	 padding: 0;
 }
 .container > div > ul > .ajaxlist{
 list-style : none;
 border: 1px solid red;
 }
 .ajaxlist:focus{
	 background-color: aqua;
	 color: black;
 }
 #suggestList{
 display: none;
 position: absolute;
 width :170px;
 overflow: hidden;
 top: 53px;
 right: 490px;
 text-align: left;
 text-indent: 15px;
 background-color: gray; 
 }
 </style>
</head>
<body>
<br>
<div class="container">
	<div class="form-group row pull-right">
		<select class="col-xs-3" id="target">
			<option value="bookId">책번호</option>
			<option selected value="bookName">책이름</option>
			<option value="publisher">출판사</option>
			<option value="price">가격</option>
		</select>
		<div class="col-xs-6">
			<input class="form-control" id="inputbox" type="text" size="20">
		</div>
		<ul id="suggestList">
		</ul>
		<div class="col-xs-1">
			<button class="btn btn-primary" id="btn" type="button">검색</button>
		</div>
	</div>
</div>
<table class="table" style="text-align: center; border: 1px solid #dddddd">
	<thead>
		<tr>
			<th style="background-color: #fafafa; text-align: center;">책번호</th>
			<th style="background-color: #fafafa; text-align: center;">책이름</th>
			<th style="background-color: #fafafa; text-align: center;">출판사</th>
			<th style="background-color: #fafafa; text-align: center;">가격</th>
		</tr>
	</thead>
	<tbody id="table">
	</tbody>
</table>


<script>
$(document).ready(function(){
	abc();
	//키 입력값 있을때마다 추천검색어 해주는부분
	$('#inputbox').keyup(function(event){
		var inputvalue = $('#inputbox').val();
		if(inputvalue ==null) inputvalue="";
		if(event.keyCode==40){ //해당부분 고쳐야함 구동안됨
			var list = $("#suggestList").children(); //ul의 모든 자식요소(배열)
			//var li1 = document.querySelector("#list1").classList.add(".focus");
			var li1 = $("#list1").css("background-color","aqua");
			var li1 = $("#list1").text();
			inputvalue.val('li1');

			//console.log(list[0]);

			
		}else{
		var target = $('#target').val();
		var listbox = $('#suggestList');
		if(inputvalue==""||inputvalue==null||inputvalue==undefined){
			listbox.hide();
		}else{
			listbox.show();
			$.ajax({
				type:"POST",
				url : "SearchSuggestServlet",
				data:{inputvalue : inputvalue,
					bookTarget : target},
				success : function(data){
					var listchildren = $("#suggestList").children();
					listchildren.remove();
					var abc = data.split(',');
					for(var i=0; i<abc.length; i++){
						var li=document.createElement('li');
						li.setAttribute("id","list"+(i+1));//아이디 부여함
						li.setAttribute("class","ajaxlist");
						if(i==abc.length-1)continue; //마지막꺼 제외 빈공백
						li.textContent = abc[i];
						listbox.append(li);
					}
					
				}
			});
		}			
		}
		

	});
	//
	function abc(){
		var search = $("#inputbox").val();
		var target = $("#target").val();
		var table = document.querySelector("#table");
		//숫자체크!
		if(target=="bookId"){
			var NumberCheck =$.isNumeric(search);
			if(NumberCheck ==false){
				alert("숫자만 입력해주세요")
				return;
			}
		}
		if(target=="price"){
			var NumberCheck =$.isNumeric(search);
			if(NumberCheck ==false){
				alert("숫자만 입력해주세요")
				return;
			}
		}
			$.ajax({
			type:"POST",
			url:"BookSearchServlet",
			dataType:"JSON",
			data:{inputvalue:search,
					bookTarget: target},
			success: function(data){
				if(data==null)data="";
				table.innerHTML = ""; //이미 만든테이블이 있으면 초기화작업
				var result = data.result;
				for(var i=0; i<result.length; i++){
					var row = table.insertRow(0); //0번째에 테이블 tr하나를 만들고!
					for(var j=0; j<result[i].length; j++){
						var cell = row.insertCell(j);
						cell.innerText = result[i][j].value;
					}
				}
			}
		});
	};
	
	//ajax이용해서 목록 비동기로 불러오는부분
	$("#btn").click(function(){
		var search = $("#inputbox").val();
		var target = $("#target").val();
		var table = document.querySelector("#table");
		//숫자체크!
		if(target=="bookId"){
			var NumberCheck =$.isNumeric(search);
			if(NumberCheck ==false){
				alert("숫자만 입력해주세요")
				return;
			}
		}
		if(target=="price"){
			var NumberCheck =$.isNumeric(search);
			if(NumberCheck ==false){
				alert("숫자만 입력해주세요")
				return;
			}
		}
			$.ajax({
			type:"POST",
			url:"BookSearchServlet",
			dataType:"JSON",
			data:{inputvalue:search,
					bookTarget: target},
			success: function(data){
				if(data==null)data="";
				table.innerHTML = ""; //이미 만든테이블이 있으면 초기화작업
				var result = data.result;
				for(var i=0; i<result.length; i++){
					var row = table.insertRow(0); //0번째에 테이블 tr하나를 만들고!
					for(var j=0; j<result[i].length; j++){
						var cell = row.insertCell(j);
						cell.innerText = result[i][j].value;
					}
				}
			}
		});
	});
}); 

/*$(document).ready(function(){
	$("#btn").click(function(){
		var search = $("#inputbox").val();
		var target = $("#target").val();
		var table = document.querySelector("#table");
		//숫자체크!
		if(target=="bookId"){
			var NumberCheck =$.isNumeric(search);
			if(NumberCheck ==false){
				alert("숫자만 입력해주세요")
				return;
			}
		}
		if(target=="price"){
			var NumberCheck =$.isNumeric(search);
			if(NumberCheck ==false){
				alert("숫자만 입력해주세요")
				return;
			}
		}
			$.ajax({
			type:"POST",
			url:"BookSearchServlet",
			dataType:"JSON",
			data:{inputvalue:search,
					bookTarget: target},
			success: function(data){
				if(data==null)data="";
				table.innerHTML = ""; //이미 만든테이블이 있으면 초기화작업
				var result = data.result;
				for(var i=0; i<result.length; i++){
					var row = table.insertRow(0); //0번째에 테이블 tr하나를 만들고!
					for(var j=0; j<result[i].length; j++){
						var cell = row.insertCell(j);
						cell.innerText = result[i][j].value;
					}
				}
			}
		});
	});
}); */


</script>
</body>
</html>