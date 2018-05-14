 <!--#include file="./class_include.asp"--> 
<!-- #include virtual = "/include/sql.asp" -->
 <!-- #include virtual = "/include/mylib1105.asp" -->

<!-- #include virtual = "/include/auth.asp" -->

 <%
 
'作者：马洪岩  于 2002-4-21 编写
'功能：文章的查询条件
'操作：本脚本任何人操作

	IF REQUEST("HOME") <> "" THEN
	Response.Redirect ("default.asp")
	END IF
	IF REQUEST("add") <> "" THEN
	Response.Redirect ("article_add.asp")
	END IF
	IF REQUEST("addn") <> "" THEN
	Response.Redirect ("article_add-20120409.asp")
	END IF
	
	set CONN = Server.CreateObject("ADODB.Connection")
    CONN.open CONNSTR,"",""  
	set RS = Server.CreateObject("ADODB.RecordSet")
	set RS1 = Server.CreateObject("ADODB.RecordSet")
	set RSLIB = Server.CreateObject("ADODB.RecordSet")
	%> 
<html>
<head>
<title>内容与文章查询</title>
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
<script language="javascript">
function GoToURL()
{
  
  var tURL= "article_main.asp?b_id="+document.un.b_id.options[document.un.b_id.selectedIndex].value;
  var tURL1= "&state="+document.un.state.options[document.un.state.selectedIndex].value;
  var tURL2= "&p_class_no="+document.un.p_class_no.options[document.un.p_class_no.selectedIndex].value;
  var tURL3= "&class_no="+document.un.class_no.options[document.un.class_no.selectedIndex].value;
  var tURL4= "&s_id="+document.un.s_id.options[document.un.s_id.selectedIndex].value;
  document.location=tURL+tURL1+tURL2+tURL3+tURL4;
}
</script>
<div align="center"><font color="#0000FF" class="main">（内部资料系统管理）内容与文章内容查询 </font></div>
<hr size="1">
<form method="POST" action="article_search.asp" name="un">
  <table width="640" border="0" bordercolordark="#99CCFF" bordercolorlight="#99CCFF" cellspacing="1" align="center" cellpadding="6" bgcolor="#000000">
    <tr bgcolor="#FFFFFF"> 
      <td width="17%" class="main">查询说明：</td>
      <td colspan="3" class="main">如果不选择条件，系统默认全部符合</td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="17%" class="main"> 
        <div align="right">大类别：</div>
      </td>
      <td width="35%" class="main"> 
        <select name="b_id" onChange="GoToURL()">
          <option value="">大类别</option>
       <%
        SQL = "SELECT * FROM B_SHORT"
        RS1.OPEN SQL,CONN,1,1
        DO WHILE NOT RS1.EOF 
        IF Request("b_id") = rs1("b_id") Then
        %>
        <option value="<%=RS1("B_ID")%>" SELECTED><%=RS1("C_NAME")%>-<%=RS1("IMG_PATH") %></option>
        <%
        else
        %>
        <option value="<%=RS1("B_ID")%>" ><%=RS1("C_NAME")%>-<%=RS1("IMG_PATH") %></option>
        <%
        end if
        RS1.MOVENEXT
        LOOP
        RS1.CLOSE
        %> 
        
        </select>
      </td>
      <td width="14%" class="main"> 
        <div align="right">小类别：</div>
      </td>
      <td width="34%" class="main"> 
        <select name="s_id">
        <option value="">小类别</option>
         <%
			IF REQUEST("B_ID") <> "" THEN
			SQL = "SELECT * FROM S_SHORT WHERE B_ID = '" & REQUEST("B_ID") & "'"
			RS1.Open SQL,CONN,adOpenKeyset ,adLockReadOnly
				DO WHILE NOT RS1.EOF 
				IF REQUEST("S_ID") = RS1("S_ID") THEN
			%> 
          <option value="<%=RS1("S_ID")%>" SELECTED><%=RS1("C_NAME")%>-<%=rs1("e_name") %></option>
          <%
			END IF
        		%> 
          <option value="<%=RS1("S_ID")%>"><%=RS1("C_NAME")%>-<%=rs1("e_name") %></option>
          <%
				RS1.MoveNext 
				LOOP
			RS1.Close 
			END IF
			%> 
        </select>
      </td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="17%" class="main"> 
        <div align="right">国家：</div>
      </td>
      <td width="35%" class="main"> 
        <select name="state">
          <option value="">全部</option>
            <%
			SQL = "SELECT * FROM COUNTRY  ORDER BY SHORT"
			RS1.Open SQL,CONN,adOpenKeyset ,adLockReadOnly
				DO WHILE NOT RS1.EOF 
				if Request("state") = rs1("state") then
				%> 
          <option value="<%=Rs1("state")%>" selected><%=RS1("C_NAME")%></option>
          <%
				else
				%> 
          <option value="<%=RS1("state")%>" ><%=RS1("C_NAME")%></option>
          <%
				end if
				RS1.MoveNext 
				LOOP
			RS1.Close 
			
        %> 
        </select>
      </td>
      <td width="14%" class="main"> 
        <div align="right">网站总栏目：</div>
      </td>
      <td width="34%" class="main"> 
        <select name="p_class_no" onChange="GoToURL()">
          <option value="">网站总栏目</option>
         <%
        SQL = "SELECT * FROM P_CLASS"
        RS1.OPEN SQL,CONN,1,1
        DO WHILE NOT RS1.EOF 
        IF Request("p_class_no") = rs1("p_class_no") Then
        %>
        <option value="<%=RS1("p_class_no")%>" SELECTED><%=RS1("p_class_NAME")%>-<%=RS1("e_name") %></option>
        <%
        else
        %>
        <option value="<%=RS1("p_class_no")%>" ><%=RS1("p_class_NAME")%>-<%=RS1("e_name") %></option>
        <%
        end if
        RS1.MOVENEXT
        LOOP
        RS1.CLOSE
        %> 
        </select>
      </td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="17%" class="main"> 
        <div align="right">网站次栏目：</div>
      </td>
      <td width="35%" class="main"> 
        <select name="class_no">
          <option value="">网站次栏目</option>
         <%
			IF REQUEST("p_class_no") <> "" THEN
			SQL = "SELECT * FROM S_CLASS WHERE P_CLASS_NO = '" & REQUEST("P_CLASS_NO") & "' ORDER BY CLASS_NO"
			RS1.Open SQL,CONN,adOpenKeyset ,adLockReadOnly
				DO WHILE NOT RS1.EOF 
				if Request("class_no") = rs1("class_no") then
				%> 
          <option value="<%=Rs1("CLASS_NO")%>" selected><%=RS1("CLASS_NAME")%>-<%=rs1("IMG_PATH") %></option>
          <%
				else
				%> 
          <option value="<%=RS1("CLASS_NO")%>" ><%=RS1("CLASS_NAME")%>-<%=rs1("IMG_PATH") %></option>
          <%
				end if
				RS1.MoveNext 
				LOOP
			RS1.Close 
			END IF
        %> 
        </select>
      </td>
      <td width="14%" class="main"> 
        <div align="right">资料标题：</div>
      </td>
      <td width="34%" class="main"><small><font face="Verdana"> 
        <input type="text" name="info_title" size="30">
        </font></small></td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="17%" class="main"> 
        <div align="right">查找字符串：</div>
      </td>
      <td width="35%" class="main"> 
        <input type="text" name="info_find" size="20">
      </td>
      <td width="14%" class="main"> 
        <div align="right">相关查询字符：</div>
      </td>
      <td width="34%" class="main"><small> 
        <input type="text" name="info_corre" size="20">
        <span class="main"> </span></small></td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="17%" class="main"> 
        <div align="right">资料来源：</div>
      </td>
      <td width="35%" class="main"> 
        <input type="text" name="info_source" size="20">
      </td>
      <td width="14%" class="main"> 
        <div align="right">作者：</div>
      </td>
      <td width="34%" class="main"><small><font face="Verdana"> 
        <input type="text" name="author" size="20">
        </font></small></td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="17%" class="main"> 
        <div align="right">内容：</div>
      </td>
      <td colspan="3" class="main"> 
        <input type="text" name="info_desc" size="50">
      </td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="17%" class="main"> 
        <div align="right">气象：</div>
      </td>
      <td colspan="3" class="main"> 
        <input type="text" name="climate" size="50" ID="Text1">
      </td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="17%" class="main"> 
        <div align="right">审核状态：</div>
      </td>
      <td width="35%" class="main"><small><font face="Verdana"> 
        <select name="prvi">
          <option value="" selected>全部</option>
          <option value="0">工作人员</option>
          <option value="1">部门经理</option>
          <option value="2">总经理</option>
        </select>
        </font></small></td>
      <td width="14%" class="main"> 
        <div align="right">是否放入外网：</div>
      </td>
      <td width="34%" class="main"><small><font face="Verdana"> 
        <input type="radio" name="nw" value="是">
        是 
        <input type="radio" name="nw" value="否" checked>
        否 
        <input type="radio" name="nw" value="" checked>
        全部</font></small></td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="17%" class="main"> 
        <div align="right">输入时间(&gt;=)：</div>
      </td>
      <td width="35%" class="main"> 
        <input type="text" name="re_date1" size="16">
      </td>
      <td width="14%" class="main"> 
        <div align="right">输入时间(&lt;)</div>
      </td>
      <td width="34%" class="main"> 
        <input type="text" name="re_date2" size="16">
        (yyyy-mm-dd) </td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="17%" class="main"> 
        <div align="right">审核时间(&gt;=)</div>
      </td>
      <td width="35%" class="main"><small><font face="Verdana"> 
        <input type="text" name="check_date1" size="16">
        (yyyy-mm-dd) </font></small></td>
      <td width="14%" class="main"> 
        <div align="right">审核时间(&lt;)</div>
      </td>
      <td width="34%" class="main"> 
        <input type="text" name="check_date2" size="16">
        (yyyy-mm-dd) </td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="17%" class="main"> 
        <div align="right">推荐时间(&gt;=)</div>
      </td>
      <td width="35%" class="main"><small><font face="Verdana"> 
        <input type="text" name="tj_date1" size="16">
        (yyyy-mm-dd) </font></small></td>
      <td width="14%" class="main"> 
        <div align="right">推荐时间(&lt;)</div>
      </td>
      <td width="34%" class="main"> 
        <input type="text" name="tj_date2" size="16">
        (yyyy-mm-dd) </td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="17%" class="main"> 
        <div align="right">是否推荐：</div>
      </td>
      <td width="35%" class="main"> 
        <select name="if_tj">
          <option value="" selected>全部</option>
          <option value="是">是</option>
          <option value="否">否</option>
        </select>
      </td>
      <td width="14%" class="main"> 
        <div align="right">是否最新：</div>
      </td>
      <td width="34%" class="main"> 
        <select name="if_zx">
          <option value="" selected>全部</option>
          <option value="是">是</option>
          <option value="否">否</option>
        </select>
      </td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="17%" class="main"> 
        <div align="right">是否综合：</div>
      </td>
      <td width="35%" class="main"> 
        <select name="if_zh">
          <option value="" selected>全部</option>
          <option value="是">是</option>
          <option value="否">否</option>
        </select>
      </td>
      <td width="14%" class="main"> 
        <div align="right">是否公开：</div>
      </td>
      <td width="34%" class="main"> 
        <select name="if_mf">
          <option value="" selected>全部</option>
          <option value="是">是</option>
          <option value="否">否</option>
        </select>
      </td>
    </tr>
    <tr bgcolor="#FFFFFF">
      <td width="17%" class="main">
        <div align="right">操作人员：</div>
      </td>
      <td width="35%" class="main"><small><font face="Verdana"> 
        <select name="person">
          <option value=""  selected >全部</option>
          <%
          FOR I = 1 TO 24
          	%> 
          <option value="<%=RENSHU(I)%>" ><%=RENSHU(I)%></option>
          <%
			NEXT
          %> 
          <option value="<%=Request.Cookies ("USER_NAME")%>" >自己</option>
        </select>
        </font></small></td>
      <td width="14%" class="main"> 
        <div align="right">文章编号：</div>
      </td>
      <td width="34%" class="main"><small><font face="Verdana">
        <input type="text" name="s_article_no" size="30">
        </font></small></td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="17%" class="main"> 
        <div align="right">是否特别报道：</div>
      </td>
      <td width="35%" class="main"><small><font face="Verdana"> 
        <select name="iffy">
          <option value="" selected>全部</option>
          <option value="是">是</option>
          <option value="否">否</option>
        </select>
        </font></small></td>
      <td width="14%" class="main"> 
        <div align="right">经济： </div>
      </td>
      <td width="34%" class="main"><small><font face="Verdana">
        <input type="text" name="econnmy" size="30">
        </font></small> </td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td colspan="4"> 
        <div align="center"><br>
          <input type="submit" name="search" value="进行查询" >
          <input type="reset" name="Submit2" value="重填信息">
          <input type="submit" name="home" value="返回主页">
        </div>
      </td>
  </table>
</form>
</body>
</html>
