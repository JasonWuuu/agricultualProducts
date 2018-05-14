<!-- #include virtual = "/include/mylib1105.asp" -->
 
<!-- #include virtual = "/include/mylib_108429.asp" --> 
<!-- #include virtual = "/include/auth.asp" -->
<!-- #include virtual = "/include/sql.asp" -->


<%

'作者：马洪岩  于 2002-4-21 编写
'功能：文章的查询结果
'操作：本脚本任何人操作，原则上是自己删除自己的记录

	set CONN = Server.CreateObject("ADODB.Connection")
    CONN.open CONNSTR,"",""  
	set RS = Server.CreateObject("ADODB.RecordSet")
	set RS1 = Server.CreateObject("ADODB.RecordSet")
	set RSlib = Server.CreateObject("ADODB.RecordSet")
		IF REQUEST("HOME") <> "" THEN
	Response.Redirect ("default.asp")
	END IF
	IF REQUEST("ADD") <> "" THEN
	Response.Redirect ("article_add.asp")
	END IF
	%> 
<%
DIM LK(20)

IF REQUEST("DEL") <> "" THEN
	
	CAOZUO = TRIM(REQUEST("CAOZUO"))
	POP = INSTR(CAOZUO,",")
		I = 0
		WHILE POP >0
			LK(I) = TRIM(MID(CAOZUO,1,POP-1))
			CAOZUO = TRIM(MID(CAOZUO,POP+1))
			POP=INSTR(CAOZUO,",")
			I = I + 1
		WEND
		LK(I)=TRIM(MID(CAOZUO,1))
	FOR J = 0 TO I
		
	  SQL = "SELECT * FROM WB_ARTICLE WHERE INFO_NO = '" & LK(J) & "' AND PERSON = '" & Request.Cookies ("USER_NAME") & "'"
	  	RS.Open SQL,CONN,adOpenKeyset ,adLockReadOnly
			IF RS.RecordCount >0 THEN
'			SQL = "UPDATE REQUEST SET REQUEST_TITLE = '资料删除',STATUS ='资料删除" & Request.Cookies ("USER_NAME") & "',RE_DATE = '" & MYDD(DATE) & "' WHERE INFO_NO = '" & LK(J) & "'"
'			CONN.Execute (SQL)
			SQL = "update  WB_ARTICLE set info_check='-1' WHERE INFO_NO = '" & LK(J) & "' AND CHECK_DATE >='" & DATE -10 & "'"
			CONN.Execute (SQL)
			SQL = "update  ARTICLE_LINSHI set info_check='-1' WHERE INFO_NO = '" & LK(J) & "' AND CHECK_DATE >='" & DATE -10 & "'"
			CONN.Execute (SQL)
		'	Response.Write SQL
			END IF
		RS.Close 
	
	NEXT
