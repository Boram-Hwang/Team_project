<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>jQuery/test2.jsp</title>
<script src="../script/jquery-3.6.0.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		// 대상.html() 
// 		$('h1').html('내용1');
		
// 		$('h1').html(function(index,oldhtml){
// 			alert(index);
// 			alert(oldhtml);
// 			return oldhtml+'*'+index;
// 		});

		// 버튼 클릭 했을때 => 클릭 이벤트  click()
		$('#btn').click(function(){
// 			alert("클릭");
			$('h1').html('클릭');
		});
		
	});
</script>
</head>
<body>
<input type="button" value="버튼" id="btn">
<h1>제목1</h1>
<h1>제목2</h1>
<h1>제목3</h1>
</body>
</html>


