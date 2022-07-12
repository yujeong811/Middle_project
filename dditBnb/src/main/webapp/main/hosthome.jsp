<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>대덕비앤비:호스트되기</title>
<link rel="stylesheet" href="../style/reset.css">
<link rel="stylesheet" href="../style/hostHome.css">
<script type="text/javascript" src="../js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="../js/login.js"></script>
<script type="text/javascript" src="../js/kakaoLogin.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script src="../js/kakaoLogin.js"></script>
 <%
	Cookie[] cookies = request.getCookies();
	
	String user = "";
	String check = "";
	
	if(cookies != null){
		for(Cookie cookie : cookies){
			if(cookie.getName().equals("user")){
				user = cookie.getValue();
			}
		}
	}
%>
</head>
<body>
	<div id="hostHome_Container">
		<div id="topContainer">
			<div id="logo">
				<a href="./index.jsp">
					<svg width="35" height="32" fill="white" style="display:block;">
						<path d="
							M 16 1 c 2.008 0 3.463 0.963 4.751 3.269 l 0.533 1.025 c 1.954 3.83 6.114 12.54 7.1 14.836 l 0.145 0.353 c 0.667 1.591 0.91 2.472 0.96 3.396 l 0.01 0.415 l 0.001 0.228 c 0 4.062 -2.877 6.478 -6.357 6.478 c -2.224 0 -4.556 -1.258 -6.709 -3.386 l -0.257 -0.26 l -0.172 -0.179 h -0.011 l -0.176 0.185 c -2.044 2.1 -4.267 3.42 -6.414 3.615 l -0.28 0.019 l -0.267 0.006 C 5.377 31 2.5 28.584 2.5 24.522 l 0.005 -0.469 c 0.026 -0.928 0.23 -1.768 0.83 -3.244 l 0.216 -0.524 c 0.966 -2.298 6.083 -12.989 7.707 -16.034 C 12.537 1.963 13.992 1 16 1 Z m 0 2 c -1.239 0 -2.053 0.539 -2.987 2.21 l -0.523 1.008 c -1.926 3.776 -6.06 12.43 -7.031 14.692 l -0.345 0.836 c -0.427 1.071 -0.573 1.655 -0.605 2.24 l -0.009 0.33 v 0.206 C 4.5 27.395 6.411 29 8.857 29 c 1.773 0 3.87 -1.236 5.831 -3.354 c -2.295 -2.938 -3.855 -6.45 -3.855 -8.91 c 0 -2.913 1.933 -5.386 5.178 -5.42 c 3.223 0.034 5.156 2.507 5.156 5.42 c 0 2.456 -1.555 5.96 -3.855 8.907 C 19.277 27.766 21.37 29 23.142 29 c 2.447 0 4.358 -1.605 4.358 -4.478 l -0.004 -0.411 c -0.019 -0.672 -0.17 -1.296 -0.714 -2.62 l -0.248 -0.6 c -1.065 -2.478 -5.993 -12.768 -7.538 -15.664 C 18.053 3.539 17.24 3 16 3 Z m 0.01 10.316 c -2.01 0.021 -3.177 1.514 -3.177 3.42 c 0 1.797 1.18 4.58 2.955 7.044 l 0.21 0.287 l 0.174 -0.234 c 1.73 -2.385 2.898 -5.066 2.989 -6.875 l 0.006 -0.221 c 0 -1.906 -1.167 -3.4 -3.156 -3.421 h -0.001 Z
						">
						</path>
					</svg>
				</a>
			</div>
			<div id="title">
				<span>			
					대덕비앤비의 핵심을 이루는 호스팅
				</span>
			</div>
			<div id="goHosting">
				<%
					if(user.equals("")){
				%>
						<button class="hostt" type="button" data-toggle="modal" data-target="#loginForm">호스팅 시작하기</button>
				<%
					}else{
				%>
						<button class="hostt" type="button"><a href='./doHosting.jsp'>호스팅 시작하기</a></button>
				<% 		
					}
				%>
			</div>
		</div>
		<div id="midContainer">
			<img src="https://a0.muscache.com/im/pictures/93ef1829-62d1-4349-8b4a-b02ebc650a25.jpg?im_w=2560&im_q=highq">
			<div id="hostHome_QnA">
				<div>
					<h2>
						호스팅에 관해 궁금하신 점이 <br>있나요?
					</h2>
					<button class="hostt"><a href="./helpBoard.jsp">자세히 알아보기</a></button>
				</div>
			</div>
		</div>
	</div>
	<!-- login modal -->
	<div class="modal fade" id="loginForm">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h4 class="modal-title">로그인</h4>
	        <button type="button" class="close" data-dismiss="modal">&times;</button>
	      </div>
	      <div class="modal-body">
	        <form>
			  <div class="form-group">
			    <!-- <label for="loginId">아이디:</label> -->
			    <input type="text" class="form-control" placeholder="Enter ID" id="loginId" autocomplete="off">
			  </div>
			  <div class="form-group">
			   <!--  <label for="loginPwd">비밀번호:</label> -->
			    <input type="password" class="form-control" placeholder="Enter PassWord" id="loginPwd" autocomplete="off">
			  </div>
			  <!-- <div class="form-group form-check"> -->
			    <label class="form-check-label" style="margin-bottom : 10px">
			      <input class="form-check-input" type="checkbox" style="margin-bottom : 10px"> ID 기억하기
			 <!--  </div> -->
			    </label><br>
			  <a class="btn btn-warning" data-toggle="modal" href="#findIdForm" id="findId">아이디 찾기</a>
			  <a class="btn btn-warning" data-toggle="modal" href="#findPwdForm" id="findPass" >비밀번호 찾기</a><br>
			  <button type="button" class="btn btn-primary" id="loginBtn">로그인</button>
			   <div class="hr-sect">또는</div>
			  <ul>			  
				<li onclick="kakaoLogin();">
			      <a href="javascript:void(0)">
			      	  <button type="button" id="kakaologin">
			      	  <span id="kakaologo">
			      	  <img src="../image/카카오.PNG" width="25px" height="25px" style="margin-left: 10px;">
			      	  </span>카카오로 로그인하기
			      	  </button>
			      </a>
				</li>
			  </ul>
				<button type="button" id="naverlogin">
			      	  <span id="kakaologo">
			      	  <img src="../image/btnG_아이콘사각.png" width="25px" height="25px" style="margin-left: 10px;">
			      	  </span>네이버로 로그인하기
			    </button>
				</form>
	      </div>