END IF
'查询
	IF REQUEST("B_ID") <> "" THEN
		IF Request("B_ID") = "1017" THEN
		MYA = " AND (CLASS_PZ = '" & REQUEST("B_ID") & "' OR S_ID = '2005' OR CLASS_CORRE LIKE '%PZ2005ED%') "
		ELSE
		MYB = " AND CLASS_PZ = '" & REQUEST("B_ID") & "' "
		END IF
	END IF
	IF REQUEST("S_ID") <> "" THEN
		If Request("B_ID") = "1017" THEN
		MYB = " AND (S_ID = '" & REQUEST("S_ID") & "' OR S_ID = '2005' OR CLASS_CORRE LIKE '%PZ2005ED%')"
		ELSE
		MYB = " AND S_ID = '" & REQUEST("S_ID") & "' "
		END IF
	END IF
	IF REQUEST("STATE") <> "" THEN
	MYC = " AND STATE = '" & REQUEST("STATE") & "' "
	END IF
	IF REQUEST("P_CLASS_NO") <> "" THEN
	MYD = " AND (P_CLASS_NO = '" & REQUEST("P_CLASS_NO") & "' OR CLASS_CORRE LIKE '%" & Request("P_CLASS_NO") & "%') "
	END IF
	IF REQUEST("CLASS_NO") <> "" THEN
	MYE = " AND (CLASS_NO = '" & REQUEST("CLASS_NO") & "' OR CLASS_CORRE LIKE '%" & Request("CLASS_NO") & "%') "
	END IF
	IF REQUEST("CLIMATE") <> "" THEN
	MYF = " AND CLIMATE LIKE  '%" & REQUEST("CLIMATE") & "%' "
	END IF
	IF REQUEST("ECONNMY") <> "" THEN
	MYG = " AND ECONNMY LIKE  '%" & REQUEST("ECONNMY") & "%' "
	END IF
	IF REQUEST("INFO_TITLE") <> "" THEN
	MYH = " AND INFO_TITLE LIKE  '%" & REQUEST("INFO_TITLE") & "%' "
	END IF
	IF REQUEST("INFO_FIND") <> "" THEN
	MYI = " AND INFO_FIND LIKE  '%" & REQUEST("INFO_FIND") & "%' "
	END IF
	IF REQUEST("INFO_CORRE") <> "" THEN
	MYJ = " AND INFO_CORRE LIKE  '%" & REQUEST("INFO_CORRE") & "%' "
	END IF
	IF REQUEST("INFO_SOURCE") <> "" THEN
	MYK = " AND INFO_SOURCE LIKE  '%" & REQUEST("INFO_SOURCE") & "%' "
	END IF
	IF REQUEST("AUTHOR") <> "" THEN
	MYL = " AND INFO_AUTHOR LIKE  '%" & REQUEST("AUTHOR") & "%' "
	END IF
	IF REQUEST("PERSON") <> "" THEN
	MYM = " AND PERSON LIKE  '%" & Request("PERSON") & "%' "
	END IF
	IF REQUEST("NW") <> "" THEN
	MYN = " AND INFO_TYPE LIKE  '%" & REQUEST("NW") & "%' "
	END IF
	IF REQUEST("RE_DATE1") <> "" THEN
	MYO = " AND RE_DATE >=  '" & MYDD(REQUEST("RE_DATE1")) & "' "
	END IF
	IF REQUEST("RE_DATE2") <> "" THEN
	MYP = " AND RE_DATE <  '" & MYDD(REQUEST("RE_DATE2")) & "' "
	END IF
	IF REQUEST("CHECK_DATE1") <> "" THEN
	MYQ = " AND CHECK_DATE >=  '" & MYDD(REQUEST("CHECK_DATE1")) & "' "
	END IF
	IF REQUEST("CHECK_DATE2") <> "" THEN
	MYR = " AND CHECK_DATE < '" & MYDD(REQUEST("CHECK_DATE2")) & "' "
	END IF
	IF REQUEST("TJ_DATE1") <> "" THEN
	MYUU = " AND TJ_DATE >=  '" & MYDD(REQUEST("TJ_DATE1")) & "' "
	END IF
	IF REQUEST("TJ_DATE2") <> "" THEN
	MYWW = " AND TJ_DATE < '" & MYDD(REQUEST("TJ_DATE2")) & "' "
	END IF
	IF REQUEST("PRVI") <> "" THEN
	MYS = " AND INFO_CHECK =  " & REQUEST("PRVI") & " "
	ELSE
		'IF Request.Cookies ("PRVI") <> "" THEN
		'	MYS = " AND PRVI <= " & CDBL(Request.Cookies ("PRVI")) & ""
		'	ELSE
		'	MYS = " AND PRVI = 0 "
		'END IF
	END IF
	IF REQUEST("S_ARTICLE_NO") <> "" THEN
	MYT = " AND S_ARTICLE_NO LIKE  '%" & REQUEST("S_ARTICLE_NO") & "%' "
	END IF
	IF REQUEST("IF_TJ") <> "" THEN
	MYW = " AND IF_TJ LIKE  '%" & REQUEST("IF_TJ") & "%' "
	END IF
	IF REQUEST("IF_ZX") <> "" THEN
	MYU = " AND IF_ZX LIKE  '%" & REQUEST("IF_ZX") & "%' "
	END IF
	IF REQUEST("IF_ZH") <> "" THEN
	MYV = " AND IF_ZH LIKE  '%" & REQUEST("IF_ZH") & "%' "
	END IF
	IF REQUEST("IF_MF") <> "" THEN
	MYX = " AND IF_MF LIKE  '%" & REQUEST("IF_MF") & "%' "
	END IF
	IF REQUEST("INFO_DESC") <> "" THEN
	MYY = " AND INFO_DESC LIKE  '%" & REQUEST("INFO_DESC") & "%' "
	END IF
	IF REQUEST("IFFY") <> "" THEN
	MZZ = " AND IFFY =  '" & REQUEST("IFFY") & "' "
	END IF
	IF REQUEST("CLIMATE") <> "" THEN
	MZZA = " AND CLIMATE LIKE  '%" & REQUEST("CLIAMTE") & "%' "
	END IF
	SQL = "SELECT TOP 200 * FROM WB_ARTICLE WHERE  INFO_CHECK >=0 " & MYA & MYB & MYC & MYD & MYE & MYF & MYG & MYH & MYI & MYJ & MYK & MYL & MYM & MYN & MYO & MYP & MYQ & MYR & MYS & MYT & MYW & MYV & MYU & MYX & MYUU & MYWW & MYY & MZZ & MZZA & " ORDER BY ID DESC"
	RS.Open SQL,CONN,adOpenKeyset ,adLockReadOnly
	IF RS.RecordCount >0 THEN
	RS.MoveLast 
			RECO=RS.RecordCount 
			AA = RECO MOD 20
			IF AA = 0 THEN
			PAGE = INT(RECO/20)
			ELSE
			PAGE = INT(RECO/20)+1
			END IF
			RS.MoveFirst 
				'定位页数
				IF REQUEST("PageNo") = "" THEN
				PageNo = Request("PageNo")
				
				if PageNo <> "" Then
					
				else
					PageNo=1
				
				End if
				ELSE
				PageNo = Request("PageNo1")
				END IF
			
				
				
