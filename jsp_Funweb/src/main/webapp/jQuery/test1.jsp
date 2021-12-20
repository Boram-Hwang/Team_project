<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>jQuery/test1.jsp</title>
<script src="../script/jquery-3.6.0.js"></script>
<script type="text/javascript">
	// 자바스크립트를 가지고 메서드를 정의 => 쉽고 코드 간결하게 사용하기 위해 만든 프로그램(프레임워크)틀
	// https://jquery.com/
	// download
	// Download the uncompressed, development jQuery 3.6.0
	// 설치 => script폴더  jquery-3.6.0.js
	
// 	jQuery(document).ready(function(){
// 		alert("준비");
// 	});
	
	$(document).ready(function(){
// 		alert("준비2");
		// 대상.함수() 
		// * 전체 document 대상
		$('*').css('color','blue');
		//  태그 대상 
		$('h1').css('color','green');
		// id=이름  #이름
		$('#ta').css('color','red');
		// class=이름 .이름
		$('.ta2').css('color','purple');
		// 태그[속성=값]
		$('input[type=text]').css('color','skyblue');
	});
	

</script>
</head>
<body>
<input type="text" name="id" value="내용">
<h1>제목1</h1>
<h1 id="ta">제목2</h1>
<h1 class="ta2">제목3</h1>
본문
</body>
</html>
