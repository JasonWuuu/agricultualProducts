 <!--#include file="./class_include.asp"--> 
<!-- #include virtual = "/include/sql.asp" -->
 <!-- #include virtual = "/include/mylib1105.asp" -->

<!-- #include virtual = "/include/auth.asp" -->

 <%
 
'���ߣ������  �� 2002-4-21 ��д
'���ܣ����µĲ�ѯ����
'���������ű��κ��˲���


	
	set CONN = Server.CreateObject("ADODB.Connection")
    CONN.open CONNSTR,"",""  
	set RS = Server.CreateObject("ADODB.RecordSet")
	set RS1 = Server.CreateObject("ADODB.RecordSet")
	set RS2 = Server.CreateObject("ADODB.RecordSet")
	set RS3 = Server.CreateObject("ADODB.RecordSet")
	set RSLIB = Server.CreateObject("ADODB.RecordSet")
	

	
	%> 
<html>
<head>
<title>���������²�ѯ</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">

<style type="text/css">
<!--
.main {  font-size: 9pt}
-->
</style>
</head>

<body bgcolor="white">

<div align="center"><font color="#0000FF" class="main">���������ѯ </font></div>
<hr size="1">
<form method="POST" action="article_click_up.asp" name="un">
  <table width="640" border="0" bordercolordark="#99CCFF" bordercolorlight="#99CCFF" cellspacing="1" align="center" cellpadding="6" bgcolor="#000000">
    
   <tr bgcolor="#FFFFFF"> 
      <td width="17%" class="main">��ѯ˵����</td>
      <td colspan="3" class="main">�����ѡ��������ϵͳĬ��ȫ������</td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
    
      <td width="14%" class="main"> 
        <div align="right">���ޣ�</div>
      </td>
      <td width="14%" class="main"> 
        <select name="m_year">
        <option value="2017">2017</option>
         <option value="2018">2018</option>
			<option value="2019">2019</option>
			<option value="2020">2020</option>
        </select>
      </td>
		 <td width="14%" class="main"> 
        <div align="right">�·ݣ�</div>
      </td>
      <td width="14%" class="main"> 
        <select name="m_month">
        <option value="01">01</option>
         <option value="02">02</option>
			<option value="03">03</option>
			<option value="04">04</option>
			<option value="05">05</option>
			<option value="06">06</option>
			<option value="07">07</option>
			<option value="08">08</option>
			<option value="09">09</option>
			<option value="10">10</option>
			<option value="11">11</option>
			<option value="12">12</option>
        </select>
      </td>
    </tr>
	 <tr bgcolor="#FFFFFF"> 
      <td colspan="4"> 
        <div align="center"><br>
          <input type="submit" name="search" value="���в�ѯ" >
          <input type="reset" name="Submit2" value="������Ϣ">
          <input type="submit" name="home" value="������ҳ">
        </div>
      </td>
		</tr>
  </table>
</form>
</body>
</html>
