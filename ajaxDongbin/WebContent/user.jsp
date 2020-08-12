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
</head>
<body>
<br>
<div class="container">
	<div class="form-group row pull-right">
		<div class="col-xs-8">
			<input class="form-control" id="userName" type="text" size="20">
		</div>
		<div class="col-xs-2">
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
	$('#btn').click(function(){
		var name = $("#userName").val();
		var table = document.getElementById("table");
		//var table = $("#table"); 제이쿼리로 호출시 호출이 안됨
		$.ajax({
			type:"POST",
			url:"UserSearchServlet",
			data:{userName : name},
			dataType : "JSON",
			success : function(data){
				if(data==null) data="";
				table.innerHTML = "";
				
				
				///var parsed = JSON.parse(data);
				var result = data.result;
				//console.log(result);
				for(var i=0; i<result.length; i++){
					var row = table.insertRow(0);
					for(var j=0; j<4; j++){
						var cell= row.insertCell(j); //총 4개 생성함 0번이 제일위에칸
						cell.innerHTML = result[i][j].value;
						console.log(result[i][j].value);
					}
				}
							
			}
		});
	});
});


</script>
</body>
</html>