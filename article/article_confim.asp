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
	IF RS("CHECK_DATE") = "1999-1-1" THEN
		if hour(now()) < 21 then
			CHECK_DATE = DATE
		else
			CHECK_DATE = DATE + 1
		end if
		ELSE
		CHECK_DATE = RS("CHECK_DATE")
	END IF
	IF RS("TJ_DATE") = "1999-1-1" THEN
		if hour(now()) < 21 then
			TJ_DATE = DATE
		else
			TJ_DATE = DATE + 1
		end if
		
	ELSE
		TJ_DATE = RS("TJ_DATE")
	END IF
	%> 
<script language="javascript">

var lsdz = "";
function checkIn()
{
    if( document.un.check_date.value.length <1) {
      alert("���ʱ�������д,��Ӱ����");
      document.un.check_date.focus();
      return false;
   }


	 if( document.un.tj_date.value.length <1) {
      alert("�ر��Ƽ���ʱ�������д,��������²����ر��Ƽ�,������Ӱ��");
      document.un.tj_date.focus();
      return false;
   }
	
}
</script>
<html>
<head>
<title>����������ϵͳ���</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
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
  <p><font color="#0000FF" class="main">���ڲ�����ϵͳ��������������ϵͳ���</font></p>
</div>
<hr size="0" width="600">
<form method="POST" action="article_confim_up.asp" name="un"  >
  <input type=hidden name=info_no value="<%=rs("info_no")%>">
  <input type=hidden name=if_nw value="<%=rs("info_type")%>">
  <input type=hidden name=s_article_no value="<%=rs("s_article_no")%>">
  <input type=hidden name=request_no value="<%=request("request_no")%>">
  <table width="506" border="1" align="center" bordercolor="#000000" bordercolorlight="#FFFFFF" cellspacing="0" cellpadding="5" class="main">
    <tr> 
      <td colspan="4"><font color="#0000FF">��˼�¼����ȷ�����Ѿ���ϸ���Ķ��˸�ƪ����</font></td>
    </tr>
    <tr> 
      <td width="74">���±��⣺</td>
      <td colspan="3"><%=rs("info_title")%></td>
    </tr>
    <tr> 
      <td width="74">������Ա��</td>
      <td colspan="3"><%=rs("person")%></td>
    </tr>
    <tr> 
      <td width="74">Ŀǰ״̬��</td>
      <td colspan="3"><%
      IF CDBL(RS("INFO_CHECK")) = CDBL(Request.Cookies ("PRVI")) THEN
      Response.Write "���Ѿ�ȷ�Ϲ���"
      ELSE
      Response.Write "��Ŀǰ��û��ȷ��"
      END IF
      %></td>
    </tr>
    <tr> 
      <td width="74">������Ѷ��</td>
      <td colspan="3"><%
      IF RS("IF_ZX") = "��" THEN
      %> 
        <input type="radio" name="if_zx" value="��" checked>
        �� 
        <input type="radio" name="if_zx" value="��">
        �� <%
       ELSE
       %> 
        <input type="radio" name="if_zx" value="��">
        �� 
        <input type="radio" name="if_zx" value="��" checked>
        �� <%
       END IF
       %> </td>
    </tr>
    <tr> 
      <td width="74">�ر��Ƽ���</td>
      <td colspan="3"><%
      IF RS("IF_TJ") = "��" THEN
      %> 
        <input type="radio" name="if_tj" value="��" checked>
        �� 
        <input type="radio" name="if_tj" value="��">
        �� <%
       ELSE
       %> 
        <input type="radio" name="if_tj" value="��">
        �� 
        <input type="radio" name="if_tj" value="��" checked>
        �� <%
       END IF
       %> </td>
    </tr>
    <tr> 
      <td width="74">�ۺϱ�����</td>
      <td colspan="3"><%
      IF RS("IF_ZH") = "��" THEN
      %> 
        <input type="radio" name="if_zh" value="��" checked>
        �� 
        <input type="radio" name="if_zh" value="��">
        �� <%
       ELSE
       %> 
        <input type="radio" name="if_zh" value="��">
        �� 
        <input type="radio" name="if_zh" value="��" checked>
        �� <%
       END IF
       %> </td>
    </tr>
    <tr> 
      <td width="74">�����</td>
      <td width="114"> 
        <select name="prvi">
          <option value="ͨ��" selected>ͨ��</option>
          <option value="�޸�">�޸�</option>
          <option value="ȡ��">ȡ��</option>
        </select>
      </td>
      <td width="64"> 
        <div align="right">�Ƽ�˳��</div>
      </td>
      <td width="204"> 
        <select name="my_short">
          <option value="-7">-7</option>
          <option value="-6" >-6</option>
          <option value="-5" >-5</option>
          <option value="-4" >-4</option>
          <option value="-3" >-3</option>
          <option value="-2">-2</option>
          <option value="-1" >-1</option>
          <option value="0" >0</option>
          <option value="1">1</option>
          <option value="2">2</option>
          <option value="3">3</option>
          <option value="4">4</option>
          <option value="5">5</option>
          <option value="6">6</option>
          <option value="7">7</option>
          <option value="8">8</option>
          <option value="9">9</option>
          <option value="<%=rs("my_short")%>" selected><%=rs("my_short")%></option>
        </select>
        ��0�������9���ڵ�һ���� </td>
    </tr>
    <tr> 
      <td width="74">������Ŀ��</td>
      <td colspan="3"> 
        <select name="c_short">
          <option value="-7" >-7</option>
          <option value="-6" >-6</option>
          <option value="-5" >-5</option>
          <option value="-4" >-4</option>
          <option value="-3" >-3</option>
          <option value="-2" >-2</option>
          <option value="-1" >-1</option>
          <option value="0" >0</option>
          <option value="1">1</option>
          <option value="2">2</option>
          <option value="3">3</option>
          <option value="4">4</option>
          <option value="5">5</option>
          <option value="6">6</option>
          <option value="7">7</option>
          <option value="8">8</option>
          <option value="9">9</option>
          <option value="<%=rs("c_short")%>" selected><%=rs("c_short")%></option>
        </select>
        ��0�������9���ڵ�һ����</td>
    </tr>
    <tr> 
      <td width="74">������ڣ�</td>
      <td colspan="3"> 
        <input type="text" name="check_date" size="20" value="<%=check_date%>">
        ��������Ѷ�� <font color=red>�벻Ҫɾ��ʱ��</font></td>
    </tr>
    <tr> 
      <td width="74">�Ƽ����ڣ�</td>
      <td colspan="3"> 
        <input type="text" name="tj_date" size="20" value="<%=tj_date%>">
        ���ر��Ƽ��� </td>
    </tr>
    <tr> 
      <td width="74">��������</td>
      <td colspan="3"> 
        <textarea name="request_desc_n" cols="50" rows="4"></textarea>
      </td>
    </tr>
    <tr> 
      <td width="74">��ǰ�����</td>
      <td colspan="3"> 
        <textarea name="request_desc" cols="50" rows="4"><%=DISPLAY_NAME("REQUEST",REQUEST("INFO_NO"),"INFO_NO","REQUEST_DESC")%></textarea>
      </td>
    </tr>
    <tr> 
      <td width="74">�Ƿ񹫿���</td>
      <td width="114"> <%
      IF RS("IF_MF") = "��" THEN
      %> 
        <input type="radio" name="if_mf" value="��" checked>
        �� 
        <input type="radio" name="if_mf" value="��">
        �� <%
       ELSE
       %> 
        <input type="radio" name="if_mf" value="��">
        �� 
        <input type="radio" name="if_mf" value="��" checked>
        �� <%
       END IF
       %> </td>
      <td width="64">�Ƿ���գ�</td>
      <td width="204">
        <input type="radio" name="if_qk" value="��">
        �� 
        <input type="radio" name="if_qk" value="��" checked>
        ��</td>
    </tr>
    <tr> 
      <td colspan="4"><font color="#FF0000">����Ѿ���˹��ˣ���˵����ڲ��ᷢ���仯</font></td>
    </tr>
    <td colspan="4"> 
      <div align="center"> 
        <input type="submit" name="send" value="����ȷ��" onClick="return checkIn();">
        <input type="button" name="Button" value="�رմ���" onClick=self.close();>
      </div>
    </td>
    </tr>
  </table>
</form>
</body>
</html>
