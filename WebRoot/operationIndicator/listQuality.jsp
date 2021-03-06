﻿<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<title>运营指标</title>

<link rel="stylesheet" href="../css/formalize.css" />
<link rel="stylesheet" href="../css/page.css" />
<link rel="stylesheet" href="../css/default/imgs.css" />
<link rel="stylesheet" href="../css/reset.css" />
<link type="text/css" href="../css/flick/jquery-ui-1.8.18.custom.css" rel="stylesheet" />	
		<!--[if IE 6.0]>
           <script src="js/iepng.js" type="text/javascript"></script>
           <script type="text/javascript">
                EvPNG.fix('div, ul, ol, img, li, input, span, a, h1, h2, h3, h4, h5, h6, p, dl, dt');
           </script>
       <![endif]-->
<!--<script src="../js/html5.js"></script>-->
<script src="../js/jquery-1.7.1.js"></script>
<script src="../js/jquery.formalize.js"></script>
<script src="../js/flick/jquery-ui-1.8.18.custom.min.js"></script>
<script src="../js/highcharts.js"></script>
<script src="../js/flick/jquery.ui.datepicker-zh-CN.js"></script>
<script src="../js/show.js"></script>
<script src="../js/indicator/list.js"></script>
<script src="../js/indicator/drawDiagram.js"></script>

<!-- 监测屏幕分辨率，设置width,height -->
<script type="text/javascript">
	var w ,h ;
	var menuWidth;
	$(document).ready(function () {
	
	if ($(parent.document).find("frameset[id=main]").attr("cols") == "210,*"){
		menuWidth = 210;
	}else{
		menuWidth = 0;
	}
		if($(window).width()-menuWidth>1024){
				$("div[id^=tab][id$=div]").removeClass("w1024");
				$("div[id^=tab][id$=div]").addClass("w1280");
				w = 360;
				h = 240;		
			}else{
				$("div[id^=tab][id$=div]").removeClass("w1280");
				$("div[id^=tab][id$=div]").addClass("w1024");
				w = 288;
				h = 240;
			}
		$(window).resize(function(){
		if ($(parent.document).find("frameset[id=main]").attr("cols") == "210,*"){
			menuWidth = 210
		}else{
			menuWidth = 0;
		}
	
			if($(window).width()-menuWidth>1024){
				$("div[id^=tab][id$=div]").removeClass("w1024");
				$("div[id^=tab][id$=div]").addClass("w1280");	
				w = 360;
				h = 240;		
			}else{
				$("div[id^=tab][id$=div]").removeClass("w1280");
				$("div[id^=tab][id$=div]").addClass("w1024");
				w = 288;
				h = 240;
			}
			$("li[id^=tab]").each(function(){
			if($(this).hasClass("selected")){
				if($(this).attr("id").indexOf(1)>0){
					showTab1ByDay();
				}else if($(this).attr("id").indexOf(2)>0){
					showTab2ByDay();
				}else if($(this).attr("id").indexOf(3)>0){
					showTab3ByDay();
				}	
			}
		});
		})
		var $tbInfo = $(".filter .query input:text");
		$tbInfo.each(function () {
			$(this).focus(function () {
				$(this).attr("placeholder", "");
			});
		});
		
		var $tblAlterRow = $(".table_1 tbody tr:even");
		if ($tblAlterRow.length > 0)
			$tblAlterRow.css("background","#fafafa");			
	});
</script>

<style type="text/css">
        button.ui-datepicker-current { display: none; }
</style>
<script type="text/javascript">
$(document).ready(function () {
	showTab2ByDay();
});	
</script>




<script type="text/javascript">
//使用日期控件
$(document).ready(function () {
	var firstDate = $("#firstDate").val();
	var lastDate = $("#lastDate").val();
	$('#datepicker').datepicker({
		inline: true,
		changeYear:true,
		minDate:firstDate,
		maxDate:lastDate,
		changeMonth:true,
		showOtherMonths: true,
		selectOtherMonths: true
	});
	$("#datepickerMonth").datepicker({
		inline: true,
		changeYear:true
	});
	
	$("input[id^=datepickerInner]").each(function(){
		$(this).datepicker({
			inline: true,
			changeYear:true,
			minDate:firstDate,
			maxDate:lastDate,
			changeMonth:true,
			showOtherMonths: true,
			selectOtherMonths: true
		});
	});
	
	loadShow();
	
});
//按钮效果转换
function showButton(obj){
	$("input[id^=view]").each(function(){
		$(this).attr("disabled",false);
	});
	$(obj).attr("disabled",true);
}

