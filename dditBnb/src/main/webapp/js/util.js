const searchHistory = new Array();

window.onload = () => {
	/* userMenu toggle */
	const userMenuList = document.querySelector('#userMenu_list');
	const userMenuBtn = document.querySelector('.userMenu')
	
	const toggleUserMenu = () => {
		userMenuList.style.display = (userMenuList.style.display != 'none') ? 'none' : 'block';
	}
	
	userMenuBtn.addEventListener('click', toggleUserMenu);
	
/* ----------------------------------------------------------------------------------------------------------------------------------- */

	/* datePicker */
	const checkIn = new Date();
	const checkOut = new Date();
	checkOut.setDate(checkOut.getDate() + 1)
	
	$('#checkIn').datepicker({
    language: 'ko',
    minDate: checkIn // Now can select only dates, which goes after today
	})
	
	$('#checkOut').datepicker({
		language:'ko',
		minDate:checkOut
	})
	
/* ----------------------------------------------------------------------------------------------------------------------------------- */
	
	/* personCount */
	
	const personCount = $('.person_count').val();
	if(personCount == 0){
		$('.person_count').prev().attr("disabled", "disabled")
	}
	
	const animalCount = $('.animal_count').val();
	if(animalCount == 0){
		$('.animal_count').prev().attr("disabled", "disabled")
	}
	
	$('.personInput_Btn').click(function(){
		if($(this).hasClass("perPlus")){
			plusPerson(this);
		}else if($(this).hasClass("perMinus")){
			minusPerson(this);
		}else{
			if($(this).hasClass("aniPlus")){
				plusAnimal(this);
			}else{
				minusAnimal(this);
			}
		}
		
		
		changeGuestValue();
	})
	
	const plusPerson = (x) => {
		$(x).parent().find('.perMinus').removeAttr("disabled");
		count = $(x).prev().text();
		if(count < 10){			
			$(x).prev().text(parseInt(count) + 1);
		}
		
		if(count == 9){
			$(x).attr("disabled","disabled");
		}
	}
	
	const minusPerson = (x) => {
		count = $(x).next().text();
		if(count > 0){			
			$(x).next().text(parseInt(count) - 1);
		}
		
		if(count == 10){
			$(x).parent().find('.perPlus').removeAttr("disabled");
		}
		
		if(count == 1){
			$(x).attr("disabled", "disabled");
		}
	}
	
	const plusAnimal = (x) => {
		$(x).parent().find('.aniMinus').removeAttr("disabled");
		count = $(x).prev().text();
		if(count < 5){					
			$(x).prev().text(parseInt(count) + 1);
		}
		
		if(count == 4){
			$(x).attr("disabled","disabled");
		}
	}
	
	const minusAnimal = (x) => {
		count = $(x).next().text();
		if(count > 0){
			$(x).next().text(parseInt(count) - 1);
		}
		
		if(count == 5){					
			$(x).parent().find('.aniPlus').removeAttr("disabled")
		}
		
		if(count == 1){
			$(x).attr("disabled","disabled");
		}
	}
	
	const changeGuestValue = () => {
		let person = 0;
		let animal = $('.animal_count').text();
		
		personCounts = document.getElementsByClassName('person_count')
		
		for(i = 0; i < personCounts.length; i++){
			person += parseInt(personCounts[i].innerText);
		}
		
		if(person == 10){
			$('.perPlus').attr("disabled", "disabled");
		}else{
			$('.perPlus').removeAttr("disabled");
		}
		
		if(animal > 0){			
			$('#person').text("게스트" + person + "명" + ", 반려동물" + animal + "마리");
		}else if(person == 0){			
			$('#person').text("게스트 추가");
		}else{
			$('#person').text("게스트" + person + "명");			
		}
	}
	
/* ----------------------------------------------------------------------------------------------------------------------------------- */

	/* personCountMenu toggle */
	
	$('.inputPersonContainer').click(function(){
		$('#inputPerson').toggle();
	})
	
	
	/* loginModal Close */
	$('#findId').click(function(){
		$('#loginForm').modal('hide');
	})
	
/* ----------------------------------------------------------------------------------------------------------------------------------- */
	
	/* searchHistory */
	
	
	$('.searchBtn').click(function(){
		if($('#where').val().trim() != ""){			
			searchSubmit();
		}
	})
	
	const searchSubmit = () => {
		where = $('#where').val().trim();
		
		
		if(searchHistory.length == 0){
			searchHistory.push(where);			
		}else{
			if(searchHistory.indexOf(where) == -1){
				if(searchHistory.length >= 4){
					searchHistory.shift();
					searchHistory.push(where);
				}else{
					searchHistory.push(where);
				}					
			}
		}
		
		saveHistory();
	} 
	
	const saveHistory = () => {
		sessionStorage.setItem("history", JSON.stringify(searchHistory));
	}
	historyObj = JSON.parse(sessionStorage.getItem("history"));
	
	if(historyObj != null){		
		historyObj.forEach((item) => {		
			searchHistory.push(item);
			const historyItem = document.createElement('li');
			const historyImg = document.createElement('span');
			const historyText = document.createElement('span');
			historyImg.classList.add("material-icons");
			historyImg.classList.add("historyIcon");
			historyImg.innerText = "schedule";
			historyText.classList.add("historyText")
			historyText.innerText = item;
			
			historyItem.addEventListener('click', function(e){
				$('#where').val($('.historyText', this).text());
				hideSearchHis();
				checkInput();
			})
			
			historyItem.appendChild(historyImg);
			historyItem.appendChild(historyText);
			document.querySelector('#searchHistoryList').appendChild(historyItem);
		})
	}
	
	$('.searchWhere').click(function(){		
		if($('#where').val().trim() == ""){			
			if(searchHistory.length > 0){
				showSearchHis();
			}
		}
	})
	
	const historyList = document.querySelector('#searchHistory');
	
	const showSearchHis = () => {
		historyList.style.display = 'block';
	}
	
	const hideSearchHis = () => {		
		historyList.style.display = 'none';
	}
	
	$('#searchHisClose').click(function(){
		hideSearchHis();
	})
	

/* --------------------------------------------------------------------------------------------------------------- */

	/* searchAuto */
	
	const autoSearchCon = document.querySelector("#autoSearchContainer");
	const searchInput = document.querySelector('#where');
	const autoSearchList = document.querySelector('#autoSearchList');
	
	const checkInput = () => {
		const beforeVal = searchInput.value.trim();
		timerCheck(beforeVal);
	}
	
	const timerCheck = (beforeVal) => {
		setTimeout(() => {
			if(searchInput.value.trim() === beforeVal){
				if(searchInput.value.trim() != ""){				
					loadData(searchInput.value.trim());
				}
			}else{
				checkInput();
			}
			
			if(searchInput.value.trim() == ""){
				autoSearchCon.style.display = 'none';
			}
		}, 500)
	}
	
	const loadData = (inputVal) => {
		$.ajax({
			url : '/dditBnb/autoSearch.do',
			type : 'post',
			data : {
				"addr" : inputVal
			},
			success : function(res){
				if(res.length != 0 ){					
					setResult(res);
					autoSearchCon.style.display = 'block';
				}
			},
			error : function(xhr){
				alert("상태 : " + xhr.status)
			},
			dataType : 'json'
		})
	}
	
	
	
	let autoSearchResult = new Array();
	const setResult = (res) => {
		res.forEach((item) => {
			let addr = item.prod_add1;
			const result = addr.split(" ", 2);
			addr = result[0] + " " +  result[1];
			
			if(autoSearchResult.indexOf(addr) == -1){
				autoSearchResult.push(addr);
			}

		})
		outPrint();
		autoSearchResult.splice(0, autoSearchResult.length);
	}
	
	const outPrint = () => {
		if(autoSearchResult.length > 0){
			autoSearchList.innerHTML = "";		
			autoSearchResult.forEach((item) => {				
				const autoSearchItem = document.createElement('li');
				const autoSearchImg = document.createElement('span');
				const autoSearchText = document.createElement('span');
				autoSearchImg.classList.add("material-icons");
				autoSearchImg.classList.add("autoSearchIcon");
				autoSearchImg.innerText = "room";
				
				
				autoSearchText.innerText = item;
				autoSearchText.classList.add('autoItem');
				
				autoSearchItem.classList.add('autoSearchItem');
				autoSearchItem.appendChild(autoSearchImg);
				autoSearchItem.appendChild(autoSearchText);
				
				autoSearchList.appendChild(autoSearchItem);
			})	
		}
	}
	
	searchInput.addEventListener('input', function(){
		hideSearchHis();		
		checkInput();
	});
	
/* ------------------------------------------------------------------------------------------ */

	/* autoSearch click */
	
	$('#autoSearchList').on('click', '.autoSearchItem' ,function(){
		where = $('.autoItem',this).text()
		$('#where').val(where);
		check_in = $('#checkIn').val();
		check_out = $('#checkOut').val();
		person = 0;

		let animal = $('.animal_count').text();
		
		personCounts = document.getElementsByClassName('person_count')
		
		for(i = 0; i < personCounts.length; i++){
			person += parseInt(personCounts[i].innerText);
		}
		if(where == ""){
			$('#where').focus();
		}else{			
			location.href = "../main/searchProd.jsp?addr=" + where + 
				"&check_in=" + check_in + "&check_out=" + check_out +
				"&person=" + person;
		}
		searchSubmit();
	})
}

