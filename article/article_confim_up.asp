<!-- #include virtual = "/include/mylib1105.asp" -->

<!-- #include virtual = "/include/auth.asp" -->
<!-- #include virtual = "/include/sql.asp" -->

<%
 
'作者：马洪岩  于 2002-4-21 编写
'功能：文章的确认
'操作：本脚本由部门经理以上操作

 '判断级别
 	set CONN = Server.CreateObject("ADODB.Connection")
	CONN.open CONNSTR,"",""  
    set RS = Server.CreateObject("ADODB.RecordSet")
	set RS1 = Server.CreateObject("ADODB.RecordSet")
	set RSLIB = Server.CreateObject("ADODB.RecordSet")
	'判断权限
	IF Request.Cookies ("PRVI") = 0 THEN
		Response.Write "对不起，您目前没有审核的权利，请努力工作，谢谢"
		Response.End 
	END IF
	 SQL = "UPDATE WB_HTML SET XG_DATE = '" & DATE & " " & HOUR(TIME) & ":" & MINUTE(TIME) & ":" & SECOND(TIME) & "'"
        CONN.EXECUTE(SQL)
        
	SQL = "SELECT * FROM WB_ARTICLE WHERE INFO_NO = '" & REQUEST("INFO_NO") & "'"
	RS.Open SQL,CONN,adOpenKeyset,adLockReadOnly
		IF RS.RecordCount >0 THEN
			MY_PRVI = RS("INFO_CHECK")
				IF CDBL(CDBL(Request.Cookies ("PRVI")) - MY_PRVI) <0 THEN
					Response.Write "对不起，您不能审核您上级的结果，谢谢"
					Response.End 
				END IF
			
		ELSE
		Response.Write "对不起，没有查询到相映记录，是否有问题，请与管理人员联系"
		Response.End 
		END IF
	
		IF Request.Form ("PRVI") = "通过" THEN
			IF CDBL(Request.Cookies("PRVI")) >1 THEN 
						SQL = "SELECT TOP 1 * FROM WB_ARTICLE WHERE INFO_NO = '" & REQUEST("INFO_NO") & "'"
                        RS1.Open SQL,CONN,adOpenKeyset, adLockBatchOptimistic
                        RS1.MoveFirst 
                        RS1("INFO_CHECK") = 2
                        IF LEN(REQUEST("CHECK_DATE")) <= 10 THEN
                        RS1("CHECK_DATE") = Request("check_date") & " 08:30:00"
                        ELSE
                        RS1("CHECK_DATE") = Request("check_date")
                        END IF
                        RS1("TJ_DATE") = Request("tj_date")
                        RS1("IF_FB") = "是"
                        RS1("IF_ZX") = TRIM(REQUEST("IF_ZX"))
                        RS1("IF_TJ") = TRIM(REQUEST("IF_TJ"))
                        RS1("IF_ZH") = TRIM(REQUEST("IF_ZH"))
                        RS1("IF_MF") = Request("if_mf")
                        RS1("MY_SHORT") = Request("my_short")
                        RS1("C_SHORT") = Request("c_short")
                        RS1.UpdateBatch
                        RS1.Close
                        
						SQL = "SELECT TOP 1 * FROM ARTICLE_LINSHI WHERE INFO_NO = '" & REQUEST("INFO_NO") & "'"
                        RS1.Open SQL,CONN,adOpenKeyset, adLockBatchOptimistic
                        RS1.MoveFirst 
                        RS1("INFO_CHECK") = 2
                        IF LEN(REQUEST("CHECK_DATE")) <= 10 THEN
                        RS1("CHECK_DATE") = Request("check_date") & " 08:30:00"
                        ELSE
                        RS1("CHECK_DATE") = Request("check_date")
                        END IF
                        RS1("TJ_DATE") = Request("tj_date")
                        RS1("IF_FB") = "是"
                        RS1("IF_ZX") = TRIM(REQUEST("IF_ZX"))
                        RS1("IF_TJ") = TRIM(REQUEST("IF_TJ"))
                        RS1("IF_ZH") = TRIM(REQUEST("IF_ZH"))
                        RS1("IF_MF") = Request("if_mf")
                        RS1("MY_SHORT") = Request("my_short")
                        RS1("C_SHORT") = Request("c_short")
                        RS1.UpdateBatch
                        RS1.Close
                
             END IF
                        
						
						'IF HOUR(NOW()) < 21 THEN  '增加16点控制
					'		SQL = "UPDATE WB_ARTICLE SET INFO_CHECK = " & Request.Cookies ("PRVI") & ",CHECK_DATE = '" & Request("check_date") & "',TJ_DATE='" & Request("tj_date") & "',IF_ZX = '" & REQUEST("IF_ZX") & "',IF_TJ = '" & REQUEST("IF_TJ") & "',IF_ZH='" & REQUEST("IF_ZH") & "',MY_SHORT = " & Request("MY_SHORT") & ",IF_MF='" & REQUEST("IF_MF") & "',C_SHORT=" & REQUEST("C_SHORT") & " WHERE INFO_NO = '" & REQUEST("INFO_NO") & "'"
						'ELSE  '增加16点控制
						'	SQL = "UPDATE WB_ARTICLE SET INFO_CHECK = " & Request.Cookies ("PRVI") & ",CHECK_DATE = '" & MYDD(Request("check_date")) & "',TJ_DATE='" & MYDD(Request("tj_date")) & "',IF_ZX = '" & REQUEST("IF_ZX") & "',IF_TJ = '" & REQUEST("IF_TJ") & "',IF_ZH='" & REQUEST("IF_ZH") & "',IF_FB='否',MY_SHORT = " & Request("MY_SHORT") & ",IF_MF='" & REQUEST("IF_MF") & "' WHERE INFO_NO = '" & REQUEST("INFO_NO") & "'"
						'END IF  '增加16点控制
					'	CONN.Execute (SQL)
					'	SQL = "UPDATE REQUEST SET STATUS = '已经通过',REQUEST_DESC = '" &  REQUEST("REQUEST_DESC_N") & CHR(13) &  NOW() & CHR(13)  & "审核人：" & Request.Cookies ("user_name") & chr(13) & REQUEST("REQUEST_DESC") & "',CHECK_DATE = '" & MYDD(Request("check_date")) & "',PRVI = " & Request.Cookies ("PRVI") & " WHERE INFO_NO = '" & REQUEST("INFO_NO") & "'"
					'	CONN.Execute (SQL)

		
		END IF
					
			
		IF REQUEST("PRVI") = "修改" THEN
				SQL = "UPDATE WB_ARTICLE SET INFO_CHECK = 0 WHERE INFO_NO = '" & REQUEST("INFO_NO") & "'"
				CONN.Execute (SQL)
				SQL = "UPDATE ARTICLE_LINSHI SET INFO_CHECK = 0 WHERE INFO_NO = '" & REQUEST("INFO_NO") & "'"
				CONN.Execute (SQL)
		END IF

		IF REQUEST("PRVI") = "取消" THEN
		
				'外部数据库
				SQL = "DELETE FROM WB_ARTICLE  WHERE INFO_NO = '" & REQUEST("INFO_NO") & "'"
				CONN.Execute (SQL)
				SQL = "DELETE FROM ARTICLE_LINSHI  WHERE INFO_NO = '" & REQUEST("INFO_NO") & "'"
				CONN.Execute (SQL)
		END IF			
		
	%> 