//点击日视图按钮
function viewDay(btObject){
	showButton(btObject);
	showTab2ByDay();
}
//点击月视图按钮
function viewMonth(btObject){
	showButton(btObject);
	showTab2ByMonth();
}
//点击年视图按钮
function viewYear(btObject){
	showButton(btObject);
	showTab2ByYear();
}
</script>

<script type="text/javascript">

//点击查询按钮后提交
function submitForm(){
	var btId = $("input:disabled").attr("id");
	var type = getViewType();
	$("p[id^=chart]").each(function(){
		$(this).html("");
	});
	switch(type){
   		case 1:showTab2ByDay();break;
		case 2:showTab2ByMonth();break;
		case 3:showTab2ByYear();break;
	}
	$("input[id^=datepickerInner]").each(function(){
		$(this).val($("#datepicker").val());
		$(this).parent().next("div").children("input").val($("#datepicker").val());
	});
}


//跳转到详细页面
function showDetail(chartId,object){
	var endDate = $(object).next("input").val();
	window.open("showQualityDetailPage.action?lineNo="+$("#lineNo").val()+"&endDate="+endDate+"&chartId="+chartId);
}
</script>

<!-- 点击tab，显示和隐藏 -->
<script type="text/javascript">
//日期改变后，设置隐藏域日期的值
function setParamDate(object){
	$(object).parent().next("div").children("input").val($(object).val());
}

//管控设置
function showQualityControl(){
	window.open("/portal/indicatorControl/showQualityControlPage.action");
}
</script>


</head>



<body>