<!-- 	      <div class="modal-footer">
	        <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
	      </div> -->
	
	    </div>
	  </div>
	</div>
	<!-- findId Modal -->
	<div class="modal fade" id="findIdForm" data-backdrop="static">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h4 class="modal-title">아이디 찾기</h4>
	        <button type="button" class="close" data-dismiss="modal">&times;</button>
	      </div>
	      <div class="modal-body">
	        <form action="">
			  <div class="form-group">
			    <label for="uname">이름</label>
			    <input type="text" class="form-control" placeholder="이름을 입력하세요" id="findIdname" autocomplete="off">
			  </div>
			  <div class="form-group">
			    <label for="tel">전화번호</label>
			    <input type="text" class="form-control" placeholder="전화번호를 입력하세요" id="findIdtel" autocomplete="off">
			  </div>
			  <div id="findIdResult">
			  </div>  
			</form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-primary" id="findIdBtn">찾기</button>	
	      </div>
	
	    </div>
	  </div>
	</div>
	<!-- findPwd Modal -->
	<div class="modal fade" id="findPwdForm" data-backdrop="static">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h4 class="modal-title">비밀번호 찾기</h4>
	        <button type="button" class="close" data-dismiss="modal">&times;</button>
	      </div>
	      <div class="modal-body" id="findpassmo">
	        <form action="">
			  <div class="form-group">
			    <label for="findPassname">이름</label>
			    <input type="text" class="form-control" placeholder="이름을 입력하세요" id="findPassname" autocomplete="off">
			  </div>
			  <div class="form-group">
			    <label for="findPassid">아이디</label>
			    <input type="text" class="form-control" placeholder="아이디를 입력하세요" id="findPassid" autocomplete="off">
			  </div>
			   <div class="form-group">
			   <label for="findPasshint">힌트질문</label>
			 	   <select name="findPwd" id="findPasshint" style="width : 300px">
			   	 		<option>
			    			보물 1호는?
			    		</option>
			    		<option>
			    			졸업한 고등학교는?
			    		</option>
			   	 		<option>
			    			가장 좋아했던 여자친구 이름은?
			    		</option>
			    		<option>
			    			가장 좋아했던 남자친구 이름은?
			    		</option>
			  	    </select>
			     </div>
			  <div class="form-group">
			    <label for="findPassans">힌트정답</label>
			    <input type="text" class="form-control" placeholder="질문에 대한 정답을 입력하세요" id="findPassans" autocomplete="off">
			  </div>	  
			</form>
	      </div>
	      <div class="modal-footer">
	         <button type="button" class="btn btn-primary" id="findPwdBtn">확인</button>	
	      </div>
	
	    </div>
	  </div>
	</div>
	<div class="modal fade" id="newPassForm" data-backdrop="static">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h4 class="modal-title">비밀번호 변경</h4>
	        <button type="button" class="close" data-dismiss="modal">&times;</button>
	      </div>
	      <div class="modal-body" id="findpassmo">
	        <form action="">
			  <div class="form-group">
			    <label for="newpass">변경할 비밀번호</label>
			    <input type="password" class="form-control" placeholder="비밀번호를 입력하세요" id="newpass" autocomplete="off">
			  </div>	  
			</form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-primary" id="getnewpass">변경하기</button>
	      </div>
	
	    </div>
	  </div>
	</div>
<footer id="footer">
	<div id="footer_list">
		<div id="footer_support">
			<h3>대덕비앤비 지원</h3>
			<ul>
				<li>도움말 센터</li>
				<li>안전 정보</li>
				<li>예약 취소 옵션</li>
				<li>에어비앤비의 코로나19 대응 방안</li>
				<li>장애인 지원</li>
				<li>이웃 민원 신고</li>
			</ul>
		</div>
		<div id="footer_community">
			<h3>커뮤니티</h3>
			<ul>
				<li>dditBnB.org:재난 구호 숙소</li>
				<li>아프간 난민 지원</li>
				<li>차별 철폐를 위한 노력</li>
			</ul>
		</div>
		<div id="footer_hosting">
			<h3>호스팅</h3>
			<ul>
				<li>호스팅 시작하기</li>
				<li>커뮤니티 포럼 방문하기</li>
				<li>에어커버:호스트를 위한 보호 프로그램</li>
				<li>책임감 있는 호스팅</li>
				<li>호스팅 자료 둘러보기</li>
			</ul>
		</div>
		<div id="footer_introduce">
			<h3>소개</h3>
			<ul>
				<li>뉴스룸</li>
				<li>채용정보</li>
				<li>새로운 기능에 대해 알아보기</li>
				<li>투자자 정보</li>
				<li>대덕비앤비 공동창업자의 메시지</li>
				<li>대덕비앤비 Luxe</li>
			</ul>
		</div>
	</div>
	<div id="footer_mark">
		<span>
			&copy; 2022 dditBnB,Inc
		</span>
	</div>
</footer>
</body>
</html>