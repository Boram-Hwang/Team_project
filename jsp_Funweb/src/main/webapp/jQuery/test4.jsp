<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="../script/jquery-3.6.0.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		// 대상.append()   뒤부분에 추가
		$('h1').append('소제목');
		
// 		$('table').append('<tr><td>1</td><td>제목1</td></tr>'); // 이건 1개 추가할때
		
		// 배열 (여러개 추가할 때)
		var arr=[
			{'num':'1','subject':'제목1'},
			{'num':'2','subject':'제목2'},
			{'num':'3','subject':'제목3'}
		];
		// 반복문 each()
		$.each(arr,function(index,item){
// 			alert(index);
// 			alert(item);
// 			alert(item.num);
// 			alert(item.subject);
			
			$('table').append('<tr><td>'+item.num+'</td><td>'+item.subject+'</td></tr>');
		});
	});
	</script>
</head>
<body>
<h1>제목</h1>
<table border="1">
<tr><td>번호</td><td>제목</td></tr>
</table>
</body>
</html>