%>

<html>
<head>
<title>内部文章与资料查询系统</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
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
<script language="javascript">
var lsdz = "";
function checkIn()
{    
   if(confirm("你现在真的要删除您选择的记录吗?"))
      return true
   else
      return false;
}
</script>
<p align="center" class="main">内部资料数据系统内容（每页20条记录） 
<form method="post" action="article_search.asp" name="un">
  <input type=hidden name="b_id" value="<%=REQUEST("b_id")%>">
  <input type=hidden name="s_id" value="<%=REQUEST("s_id")%>">
  <input type=hidden name="state" value="<%=REQUEST("state")%>">
  <input type=hidden name="p_class_no" value="<%=REQUEST("p_class_no")%>">
  <input type=hidden name="class_no" value="<%=REQUEST("class_no")%>">
  <input type=hidden name="info_title" value="<%=REQUEST("info_title")%>">
  <input type=hidden name="climate" value="<%=REQUEST("climate")%>">
  <input type=hidden name="econnmy" value="<%=REQUEST("econnmy")%>">
  <input type=hidden name="info_find" value="<%=REQUEST("info_find")%>">
  <input type=hidden name="info_corre" value="<%=REQUEST("info_corre")%>">
  <input type=hidden name="info_source" value="<%=REQUEST("info_source")%>">
  <input type=hidden name="author" value="<%=REQUEST("author")%>">
  <input type=hidden name="prvi" value="<%=REQUEST("prvi")%>">
  <input type=hidden name="nw" value="<%=REQUEST("nw")%>">
  <input type=hidden name="person" value="<%=REQUEST("person")%>">
  <input type=hidden name="PageNo1" value="<%=REQUEST("PageNo")%>">
  <input type=hidden name="re_date1" value="<%=REQUEST("re_date1")%>">
  <input type=hidden name="re_date2" value="<%=REQUEST("re_date2")%>">
  <input type=hidden name="check_date1" value="<%=REQUEST("check_date1")%>">
  <input type=hidden name="check_date2" value="<%=REQUEST("check_date2")%>">
  <input type=hidden name="s_article_no" value="<%=REQUEST("s_article_no")%>">
  <input type=hidden name="if_tj" value="<%=REQUEST("if_tj")%>">
  <input type=hidden name="if_zx" value="<%=REQUEST("if_zx")%>">
  <input type=hidden name="if_zh" value="<%=REQUEST("if_zh")%>">
  <input type=hidden name="if_mf" value="<%=REQUEST("if_mf")%>">
  <table width="898" border="0" bordercolordark="#99CCFF" bordercolorlight="#99CCFF" cellspacing="1" align="center" cellpadding="6" bgcolor="#000000" class="main">
    <tr bgcolor="#CCCCCC"> 
      <td width="5%"> 
        <div align="center"><font color="#0000FF">删除</font></div>
      </td>
      <td width="5%"><font color="#0000FF">修改</font></td>
      <td width="5%"><font color="#0000FF">审核</font></td>
	  <td width="5%"><font color="#0000FF">微信</font></td>
      <td width="9%"> 
        <div align="center"><font color="#0000FF">提交人员</font></div>
      </td>
      <td width="9%"><font color="#0000FF">栏目名称</font></td>
      <td width="11%"> 
        <div align="center"><font color="#0000FF">文章编号</font></div>
      </td>
      <td width="21%"> 
        <div align="center"><font color="#0000FF">标题</font></div>
      </td>
      <td width="9%"> 
        <div align="center"><font color="#0000FF">需要翻译</font></div>
      </td>
      <td width="7%"><font color="#0000FF">自己</font></td>
      <td width="11%"> 
        <div align="center"><font color="#0000FF">输入时间</font></div>
      </td>
      <td width="8%"><font color="#0000FF">状态</font></td>
    </tr>
    <%
		'判断显示的总页数
			RS.MoveLast 
			RECO=RS.RecordCount 
			AA = RECO MOD 20
			IF AA = 0 THEN
			PAGE = INT(RECO/20)
			ELSE
			PAGE = INT(RECO/20)+1
			END IF
			RS.MoveFirst 
				'定位页数
				PageNo = Request("PageNo")
				if PageNo <> "" Then
				
				else
					PageNo=1
				
				End if
			RS.PageSize = 20	'每页一10条
			RS.AbsolutePage = PageNo
		RowCount = RS.PageSize
		Do While Not RS.EOF and RowCount > 0 
		
    %> 
    <tr bgcolor="#FFFFFF"> 
      <td width="5%" height="34"> 
        <div align="center"> 
          <input type="checkbox" name="caozuo" value=<%=RS("info_no")%>>
          &nbsp; </div>
      </td>
      <td width="5%" height="34"> <a href="article_modi.asp?info_no=<%=RS("info_no")%>" target="_blank">Go!</a> 
        &nbsp; </td>
      <td width="5%" height="34"><a href="article_confim.asp?INFO_NO=<%=RS("INFO_NO")%>" target="_blank"><img src="/images/<%=cdbl(rs("INFO_CHECK"))+1%>.jpg" width="27" height="24" border="0"></a></td>
	   <td width="5%" height="34"><a href="article_wx.asp?INFO_NO=<%=RS("INFO_NO")%>" target="_blank">微信</a></td>
      <td width="9%" height="34"><%=RS("person")%> 
        <div align="center"></div>
      </td>
      <td width="9%" height="34"> <%
      IF RS("CLASS_NO") <> "" THEN
      P_N = DISPLAY_NAME("P_CLASS",RS("P_CLASS_NO"),"P_CLASS_NO","P_CLASS_NAME")
      S_N = DISPLAY_NAME("S_CLASS",RS("CLASS_NO"),"CLASS_NO","CLASS_NAME")
      Response.Write P_N & "->" & S_N
      ELSE
      Response.Write "内部"
      END IF
      %> </td>
      <td width="11%" height="34"> 
        <div align="center"><a href="article_detail.asp?info_no=<%=RS("info_no")%>" target='blank'><%=RS("s_article_no")%></a></div>
      </td>
      <td width="21%" height="34"> 
        <div align="center"><%=RS("info_title")%></div>
      </td>
      <td width="9%" height="34"> 
        <div align="center"> <%IF RS("IFFY") = "是" THEN%> <font color=red><%=RS("IFFY")%></font> 
          <%ELSE%> <font color=blue><%=RS("IFFY")%></font> <%END IF %> </div>
      </td>
      <td width="7%" height="34"><%=RS("IF_ZJ")%>&nbsp;</td>
      <td width="11%" height="34"> 
        <div align="center"><%=RS("re_date")%></div>
      </td>
      <td width="8%" height="34"><a href=request_detail.asp?info_no=<%=RS("info_no")%> target='blank'><%=DISPLAY_NAME("REQUEST",RS("INFO_NO"),"INFO_NO","STATUS")%></a></td>
    </tr>
    <%
			RS.MoveNext
			RowCount = RowCount - 1
			Loop
			RS.Close 
			%> 
  </table>
  <table width="740" border="0" bordercolordark="#99CCFF" bordercolorlight="#99CCFF" cellspacing="1" align="center" cellpadding="6" bgcolor="#000000" class="main">
    <tr bgcolor="#FFFFFF"> 
      <td width="10%"> 
        <div align="center"><font color="#000000">总计：</font></div>
      </td>
      <td width="11%"><font color="#000000"><font color=red><%=PAGE%></font>页</font></td>
      <td width="11%"> 
        <div align="center">当前<font color=red><%=PageNo%></font>页</div>
      </td>
      <td width="8%"> 
        <div align="center"> <font color="#000000"> 
          <input type="submit" name="Home" value="主页">
          </font></div>
      </td>
      <td width="8%"> 
        <div align="center"> <font color="#000000"> 
          <input type="submit" name="Del" value="删除" onClick="return checkIn();">
          </font></div>
      </td>
      <td width="8%"> 
        <div align="center"> <font color="#000000"> 
          <input type="button" name="Button" value="返回" onClick=history.back()>
          </font></div>
      </td>
      <td width="20%"> 
        <div align="center"><font color="#000000">显示 
          <input type="text" name="PageNo" size="4" maxlength="6">
          页 
          <input type="submit" name="Search" value="Go">
          </font></div>
      </td>
      <td width="12%"> 
        <div align="center"> <font color="#000000"><%
                IF INT(PageNo) >1 THEN
                %><a href="article_search.asp?b_id=<%=request("b_id")%>&s_id=<%=request("s_id")%>&state=<%=request("state")%>&p_class_no=<%=request("p_class_no")%>&class_no=<%=request("class_no")%>&climate=<%=request("climate")%>&econnmy=<%=request("econnmy")%>&info_title=<%=request("info_title")%>&info_find=<%=request("info_find")%>&info_corre=<%=request("info_corre")%>&info_source=<%=request("info_source")%>&author=<%=request("author")%>&prvi=<%=request("prvi")%>&nw=<%=request("nw")%>&person=<%=request("person")%>&re_date1=<%=request("re_date1")%>&re_date2=<%=request("re_date2")%>&check_date1=<%=request("check_date1")%>&check_date2=<%=request("check_date2")%>&tj_date1=<%=request("tj_date1")%>&tj_date2=<%=request("tj_date2")%>&s_article_no=<%=Request("s_article_no")%>&if_tj=<%=Request("if_tj")%>&if_zx=<%=Request("if_zx")%>&if_zh=<%=Request("if_zh")%>&if_mf=<%=Request("if_mf")%>&PageNo=<%=PageNo-1%>&search=all">上一页 
          </a> <%
                ELSE
                %> 上一页 <%
                END IF
                %> </font></div>
      </td>
      <td width="12%"> 
        <div align="center"> <font color="#000000"><%
                IF INT(PageNo) <INT(PAGE) AND INT(PageNo+1) <=INT(PAGE) THEN
                %> <a href="article_search.asp?b_id=<%=request("b_id")%>&s_id=<%=request("s_id")%>&state=<%=request("state")%>&p_class_no=<%=request("p_class_no")%>&class_no=<%=request("class_no")%>&climate=<%=request("climate")%>&econnmy=<%=request("econnmy")%>&info_title=<%=request("info_title")%>&info_find=<%=request("info_find")%>&info_corre=<%=request("info_corre")%>&info_source=<%=request("info_source")%>&author=<%=request("author")%>&prvi=<%=request("prvi")%>&nw=<%=request("nw")%>&person=<%=request("person")%>&re_date1=<%=request("re_date1")%>&re_date2=<%=request("re_date2")%>&check_date1=<%=request("check_date1")%>&check_date2=<%=request("check_date2")%>&tj_date1=<%=request("tj_date1")%>&tj_date2=<%=request("tj_date2")%>&s_article_no=<%=Request("s_article_no")%>&if_tj=<%=Request("if_tj")%>&if_zx=<%=Request("if_zx")%>&if_zh=<%=Request("if_zh")%>&if_mf=<%=Request("if_mf")%>&PageNo=<%=PageNo+1%>&search=all"> 
          下一页</a> <%
                ELSE
                %> 下一页 <%
                END IF
                %> </font></div>
      </td>
    </tr>
  </table>
</form>
</body>
</html>


<%
ELSE
%>
<html>
<head>
<title>没有查询到记录</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>
<body bgcolor="#FFFFFF">
<p>没有查询到记录</p>
<p><input type=button name=back value="返回" onclick=history.back();></p>
</body>
<%
END IF

%>
