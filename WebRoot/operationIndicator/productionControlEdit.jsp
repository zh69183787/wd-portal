<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<title>运营生产指标管控设置</title>
<link rel="stylesheet" href="../css/formalize.css" />
<link rel="stylesheet" href="../css/page.css" />
<link rel="stylesheet" href="../css/default/imgs.css" />
<link rel="stylesheet" href="../css/reset.css" />
<!--[if IE 6.0]>
           <script src="js/iepng.js" type="text/javascript"></script>
           <script type="text/javascript">
                EvPNG.fix('div, ul, ol, img, li, input, span, a, h1, h2, h3, h4, h5, h6, p, dl, dt');
           </script>
       <![endif]-->
<script src="../js/html5.js"></script>
<script src="../js/jquery-1.7.1.js"></script>
<script src="../js/jquery.formalize.js"></script>
      
<script type="text/javascript">
$(function(){
	$(".odd tr:odd").css("background","#fafafa");			
	
	$("input[type=text]").each(function(){
		var value = $(this).val(); 
		$(this).val(value.replace(".0",""));
	});
});
		
function shut(){
	window.opener=null;
	window.open("","_self");
	window.close();	
}


function checkForm(){
	var status = true;
	$("#yearAndMonth").val($("#yearChoose").val()+$("#monthChoose").val());
	$("input[type=text]").each(function(){
		if($(this).val()==null || $(this).val()==''){
			return status;
		}else{
			if($(this).attr("name").indexOf("Describe")==-1){
				if(!$(this).val().match(/^[0-9]*$/)){
					alert("请输入正整数！")
					status = false;
					$(this).focus();
					return false;
				}			
			}else{		//检查管控说明
				if($(this).val().indexOf("|")==-1){
					$(this).focus();
					alert("请用“|”来分隔管控说明！");
					status = false;
					return false;
				}
			}
		}
		status = true;
	});
	return status;
}

function quickSet(){
	var first = $("input[type=text]:first").val();
	$("input[type=text]").each(function(){
		$(this).val(first);		
	});
}

		
</script>

</head>

<body>

<div class="main"><!--Ctrl-->
<div class="ctrl clearfix">
<div class="fl"><img src="../css/default/images/sideBar_arrow_right.jpg"
	width="46" height="30" alt="收起"></div>
<div class="posi fl">
<ul>
	<li><a href="#">运营管理</a></li>
	<li><a href="#">运营指标</a></li>	
	<li class="fin">运营生产管控设置</li>
</ul>
</div>
<div class="fr lit_nav">
<ul>
	<li class="selected"><a class="print" href="#">打印</a></li>
	<li><a class="storage" href="#">网络硬盘</a></li>
	<li><a class="rss" href="#">订阅</a></li>
	<li><a class="chat" href="#">聊天</a></li>
	<li><a class="query" href="#">查询</a></li>
</ul>
</div>
</div>

<div class="mb10 pt45">

<s:form action="updateProductionEditPage" name="MetroProductionControl" namespace="/indicatorControl" method="post">
<input type="hidden" name="id" value="<s:property value='#request.vo.id'/>">

