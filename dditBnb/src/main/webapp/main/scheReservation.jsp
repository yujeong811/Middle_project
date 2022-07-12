<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String prod_id = request.getParameter("prodId");
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
	
	String check_in = request.getParameter("check_in");
	String check_out = request.getParameter("check_out");
	int person = Integer.parseInt(request.getParameter("person"));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>대덕비앤비:예약하기</title>
<script type="text/javascript" src="../js/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="../style/reset.css">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
      rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Fira+Sans:ital,wght@1,900&display=swap" rel="stylesheet">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="../js/util.js"></script>
<link rel="stylesheet" href="../style/scheReservationStyle.css">
<link href="../datepicker/css/datepicker.min.css" rel="stylesheet" type="text/css" media="all">
<!-- Air datepicker css -->
<script src="../datepicker/js/datepicker.js"></script> <!-- Air datepicker js -->
<script src="../datepicker/js/i18n/datepicker.ko.js"></script> <!-- 달력 한글 추가를 위해 커스텀 -->
<script type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script type="text/javascript">
$(function(){
	var prodPrice = 0;
	var person = <%= person%>
	
	personCounts = document.getElementsByClassName('person_count')
	
	for(i = 0; i < personCounts.length; i++){
		person += parseInt(personCounts[i].innerText);
	}
	
	$.ajax({
		url : '/dditBnb/getProdDetail.do',
		type : 'post',
		data : {
			"prod_id" : "<%= prod_id%>",
			"check_in" : "<%= check_in%>",
			"check_out" : "<%= check_out%>"
		},
		success : function(res){
			imgCode = "<img src='" + res.prodDetail.link[0] + "'/>"
			$('#prodImg').html(imgCode);
			
			nameCode = "<div>" + res.prodDetail.prod_name + "</div>"
			$('#prodName').append(nameCode);
			
			starCode = "	<span>"
			starCode += '		<svg viewBox="0 0 32 32" xmlns="http://www.w3.org/2000/svg" aria-hidden="true" role="presentation" focusable="false" style="display: block; fill: #FF385C; height: 14px; width: 14px;">'
			starCode += ' 			<path d="M15.094 1.579l-4.124 8.885-9.86 1.27a1 1 0 0 0-.542 1.736l7.293 6.565-1.965 9.852a1 1 0 0 0 1.483 1.061L16 25.951l8.625 4.997a1 1 0 0 0 1.482-1.06l-1.965-9.853 7.293-6.565a1 1 0 0 0-.541-1.735l-9.86-1.271-4.127-8.885a1 1 0 0 0-1.814 0z" fill-rule="evenodd">'
			starCode += '			</path>'		
			starCode += '		</svg>'	
			starCode += "	</span>"
			starCode += "<span style='font-weight:bold; margin-left:5px;'>" + res.star + "</span>"
			
			
			$('#prodStar').append(starCode)
			
			priceCode = "₩" + priceToString(res.prodDetail.prod_price)+ " / 박"
			$('#calPrice').html(priceCode);
			
			prodPrice = res.schePrice;
			
			checkIn = new Date("<%= check_in%>")
			checkOut = new Date("<%= check_out%>")
			day = (checkOut - checkIn) / (1000 * 3600 * 24)
			
			schePriceCode = "<p class='calTotal'>"
			schePriceCode += "<span>"
			schePriceCode += "₩" + priceToString(res.prodDetail.prod_price) + " X " + day + "박"
			schePriceCode += "</span>"
			schePriceCode += "<span>"
			schePriceCode += "₩" + priceToString(res.schePrice)
			schePriceCode += "</span>"
			schePriceCode += "</p><hr>"
			schePriceCode += "<p class='totalPriceCon'>총 합계(KRW)₩<span id='totalPrice'>" + priceToString(res.schePrice) + "</span></p>"
			
			$('#payInfo').append(schePriceCode);
			
			$('#prodHost').append(res.prodDetail.mem_id + '님')
		},
		error : function(xhr){
			alert("상태 : " + xhr.status)
		},
		dataType : 'json'
	})
	
	function priceToString(price) {
    	return price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
	}
	
	$.ajax({
		url : "/dditBnb/myInfo.do",
		type : "post",
		data : {
			"memId" : "<%= user %>"
		},
		success : function(res){
			$('.username').val(res.mem_name)
			$('.usertel').val(res.mem_tel)
			$('.useremail').val(res.mem_email)
			
		},
		error : function(xhr){
			alert("상태 : " + xhr.status)
		},
		dataType:'json'
	})
	
	$('#person').text("게스트" + person + "명")
	$('#payBtn').click(function(){
		if(person == 0){
			alert("인원을 입력해주세요.")
		}else{
			var IMP = window.IMP; // 생략가능
			IMP.init('imp62023948');
			// 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용
			// i'mport 관리자 페이지 -> 내정보 -> 가맹점식별코드
			IMP.request_pay({
			pg: 'html5_inicis', // version 1.1.0부터 지원.
				/*
				'kakao':카카오페이,
				html5_inicis':이니시스(웹표준결제)
				'nice':나이스페이
				'jtnet':제이티넷
				'uplus':LG유플러스
				'danal':다날
				'payco':페이코
				'syrup':시럽페이
				'paypal':페이팔
				*/
			pay_method: 'card',
				/*
				'samsung':삼성페이,
				'card':신용카드,
				'trans':실시간계좌이체,
				'vbank':가상계좌,
				'phone':휴대폰소액결제
				*/
			merchant_uid: 'merchant_' + new Date().getTime(),
				/*
				merchant_uid에 경우
				https://docs.iamport.kr/implementation/payment
				위에 url에 따라가시면 넣을 수 있는 방법이 있습니다.
				참고하세요.
				나중에 포스팅 해볼게요.
				*/
			name: "제주 오션갤러리 호텔앤리조트", //결제창에서 보여질 이름
			amount: 100, //가격
			buyer_email: $('.useremail').val(),
			buyer_name: $('.username').val(),
	//	 	buyer_postcode: '123-456',
	//	 	m_redirect_url: 'https://www.yourdomain.com/payments/complete'
				/*
				모바일 결제시,
				결제가 끝나고 랜딩되는 URL을 지정
				(카카오페이, 페이코, 다날의 경우는 필요없음. PC와 마찬가지로 callback함수로 결과가 떨어짐)
				*/
			}, function (rsp) {
				
				if (rsp.success) {
					// jQuery로 HTTP 요청
			        $.ajax({
			            url: "/dditBnb/payReservation.do", 
			            type: "POST",
			            data: {
			                "imp_uid": rsp.imp_uid,
			                "merchant_uid": rsp.merchant_uid,
			                "prod_id" : "<%= prod_id%>",
		 	                "mem_id" : "<%= user%>",
		 	                "check_in" : $('#checkIn').val(),
		 	                "check_out" : $('#checkOut').val(),
		 	                "sche_price" : prodPrice,
		 	                "reser_req" : $('.reserReq').val(),
		 	                "reser_per" : person
			            },
			            success : function(res){
			            	//성공시 로직
			            	alert(res);
			            	location.href = "./myPage.jsp";
			    		},
			    		error : function(xhr){
			    			alert(xhr.status);
			    		}
			        })
				} else {
					alert("결제에 실패하였습니다. 에러 내용: " +  rsp.error_msg);
				}
			});
		}
	})
})
</script>
</head>
<body>
<header>
	<div id="headerTop">
		<div id="logoContainer">
			<a href="./index.jsp">
				<svg width="35" height="32" fill="hotpink" style="display:block;">
					<path d="
						M 16 1 c 2.008 0 3.463 0.963 4.751 3.269 l 0.533 1.025 c 1.954 3.83 6.114 12.54 7.1 14.836 l 0.145 0.353 c 0.667 1.591 0.91 2.472 0.96 3.396 l 0.01 0.415 l 0.001 0.228 c 0 4.062 -2.877 6.478 -6.357 6.478 c -2.224 0 -4.556 -1.258 -6.709 -3.386 l -0.257 -0.26 l -0.172 -0.179 h -0.011 l -0.176 0.185 c -2.044 2.1 -4.267 3.42 -6.414 3.615 l -0.28 0.019 l -0.267 0.006 C 5.377 31 2.5 28.584 2.5 24.522 l 0.005 -0.469 c 0.026 -0.928 0.23 -1.768 0.83 -3.244 l 0.216 -0.524 c 0.966 -2.298 6.083 -12.989 7.707 -16.034 C 12.537 1.963 13.992 1 16 1 Z m 0 2 c -1.239 0 -2.053 0.539 -2.987 2.21 l -0.523 1.008 c -1.926 3.776 -6.06 12.43 -7.031 14.692 l -0.345 0.836 c -0.427 1.071 -0.573 1.655 -0.605 2.24 l -0.009 0.33 v 0.206 C 4.5 27.395 6.411 29 8.857 29 c 1.773 0 3.87 -1.236 5.831 -3.354 c -2.295 -2.938 -3.855 -6.45 -3.855 -8.91 c 0 -2.913 1.933 -5.386 5.178 -5.42 c 3.223 0.034 5.156 2.507 5.156 5.42 c 0 2.456 -1.555 5.96 -3.855 8.907 C 19.277 27.766 21.37 29 23.142 29 c 2.447 0 4.358 -1.605 4.358 -4.478 l -0.004 -0.411 c -0.019 -0.672 -0.17 -1.296 -0.714 -2.62 l -0.248 -0.6 c -1.065 -2.478 -5.993 -12.768 -7.538 -15.664 C 18.053 3.539 17.24 3 16 3 Z m 0.01 10.316 c -2.01 0.021 -3.177 1.514 -3.177 3.42 c 0 1.797 1.18 4.58 2.955 7.044 l 0.21 0.287 l 0.174 -0.234 c 1.73 -2.385 2.898 -5.066 2.989 -6.875 l 0.006 -0.221 c 0 -1.906 -1.167 -3.4 -3.156 -3.421 h -0.001 Z
					">
					</path>
				</svg>
				<span id="logoTitle">
					dditBnB
				</span>
			</a>
		</div>
		<div class="userContent">
			<button class="hostingBtn"><a href="./hosthome.jsp">호스트 되기</a></button>
			<button class="userMenu">
				<span class="material-icons">
					reorder
				</span>
				<span class="material-icons" style="font-size:35px;">
					account_circle
				</span>
			</button>
		</div>
		<ul id="userMenu_list" style="display: none;">
			<li class="userMenu_item" id="message">메세지</li>
			<li class="userMenu_item" id="myPage"><a href="./myPage.jsp">마이페이지</a></li>
			<hr>
			<li class="userMenu_item" id="prodManage"><a href="./manageHostprod.jsp">숙소관리</a></li>
			<li class="userMenu_item" id="help"><a href="./helpBoard.jsp">도움말</a></li>
			<li class="userMenu_item" id="logOut">로그아웃</li>
		</ul>
	</div>
