<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 
	labelsArr이라는 이름이 전역변수로도 있고 필드의 속성으로도 있으면
	어떤 labelsArr을 컨트롤 F로 검색했을때 여기도 저기도 labelsArr이라 가독성이 매우 떨어질꺼에요
	변수명을 다르게 해주세요
 -->
<script>

var labelsArr 	= [],
	dataArr		= [];

var fidldC = {
	
	// labelsArr과 dataArr에 A가 붙어서 사용이 안되므로 A삭제
	labelsArr 	: [],
	dataArr	 	: [],
	myPieA		: null
}

// config변수가 fieldC에서 사용이 되야하는데 charC안에 있었으므로 위치 이동
// config변수가 charC?? chartC 아닌가요? 암튼  그 안에 있으면 사용이 안되나요? 사용이 될 것같은데요 
var config = {
		type: 'pie',  // 여기 왜 들여쓰기가 두번 되어있죠
			data: { 
				datasets: [{
					data: dataArr,
					backgroundColor: [
						window.chartColors.red, // 여기 왜 앞에 window.이 붙어있죠? 아시는대로 설명해주세요
						window.chartColors.yellow,
						window.chartColors.green,
						window.chartColors.blue,
					],
					label: 'Dataset 1'
				}],
				labels: labelsArr
			},
			options: {
				responsive: true
			}
};

var chartC = {

	configA : function() {
		<c:forEach items="${classInfoList}" var="classInfo" varStatus = "status">
			labelsArr[${status.index}] 	= "${classInfo.classNm}";
			dataArr[${status.index}] 	= "${classInfo.cnt}";
		</c:forEach>
	},
	
	createA : function() {
		var ctx = document.getElementById('chart-area').getContext('2d');
		
		fidldC.myPieA = new Chart(ctx, config);
	}
};

var eventC = {
		
	clickA : function() {
		
		// 렉시컬 컨텍스트 말고 this 컨텍스트로 변겨해주세요. fieldC 추가하신거 이야기 드리는겁니다. 
		//경로가 맞지 않아 fieldC 추가                    주석 한줄 위 띄는겁니다.
		$("#chart-area").click(function(e) {
			var firstPoint = fieldC.myPie.getElementAtEvent(e)[0];
			//경로가 맞지 않아 fieldC 추가	
			if (firstPoint) {
				var label = fieldC.myPie.data.labels[firstPoint._index];
				        
				if ($("tbody > tr").length > 0) {
					$("tbody > tr").remove();
				}
				
				// ajax 부분을 다른곳으로 빼서 호출해주세요
			    $.ajax({
				        	
		        	url  : "/selectStudentStatusList.do",
			        type : "post",
			        data : {"param" : label},
				        	
		        	success : function(data) {
			        	data.forEach(function(obj, idx) {
			        		var tr = document.createElement("tr");
				        			
			        		for (var key in obj) { // 들여쓰기가 또 안맞네요
		        			var td = document.createElement("td");
				        				 
		        			$(td).text(obj[key]);
				        				 
		        			$(tr).append(td);
				        	}
				        			
			        		$("tbody").append(tr);
						});
					}
				});
			}
		});
	}
}

$(function () {
	
	// 차트를 설정
	chartC.configA();
	
	// 차트를 생성
	chartC.createA();
	
	// 클릭이벤트 부여
	eventC.clickA();
});
		
</script>
<!-- contents -->
<div id="contents">
	<!-- 컨텐츠 -->
	<div class="content_wrap">
		<h2 class="fs-18 fw-b">수강생 현황 차트</h2>
		<div id=" canvas-holder" style="width:40%">
			<div class="chartjs-size-monitor">
				<div class="chartjs-size-monitor-expand">
					<div class="">
					</div>
				</div>
				<div class="chartjs-size-monitor-shrink">
					<div class="">
					</div>
				</div>
			</div>
			<canvas id="chart-area" style="cursor:pointer; display: block; height: 242px; width: 484px;" width="605"
					height="302" class="chartjs-render-monitor">
			</canvas>
		</div>
		<div class="btn-wrap mgt-20">
		  <div class="f-r">
			<ul>
			  <li>
				<button id="btn" type="button" class="btn type03 f-r">검색</button>
			  </li>
			</ul>
		  </div>
		</div>
		<h2 class="fs-18 fw-b">수강생 테이블</h2><br>
		<table class="tbl type02">
			<thead>
				<tr>
					<th scope="row">순번</th>
					<th scope="row">아이디</th>
					<th scope="row">이름</th>
					<th scope="row">나이</th>
					<th scope="row">닉네임</th>
					<th scope="row">핸드폰번호</th>
					<th scope="row">수업과정</th>
					<th scope="row">기수</th>
					<th scope="row">주차</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
		</table>
	</div>
</div>
<!--// contents -->