<input type="hidden" value="<s:property value='#request.lastDate'/>" id="lastDate">
<input type="hidden" value="<s:property value='#request.firstDate'/>" id="firstDate">
	<div class="main mw1002">
    	<!--Ctrl-->
		<div class="ctrl clearfix nwarp">
        	<div class="fl"><img id="show" onclick="showHide();" src="../css/default/images/sideBar_arrow_right.jpg" width="46" height="30" alt="展开"></div>
            <div class="posi fl nwarp">
            	<ul>
                	<li><a href="javascript:window.location.href='/portal/center/yygl/yg_index.jsp'">运营管理</a></li>
                	<li class="fin">运营指标</li>
                </ul>
            </div>
            <div class="fr lit_nav nwarp">
            	<ul>
                    <li class="selected"><a class="print" href="#">打印</a></li>
                    <li><a class="express" href="#">导出数据</a></li>
                    <li class="selected"><a class="table" href="#">表格模式</a></li>
                    <li><a class="treeOpen" href="#">打开树</a></li>
                    <li><a class="filterClose" href="#">关闭过滤</a></li>
                </ul>
            </div>
   		</div>
        <!--Ctrl End-->
        <div class="pt45">
        <!--Tabs_2-->
        <div class="tabs_2 nwarp">
        	<ul>
            	<li  id="tab1"><a href="showProductionListPage.action"><span>运营生产指标</span></a></li>
				<li id="tab2" class="selected"><a href="#"><span>运营质量安全指标</span></a></li>
				<li id="tab3"><a href="showScaleListPage.action"><span>运营规模指标</span></a></li>
            </ul>
        </div>
        <!--Tabs_2 End-->
        <!--Filter-->
      <div class="filter">
      	<div class="query">
	      	<div class="filter_sandglass p8"><!--这里根据内容做样式调整。1、筛选：filter_sandglass 2、搜索filter_search 3、提示：.filter_tips 背景图会改变。-->
	      	  <table class="nwarp" width="100%" border="0" cellspacing="0" cellpadding="0">
	      	    <tr>
	      	      <td class="t_r">线路</td>
	      	      <td>
	      	      	<select name="lineNo" class="input_large" id="lineNo">
						<s:iterator value="#request.lineMap" id="st" status="s">
							<option value="<s:property value='#st.key'/>" id="op<s:property value='#s.index'/>"><s:property value="#st.value"/></option>
						</s:iterator>
					</select>
	      	      </td>
	      	      <td class="t_r">日期</td>
	     	      <td>
					<input type="text" class="date" id="datepicker" name="date" readonly="readonly" value="<s:property value='#request.lastDate'/>"/>
					<input type="text" class="date" id="datepickerMonth" name="date" readonly="readonly" style="display: none;"/>
					<input type="button" value="查询" onclick="submitForm()"/>
				  </td> 
	     		  <td class="t_c">
					<input type="button" value="日视图" onclick="viewDay(this);" id="viewDay" disabled="disabled"/> &nbsp; 
					<input type="button" value="月视图" onclick="viewMonth(this);" id="viewMonth"/> &nbsp; 
					<input type="button" value="年视图" onclick="viewYear(this);" id="viewYear"/>
					<input type="button" value="管控设置" onclick="showQualityControl();" id="viewYear"/>
				  </td>
	    	    </tr>
	    	  </table>
	        </div>
      	</div>
      </div>
      <!--Filter End-->
        
        <!-- tab2 -->
        <div  id="tab2div">
        	<!--8.正点率-->
        	<div class="fl panel_7">
            	<div class="p_right">
            		<div class="hgroup">
                    <hgroup>
                    	<div class="text clearfix">
                        	<h3 class="fl">正点率</h3>
                            <div class="fr setting"><a href="javascript:void(0)" >设置</a></div>
                            <div class="clear"></div>
                            <div class="fl">
                              <input type="text" onchange="drawChart8();setParamDate(this);" class="date"  id="datepickerInner8" name="datepicker" readonly="readonly" value="<s:property value='#request.lastDate'/>"/>
                            </div>
                            <div class="fr clearfix data">
                                <h6 class="fr pt10">%</h6>
                                <h1 class="fr mr5" id="chart8_daily" onclick="showDetail(8,this)"></h1>
                                <input type="hidden" value="<s:property value='#request.lastDate'/>" id="valueDate8">
                            </div>
                            <div class="clear"></div>
                        </div>
                    </hgroup>
                    </div>
                    <div class="con clearfix">
                    	<div class="conner"></div>
                    	<div class="fl bor Hcharts mr8" id="chart8"></div>
                        <div class="fl">
                       	  <ul class="mb10">
                            	<li class="clearfix"><span>去年同期：</span><h6 class="fr">%</h6><b class="fr" id="chart8_lastyear"></b></li>
                            	<li class="clearfix"><span>月累计：</span><h6 class="fr">%</h6><b class="fr" id="chart8_month"></b></li>
                            	<li class="clearfix"><span>年累计：</span><h6 class="fr">%</h6><b class="fr" id="chart8_year"></b></li>
                            </ul>
                            <p id="chart8Info"></p>
                        </div>
                        <div class="clear"></div>
                    </div>
                </div>
            </div>
        	<!--End-->
        	
        	<!--9.兑现率-->
        	<div class="fl panel_7">
            	<div class="p_right">
            		<div class="hgroup">
                    <hgroup>
                    	<div class="text clearfix">
                        	<h3 class="fl">兑现率</h3>
                            <div class="fr setting"><a href="javascript:void(0)" >设置</a></div>
                            <div class="clear"></div>
                            <div class="fl">
                              <input type="text" onchange="drawChart9();setParamDate(this);" class="date"  id="datepickerInner9" name="datepicker" readonly="readonly" value="<s:property value='#request.lastDate'/>"/>
                            </div>
                            <div class="fr clearfix data">
                                <h6 class="fr pt10">%</h6>
                                <h1 class="fr mr5" id="chart9_daily" onclick="showDetail(9,this)"></h1>
                                <input type="hidden" value="<s:property value='#request.lastDate'/>" id="valueDate9">
                            </div>
                            <div class="clear"></div>
                        </div>
                    </hgroup>
                    </div>
                    <div class="con clearfix">
                    	<div class="conner"></div>
                    	<div class="fl bor Hcharts mr8" id="chart9"></div>
                        <div class="fl">
                       	  <ul class="mb10">
                            	<li class="clearfix"><span>去年同期：</span><h6 class="fr">%</h6><b class="fr" id="chart9_lastyear"></b></li>
                            	<li class="clearfix"><span>月累计：</span><h6 class="fr">%</h6><b class="fr" id="chart9_month"></b></li>
                            	<li class="clearfix"><span>年累计：</span><h6 class="fr">%</h6><b class="fr" id="chart9_year"></b></li>
                            </ul>
                            <p id="chart9Info"></p>
                        </div>
                        <div class="clear"></div>
                    </div>
                </div>
            </div>
        	<!--End-->
        	 <div class="clear"></div>
        	
        </div>
        <!-- tab2 End -->
        
        
	</div>
	</div>
</body>
</html>