</header>
<hr>
<main>
	<div id="reserContainer">
		<h1>확인 및 결제</h1>
		<div id="reser_user_Info">		
			<div id="reserInfoCon">
			<h2>예약 정보</h2>
			<table id="reserInfo">
					<tr>
						<td>
							<p>체크인</p>
							<input type='text' data-language='ko' value="<%= check_in%>" id="checkIn"  disabled/>
						</td>
						<td>
							<p>체크아웃</p>
							<input type='text' data-language='ko' value="<%= check_out%>" id="checkOut"  disabled/>
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<div class="inputPersonContainer">				
								<p>인원</p>
								<span id="person">게스트 추가</span>
							</div>
							<div id="inputPerson" >
								<div id="adult" class="inputPerson_list">
									<div class="personDes">
										<p>일반</p>
										<span>만13세 이상</span>
									</div>
									<div class="personCount">
										<button class="personInput_Btn perMinus">
											<span>
												<svg viewBox="0 0 32 32" xmlns="http://www.w3.org/2000/svg" aria-hidden="true"
												style="display: block; fill: none; height: 12px; width: 12px; stroke: currentcolor; stroke-width: 5.33333; overflow: visible;">
													<path d="m2 16h28"></path>
												</svg>
											</span>
										</button>
										<span class="person_count">0</span>
										<button class="personInput_Btn perPlus">
											<span>
												<svg viewBox="0 0 32 32" xmlns="http://www.w3.org/2000/svg" aria-hidden="true"
												style="display: block; fill: none; height: 12px; width: 12px; stroke: currentcolor; stroke-width: 5.33333; overflow: visible;">
													<path d="m2 16h28m-14-14v28"></path>
												</svg>
											</span>
										</button>
									</div>
								</div>
								<hr>
								<div id="child" class="inputPerson_list">
									<div class="personDes">
										<p>어린이</p>
										<span>만 2 ~ 12세</span>
									</div>
									<div class="personCount">
										<button class="personInput_Btn perMinus">
											<span>
												<svg viewBox="0 0 32 32" xmlns="http://www.w3.org/2000/svg" aria-hidden="true"
												style="display: block; fill: none; height: 12px; width: 12px; stroke: currentcolor; stroke-width: 5.33333; overflow: visible;">
													<path d="m2 16h28"></path>
												</svg>
											</span>
										</button>
										<span class="person_count">0</span>
										<button class="personInput_Btn perPlus">
											<span>
												<svg viewBox="0 0 32 32" xmlns="http://www.w3.org/2000/svg" aria-hidden="true"
												style="display: block; fill: none; height: 12px; width: 12px; stroke: currentcolor; stroke-width: 5.33333; overflow: visible;">
													<path d="m2 16h28m-14-14v28"></path>
												</svg>
											</span>
										</button>
									</div>
								</div>
								<hr>
								<div id="animal" class="inputPerson_list">
									<div class="personDes">
										<p>반려동물</p>
									</div>
									<div class="personCount">
										<button class="personInput_Btn aniMinus">
											<span>
												<svg viewBox="0 0 32 32" xmlns="http://www.w3.org/2000/svg" aria-hidden="true"
												style="display: block; fill: none; height: 12px; width: 12px; stroke: currentcolor; stroke-width: 5.33333; overflow: visible;">
													<path d="m2 16h28"></path>
												</svg>
											</span>
										</button>
										<span class="animal_count">0</span>
										<button class="personInput_Btn aniPlus">
											<span>
												<svg viewBox="0 0 32 32" xmlns="http://www.w3.org/2000/svg" aria-hidden="true"
												style="display: block; fill: none; height: 12px; width: 12px; stroke: currentcolor; stroke-width: 5.33333; overflow: visible;">
													<path d="m2 16h28m-14-14v28"></path>
												</svg>
											</span>
										</button>
									</div>
								</div>
							</div>
						</td>
					</tr>
				</table>
				<div id="prodInfo">
					<div id="prodImg">
					</div>
					<div id="prodDes">
						<div id="prodName" class="desCon">
							<p class="title">숙소 이름</p>
						</div>
						<div id="prodStar" class="desCon">
							<p class="title" style="display: inline-block;">숙소 평점&nbsp;</p>
						</div>
						<div id="prodHost" class="desCon">
							<p class="title" style="display: inline-block;">호스트&nbsp;</p>
						</div>
					</div>
				</div>
				<div id="payInfo">
					<h2>결제</h2>
					<hr>
				</div>
				<button id="payBtn" type="button">확인 및 결제</button>
			</div>
			<div id="userInfoCon">
				<h2>필수 입력 정보</h2>
				<hr>
				<div id="userInfoForm">
					<span class='title' style="display:inline-block; width: 150px;">예약자 이름</span>
					<input type="text" class="username"><hr>
					<span class='title' style="display:inline-block; width: 150px;">연락자 전화번호</span>
					<input type="text" class="usertel"><hr>
					<span class='title' style="display:inline-block; width: 150px;">연락자 이메일</span>
					<input type="text" class="useremail"><hr>
					<span class='title' style="display:inline-block; width: 150px;">요청사항</span>
					<textarea  class="reserReq" placeholder="요청사항을 입력하세요"></textarea>
				</div>
			</div>
		</div>
	</div>
</main>
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