<%/*
* MassRemitHoldQuery.jsp
* Copyright (c) 2019 HiTRUST INC. All rights reserved.
* Description:大額匯款未完成交易查詢
* Modify History:
*/
%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.sql.*, javax.sql.*, javax.naming.*"%>
<%@ page import="java.io.*, java.util.Date, java.text.* , java.util.Hashtable" %>
<%@ page import="org.apache.log4j.Logger"%>

<%@ page import="org.apache.commons.lang.StringEscapeUtils"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%
Date currentDate = new Date();
DateFormat BUSDATE = new SimpleDateFormat("yyyyMMdd");
String CUR_OS_DATE=BUSDATE.format(currentDate);


String startDate=StringEscapeUtils.escapeJava(request.getParameter("startDate"));
String procStatus=StringEscapeUtils.escapeJava(request.getParameter("procStatus"));
String queryDate=StringEscapeUtils.escapeJava(request.getParameter("queryDate"));
if(startDate!=null){
	CUR_OS_DATE=startDate;
}
if (procStatus==null){
	procStatus="H";  //設定下拉選單預設值
}

%>
<c:set var="queryDate" value="<%=CUR_OS_DATE%>" />
                                                              
<html>
                                                       
<head>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache">
<meta http-equiv="Expires" content="-1"> 
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<TITLE>大額匯款未完成交易查詢</TITLE>
  <link rel="stylesheet" type="text/css" media="all" href="css/calendar-blue2.css"  />

</head>
<style type="text/css">
 th:vertical-align:middle
</style>
<body>

<FORM name="thisform" id="thisform" method="post" action="MassRemitHoldQuery">
<CENTER>
  <table  border="0" width="100%" id="TT">	
  	<tr   align="center" style="FONT-SIZE: 18PX;BACKGROUND-COLOR: #FF6600;COLOR: #FFFFFF;LINE-HEIGHT:30px;BORDERCOLOR:#FFA500 ">
					<td  ><B>大額匯款未完成交易查詢</B></td>
		</tr>	
   </table>
<table  border="0">	
	<tr align="LEFT">
		<td><B>匯款日期</B></td>
		<td align="LEFT"><input type="text"  id="datepickerT" name="datepickerT" value="${queryDate}"></td>
	</tr>	
  	<tr align="center">
		<td><B>狀態</B></td>
		<td>
		 <SELECT NAME='takestatus' id='takestatus'>   
		  	<option value='H'>(H)未完成</option>
          	<option value='Z'>全部</option>
          	<option value='0'>(0)待主機處理</option>
			<option value='1'>(1)主機處理完畢</option>
			<option value='2'>(2)交易成功</option>
			<option value='3'>(3)主機交易逾時</option>
			<option value='4'>(4)資料庫逾時</option>
			<option value='5'>(5)交易失敗</option>
			<option value='9'>(9)統計過檔完畢</option>
			<option value='P'>(P)主機處理中</option>
         </SELECT> 		
		</td>
	</tr>	
</table>
<TABLE bgcolor=#5F9EA0 border>
	<TR>
		<TD>
		<input type="hidden" name="startDate" id="startDate" value="" >
		<input type="hidden" name="procStatus" id="procStatus" value="" >
		<INPUT class="buttonBlue" TYPE="button" name='btn1' VALUE='確定' OnClick='checkALLInput();' >
        <input type="hidden" name="actionFunction" id="actionFunction" value="大額匯款未完成交易查詢"> 
		</TD>
	</TR>
