<!-- 
	* query.jsp
	* Copyright (c) 2016 HiTRUST INC. All rights reserved.
	* Description:交易查詢
	* Modify History:
	* v1.00, 2017-02-13, Jack Liu
	* 1) First released.
	* v1.01, 2017-12-12, Jack Liu
	* 1) 變更查詢條件轉帳金額to清算金額
 -->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="com.hitrust.fedi.adm.bean.QueryBean" %>
<jsp:useBean id="now" class="java.util.Date" scope="page" />
<title>
	<c:out value="${sessionScope.httpSessionBean.currentMenu.name}" />
</title>
			<% 
					QueryBean queryBean=(QueryBean)session.getAttribute("queryBean");
			%>
<c:if test="${checkPermission!='permission'}">
	<body><font color="red">請勿直接輸入網址,請直接點選功能選單,若無權限請洽系統管理員.</font></body>
</c:if>
<c:if test="${checkPermission=='permission'}">
<body>
	<c:if test="${sessionScope.httpSessionBean.queryType == sessionScope.httpSessionBean.queryTxn}">
		<c:set var="url" value="txn_master_list" />
	</c:if>
	<c:if test="${sessionScope.httpSessionBean.queryType == sessionScope.httpSessionBean.queryTxnMasterForReVerify}">
		<c:set var="url" value="txn_master_list_for_re_verify" />
	</c:if>
	<c:if test="${sessionScope.httpSessionBean.queryType == sessionScope.httpSessionBean.queryTxnAutack }">
		<c:set var="url" value="txn_autack_list" />
	</c:if>
	<c:if test="${sessionScope.httpSessionBean.queryType ==sessionScope.httpSessionBean.queryTxnAutackForResign}">
		<c:set var="url" value="txn_autack_list_for_resign"/>
	</c:if>
	<c:if test="${sessionScope.httpSessionBean.queryType == sessionScope.httpSessionBean.queryTxnControl}">
		<c:set var="url" value="txn_control_list" />
	</c:if>
	<c:if test="${sessionScope.httpSessionBean.queryType == sessionScope.httpSessionBean.queryTxnForAdvanced}">
		<c:set var="url" value="txn_master_list_for_adanced" />
	</c:if>
	
	<c:if test="${sessionScope.httpSessionBean.queryType == sessionScope.httpSessionBean.queryTxnMasterForHostRequest}">
		<c:set var="url" value="txn_master_list_for_host_request" />
	</c:if>
	<c:if test="${sessionScope.httpSessionBean.queryType == sessionScope.httpSessionBean.queryFinpayForResign}">
		<c:set var="url" value="query_finpay_for_resign" />
	</c:if>
	<c:if test="${sessionScope.httpSessionBean.queryType == sessionScope.httpSessionBean.queryTxnMasterForResendCopy}">
		<c:set var="url" value="txn_master_list_for_re_send_copy" />
	</c:if>
	<c:if test="${sessionScope.httpSessionBean.queryType == sessionScope.httpSessionBean.queryTxnMasterForReProcess}">
		<c:set var="url" value="txn_master_list_for_re_process" />
	</c:if>
	<c:if test="${sessionScope.httpSessionBean.queryType == sessionScope.httpSessionBean.queryTxnMasterForReSend080100}">
		<c:set var="url" value="txn_master_list_for_re_send_080100" />
	</c:if>
	<c:if test="${sessionScope.httpSessionBean.queryType == sessionScope.httpSessionBean.queryTxnMasterForReSend080150}">
		<c:set var="url" value="txn_master_list_for_re_send_080150" />
	</c:if>
	<c:if test="${sessionScope.httpSessionBean.queryType == sessionScope.httpSessionBean.queryTxnMasterForReSend050100}">
		<c:set var="url" value="txn_master_list_for_re_send_050100" />
	</c:if>
	<c:if test="${sessionScope.httpSessionBean.queryType == sessionScope.httpSessionBean.queryTxnMasterForReSend110151}">
		<c:set var="url" value="txn_master_list_for_re_send_110151" />
	</c:if>

	<c:if test="${sessionScope.httpSessionBean.queryType == sessionScope.httpSessionBean.queryTxnForManual}">
		<c:set var="url" value="txn_master_list_for_manual" />
	</c:if>
	
	<c:if test="${sessionScope.httpSessionBean.queryType == sessionScope.httpSessionBean.queryTxnAutackForFISCNotReply}">
		<c:set var="url" value="txn_master_list_for_fisc_not_reply" />
	</c:if>
	<c:if test="${sessionScope.httpSessionBean.queryType == sessionScope.httpSessionBean.query170Fail}">
		<c:set var="url" value="txn_master_list_for_170_fail" />
	</c:if>
	<c:if test="${sessionScope.httpSessionBean.queryType == sessionScope.httpSessionBean.query180Fail}">
		<c:set var="url" value="txn_master_list_for_180_fail" />
	</c:if>
	<c:if test="${sessionScope.httpSessionBean.queryType == sessionScope.httpSessionBean.queryTxnMasterNewSend080150}">
		<c:set var="url" value="txn_master_list_for_New_send_080150"/>
	</c:if>

	<form  action="${url}" method="get">
		<input type="hidden" name="actionFunction" id="actionFunction" value="查詢">
		<table width="80%" border="0" align="center" cellpadding="0" cellspacing="0" class="temp001">
		<input type="hidden" id="clearAmount" name="clearAmount" value="0" />
			<c:if test="${sessionScope.httpSessionBean.queryType != sessionScope.httpSessionBean.queryTxnForAdvanced}">
			<input type="hidden" name="startDate" id="startDate" >
			<input type="hidden" name="stopDate" id="stopDate" >
			
			<tr class="table-title">

			<c:if test="${sessionScope.httpSessionBean.queryType == sessionScope.httpSessionBean.queryTxn || 
						  sessionScope.httpSessionBean.queryType == sessionScope.httpSessionBean.queryTxnMasterForReVerify ||
						  sessionScope.httpSessionBean.queryType == sessionScope.httpSessionBean.queryFinpayForResign ||
						  sessionScope.httpSessionBean.queryType == sessionScope.httpSessionBean.queryTxnMasterForResendCopy ||
						  sessionScope.httpSessionBean.queryType == sessionScope.httpSessionBean.queryTxnMasterForReProcess ||
						  sessionScope.httpSessionBean.queryType == sessionScope.httpSessionBean.queryTxnMasterForReSend080100 ||
						  sessionScope.httpSessionBean.queryType == sessionScope.httpSessionBean.queryTxnMasterForReSend080150 ||
						  sessionScope.httpSessionBean.queryType == sessionScope.httpSessionBean.queryTxnMasterForReSend050100 ||
						  sessionScope.httpSessionBean.queryType == sessionScope.httpSessionBean.queryTxnMasterForReSend110151 ||
						  sessionScope.httpSessionBean.queryType == sessionScope.httpSessionBean.queryTxnForManual ||
						  sessionScope.httpSessionBean.queryType == sessionScope.httpSessionBean.queryTxnAutackForFISCNotReply ||
						  sessionScope.httpSessionBean.queryType == sessionScope.httpSessionBean.query170Fail ||
						  sessionScope.httpSessionBean.queryType == sessionScope.httpSessionBean.query180Fail ||
						  sessionScope.httpSessionBean.queryType == sessionScope.httpSessionBean.queryTxnMasterForHostRequest||
						  sessionScope.httpSessionBean.queryType == sessionScope.httpSessionBean.queryTxnMasterNewSend080150}">
				<td nowrap="nowrap">&nbsp&nbsp日期種類: 
				

				<input type="radio" id="dateType" name="dateType" value="payDate" checked="checked" >付款日期<input type="radio" id="dateType" name="dateType" value="startDateTime">交易日期<input type="radio" id="dateType" name="dateType" value="stateDateTime" >處理狀態日期&nbsp&nbsp</td>
				<td nowrap="nowrap">&nbsp&nbsp開始
				*<input type="text" class="input" id="datetimepicker3" name="pickerStartDate" value="<fmt:formatDate value='${now}' pattern='yyyyMMdd' /> 0000" readonly="readonly">
				結束
				*<input type="text" class="input" id="datetimepicker4" name="pickerStopDate" value="<fmt:formatDate value='${now}' pattern='yyyyMMdd' /> 2359" readonly="readonly">&nbsp&nbsp</td>

			</c:if>
							
			<c:if test="${!(sessionScope.httpSessionBean.queryType == sessionScope.httpSessionBean.queryTxn || 
						  sessionScope.httpSessionBean.queryType == sessionScope.httpSessionBean.queryTxnMasterForReVerify ||
						  sessionScope.httpSessionBean.queryType == sessionScope.httpSessionBean.queryFinpayForResign ||
						  sessionScope.httpSessionBean.queryType == sessionScope.httpSessionBean.queryTxnMasterForResendCopy ||
						  sessionScope.httpSessionBean.queryType == sessionScope.httpSessionBean.queryTxnMasterForReProcess ||
						  sessionScope.httpSessionBean.queryType == sessionScope.httpSessionBean.queryTxnMasterForReSend080100 ||
						  sessionScope.httpSessionBean.queryType == sessionScope.httpSessionBean.queryTxnMasterForReSend080150 ||
						  sessionScope.httpSessionBean.queryType == sessionScope.httpSessionBean.queryTxnMasterForReSend050100 ||
						  sessionScope.httpSessionBean.queryType == sessionScope.httpSessionBean.queryTxnMasterForReSend110151 ||
						  sessionScope.httpSessionBean.queryType == sessionScope.httpSessionBean.queryTxnForManual ||
						  sessionScope.httpSessionBean.queryType == sessionScope.httpSessionBean.queryTxnAutackForFISCNotReply ||
						  sessionScope.httpSessionBean.queryType == sessionScope.httpSessionBean.query170Fail ||
						  sessionScope.httpSessionBean.queryType == sessionScope.httpSessionBean.query180Fail ||
						  sessionScope.httpSessionBean.queryType == sessionScope.httpSessionBean.queryTxnMasterForHostRequest||
						  sessionScope.httpSessionBean.queryType == sessionScope.httpSessionBean.queryTxnMasterNewSend080150)}">
				<td nowrap="nowrap">開始日期
				*<input type="text" class="input" id="datetimepicker3" name="pickerStartDate" value="<fmt:formatDate value='${now}' pattern='yyyyMMdd' /> 0000" readonly="readonly"></td>
				<td nowrap="nowrap">
				結束日期
				*<input type="text" class="input" id="datetimepicker4" name="pickerStopDate" value="<fmt:formatDate value='${now}' pattern='yyyyMMdd' /> 2359" readonly="readonly"></td>
				</c:if>	
			</tr>
			</c:if>
			<c:if test="${sessionScope.httpSessionBean.queryType == sessionScope.httpSessionBean.queryTxn || 
						  sessionScope.httpSessionBean.queryType == sessionScope.httpSessionBean.queryTxnMasterForReVerify ||
						  sessionScope.httpSessionBean.queryType == sessionScope.httpSessionBean.queryFinpayForResign ||
						  sessionScope.httpSessionBean.queryType == sessionScope.httpSessionBean.queryTxnMasterForResendCopy ||
						  sessionScope.httpSessionBean.queryType == sessionScope.httpSessionBean.queryTxnForAdvanced ||
						  sessionScope.httpSessionBean.queryType == sessionScope.httpSessionBean.queryTxnMasterForReProcess ||
						  sessionScope.httpSessionBean.queryType == sessionScope.httpSessionBean.queryTxnMasterForReSend080100 ||
						  sessionScope.httpSessionBean.queryType == sessionScope.httpSessionBean.queryTxnMasterForReSend080150 ||
						  sessionScope.httpSessionBean.queryType == sessionScope.httpSessionBean.queryTxnMasterForReSend050100 ||
						  sessionScope.httpSessionBean.queryType == sessionScope.httpSessionBean.queryTxnMasterForReSend110151 ||
						  sessionScope.httpSessionBean.queryType == sessionScope.httpSessionBean.queryTxnForManual ||
						  sessionScope.httpSessionBean.queryType == sessionScope.httpSessionBean.queryTxnAutackForFISCNotReply ||
						  sessionScope.httpSessionBean.queryType == sessionScope.httpSessionBean.query170Fail ||
						  sessionScope.httpSessionBean.queryType == sessionScope.httpSessionBean.query180Fail ||
						  sessionScope.httpSessionBean.queryType == sessionScope.httpSessionBean.queryTxnMasterNewSend080150
						  }">
				<tr class="table-title">
					<td nowrap="nowrap">AEK NUMBER</td><td><input type="text" id="aekno" name="aekno" class="input" value=""></td>
				</tr>
				<tr class="table-title">
					<td nowrap="nowrap">統一編號</td><td><input type="text" id="sid" name="sid" class="input" value=""></td>
				</tr>
				<c:if test="${!(sessionScope.httpSessionBean.queryType == sessionScope.httpSessionBean.queryTxnMasterForCancelAdvanced || 
						  sessionScope.httpSessionBean.queryType == sessionScope.httpSessionBean.queryTxnMasterForReProcess ||
						  sessionScope.httpSessionBean.queryType == sessionScope.httpSessionBean.queryTxnMasterForResendCopy ||
						  sessionScope.httpSessionBean.queryType == sessionScope.httpSessionBean.queryTxnMasterForReSend080100 ||
						  sessionScope.httpSessionBean.queryType == sessionScope.httpSessionBean.queryTxnMasterForReSend080150 ||
						  sessionScope.httpSessionBean.queryType == sessionScope.httpSessionBean.queryTxnMasterForReSend050100 ||
						  sessionScope.httpSessionBean.queryType == sessionScope.httpSessionBean.queryTxnMasterForReSend110151 ||
						  sessionScope.httpSessionBean.queryType == sessionScope.httpSessionBean.queryTxnMasterNewSend080150||
						  sessionScope.httpSessionBean.queryType == sessionScope.httpSessionBean.queryTxnForAdvanced||
						  sessionScope.httpSessionBean.queryType == sessionScope.httpSessionBean.queryTxnForManual ||
						  sessionScope.httpSessionBean.queryType == sessionScope.httpSessionBean.query170Fail ||
						  sessionScope.httpSessionBean.queryType == sessionScope.httpSessionBean.query180Fail)
						  }">
				<tr class="table-title">
					<td nowrap="nowrap">交易結果</td>
					<td nowrap="nowrap">
						<select class="select" name="pending"  id="pending" style="">
							<option value="ALL">全部</option>
							<option value="Y">交易未完成</option>
							<option value="N">交易完成</option>
							<option value="E">交易失敗</option>
						</select>
					</td>
				</tr>
				</c:if>
				<tr class="table-title">
					<td nowrap="nowrap">交易種類</td>
					<td nowrap="nowrap">
						<select class="select" name="netType"  id="netType">
							<option value="">全部</option>
								<c:if test="${!(sessionScope.httpSessionBean.queryType == sessionScope.httpSessionBean.queryTxnForAdvanced||
												sessionScope.httpSessionBean.queryType == sessionScope.httpSessionBean.queryFinpayForResign||
												sessionScope.httpSessionBean.queryType == sessionScope.httpSessionBean.query170Fail ||
												sessionScope.httpSessionBean.queryType == sessionScope.httpSessionBean.queryTxnAutackForFISCNotReply||
						  						sessionScope.httpSessionBean.queryType == sessionScope.httpSessionBean.query180Fail||
						  						sessionScope.httpSessionBean.queryType == sessionScope.httpSessionBean.queryTxnForManual)}">
						  			
									<option value="F">他行入帳</option>
									<option value="A">自網扣自入自</option>
									<option value="B">自網扣自入他</option>
									<option value="D">自網扣他入自</option>
									<option value="C">自網扣他入他</option>
									<option value="O">他網扣自入自</option>
									<option value="P">他網扣自入他</option>
								</c:if>
								<c:if test="${sessionScope.httpSessionBean.queryType == sessionScope.httpSessionBean.queryTxnAutackForFISCNotReply}">
									<option value="D,F">入帳</option>
									<option value="B,P">扣款</option>					
								</c:if>
								<c:if test="${sessionScope.httpSessionBean.queryType == sessionScope.httpSessionBean.queryTxnForAdvanced}">
									<option value="F">入帳</option>
									<option value="A,B,O,P">扣款</option>												
								</c:if>
								<c:if test="${sessionScope.httpSessionBean.queryType == sessionScope.httpSessionBean.queryFinpayForResign}">
									<option value="D,F">入帳</option>
									<option value="B,P">扣款</option>			
								</c:if>
								<c:if test="${sessionScope.httpSessionBean.queryType == sessionScope.httpSessionBean.queryTxnForManual}">
									<option value="D,F">入帳</option>
									<option value="A,B,O,P">扣款</option>				
								</c:if>
								<c:if test="${sessionScope.httpSessionBean.queryType == sessionScope.httpSessionBean.query180Fail}">
									<c:forEach var="tbCodeBean" items="${sessionScope.httpSessionBean.netTypeList}" varStatus="loop">
										<c:if test="${tbCodeBean.codeId=='B'||tbCodeBean.codeId=='P'}">
											<option value="${tbCodeBean.codeId}"><c:out value="${tbCodeBean.codeName}" /></option>
										</c:if>
									</c:forEach>
									<option value="B,P">扣款</option>			
								</c:if>
								<c:if test="${sessionScope.httpSessionBean.queryType == sessionScope.httpSessionBean.query170Fail}">
									<option value="F">入帳</option>
									<option value="D">扣款</option>				
								</c:if>
						</select>
					</td>
				</tr>
				<tr class="table-title">
					<td nowrap="nowrap">清算金額</td><td><input type="text" name="inputAmount" id="inputAmount" class="input" value=""></td>
				</tr>
				<tr class="table-title">
					<td nowrap="nowrap">交易序號 (Stan)</td><td><input type="text" id="stan" name="stan" class="input" value=""></td>
				</tr>

				<tr class="table-title">
					<td nowrap="nowrap">付款銀行</td><td><input type="text" name="orderbank" id="orderbank" class="input" value=""></td>
				</tr>
				<tr class="table-title">
					<td nowrap="nowrap">付款帳號</td><td><input type="text" name="saccount" id="saccount" class="input" value=""></td>
				</tr>
				<tr class="table-title">
					<td nowrap="nowrap">收款銀行</td><td><input type="text" name="benefbank" id="benefbank" class="input" value=""></td>
				</tr>
				<tr class="table-title">
					<td nowrap="nowrap">收款帳號</td><td><input type="text" name="raccount" id="raccount" class="input" value=""></td>
				</tr>
				
			</c:if>				
			<c:if test="${sessionScope.httpSessionBean.queryType == sessionScope.httpSessionBean.queryTxnAutack || 
						sessionScope.httpSessionBean.queryType == sessionScope.httpSessionBean.queryTxnAutackForResign}">
				
				<c:if test="${sessionScope.httpSessionBean.queryType == sessionScope.httpSessionBean.queryTxnAutack}">
				<tr class="table-title">
					<td nowrap="nowrap">處理狀況</td>
					<td nowrap="nowrap">
						<select name="procStatus" id="procStatus">
							<option value="%">全部</option>
							<c:forEach var="tbCodeBean" items="${sessionScope.httpSessionBean.procStatusList}" varStatus="loop">
								<c:if test="${tbCodeBean.codeId!='5'}">
									<option value="${tbCodeBean.codeId}"><c:out value="${tbCodeBean.codeId }" />-<c:out value="${tbCodeBean.codeName }" /></option>
								</c:if>							
							</c:forEach>
						</select>
				</tr>
				</c:if>
				<c:if test="${sessionScope.httpSessionBean.queryType == sessionScope.httpSessionBean.queryTxnAutackForResign}">
				<tr class="table-title">
					<td nowrap="nowrap">處理狀況</td>
					<td nowrap="nowrap">
						<input type="radio" name="procStatus" value="3">成功
						<input type="radio" name="procStatus" value="4" checked="checked">失敗
					</td>
				</tr>
				</c:if>
				<tr class="table-title">
					<td nowrap="nowrap">驗章結果</td>
					<td nowrap="nowrap">
						<input type="radio" name="secStatus" value="0">成功
						<input type="radio" name="secStatus" value="1" checked="checked">失敗
					</td>
				</tr>
			</c:if>				
			
			<c:if test="${sessionScope.httpSessionBean.queryType == sessionScope.httpSessionBean.queryTxn}">
			<tr class="table-title">
					<td nowrap="nowrap">對外訊息傳送狀態</td>
					<td nowrap="nowrap">
						<input type="radio" name="fwdStatus" value="Z" checked="checked">全部
						<input type="radio" name="fwdStatus" value="0">傳送成功
						<input type="radio" name="fwdStatus" value="1">傳送中
					</td>
				</tr>	
			</c:if>				
			<tr>
				<td align="center" colspan=2 align=center><span class="button001" nowrap="nowrap">
					<c:if test="${!(sessionScope.httpSessionBean.queryType == sessionScope.httpSessionBean.queryTxnForAdvanced)}"><input type="submit" class="buttonBlue" id="query_submit" value="查詢"></c:if>
					<c:if test="${sessionScope.httpSessionBean.queryType == sessionScope.httpSessionBean.queryTxnForAdvanced}"><input type="submit" class="buttonBlue" id="query_ad_submit" value="查詢"></c:if>
				</span></td>
			</tr>
			
		</table>
		<script type="text/javascript">
			var dateType1='<%=queryBean.getDateType()%>';
			if('null'!=dateType1&&''!=dateType1){
				var dateTypeBtn=document.getElementsByName('dateType');
				if(dateType1=='payDate'){
					dateTypeBtn[0].checked='true';
				}else if(dateType1=='startDateTime'){
					dateTypeBtn[1].checked='true';
				}else if(dateType1=='stateDateTime'){
					dateTypeBtn[2].checked='true';
				}
			}
			var startTime='<%=queryBean.getStartDate()%>';
			var endTime='<%=queryBean.getStopDate()%>';
			if('null'!=startTime&&''!=startTime){
				document.getElementById('datetimepicker3').value=startTime;
			}
			if('null'!=endTime&&''!=endTime){
				document.getElementById('datetimepicker4').value=endTime;
			}
			var aekNo='<%=queryBean.getAekno()%>';
			if('null'!=aekNo&&''!=aekNo){
				document.getElementById('aekno').value=aekNo;
			}
			var sID='<%=queryBean.getSid()%>';
			if('null'!=sID&&''!=sID){
				document.getElementById('sid').value=sID;
			}
			var pEnding='<%=queryBean.getPending()%>';
			if('null'!=pEnding&&''!=pEnding){
				document.getElementById('pending').value=pEnding;
			}
			var netType='<%=queryBean.getNetType()%>';
			if('null'!=netType&&''!=netType){
				document.getElementById('netType').value=netType;
			}
			var clearAmount='<%=queryBean.getClearAmount()%>';
			if('null'!=clearAmount&&''!=clearAmount){
				if('0'!=clearAmount&&0!=clearAmount){
					document.getElementById('inputAmount').value=clearAmount;
				}			
			}
			var sTan='<%=queryBean.getStan()%>';
			if('null'!=sTan&&''!=sTan){
				document.getElementById('stan').value=sTan;
			}
			var orderbank='<%=queryBean.getOrderbank()%>';
			if('null'!=orderbank&&''!=orderbank){
				document.getElementById('orderbank').value=orderbank;
			}
			var saccount='<%=queryBean.getSaccount()%>';
			if('null'!=saccount&&''!=saccount){
				document.getElementById('saccount').value=saccount;
			}
			var benefbank='<%=queryBean.getBenefbank()%>';
			if('null'!=benefbank&&''!=benefbank){
				document.getElementById('benefbank').value=benefbank;
			}
			var raccount='<%=queryBean.getRaccount()%>';
			if('null'!=raccount&&''!=raccount){
				document.getElementById('raccount').value=raccount;
			}
			var procStatus='<%=queryBean.getProcStatus()%>';
			if('101'=='${sessionScope.httpSessionBean.queryType}'){
				if('null'!=procStatus&&''!=procStatus){
					document.getElementById('procStatus').value=procStatus;
				}
				
			}else if('201'=='${sessionScope.httpSessionBean.queryType}'){
				if('null'!=procStatus&&''!=procStatus){
				var procStatu=document.getElementsByName('procStatus');
				if('3'==procStatus){
					procStatu[0].checked='checked';
				}else if('4'==procStatus){
					procStatu[1].checked='checked';
				}
				}
			}
			var secStatus='<%=queryBean.getSecStatus()%>';
			var secStatu=document.getElementsByName('secStatus');
			if('null'!=secStatus&&''!=secStatus){
				if('0'==secStatus){
					secStatu[0].checked='checked';
				}else if('1'==secStatus){
					secStatu[1].checked='checked';
				}
			}
			var fwdStatus='<%=queryBean.getFwdStatus()%>';
			var fwdStatu=document.getElementsByName('fwdStatus');
			alert
			if('null'!=fwdStatus&&''!=fwdStatus){
				if('Z'==fwdStatus){
					fwdStatu[0].checked='checked';
				}else if('0'==fwdStatus){
					fwdStatu[1].checked='checked';
				}else if('1'==fwdStatus){
					fwdStatu[2].checked='checked';
				}
			}
			
		</script>
	</form>
</body>
</c:if>