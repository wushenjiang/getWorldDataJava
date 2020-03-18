<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>图表展示界面</title>
<!-- 引入Bootstrap核心样式文件 -->
<link href="css/bootstrap.css" rel="stylesheet">
<!-- 引入jQuery核心js文件 -->
<script src="./js/jquery-1.11.3.min.js"></script>
<!-- 引入BootStrap核心js文件 -->
<script src="./js/bootstrap.js"></script>
<script src="./js/echarts.min.js"></script>
<script>
function search(){
	var $condition = $("#condition").val();
	var $content = $("#content").val();
	var $type = $("#type").val();
	if($type =="表格"){
		location.href = "${pageContext.request.contextPath}/searchByCondition?condition="
			+ $condition + "&content=" + $content;
	}
	if($type=="图表"){
		location.href = "${pageContext.request.contextPath}/searchByConditionWithChart?condition="
			+ $condition + "&content=" + $content;
	}

}
$(function() {
	$("#condition").change(function() {
		var selectEle = $("#condition").val();
		if (selectEle == "时间") {
			$("#content").attr("type", "date");
		} else {
			$("#content").attr("type", "text");
		}
	})
})
</script>
</head>
<body>
	<div class="container" style="margin-top:15px" align="center">
		<label style="font-size: 20px">查询条件:</label>&nbsp;&nbsp;
			<select name="select" style="font-size: 15px" id="condition">
				<option value="时间">时间</option>
				<option value="国家">国家</option>
			</select>
			 <input type="date" name="content" style="font-size: 15px; width: 150px" id="content">
			 <label style="font-size: 20px">显示格式</label>
			 <select name="type" style="font-size: 15px" id="type">
				<option value="表格">表格</option>
				<option value="图表">图表</option>
			</select>
			<button type="button" class="btn btn-default"
				onclick="search()">
				<span class="glyphicon glyphicon-search" aria-hidden="true"></span>
			</button>
			<input type="hidden" value="${condition}" id="condition1" name="condition">
			<input type="hidden" value="${content}" id="content1" name="content">
	</div>
<div class="container"  style="width: 1000px;height:600px" id="chart"></div>
<script>
		var names= new Array();
		var chartData = new Array();
		var $condition = $("#condition1").val();
		var $content = $("#content1").val();
		var chart = echarts.init(document.getElementById("chart"));
		var postURL = "/getWorldData/GetJson?condition="+$condition+"&content="+$content;
	    $.ajaxSettings.async = false;
	    $.post(postURL, {}, function(rs) {
		    var dataList = JSON.parse(rs);
		    var size = dataList.length;
		    if($condition =="国家"){
			    for(i=0;i<size;i++){
			    	names.push(dataList[i].countryname);
			    	chartData.push(dataList[i].confirmed);
			    }
		    }
		    if($condition =="时间"){
			    for(i=0;i<size;i++){
			    	names.push(dataList[i].lastUpdateTime);	    	
			    	chartData.push(dataList[i].confirmed);
			    }
		    }
	    });
	    $.ajaxSettings.async = true;
	    var option ={
	    		title:{
	    			text:'确诊人数表'
	    		},
	    		tooltip:{},
	    		xAxis:{
		    		axisLabel:{interval:0,rotate:40},
	    			data:names
	    		},
	    		yAxis:{},
	    		series:[{
	    			name:'确诊人数',
	    			type:'bar',
	                barWidth: '50%',
	    			data:chartData
	    		}],
	    		itemStyle:{
	    			color:'red'
	    		}
	    };
	    chart.setOption(option);
</script>
</body>
</html>