</TABLE>
<BR>
</CENTER><hr size=3 noshade>    
                                                                     
  <table  border="1" id="RMTTable">
			<tr>
			    <th nowrap  align='center' 
					style="color: #FFFFFF; background-color: #477C6D"><B>序號</B></th>
				<th nowrap  align='center' 
					style="color: #FFFFFF; background-color: #477C6D"><B>交易序號</B></th>
				<th nowrap  align='center' 
					style="color: #FFFFFF; background-color: #477C6D"><B>狀況</B></th>
				<th nowrap  align='center' 
					style="color: #FFFFFF; background-color: #477C6D"><B>網路代號</B></th>
				<th nowrap  align='center' 
					style="color: #FFFFFF; background-color: #477C6D"><B>交易金額</B></th>
				<th nowrap  align='center' 
					style="color: #FFFFFF; background-color: #477C6D"><B>清算金額</B></th>
				<th nowrap  align='center' 
					style="color: #FFFFFF; background-color: #477C6D"><B>財金<BR>清算金額</B></th>
				<th nowrap  align='center' 
					style="color: #FFFFFF; background-color: #477C6D"><B>主機金額</B></th>
				<th nowrap  align='center' 
					style="color: #FFFFFF; background-color: #477C6D"><B>手續費<BR>支付別</B></th>
				<th nowrap  align='center' 
					style="color: #FFFFFF; background-color: #477C6D"><B>分行應收<BR>手續費</B></th>
				<th nowrap  align='center' 
					style="color: #FFFFFF; background-color: #477C6D"><B>應付財金<BR>手續費</B></th>
				<th nowrap  align='center' 
					style="color: #FFFFFF; background-color: #477C6D"><B>應付財金<BR>傳輸費</B></th>
				<th nowrap  align='center' 
					style="color: #FFFFFF; background-color: #477C6D"><B>付款銀行<BR>總行代號</B></th>
				<th nowrap  align='center' 
					style="color: #FFFFFF; background-color: #477C6D"><B>付款銀行<BR>分行代號</B></th>
				<th nowrap  align='center' 
					style="color: #FFFFFF; background-color: #477C6D"><B>付款人帳號</B></th>
				<th nowrap  align='center' 
					style="color: #FFFFFF; background-color: #477C6D"><B>付款戶名</B></th>
				<th nowrap  align='center' 
					style="color: #FFFFFF; background-color: #477C6D"><B>收款銀行<BR>總行代號</B></th>
				<th nowrap  align='center' 
					style="color: #FFFFFF; background-color: #477C6D"><B>收款銀行<BR>分行代號</B></th>
				<th nowrap  align='center' 
					style="color: #FFFFFF; background-color: #477C6D"><B>收款人帳號</B></th>
				<th nowrap  align='center' 
					style="color: #FFFFFF; background-color: #477C6D"><B>收款戶名</B></th>
				<th nowrap  align='center' 
					style="color: #FFFFFF; background-color: #477C6D"><B>掛帳行</B></th>
				<th nowrap  align='center' 
					style="color: #FFFFFF; background-color: #477C6D"><B>提取<BR>績效行</B></th>
				<th nowrap  align='center' 
					style="color: #FFFFFF; background-color: #477C6D"><B>存入<BR>績效行</B></th>
				<th nowrap  align='center' 
					style="color: #FFFFFF; background-color: #477C6D"><B>下傳記號</B></th>
				<th nowrap  align='center' 
					style="color: #FFFFFF; background-color: #477C6D"><B>匯款別</B></th>
				<th nowrap  align='center' 
					style="color: #FFFFFF; background-color: #477C6D"><B>轉通匯<BR>結果代碼</B></th>
				<th nowrap  align='center' 
					style="color: #FFFFFF; background-color: #477C6D"><B>扣/入帳日期</B></th>
				<th nowrap  align='center' 
					style="color: #FFFFFF; background-color: #477C6D"><B>清算日期</B></th>
				<th nowrap  align='center' 
					style="color: #FFFFFF; background-color: #477C6D"><B>EDI<BR>用戶號碼</B></th>
				<th nowrap  align='center' 
					style="color: #FFFFFF; background-color: #477C6D"><B>交易序號</B></th>
				<th nowrap  align='center' 
					style="color: #FFFFFF; background-color: #477C6D"><B>交易時間</B></th>
				<th nowrap  align='center' 
					style="color: #FFFFFF; background-color: #477C6D"><B>交易來源</B></th>
				<th nowrap  align='center' 
					style="color: #FFFFFF; background-color: #477C6D"><B>交易種類</B></th>
				<th nowrap  align='center' 
					style="color: #FFFFFF; background-color: #477C6D"><B>付款人<BR>識別碼</B></th>
				<th nowrap  align='center' 
					style="color: #FFFFFF; background-color: #477C6D"><B>收款人<BR>識別碼</B></th>
				<th nowrap  align='center' 
					style="color: #FFFFFF; background-color: #477C6D"><B>手續費<BR>負擔者</B></th>
				<th nowrap  align='center' 
					style="color: #FFFFFF; background-color: #477C6D"><B>帳務主機<BR>回應代碼</B></th>
				<th nowrap  align='center' 
					style="color: #FFFFFF; background-color: #477C6D"><B>交易<BR>寫入時間</B></th>
				<th nowrap  align='center' 
					style="color: #FFFFFF; background-color: #477C6D"><B>狀態<BR>變更時間</B></th>
				<th nowrap  align='center' 
					style="color: #FFFFFF; background-color: #477C6D"><B>帳務主機<BR>回覆時間</B></th>
				<th nowrap  align='center' 
					style="color: #FFFFFF; background-color: #477C6D"><B>中介表格<BR>名稱</B></th>
				<th nowrap  align='center' 
					style="color: #FFFFFF; background-color: #477C6D"><B>中介表格<BR>鍵值</B></th>
				<th nowrap  align='center' 
					style="color: #FFFFFF; background-color: #477C6D"><B>他行<BR>退款原因</B></th>
				<th nowrap  align='center' 
					style="color: #FFFFFF; background-color: #477C6D"><B>來源IP</B></th>
				<th nowrap  align='center' 
					style="color: #FFFFFF; background-color: #477C6D"><B>交易<BR>MasterUnitid</B></th>
				<th nowrap  align='center' 
					style="color: #FFFFFF; background-color: #477C6D"><B>交易<BR>DetailUnitId</B></th>			
			</tr>



			<c:if test="${!empty listMassRemitHold}"> 
  <c:set var="Total" value="${0}" />			
  <c:forEach items="${listMassRemitHold}" var="HostTxs" varStatus="status">      
   <tr id="tablerow" name="tablerow"> 	
        <td nowrap align="center">${status.count}</td>
   	<td nowrap align="center">${HostTxs.unitid}</td>
   	<td nowrap align="center">
		<c:if test="${HostTxs.flag == 'H'}">(H)未完成</c:if>
		<c:if test="${HostTxs.flag == '0'}">(0)待主機處理</c:if>
		<c:if test="${HostTxs.flag == '1'}">(1)主機處理完畢</c:if>
		<c:if test="${HostTxs.flag == '2'}">(2)交易成功</c:if>
		<c:if test="${HostTxs.flag == '3'}">(3)主機交易逾時</c:if>
		<c:if test="${HostTxs.flag == '4'}">(4)資料庫逾時</c:if>
		<c:if test="${HostTxs.flag == '5'}">(5)交易失敗</c:if>
		<c:if test="${HostTxs.flag == '9'}">(9)統計過檔完畢</c:if>
		<c:if test="${HostTxs.flag == 'P'}">(P)主機處理中</c:if>
    </td>
    <td nowrap align="center">${HostTxs.node}</td>
    
    <td nowrap align="right"><fmt:formatNumber value="${HostTxs.txamtNofee}" pattern="#,##0"/></td>
    <td nowrap align="right"><fmt:formatNumber value="${HostTxs.txamtFee}" pattern="#,##0"/></td> 
    <td nowrap align="right"><fmt:formatNumber value="${HostTxs.txamtClean}" pattern="#,##0"/></td> 
    <td nowrap align="right"><fmt:formatNumber value="${HostTxs.txamtBank}" pattern="#,##0"/></td> 
   	<td nowrap align="center">
   	  <c:if test="${HostTxs.feePayer == '0'}">(0)收費</c:if>
	  <c:if test="${HostTxs.feePayer == '1'}">(1)免收</c:if>
   	</td> 
    <td nowrap align="right"><fmt:formatNumber value="${HostTxs.rfeeamt}" pattern="#,##0"/></td> 
    <td nowrap align="right"><fmt:formatNumber value="${HostTxs.feeamt1}" pattern="#,##0"/></td> 
    <td nowrap align="right"><fmt:formatNumber value="${HostTxs.feeamt2}" pattern="#,##0"/></td> 
    <td nowrap align="center">${HostTxs.sbank}</td> 
    <td nowrap align="center">${HostTxs.sbranch}</td>
	<td nowrap align="center">${HostTxs.saccount}</td>
	<td nowrap align="center">${HostTxs.spartyName}</td>
	<td nowrap align="center">${HostTxs.rbank}</td>
	<td nowrap align="center">${HostTxs.rbranch}</td>
	<td nowrap align="center">${HostTxs.raccount}</td>
	<td nowrap align="center">${HostTxs.rpartyName}</td>
	<td nowrap align="center">${HostTxs.acbrno}</td>
	<td nowrap align="center">${HostTxs.debr}</td>
	<td nowrap align="center">${HostTxs.crbr}</td>
	<td nowrap align="center">
	    <c:if test="${HostTxs.dnldFlag == '1'}">(1)處理中</c:if>
		<c:if test="${HostTxs.dnldFlag == '2'}">(2)已入戶</c:if>
		<c:if test="${HostTxs.dnldFlag == '3'}">(3)待解款</c:if>
		<c:if test="${HostTxs.dnldFlag == '4'}">(4)交易失敗</c:if>
		<c:if test="${HostTxs.dnldFlag == '5'}">(5)已扣/退款</c:if>
	</td>
	<td nowrap align="center">
	  <c:if test="${HostTxs.rtflag == '0'}">(0)FEDI</c:if>
	  <c:if test="${HostTxs.rtflag == '1'}">(1)轉通匯</c:if>
	</td>
	<td nowrap align="center">${HostTxs.rmtcode}</td>
	<td nowrap align="center">${HostTxs.payDate_1}</td>
	<td nowrap align="center">${HostTxs.clearDate}</td>
	<td nowrap align="center">${HostTxs.ediId}</td>
	<td nowrap align="center">${HostTxs.stan}</td>
	<td nowrap align="center">${HostTxs.tranDate}</td>
	<td nowrap align="center">
	  <c:choose>
   		<c:when test="${fn:substring(HostTxs.original,0,1)=='2'}">FEDI</c:when>
   		<c:when test="${fn:substring(HostTxs.original,0,1)=='4'}">B2B</c:when>
   		<c:otherwise>{HostTxs.original}其他交易 </c:otherwise>
      </c:choose>
	</td>
	<td nowrap align="center">
		<c:if test="${HostTxs.tranType == '163'}">(163)跨行入帳</c:if>
		<c:if test="${HostTxs.tranType == '164'}">(164)跨行扣帳退款</c:if>
		<c:if test="${HostTxs.tranType == '167'}">(167)扣自入自</c:if>
		<c:if test="${HostTxs.tranType == '168'}">(168)扣自入他</c:if>
	</td>
	<td nowrap align="center">${HostTxs.pidNo}</td>
	<td nowrap align="center">${HostTxs.ridNo}</td>
	<td nowrap align="center">
	    <c:if test="${HostTxs.feeType == '15'}">(15)付款人</c:if>
		<c:if test="${HostTxs.feeType == '13'}">(13)收款人</c:if>
	</td>
	<td nowrap align="center">${HostTxs.hostCode}</td>
	<td nowrap align="center">${HostTxs.arriDate}</td>
	<td nowrap align="center">${HostTxs.statusTime}</td>
	<td nowrap align="center">${HostTxs.respDate}</td>
	<td nowrap align="center">${HostTxs.tableName_1}</td>
	<td nowrap align="center">${HostTxs.twdkey}</td>
	<td nowrap align="center">${HostTxs.derrCode}</td>
	<td nowrap align="center">${HostTxs.passuserIP}</td>
	<td nowrap align="center">${HostTxs.masterUnitId}</td>
	<td nowrap align="center">${HostTxs.detailUnitId}</td>
	<c:set var="Total" value="${Total + 1}" />
   </tr>
  </c:forEach>	                                        
 </c:if>  
 </table> 
 <c:if test="${Total gt 0}">
  <BR>
  <font color="red"><b>合計&nbsp;<c:out value="${Total}"/>&nbsp;筆資料</b></font>
 </c:if>
  

<script type="text/javascript">
$(window).load(function() {
	//設定SELECT預設的狀態
	var DefaultTakestatus="<%=procStatus%>"; 
	$("select#takestatus").val(DefaultTakestatus); 
	$("select#takestatus").trigger('chosen:updated');
			
});

$(function() {

    $("table").css("font-family","Arial, 新細明體");
	$("table tr:nth-child(odd)").css("background-color","#DDEEFF");
	$("table tr:nth-child(even)").css("background-color","#99CDFF");
	$("#RMTTable th").css("vertical-align","middle");
	$("#TT tr").css("background-color","#FF6600");
	$( "#datepickerT" ).datepicker(opt);

	
  });

function checkALLInput() {   
	$('#startDate').val($('#datepickerT').val());
	$('#procStatus').val($('#takestatus').val());
    document.thisform.submit();
} 
        
</script>  
</FORM>                                             
 </body>                                                        
</html>                                                          
                                                                 