<!-- #include virtual = "/include/mylib1105.asp" -->

<!-- #include virtual = "/include/auth.asp" -->
<!-- #include virtual = "/include/sql.asp" -->

<%
 
'���ߣ������  �� 2002-4-21 ��д
'���ܣ����µ�ȷ��
'���������ű��ɲ��ž������ϲ���

 '�жϼ���
 	set CONN = Server.CreateObject("ADODB.Connection")
	CONN.open CONNSTR,"",""  
    set RS = Server.CreateObject("ADODB.RecordSet")
	set RS1 = Server.CreateObject("ADODB.RecordSet")
	set RSLIB = Server.CreateObject("ADODB.RecordSet")
	'�ж�Ȩ��
	IF Request.Cookies ("PRVI") = 0 THEN
		Response.Write "�Բ�����Ŀǰû����˵�Ȩ������Ŭ��������лл"
		Response.End 
	END IF
	 SQL = "UPDATE WB_HTML SET XG_DATE = '" & DATE & " " & HOUR(TIME) & ":" & MINUTE(TIME) & ":" & SECOND(TIME) & "'"
        CONN.EXECUTE(SQL)
        
	SQL = "SELECT * FROM WB_ARTICLE WHERE INFO_NO = '" & REQUEST("INFO_NO") & "'"
	RS.Open SQL,CONN,adOpenKeyset,adLockReadOnly
		IF RS.RecordCount >0 THEN
			MY_PRVI = RS("INFO_CHECK")
				IF CDBL(CDBL(Request.Cookies ("PRVI")) - MY_PRVI) <0 THEN
					Response.Write "�Բ���������������ϼ��Ľ����лл"
					Response.End 
				END IF
			
		ELSE
		Response.Write "�Բ���û�в�ѯ����ӳ��¼���Ƿ������⣬���������Ա��ϵ"
		Response.End 
		END IF
	
		IF Request.Form ("PRVI") = "ͨ��" THEN
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
                        RS1("IF_FB") = "��"
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
                        RS1("IF_FB") = "��"
                        RS1("IF_ZX") = TRIM(REQUEST("IF_ZX"))
                        RS1("IF_TJ") = TRIM(REQUEST("IF_TJ"))
                        RS1("IF_ZH") = TRIM(REQUEST("IF_ZH"))
                        RS1("IF_MF") = Request("if_mf")
                        RS1("MY_SHORT") = Request("my_short")
                        RS1("C_SHORT") = Request("c_short")
                        RS1.UpdateBatch
                        RS1.Close
                
             END IF
                        
						
						'IF HOUR(NOW()) < 21 THEN  '����16�����
					'		SQL = "UPDATE WB_ARTICLE SET INFO_CHECK = " & Request.Cookies ("PRVI") & ",CHECK_DATE = '" & Request("check_date") & "',TJ_DATE='" & Request("tj_date") & "',IF_ZX = '" & REQUEST("IF_ZX") & "',IF_TJ = '" & REQUEST("IF_TJ") & "',IF_ZH='" & REQUEST("IF_ZH") & "',MY_SHORT = " & Request("MY_SHORT") & ",IF_MF='" & REQUEST("IF_MF") & "',C_SHORT=" & REQUEST("C_SHORT") & " WHERE INFO_NO = '" & REQUEST("INFO_NO") & "'"
						'ELSE  '����16�����
						'	SQL = "UPDATE WB_ARTICLE SET INFO_CHECK = " & Request.Cookies ("PRVI") & ",CHECK_DATE = '" & MYDD(Request("check_date")) & "',TJ_DATE='" & MYDD(Request("tj_date")) & "',IF_ZX = '" & REQUEST("IF_ZX") & "',IF_TJ = '" & REQUEST("IF_TJ") & "',IF_ZH='" & REQUEST("IF_ZH") & "',IF_FB='��',MY_SHORT = " & Request("MY_SHORT") & ",IF_MF='" & REQUEST("IF_MF") & "' WHERE INFO_NO = '" & REQUEST("INFO_NO") & "'"
						'END IF  '����16�����
					'	CONN.Execute (SQL)
					'	SQL = "UPDATE REQUEST SET STATUS = '�Ѿ�ͨ��',REQUEST_DESC = '" &  REQUEST("REQUEST_DESC_N") & CHR(13) &  NOW() & CHR(13)  & "����ˣ�" & Request.Cookies ("user_name") & chr(13) & REQUEST("REQUEST_DESC") & "',CHECK_DATE = '" & MYDD(Request("check_date")) & "',PRVI = " & Request.Cookies ("PRVI") & " WHERE INFO_NO = '" & REQUEST("INFO_NO") & "'"
					'	CONN.Execute (SQL)

		
		END IF
					
			
		IF REQUEST("PRVI") = "�޸�" THEN
				SQL = "UPDATE WB_ARTICLE SET INFO_CHECK = 0 WHERE INFO_NO = '" & REQUEST("INFO_NO") & "'"
				CONN.Execute (SQL)
				SQL = "UPDATE ARTICLE_LINSHI SET INFO_CHECK = 0 WHERE INFO_NO = '" & REQUEST("INFO_NO") & "'"
				CONN.Execute (SQL)
		END IF

		IF REQUEST("PRVI") = "ȡ��" THEN
		
				'�ⲿ���ݿ�
				SQL = "DELETE FROM WB_ARTICLE  WHERE INFO_NO = '" & REQUEST("INFO_NO") & "'"
				CONN.Execute (SQL)
				SQL = "DELETE FROM ARTICLE_LINSHI  WHERE INFO_NO = '" & REQUEST("INFO_NO") & "'"
				CONN.Execute (SQL)
		END IF			
		
	%> 
<html>
<head>
<title>������������˽��</title>
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
  <p><font color="#0000FF" class="main">���ڲ�����ϵͳ��������������ϵͳ��˽��</font></p>
</div>
<hr size="0" width="600">
<form method="POST" action="article_confim_up.asp" name="un" >
  <table width="400" border="1" align="center" bordercolor="#000000" bordercolorlight="#FFFFFF" cellspacing="0" cellpadding="0" class="main">
    <tr> 
      <td colspan="2"><font color="#0000FF">��˼�¼����ȷ�����Ѿ���ϸ���Ķ��˸�ƪ����</font></td>
    </tr>
    <tr> 
      <td width="98">&nbsp;</td>
      <td width="296">&nbsp;</td>
    </tr>
    <tr> 
      <td width="98">Ŀǰ״̬��</td>
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
          <input type="button" name="Button" value="�رմ���" onclick=self.close();>
        </div>
      </td>
    </tr>
  </table>
</form>
</body>
</html>
