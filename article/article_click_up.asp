 <!--#include file="./class_include.asp"--> 
<!-- #include virtual = "/include/sql.asp" -->
 <!-- #include virtual = "/include/mylib1105.asp" -->

<!-- #include virtual = "/include/auth.asp" -->

 <%
 
'作者：马洪岩  于 2002-4-21 编写
'功能：文章的查询条件
'操作：本脚本任何人操作


	
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
<title>信息部门工作量统计</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<style type="text/css">
<!--
.main {  font-size: 9pt}
-->
</style>
</head>

<body bgcolor="#FFFFFF">
<style type="text/css">
<!--
.main {  font-size: 9pt}
-->
</style>

<p align="center" class="main"><b><font color="#FF0000">信息部门工作量统计</font></b> <%
	sql = "select user_name from person where tj='1'"
	rs.Open sql,conn,1,1
		do while not rs.eof 
	%> 
<hr size="1">
<p align="center" class="main"><font color=blue><font size="+2""><%=rs("user_name")%></font></font>

<table width="75%" border="1" cellpadding="0" cellspacing="0" class="main">
  <tr bgcolor="#0000FF"> 
    <td width="12%"><font color="#FFFF00">日期</font></td>
    <td width="10%"><font color="#FFFF00">市场快报（上载）</font></td>
    <td width="15%"><font color="#FFFF00">市场快报（点击）</font></td>
    <td width="18%"><font color="#FFFF00">独家视点（上载）</font></td>
    <td width="12%"><font color="#FFFF00">独家视点（点击）</font></td>
    <td width="14%"><font color="#FFFF00">价格日报（上载）</font></td>
    <td width="13%"><font color="#FFFF00">价格日报（点击）</font></td>
   
  </tr>
  <tr> <%
	  TOTAL1Z=0
	  TOTAL2Z=0
	  TOTAL3Z=0
	  TOTAL4Z=0
	  TOTAL5Z=0
	  TOTAL6Z=0
 
 sql1 = "select * from jci_hits where year(re_date) = '" & request("m_year") & "' and month(re_date) = '" & request("m_month") & "' and person = '" & rs("user_name") & "' order by re_date"
 rs1.Open sql1,conn,1,1
	do while not rs1.eof 
  
  %> 
    <td width="12%"><%=rs1("re_date")%>&nbsp;</td>
    <td width="10%"><%=rs1("cnums")%>&nbsp;</td>
    <td width="15%"><%=rs1("chits")%>&nbsp;</td>
    <td width="18%"><%=rs1("dnums")%>&nbsp;</td>
    <td width="12%"><%=rs1("dhits")%>&nbsp;</td>
    <td width="9%"><%=rs1("gnums")%>&nbsp;</td>
    <td width="13%"><%=rs1("ghits")%>&nbsp;</td>
    
  </tr>
  <%
  total1z = cdbl(total1z) + rs1("cnums")
  total2z = cdbl(total2z) + rs1("chits")
  total3z = cdbl(total3z) + rs1("dnums")
  total4z = cdbl(total4z) + rs1("dhits")
  total5z = cdbl(total5z) + rs1("gnums")
  total6z = cdbl(total6z) + rs1("ghits")
  rs1.MoveNext
  loop
  rs1.close 
  %> 
  <tr bgcolor="#CCCCFF"> 
    <td width="12%"><font color="#FF0000">当月合计：&nbsp;</font></td>
    <td width="10%"><font color="#FF0000"><%=TOTAL1Z%>&nbsp;</font></td>
    <td width="15%"><font color="#FF0000"><%=TOTAL2Z%>&nbsp;</font></td>
    <td width="18%"><font color="#FF0000"><%=TOTAL3Z%>&nbsp;</font></td>
    <td width="12%"><font color="#FF0000"><%=TOTAL4Z%>&nbsp;</font></td>
    <td width="9%"><font color="#FF0000"><%=TOTAL5Z%>&nbsp;</font></td>
    <td width="13%"><font color="#FF0000"><%=TOTAL6Z%>&nbsp;</font></td>
   
  </tr>
  <%
  sql1 = "select COALESCE(SUM(cnums),0) AS total1z,COALESCE(SUM(chits),0) AS total2z,COALESCE(SUM(dnums),0) AS total3z,COALESCE(SUM(dhits),0) AS total4z,COALESCE(SUM(gnums),0) AS total5z,COALESCE(SUM(ghits),0) AS total6z from jci_hits where year(re_date) = '" & request("m_year") & "' and person = '" & rs("user_name") & "'"
   rs1.Open sql1,conn,1,1
		if rs1.RecordCount>0 then
		total1z = rs1("total1z") 
		total2z = rs1("total2z") 
  total3z = rs1("total3z") 
  total4z = rs1("total4z") 
  total5z = rs1("total5z") 
  total6z = rs1("total6z") 
		else
		end if
	rs1.close 
  %>
  <tr bgcolor="#CCCCFF"> 
    <td width="12%"><font color="#FF0000">当年合计：&nbsp;</font></td>
    <td width="10%"><font color="#FF0000"><%=TOTAL1Z%>&nbsp;</font></td>
    <td width="15%"><font color="#FF0000"><%=TOTAL2Z%>&nbsp;</font></td>
    <td width="18%"><font color="#FF0000"><%=TOTAL3Z%>&nbsp;</font></td>
    <td width="12%"><font color="#FF0000"><%=TOTAL4Z%>&nbsp;</font></td>
    <td width="9%"><font color="#FF0000"><%=TOTAL5Z%>&nbsp;</font></td>
    <td width="13%"><font color="#FF0000"><%=TOTAL6Z%>&nbsp;</font></td>
    
  </tr>
  
  
</table>
<hr size="1">
<%
 rs.MoveNext
 loop
 rs.close 
  %> <br>
</body>
</html>