<table width="100%" class="table_1">
	<thead>
		<th colspan="6" class="t_r">
			<!-- <input type="submit" value="确 认" onclick="return checkForm();"/>&nbsp; --> 
			<input type="submit" value="确 认" onclick="return checkForm();"/>&nbsp;
			<input type="button" value="关 闭" onclick="shut()"/> &nbsp; 
			<input type="reset" value="取 消" /> &nbsp;
		</th>
	</thead>
	<tbody>
		<tr>
		  <td class="t_r lableTd">线路</td>		  
		    <td colspan="5">
		    	<s:if test="#request.vo.indicatorLine==0">全网</s:if>
		    	<s:else><s:property value="#request.vo.indicatorLine"/></s:else>
		    </td>
		</tr>
		<tr>
		  <td class="t_r lableTd">年份/月份</td>		  
		    <td colspan="5">
		    	<s:if test="#request.vo.ext1!=null">
		    		<s:property value="#request.vo.ext1"/>年
		    	</s:if>
		    	<s:if test="#request.vo.ext2==0">
		    		全年
		    	</s:if>
		    	<s:else>
		    		<s:property value="#request.vo.ext2"/>月
		    	</s:else>
		    	<input type="hidden" value="<s:property value='#request.vo.ext1'/>" name="metroProductionControl.ext1"> 
		    	<input type="hidden" value="<s:property value='#request.vo.ext2'/>" name="metroProductionControl.ext2">
		    </td>
		</tr>
		<tr>
		  <td class="t_r lableTd">开行列次</td>
		  	<s:if test="#request.vo.ext2==0">
	    		<td>
			    	<input style="text-align: right;" type="text" name="metroProductionControl.metroColumnYear" value="<s:property value='#request.vo.metroColumnYear'/>" maxlength="20"/>&nbsp;列次/年	   		    
			    </td>
	    	</s:if>
	    	<s:else>
	    		<td>
			    	<input style="text-align: right;" type="text" name="metroProductionControl.metroColumnDaily" value="<s:property value='#request.vo.metroColumnDaily'/>" maxlength="20"/>&nbsp;列次/日	   		    
			    </td>
			    <td>
			    	<input style="text-align: right;" type="text" name="metroProductionControl.metroColumnMonth" value="<s:property value='#request.vo.metroColumnMonth'/>" maxlength="20"/>&nbsp;列次/月	   		    
			    </td>
	    	</s:else>
		   <td>
		       	管控说明：
		       	<select name="metroProductionControl.metroColumnControl">
		    		
		    		<s:if test="#request.vo.metroColumnControl==1">
		    			<option value="0">---请选择---</option>
			    		<option value="1" selected="selected">高好</option>
			    		<option value="2">低好</option>
			    		<option value="3">接近好</option>
		    		</s:if>
		    		<s:elseif test="#request.vo.metroColumnControl==2">
		    			<option value="0">---请选择---</option>
			    		<option value="1">高好</option>
			    		<option value="2"  selected="selected">低好</option>
			    		<option value="3">接近好</option>
		    		</s:elseif>
		    		<s:elseif test="#request.vo.metroColumnControl==3">
		    			<option value="0">---请选择---</option>
			    		<option value="1">高好</option>
			    		<option value="2">低好</option>
			    		<option value="3" selected="selected">接近好</option>
		    		</s:elseif>
		    		<s:else>
		    			<option value="0">---请选择---</option>
			    		<option value="1">高好</option>
			    		<option value="2">低好</option>
			    		<option value="3">接近好</option>
		    		</s:else>
		    	</select>	
		       	<input type="text" name="metroProductionControl.metroColumnDescribe" maxlength="20" value="<s:property value='#request.vo.metroColumnDescribe'/>" />  		    
		   </td>				    
		</tr>
		<tr>
		  <td class="t_r lableTd">运营里程</td>
		  <s:if test="#request.vo.ext2==0">
    		 <td>
		    	<input style="text-align: right;" type="text" name="metroProductionControl.metroDistanceYear" value="<s:property value='#request.vo.metroDistanceYear'/>" maxlength="20"/>&nbsp;车公里/年  		    
		    </td>
    	</s:if>
    	<s:else>
    		<td>
		    	<input style="text-align: right;" type="text" name="metroProductionControl.metroDistanceDaily" value="<s:property value='#request.vo.metroDistanceDaily'/>" maxlength="20"/>&nbsp;车公里/日  		    
		    </td>
		    <td>
		    	<input style="text-align: right;" type="text" name="metroProductionControl.metroDistanceMonth" value="<s:property value='#request.vo.metroDistanceMonth'/>" maxlength="20"/>&nbsp;车公里/月  		    
		    </td>
    	</s:else>
		   <td>
		       	管控说明：
		       	<select name="metroProductionControl.metroDistanceControl">
		    		<s:if test="#request.vo.metroDistanceControl==1">
		    			<option value="0">---请选择---</option>
			    		<option value="1" selected="selected">高好</option>
			    		<option value="2">低好</option>
			    		<option value="3">接近好</option>
		    		</s:if>
		    		<s:elseif test="#request.vo.metroDistanceControl==2">
		    			<option value="0">---请选择---</option>
			    		<option value="1">高好</option>
			    		<option value="2"  selected="selected">低好</option>
			    		<option value="3">接近好</option>
		    		</s:elseif>
		    		<s:elseif test="#request.vo.metroDistanceControl==3">
		    			<option value="0">---请选择---</option>
			    		<option value="1">高好</option>
			    		<option value="2">低好</option>
			    		<option value="3" selected="selected">接近好</option>
		    		</s:elseif>
		    		<s:else>
		    			<option value="0">---请选择---</option>
			    		<option value="1">高好</option>
			    		<option value="2">低好</option>
			    		<option value="3">接近好</option>
		    		</s:else>	
		    	</select>   
		       	<input type="text" name="metroProductionControl.metroDistanceDescribe" maxlength="20" value="<s:property value='#request.vo.metroDistanceDescribe'/>" />  		    
		   </td>				    
		</tr>
		<tr>
		  <td class="t_r lableTd">客流量</td>
		  	<s:if test="#request.vo.ext2==0">
	    		 <td>
			    	<input style="text-align: right;" type="text" name="metroProductionControl.passengerCapacityYear" value="<s:property value='#request.vo.passengerCapacityYear'/>" maxlength="20"/>&nbsp;人/年	   		    
			    </td>
	    	</s:if>
	    	<s:else>
	    		<td>
			    	<input style="text-align: right;" type="text" name="metroProductionControl.passengerCapacityDaily" value="<s:property value='#request.vo.passengerCapacityDaily'/>" maxlength="20"/>&nbsp;人/日	   		    
			    </td>
			     <td>
			    	<input style="text-align: right;" type="text" name="metroProductionControl.passengerCapacityMonth" value="<s:property value='#request.vo.passengerCapacityMonth'/>" maxlength="20"/>&nbsp;人/月	   		    
			    </td>
	    	</s:else>
		   <td>
		       	管控说明：
		       	<select name="metroProductionControl.passengerCapacityControl">
		    		<s:if test="#request.vo.passengerCapacityControl==1">
		    			<option value="0">---请选择---</option>
			    		<option value="1" selected="selected">高好</option>
			    		<option value="2">低好</option>
			    		<option value="3">接近好</option>
		    		</s:if>
		    		<s:elseif test="#request.vo.passengerCapacityControl==2">
		    			<option value="0">---请选择---</option>
			    		<option value="1">高好</option>
			    		<option value="2"  selected="selected">低好</option>
			    		<option value="3">接近好</option>
		    		</s:elseif>
		    		<s:elseif test="#request.vo.passengerCapacityControl==3">
		    			<option value="0">---请选择---</option>
			    		<option value="1">高好</option>
			    		<option value="2">低好</option>
			    		<option value="3" selected="selected">接近好</option>
		    		</s:elseif>
		    		<s:else>
		    			<option value="0">---请选择---</option>
			    		<option value="1">高好</option>
			    		<option value="2">低好</option>
			    		<option value="3">接近好</option>
		    		</s:else>
		    	</select>
		       	<input type="text" name="metroProductionControl.passengerCapacityDescribe" maxlength="20" value="<s:property value='#request.vo.passengerCapacityDescribe'/>" />  		    
		   </td>				    
		</tr>
		<tr>
		  <td class="t_r lableTd">换乘人次</td>
		  	<s:if test="#request.vo.ext2==0">
		    		 <td>
				    	<input style="text-align: right;" type="text" name="metroProductionControl.passengerTransferYear" value="<s:property value='#request.vo.passengerTransferYear'/>" maxlength="20"/>&nbsp;人/年   		    
				    </td>
	    	</s:if>
	    	<s:else>
	    		<td>
			    	<input style="text-align: right;" type="text" name="metroProductionControl.passengerTransferDaily" value="<s:property value='#request.vo.passengerTransferDaily'/>" maxlength="20"/>&nbsp;人/日	   		    
			    </td>		    
			     <td>
			    	<input style="text-align: right;" type="text" name="metroProductionControl.passengerTransferMonth" value="<s:property value='#request.vo.passengerTransferMonth'/>" maxlength="20"/>&nbsp;人/月	   		    
			    </td>
	    	</s:else>		  
		   <td>
		       	管控说明：
		       	<select name="metroProductionControl.passengerTransferControl">
		    		<s:if test="#request.vo.passengerTransferControl==1">
		    			<option value="0">---请选择---</option>
			    		<option value="1" selected="selected">高好</option>
			    		<option value="2">低好</option>
			    		<option value="3">接近好</option>
		    		</s:if>
		    		<s:elseif test="#request.vo.passengerTransferControl==2">
		    			<option value="0">---请选择---</option>
			    		<option value="1">高好</option>
			    		<option value="2"  selected="selected">低好</option>
			    		<option value="3">接近好</option>
		    		</s:elseif>
		    		<s:elseif test="#request.vo.passengerTransferControl==3">
		    			<option value="0">---请选择---</option>
			    		<option value="1">高好</option>
			    		<option value="2">低好</option>
			    		<option value="3" selected="selected">接近好</option>
		    		</s:elseif>
		    		<s:else>
		    			<option value="0">---请选择---</option>
			    		<option value="1">高好</option>
			    		<option value="2">低好</option>
			    		<option value="3">接近好</option>
		    		</s:else>  		
		    	</select> 
		       	<input type="text" name="metroProductionControl.passengerTransferDescribe" maxlength="20" value="<s:property value='#request.vo.passengerTransferDescribe'/>" />  		    
		   </td>		
		</tr>
		<tr>
		  <td class="t_r lableTd">客运收入</td>
		  	<s:if test="#request.vo.ext2==0">
			    <td>
			    	<input style="text-align: right;" type="text" name="metroProductionControl.ticketIncomeYear" value="<s:property value='#request.vo.ticketIncomeYear'/>" maxlength="20"/>&nbsp;元/年	   		    
			    </td>
		    </s:if>
		    <s:else>
	    		<td>
			    	<input style="text-align: right;" type="text" name="metroProductionControl.ticketIncomeDaily" value="<s:property value='#request.vo.ticketIncomeDaily'/>" maxlength="20"/>&nbsp;元/日	   		    
			    </td>		    
			     <td>
			    	<input style="text-align: right;" type="text" name="metroProductionControl.ticketIncomeMonth" value="<s:property value='#request.vo.ticketIncomeMonth'/>" maxlength="20"/>&nbsp;元/月   		    
			    </td>
		    </s:else>		  
		   <td>
		       	管控说明：
		       	<select name="metroProductionControl.ticketIncomeControl">
		    		<s:if test="#request.vo.ticketIncomeControl==1">
		    			<option value="0">---请选择---</option>
			    		<option value="1" selected="selected">高好</option>
			    		<option value="2">低好</option>
			    		<option value="3">接近好</option>
		    		</s:if>
		    		<s:elseif test="#request.vo.ticketIncomeControl==2">
		    			<option value="0">---请选择---</option>
			    		<option value="1">高好</option>
			    		<option value="2"  selected="selected">低好</option>
			    		<option value="3">接近好</option>
		    		</s:elseif>
		    		<s:elseif test="#request.vo.ticketIncomeControl==3">
		    			<option value="0">---请选择---</option>
			    		<option value="1">高好</option>
			    		<option value="2">低好</option>
			    		<option value="3" selected="selected">接近好</option>
		    		</s:elseif>
		    		<s:else>
		    			<option value="0">---请选择---</option>
			    		<option value="1">高好</option>
			    		<option value="2">低好</option>
			    		<option value="3">接近好</option>
		    		</s:else> 		
		    	</select>  
		       	<input type="text" name="metroProductionControl.ticketIncomeDescribe" maxlength="20" value="<s:property value='#request.vo.ticketIncomeDescribe'/>" />  		    
		   </td>		
		</tr>
	</tbody>
	<tr class="tfoot">
		<td colspan="6" class="t_r">
			<input type="submit" value="确 认" onclick="return checkForm();"/>&nbsp; 
			<input type="button" value="关 闭" onclick="shut()"/> &nbsp; 
			<input type="reset" value="取 消" />&nbsp;
		</td>
	</tr>
</table>
</s:form>

</div>
<!--Table End--></div>
</body>
</html>