<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>全球疫情数据查询</title>
<!-- 引入Bootstrap核心样式文件 -->
<link href="css/bootstrap.css" rel="stylesheet">
<!-- 引入jQuery核心js文件 -->
<script src="./js/jquery-1.11.3.min.js"></script>
<!-- 引入BootStrap核心js文件 -->
<script src="./js/bootstrap.js"></script>
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
	</div>
		<div class="container" style="margin-top:15px">
			<table class="table table-bordered">
 				 <thead>
 				 	<tr>
 				 		<td>编号</td>
 				 		<td>日期</td>
 				 		<td>国家</td>
 				 		<td>确诊数</td>
 				 		<td>疑似人数</td>
 				 		<td>死亡人数</td>
 				 		<td>治愈人数</td>
 				 	</tr>
 				 </thead>
 				 <tbody>
 				<c:forEach items="${worlddataList}" var="worlddata" varStatus="vs">
				<tr>
					<td>${vs.count}</td>
					<td>${worlddata.lastUpdateTime }</td>
					<td>${worlddata.countryname}</td>
					<td>${worlddata.confirmed }</td>
					<td>${worlddata.suspected}</td>
					<td>${worlddata.dead }</td>
					<td>${worlddata.healed}</td>
				</tr>
				</c:forEach>
 				 </tbody>
			</table>
		
		</div>
</body>
</html>