<html>
<head>
<title>内容与文章审核结果</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" href="../../manage/article/font.css">
<style type="text/css">
<!--
.main {  font-size: 9pt}
-->
</style>
</head>

<body bgcolor="white">
<div align="center">
  <p>&nbsp;</p>
  <p>&nbsp;</p>
  <p><font color="#0000FF" class="main">（内部资料系统管理）内容与文章系统审核结果</font></p>
</div>
<hr size="0" width="600">
<form method="POST" action="article_confim_up.asp" name="un" >
  <table width="400" border="1" align="center" bordercolor="#000000" bordercolorlight="#FFFFFF" cellspacing="0" cellpadding="0" class="main">
    <tr> 
      <td colspan="2"><font color="#0000FF">审核记录，请确信您已经仔细的阅读了该篇文章</font></td>
    </tr>
    <tr> 
      <td width="98">&nbsp;</td>
      <td width="296">&nbsp;</td>
    </tr>
    <tr> 
      <td width="98">目前状态：</td>
      <td width="296">
      <%=request("prvi")
      %></td>
    </tr>
   
    <tr> 
      <td width="98">&nbsp;</td>
      <td width="296">&nbsp;</td>
    </tr>
    <tr> 
      <td colspan="2">
        <div align="center">
          <input type="button" name="Button" value="关闭窗口" onclick=self.close();>
        </div>
      </td>
    </tr>
  </table>
</form>
</body>
</html>
