<%@page import="member.MemberDTO"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>member/update.jsp</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<!--[if lt IE 9]>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/IE9.js" type="text/javascript"></script>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/ie7-squish.js" type="text/javascript"></script>
<script src="http://html5shim.googlecode.com/svn/trunk/html5.js" type="text/javascript"></script>
<![endif]-->
<!--[if IE 6]>
 <script src="../script/DD_belatedPNG_0.0.8a.js"></script>
 <script>
   /* EXAMPLE */
   DD_belatedPNG.fix('#wrap');
   DD_belatedPNG.fix('#main_img');   

 </script>
 <![endif]-->
</head>
<body>
<div id="wrap">
<!-- 헤더들어가는 곳 -->
<jsp:include page="../inc/top.jsp"></jsp:include>
<!-- 헤더들어가는 곳 -->

<!-- 본문들어가는 곳 -->
<!-- 본문메인이미지 -->
<div id="sub_img_member"></div>
<!-- 본문메인이미지 -->
<!-- 왼쪽메뉴 -->
<nav id="sub_menu">
<ul>
<li><a href="#">Join us</a></li>
<li><a href="#">Privacy policy</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->
<!-- 본문내용 -->
<%
//세션값 가져오기 
String id=(String)session.getAttribute("id");
// MemberDAO 객체생성
MemberDAO memberDAO = new MemberDAO();
// 리턴할형 MemberDTO  getMember(String id) 메서드 정의
// MemberDTO memberDTO =getMember(id) 메서드호출
MemberDTO memberDTO=memberDAO.getMember(id);
%>
<article>
<h1>Update Us</h1>
<form action="updatePro.jsp" id="join" method="post">
<fieldset>
<legend>기본 정보</legend>
<label>사용자 ID</label>
<input type="text" name="id" class="id" value="<%=memberDTO.getId() %>" readonly>
<input type="button" value="dup. check" class="dup"><br>
<label>비밀번호</label>
<input type="password" name="pass"><br>
<label>이름</label>
<input type="text" name="name" value="<%=memberDTO.getName() %>"><br>
<label>E-Mail</label>
<input type="email" name="email" value="<%=memberDTO.getEmail() %>"><br>
</fieldset>

<fieldset>
<legend>추가 사항</legend>
<label>주소</label>
<tr>
	<td><input type="text" name="postcode" id="sample6_postcode" value="<%=memberDTO.getPostcode() %>" palceholder="우편번호" readonly></td>
	<td><input type="button" onclick="sample6_execDaumPostcode()" value="우편번호찾기" class="dup"></td><br>
	<label></label>
	<td><input type="text" name="addr" id="sample6_address" value="<%=memberDTO.getAddress() %>" palceholder="주소"></td> <br>
</tr>

<label>전화번호</label>
<input type="text" name="phone" value="<%=memberDTO.getPhone() %>"><br>
<label>휴대폰번호</label>
<input type="text" name="mobile" value="<%=memberDTO.getMobile() %>"><br>
</fieldset>
<div class="clear"></div>
<div id="buttons">
<input type="submit" value="Submit" class="submit">
<input type="reset" value="Cancel" class="cancel">
</div>
</form>


<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        addr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        addr += (addr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("sample6_address").value = addr;
                
                } else {
                    document.getElementById("sample6_address").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("sample6_address").value = addr;
            }
        }).open();
    }
</script>


</article>
<!-- 본문내용 -->
<!-- 본문들어가는 곳 -->

<div class="clear"></div>
<!-- 푸터들어가는 곳 -->
<jsp:include page="../inc/bottom.jsp"></jsp:include>
<!-- 푸터들어가는 곳 -->
</div>
</body>
</html>