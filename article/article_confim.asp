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
      alert("审核时间必须填写,不影响结果");
      document.un.check_date.focus();
      return false;
   }


	 if( document.un.tj_date.value.length <1) {
      alert("特别推荐的时间必须填写,如果不文章不是特别推荐,不产生影响");
      document.un.tj_date.focus();
      return false;
   }
	
}
</script>
<html>
<head>
<title>内容与文章系统审核</title>
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
  <p><font color="#0000FF" class="main">（内部资料系统管理）内容与文章系统审核</font></p>
</div>
<hr size="0" width="600">
<form method="POST" action="article_confim_up.asp" name="un"  >
  <input type=hidden name=info_no value="<%=rs("info_no")%>">
  <input type=hidden name=if_nw value="<%=rs("info_type")%>">
  <input type=hidden name=s_article_no value="<%=rs("s_article_no")%>">
  <input type=hidden name=request_no value="<%=request("request_no")%>">
  <table width="506" border="1" align="center" bordercolor="#000000" bordercolorlight="#FFFFFF" cellspacing="0" cellpadding="5" class="main">
    <tr> 
      <td colspan="4"><font color="#0000FF">审核记录，请确信您已经仔细的阅读了该篇文章</font></td>
    </tr>
    <tr> 
      <td width="74">文章标题：</td>
      <td colspan="3"><%=rs("info_title")%></td>
    </tr>
    <tr> 
      <td width="74">操作人员：</td>
      <td colspan="3"><%=rs("person")%></td>
    </tr>
    <tr> 
      <td width="74">目前状态：</td>
      <td colspan="3"><%
      IF CDBL(RS("INFO_CHECK")) = CDBL(Request.Cookies ("PRVI")) THEN
      Response.Write "您已经确认过了"
      ELSE
      Response.Write "您目前还没有确认"
      END IF
      %></td>
    </tr>
    <tr> 
      <td width="74">最新资讯：</td>
      <td colspan="3"><%
      IF RS("IF_ZX") = "是" THEN
      %> 
        <input type="radio" name="if_zx" value="是" checked>
        是 
        <input type="radio" name="if_zx" value="否">
        否 <%
       ELSE
       %> 
        <input type="radio" name="if_zx" value="是">
        是 
        <input type="radio" name="if_zx" value="否" checked>
        否 <%
       END IF
       %> </td>
    </tr>
    <tr> 
      <td width="74">特别推荐：</td>
      <td colspan="3"><%
      IF RS("IF_TJ") = "是" THEN
      %> 
        <input type="radio" name="if_tj" value="是" checked>
        是 
        <input type="radio" name="if_tj" value="否">
        否 <%
       ELSE
       %> 
        <input type="radio" name="if_tj" value="是">
        是 
        <input type="radio" name="if_tj" value="否" checked>
        否 <%
       END IF
       %> </td>
    </tr>
    <tr> 
      <td width="74">综合报道：</td>
      <td colspan="3"><%
      IF RS("IF_ZH") = "是" THEN
      %> 
        <input type="radio" name="if_zh" value="是" checked>
        是 
        <input type="radio" name="if_zh" value="否">
        否 <%
       ELSE
       %> 
        <input type="radio" name="if_zh" value="是">
        是 
        <input type="radio" name="if_zh" value="否" checked>
        否 <%
       END IF
       %> </td>
    </tr>
    <tr> 
      <td width="74">结果：</td>
      <td width="114"> 
        <select name="prvi">
          <option value="通过" selected>通过</option>
          <option value="修改">修改</option>
          <option value="取消">取消</option>
        </select>
      </td>
      <td width="64"> 
        <div align="right">推荐顺序：</div>
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
        （0放在最后，9放在第一条） </td>
    </tr>
    <tr> 
      <td width="74">其它栏目：</td>
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
        （0放在最后，9放在第一条）</td>
    </tr>
    <tr> 
      <td width="74">审核日期：</td>
      <td colspan="3"> 
        <input type="text" name="check_date" size="20" value="<%=check_date%>">
        （最新资讯） <font color=red>请不要删除时间</font></td>
    </tr>
    <tr> 
      <td width="74">推荐日期：</td>
      <td colspan="3"> 
        <input type="text" name="tj_date" size="20" value="<%=tj_date%>">
        （特别推荐） </td>
    </tr>
    <tr> 
      <td width="74">审核意见：</td>
      <td colspan="3"> 
        <textarea name="request_desc_n" cols="50" rows="4"></textarea>
      </td>
    </tr>
    <tr> 
      <td width="74">以前意见：</td>
      <td colspan="3"> 
        <textarea name="request_desc" cols="50" rows="4"><%=DISPLAY_NAME("REQUEST",REQUEST("INFO_NO"),"INFO_NO","REQUEST_DESC")%></textarea>
      </td>
    </tr>
    <tr> 
      <td width="74">是否公开：</td>
      <td width="114"> <%
      IF RS("IF_MF") = "是" THEN
      %> 
        <input type="radio" name="if_mf" value="是" checked>
        是 
        <input type="radio" name="if_mf" value="否">
        否 <%
       ELSE
       %> 
        <input type="radio" name="if_mf" value="是">
        是 
        <input type="radio" name="if_mf" value="否" checked>
        否 <%
       END IF
       %> </td>
      <td width="64">是否清空：</td>
      <td width="204">
        <input type="radio" name="if_qk" value="是">
        是 
        <input type="radio" name="if_qk" value="否" checked>
        否</td>
    </tr>
    <tr> 
      <td colspan="4"><font color="#FF0000">如果已经审核过了，审核的日期不会发生变化</font></td>
    </tr>
    <td colspan="4"> 
      <div align="center"> 
        <input type="submit" name="send" value="进行确定" onClick="return checkIn();">
        <input type="button" name="Button" value="关闭窗口" onClick=self.close();>
      </div>
    </td>
    </tr>
  </table>
</form>
</body>
</html>
