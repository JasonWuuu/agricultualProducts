<!-- #include virtual = "/include/mylib1105.asp" -->

<!-- #include virtual = "/include/auth.asp" -->
<!-- #include virtual = "/include/wsql.asp" -->

 <%
 
	'作者：马洪岩  于 2002-4-21 编写
	'功能：增加文章
	'操作：本脚本操作人员操作
 '判断级别
 
	set CONN = Server.CreateObject("ADODB.Connection")
    CONN.open CONNSTR,"",""  
	set RS = Server.CreateObject("ADODB.RecordSet")
	set RS1 = Server.CreateObject("ADODB.RecordSet")
	set RSLIB = Server.CreateObject("ADODB.RecordSet")
'	IF Request.Cookies ("PRVI") <> 0 THEN
'	Response.Write "对不起，您只能进行审核，请使用您增加内容的帐号进行登录，谢谢"
'	Response.End 
'	END IF
	
	%> 
<html>
<head>
<title>文章增加</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<style type="text/css">
<!--
.main {  font-size: 9pt}
-->
</style>
<script src="https://cdn.bootcss.com/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdn.bootcss.com/jqueryui/1.12.1/jquery-ui.min.js"></script>
<link href="https://cdn.bootcss.com/jqueryui/1.12.1/jquery-ui.css" rel="stylesheet">
<script src="https://cdn.bootcss.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
<link href="https://cdn.bootcss.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet">

<script type="text/javascript" charset="utf-8" src="./ueditor/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="./ueditor/ueditor.all.min.js"> </script>
<!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
<!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
<script type="text/javascript" charset="utf-8" src="./ueditor/lang/zh-cn/zh-cn.js"></script>

<script src="./ueditor/index_ueditor.js"></script>
<script src="./ueditor/index_135editor.js"></script>
<script src="./ueditor/index_135editor_styles.js"></script>
<script src="./ueditor/index_135editor_htmlParsersList.js"></script>
<script src="./ueditor/index_135editor_systemTemplates.js"></script>
<script src="./ueditor/templateCategory.js"></script>
<script src="./ueditor/index_135editor_draft.js"></script>
<script src="./js/dom-to-image.js"></script>
<script src="./js/article_add.js"></script>
<link href="./article_add.css" rel="stylesheet">
</head>

<body bgcolor="#FFFFFF">
<script language="javascript">
function GoToURL()
{
  
  var tURL= "article_add.asp?b_id="+document.un.b_id.options[document.un.b_id.selectedIndex].value;
  var tURL1= "&state="+document.un.state.options[document.un.state.selectedIndex].value;
  var tURL3= "&class_no="+document.un.class_no.options[document.un.class_no.selectedIndex].value;
  var tURL2= "&p_class_no="+document.un.p_class_no.options[document.un.p_class_no.selectedIndex].value;
  var tURL4= "&s_id="+document.un.s_id.options[document.un.s_id.selectedIndex].value;
  document.location=tURL+tURL1+tURL3+tURL4+tURL2;
}
</script>
<script language="javascript">
function retable()
{
  	document.un.check_date.value="";

}
</script>
<%
if hour(now()) < 21 then
%> 
<script language="javascript">
function retable1()
{
  today=new Date(); 
  my_month = today.getMonth()+1;
 document.un.check_date.value="2017-"+my_month+"-"+today.getDate();
 //document.un.check_date.value=today.getYear();
  }
</script>
<%
ELSE
%> 
<script language="javascript">
function retable1()
{
  yx_date="<%=DATE()+1%>";
  
  document.un.check_date.value=yx_date;
  }
</script>
<%
END IF
%> 
<script language="javascript">

var lsdz = "";
function checkIn()
{
     if( document.un.b_id.options[document.un.b_id.selectedIndex].value <1) {
      alert("大类别必须选择");
      document.un.b_id.focus();
      return false;
   }
    
     if( document.un.p_class_no.options[document.un.p_class_no.selectedIndex].value <1) {
      alert("网站的总栏目必须选择（内网也要选择）");
      document.un.p_class_no.focus();
      return false;
   }
    
    if( document.un.class_no.options[document.un.class_no.selectedIndex].value <1) {
      alert("网站的分栏目必须选择（内网也要选择）");
      document.un.class_no.focus();
      return false;
   }
   
    if( document.un.info_title.value.length <1) {
      alert("标题必须填写");
      document.un.info_title.focus();
      return false;
   }


	 if( document.un.s_article_no.value.length <1) {
      alert("文章编号必须选择");
      document.un.s_article_no.focus();
      return false;
   }
	
	if( document.un.author.value.length <1) {
      alert(" 作者或编写必须选择");
      document.un.author.focus();
      return false;
   }
	
	if( document.un.x_article_no.value.length <1) {
      alert("手机网简介必须填写少于100个字符");
      document.un.x_article_no.focus();
      return false;
   }
	
	if( document.un.info_corre.value.length <1) {
      alert("相关查询字符必须填写，一个系列的文章，字符相同，可以用文字代替，例如：玉米市场综合快报");
      document.un.info_corre.focus();
      return false;
   }
    
	 if( document.un.info_corre.value=='玉米') {
      alert("相关字符不符合要求，范围太广，例如：玉米市场综合快报");
      document.un.info_corre.focus();
      return false;
   }
	
	 if( document.un.info_corre.value=='大豆') {
      alert("相关字符不符合要求，范围太广，例如：大豆市场综合快报");
      document.un.info_corre.focus();
      return false;
   }
	
	if( document.un.info_corre.value=='豆粕') {
      alert("相关字符不符合要求，范围太广，例如：豆粕市场综合快报");
      document.un.info_corre.focus();
      return false;
   }
	
	if( document.un.info_corre.value=='鱼粉') {
      alert("相关字符不符合要求，范围太广，例如：鱼粉市场综合快报");
      document.un.info_corre.focus();
      return false;
   }
	
		if( document.un.info_corre.value=='油脂') {
      alert("相关字符不符合要求，范围太广，例如：油脂市场综合快报");
      document.un.info_corre.focus();
      return false;
   }
	
			if( document.un.info_corre.value=='小麦') {
      alert("相关字符不符合要求，范围太广，例如：小麦市场综合快报");
      document.un.info_corre.focus();
      return false;
   }
	
	if( document.un.info_corre.value=='养殖') {
      alert("相关字符不符合要求，范围太广，例如：养殖市场综合快报");
      document.un.info_corre.focus();
      return false;
   }
	
		
	if( document.un.info_corre.value=='饲料') {
      alert("相关字符不符合要求，范围太广，例如：饲料市场综合快报");
      document.un.info_corre.focus();
      return false;
   }
	
			
	if( document.un.info_corre.value=='肉骨粉') {
      alert("相关字符不符合要求，范围太广，例如：肉骨粉市场综合快报");
      document.un.info_corre.focus();
      return false;
   }
	
	if( document.un.info_corre.value=='高粱') {
      alert("相关字符不符合要求，范围太广，例如：高粱市场综合快报");
      document.un.info_corre.focus();
      return false;
   }
	
		if( document.un.info_corre.value=='大麦') {
      alert("相关字符不符合要求，范围太广，例如：大麦市场综合快报");
      document.un.info_corre.focus();
      return false;
   }
	
			if( document.un.info_corre.value=='马铃薯') {
      alert("相关字符不符合要求，范围太广，例如：马铃薯市场综合快报");
      document.un.info_corre.focus();
      return false;
   }
	
		if( document.un.info_corre.value=='苜蓿草') {
      alert("相关字符不符合要求，范围太广，例如：苜蓿草市场综合快报");
      document.un.info_corre.focus();
      return false;
   }
	
			if( document.un.info_corre.value=='苜蓿草') {
      alert("相关字符不符合要求，范围太广，例如：苜蓿草市场综合快报");
      document.un.info_corre.focus();
      return false;
   }
				if( document.un.info_corre.value=='玉米蛋白粉') {
      alert("相关字符不符合要求，范围太广，例如：玉米蛋白粉市场综合快报");
      document.un.info_corre.focus();
      return false;
   }
	
				if( document.un.info_corre.value=='DDGS') {
      alert("相关字符不符合要求，范围太广，例如：DDGS市场综合快报");
      document.un.info_corre.focus();
      return false;
   }
	
			if( document.un.info_corre.value=='菜油') {
      alert("相关字符不符合要求，范围太广，例如：菜油市场综合快报");
      document.un.info_corre.focus();
      return false;
   }
				if( document.un.info_corre.value=='豆油') {
      alert("相关字符不符合要求，范围太广，例如：豆油市场综合快报");
      document.un.info_corre.focus();
      return false;
   }
			if( document.un.info_corre.value=='菜粕') {
      alert("相关字符不符合要求，范围太广，例如：菜粕市场综合快报");
      document.un.info_corre.focus();
      return false;
   }
				if( document.un.info_corre.value=='棉粕') {
      alert("相关字符不符合要求，范围太广，例如：棉粕市场综合快报");
      document.un.info_corre.focus();
      return false;
   }
		if( document.un.info_corre.value=='氨基酸') {
      alert("相关字符不符合要求，范围太广，例如：氨基酸市场综合快报");
      document.un.info_corre.focus();
      return false;
   }
		if( document.un.info_corre.value=='蛋氨酸') {
      alert("相关字符不符合要求，范围太广，例如：蛋氨酸市场综合快报");
      document.un.info_corre.focus();
      return false;
   }
	
	
   if(confirm("你现在要提交吗?"))
      return true
   else
      return false;
}
</script>
<div align="center"><font color="#0000FF" class="main">（内部资料系统管理）内容与文章系统增加 </font></div>
<hr>
<form method="POST" action="article_save.asp" name="un">
  <table width="653" border="0" bordercolordark="#99CCFF" bordercolorlight="#99CCFF" cellspacing="1" align="center" cellpadding="6" bgcolor="#000000">
    <tr bgcolor="#FFFFFF"> 
      <td width="21%" class="main">大类别：</td>
      <td width="79%" class="main"> 
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
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="21%" class="main">小类别：</td>
      <td width="79%" class="main"> 
        <select name="s_id">
          <option value="">小类别</option>
          <%
			IF REQUEST("B_ID") <> "" THEN
			SQL = "SELECT * FROM S_SHORT WHERE B_ID = '" & REQUEST("B_ID") & "'"
			RS1.Open SQL,CONN,adOpenKeyset ,adLockReadOnly
				DO WHILE NOT RS1.EOF 
				IF REQUEST("S_ID") = RS1("S_ID") THEN
			%> 
          <option value="<%=RS1("S_ID")%>" SELECTED><%=RS1("C_NAME")%>-<%=rs1("img_path") %></option>
          <%
			END IF
        		%> 
          <option value="<%=RS1("S_ID")%>"><%=RS1("C_NAME")%>-<%=rs1("img_path") %></option>
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
      <td width="21%" class="main">产地：</td>
      <td width="79%" class="main"> 
        <select name="state">
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
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="21%" class="main">网站总栏目：</td>
      <td width="79%" class="main"> 
        <select name="p_class_no" onChange="GoToURL()">
          <option value="">网站总栏目</option>
          <%
        SQL = "SELECT * FROM P_CLASS"
        RS1.OPEN SQL,CONN,1,1
        DO WHILE NOT RS1.EOF 
        IF Request("p_class_no") = rs1("p_class_no") Then
        %>
        <option value="<%=RS1("p_class_no")%>" SELECTED><%=RS1("p_class_NAME")%>-<%=RS1("img_path") %></option>
        <%
        else
        %>
        <option value="<%=RS1("p_class_no")%>" ><%=RS1("p_class_NAME")%>-<%=RS1("img_path") %></option>
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
      <td width="21%" class="main">网站分栏目：</td>
      <td width="79%" class="main"> 
        <select name="class_no" onChange="GoToURL()">
          <option value="">网站分栏目</option>
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
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="21%" class="main">气象：</td>
      <td width="79%" class="main"><small><font face="Verdana"> 
        <input type="TEXT" name="climate" value="" size="40">
        </font></small></td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="21%" class="main">经济：</td>
      <td width="79%" class="main"> 
        <input type="text" name="econnmy" size="40">
      </td>
    </tr>
	 <tr bgcolor="#FFFFFF">
					<td width="21%" class="main"><font color=red>关于下面两栏说明：</font></td>
					<td width="79%" class="main">
						<font color=red>主要是针对市场快报的来源，不填写默认是“自己编写”，每日（15：00）会自动计算，产生报表，由专人抽查审核（本处只能增加，无法修改！）</font>
					</td>
				</tr>
				<tr bgcolor="#FFFFFF">
					<td width="21%" class="main">信息询问人：</td>
					<td width="79%" class="main"><input type="text" name="person_ly" size="40"><font color=red>（本条快报你问的是谁？）</font>
							
					</td>
				</tr>
				<tr bgcolor="#FFFFFF">
					<td width="21%" class="main">联系方式：</td>
					<td width="79%" class="main"><input type="text" name="fangshi_ly" size="40"><font color=red>（电话或MSN或QQ等要写详细的）</font>
						
					</td>
				</tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="21%" class="main">资料标题：</td>
      <td width="79%" class="main"><small><font face="Verdana"> 
        <input type="text" name="info_title" size="50">
        </font></small>
           <input type="radio" name="colorxz" checked value="">
            正常
             <input type="radio" name="colorxz" value="标红">
            标红</td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="21%" class="main">简介：</td>
      <td width="79%" class="main"> 
        <textarea name="info_desc" rows="10" cols="60"></textarea>
      </td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="21%" class="main">是否是HTML方式：</td>
      <td width="79%" class="main"> 
        <input type="radio" name="if_html" value="是">
        是 
        <input type="radio" name="if_html" value="否" checked>
        否 </td>
    </tr>
      <tr bgcolor="#FFFFFF"> 
      <td width="21%" class="main">查找字符串：</td>
      <td width="79%" class="main"> 
        <input type="text" name="info_find" size="30">
      
        <select name="info_find1">
        <option value="" selected>如果是期货请选择</option>
          <%
			SQL = "SELECT * FROM S_SHORT WHERE B_ID = '1019'"
			RS1.Open SQL,CONN,adOpenKeyset ,adLockReadOnly
				DO WHILE NOT RS1.EOF 
				%> 
          <option value="<%=RS1("S_ID")%>"><%=RS1("C_NAME")%></option>
          <%
				RS1.MoveNext 
				LOOP
			RS1.Close 
			%> 
        </select>
        （<font color=red>注意是期货请选</font>）
      </td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="21%" class="main"><font color=red>相关查询字符：</font></td>
      <td width="79%" class="main"><small> 
        <input type="text" name="info_corre" size="30">
        <span class="main"> （输入相关的关键字符）</span></small></td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="21%" class="main">资料来源：</td>
      <td width="79%" class="main"> 
        <input type="text" name="info_source" size="30">
      </td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="21%" class="main">作者： </td>
      <td width="79%" class="main"><small><font face="Verdana"> 
        <input type="text" name="author" size="20">
        </font></small></td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="21%" class="main">备注：</td>
      <td width="79%" class="main"><small><font face="Verdana"> 
        <input type="text" name="remark" size="50">
        </font></small></td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="21%" class="main">文章编号：</td>
      <td width="79%" class="main"> 
        <input type="text" name="s_article_no" size="30">
      </td>
    </tr>
	  <tr bgcolor="#FFFFFF"> 
      <td width="21%" class="main">手机图片：</td>
      <td width="79%" class="main"> 
		 <input type="text" name="s_pic" size="16"><font color=red>输入图片名称如果不输入系统默认图片库里随机分配本品种下的图片</font>
       </td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="21%" class="main">手机网简介：</td>
      <td width="79%" class="main"> 
		 <textarea name="x_article_no" rows="3" cols="60"></textarea>
       </td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="21%" class="main">是否放入外网：</td>
      <td width="79%" class="main"> 
        <input type="radio" name="nw" value="是" checked>
        是 
        <input type="radio" name="nw" value="否">
        否 </td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="21%" class="main">专题相关：</td>
      <td width="79%" class="main"> 
		<select name="ZT_NO">
        <option value="N" selected>专题选择</option>
        <%
				SQL1 = "SELECT * FROM SPECAIL "
				RS1.Open SQL1,CONN,adOpenKeyset ,adLockReadOnly
					DO WHILE NOT RS1.EOF 
            %>
				    <option value="<%=RS1("SPECAIL_NO")%>"><%=RS1("SPECAIL_NAME")%></option>
		           <%
					RS1.MoveNext 
					LOOP
					RS1.Close 
              %>
   </select>				  </td>
    </tr>
	 <tr bgcolor="#FFFFFF"> 
      <td width="21%" class="main">省份选择：</td>
		  <td width="79%" class="main">
		  	<select name="CITY">
       <option value="安徽" >安徽</option>
		 <option value="北京" >北京</option>
		 <option value="福建">福建</option>
		 <option value="甘肃">甘肃</option>
		 <option value="广东" >广东</option>
		 <option value="广西" >广西</option>
		 <option value="贵州" >贵州</option>
		 <option value="海南" >海南</option>
		 <option value="河北" >河北</option>
		 <option value="河南" >河南</option>
		 <option value="黑龙江" >黑龙江</option>
		 <option value="湖北" >湖北</option>
		 <option value="湖南" >湖南</option>
		 <option value="吉林" >吉林</option>
		 <option value="江苏" >江苏</option>
		 <option value="江西" >江西</option>
		 <option value="辽宁" >辽宁</option>
		 <option value="内蒙古" >内蒙古</option>
		 <option value="宁夏" >宁夏</option>
		 <option value="青海" >青海</option>
		 <option value="山东" >山东</option>
		 <option value="山西" >山西</option>
		 <option value="陕西" >陕西</option>
		 <option value="上海" >上海</option>
		 <option value="四川" >四川</option>
		 <option value="天津" >天津</option>
		 <option value="西藏" >西藏</option>
		 <option value="新疆" >新疆</option>
		 <option value="云南" >云南</option>
		 <option value="浙江" >浙江</option>
		 <option value="重庆" >重庆</option>
		 <option value="其他"  selected>其他</option>
	
      
   </select>				  </td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="21%" class="main" height="80">相关类别：</td>
      <td width="79%" class="main" height="80"> 
        <table width="100%" border="1" cellspacing="0" cellpadding="3" class="main" bordercolor="#000000" bordercolordark="#FFFFFF" bordercolorlight="#000000">
          <tr> 
            <td width="12%"><font color="#0000FF">世界经济</font></td>
            <td width="88%"> 
            <%
				SQL1 = "SELECT * FROM S_CLASS WHERE P_CLASS_NO = '990002'"
				RS1.Open SQL1,CONN,adOpenKeyset ,adLockReadOnly
					DO WHILE NOT RS1.EOF 
            %>
			  <input type="checkbox" name="sjjj" value="<%=RS1("CLASS_NO")%>"  ID="Checkbox1"><%=RS1("CLASS_NAME")%>
              <%
					RS1.MoveNext 
					LOOP
					RS1.Close 
              %>
               </td>
          </tr>
          <tr> 
            <td width="12%"><font color="#0000FF">各国农业</font></td>
            <td width="88%"> 
               <%
				SQL1 = "SELECT * FROM S_CLASS WHERE P_CLASS_NO = '990010'"
				RS1.Open SQL1,CONN,adOpenKeyset ,adLockReadOnly
					DO WHILE NOT RS1.EOF 
            %>
			  <input type="checkbox" name="ggny" value="<%=RS1("CLASS_NO")%>"  ID="Checkbox2"><%=RS1("CLASS_NAME")%>
              <%
					RS1.MoveNext 
					LOOP
					RS1.Close 
              %></td>
          </tr>
          <tr> 
            <td width="12%"><font color="#0000FF">饲料养殖</font></td>
            <td width="88%"> 
              <%
				SQL1 = "SELECT * FROM S_CLASS WHERE P_CLASS_NO = '990012'"
				RS1.Open SQL1,CONN,adOpenKeyset ,adLockReadOnly
					DO WHILE NOT RS1.EOF 
            %>
			  <input type="checkbox" name="slyz" value="<%=RS1("CLASS_NO")%>"  ID="Checkbox3"><%=RS1("CLASS_NAME")%>
              <%
					RS1.MoveNext 
					LOOP
					RS1.Close 
              %> </td>
          </tr>
          <tr> 
            <td width="12%"><font color="#0000FF">气象预报</font></td>
            <td width="88%"> 
              <%
				SQL1 = "SELECT * FROM S_CLASS WHERE P_CLASS_NO = '990005'"
				RS1.Open SQL1,CONN,adOpenKeyset ,adLockReadOnly
					DO WHILE NOT RS1.EOF 
            %>
			  <input type="checkbox" name="qxyb" value="<%=RS1("CLASS_NO")%>"  ID="Checkbox4"><%=RS1("CLASS_NAME")%>
              <%
					RS1.MoveNext 
					LOOP
					RS1.Close 
              %> </td>
          </tr>
          <tr> 
            <td width="12%"><font color="#0000FF">港口海关</font></td>
            <td width="88%"> 
              <%
				SQL1 = "SELECT * FROM S_CLASS WHERE P_CLASS_NO = '990013'"
				RS1.Open SQL1,CONN,adOpenKeyset ,adLockReadOnly
					DO WHILE NOT RS1.EOF 
            %>
			  <input type="checkbox" name="gkhg" value="<%=RS1("CLASS_NO")%>"  ID="Checkbox5"><%=RS1("CLASS_NAME")%>
              <%
					RS1.MoveNext 
					LOOP
					RS1.Close 
              %> </td>
          </tr>
          <tr> 
            <td width="12%"><font color="#0000FF">统计资料</font></td>
            <td width="88%"> 
              <%
				SQL1 = "SELECT * FROM S_CLASS WHERE P_CLASS_NO = '990016'"
				RS1.Open SQL1,CONN,adOpenKeyset ,adLockReadOnly
					DO WHILE NOT RS1.EOF 
            %>
			  <input type="checkbox" name="tjzl" value="<%=RS1("CLASS_NO")%>"  ID="Checkbox6"><%=RS1("CLASS_NAME")%>
              <%
					RS1.MoveNext 
					LOOP
					RS1.Close 
              %>  </td>
          </tr><tr> 
            <td width="12%"><font color="#0000FF">价格趋势</font></td>
            <td width="88%"> 
              <%
				SQL1 = "SELECT * FROM S_CLASS WHERE P_CLASS_NO = '990004'"
				RS1.Open SQL1,CONN,adOpenKeyset ,adLockReadOnly
					DO WHILE NOT RS1.EOF 
            %>
			  <input type="checkbox" name="jgqs" value="<%=RS1("CLASS_NO")%>"  ID="Checkbox7"><%=RS1("CLASS_NAME")%>
              <%
					RS1.MoveNext 
					LOOP
					RS1.Close 
              %> 
               </td>
          </tr>
          <tr> 
            <td width="12%"><font color="#0000FF">政策动态</font></td>
            <td width="88%"> 
              <%
				SQL1 = "SELECT * FROM S_CLASS WHERE P_CLASS_NO = '990014'"
				RS1.Open SQL1,CONN,adOpenKeyset ,adLockReadOnly
					DO WHILE NOT RS1.EOF 
            %>
			  <input type="checkbox" name="zcdt" value="<%=RS1("CLASS_NO")%>"  ID="Checkbox8"><%=RS1("CLASS_NAME")%>
              <%
					RS1.MoveNext 
					LOOP
					RS1.Close 
              %>  </td>
          </tr>
          <tr> 
            <td width="12%"><font color="#0000FF">综合资讯</font></td>
            <td width="88%"> 
              <%
				SQL1 = "SELECT * FROM S_CLASS WHERE P_CLASS_NO = '990015'"
				RS1.Open SQL1,CONN,adOpenKeyset ,adLockReadOnly
					DO WHILE NOT RS1.EOF 
            %>
			  <input type="checkbox" name="zhzx" value="<%=RS1("CLASS_NO")%>"  ID="Checkbox9"><%=RS1("CLASS_NAME")%>
              <%
					RS1.MoveNext 
					LOOP
					RS1.Close 
              %> </td>
          </tr>
          <tr> 
            <td width="12%"><font color="#0000FF">品种频道</font></td>
            <td width="88%"> 
             <%
				SQL1 = "SELECT * FROM S_CLASS WHERE P_CLASS_NO = '990001'"
				RS1.Open SQL1,CONN,adOpenKeyset ,adLockReadOnly
					DO WHILE NOT RS1.EOF 
            %>
			  <input type="checkbox" name="pzpd" value="<%=RS1("CLASS_NO")%>"  ID="Checkbox10"><%=RS1("CLASS_NAME")%>
              <%
					RS1.MoveNext 
					LOOP
					RS1.Close 
              %> </td>
          </tr>
          <tr> 
            <td width="12%"><font color="#0000FF">行业动态</font></td>
            <td width="88%"> 
              <%
				SQL1 = "SELECT * FROM S_CLASS WHERE P_CLASS_NO = '990026'"
				RS1.Open SQL1,CONN,adOpenKeyset ,adLockReadOnly
					DO WHILE NOT RS1.EOF 
            %>
			  <input type="checkbox" name="hydt" value="<%=RS1("CLASS_NO")%>"  ID="Checkbox11"><%=RS1("CLASS_NAME")%>
              <%
					RS1.MoveNext 
					LOOP
					RS1.Close 
              %>  </td>
          </tr>
          <tr> 
            <td width="12%"><font color="#0000FF">期货百家</font></td>
            <td width="88%"> 
              <%
				SQL1 = "SELECT * FROM S_CLASS WHERE P_CLASS_NO = '990018'"
				RS1.Open SQL1,CONN,adOpenKeyset ,adLockReadOnly
					DO WHILE NOT RS1.EOF 
            %>
			  <input type="checkbox" name="qhbj" value="<%=RS1("CLASS_NO")%>"  ID="Checkbox12"><%=RS1("CLASS_NAME")%>
              <%
					RS1.MoveNext 
					LOOP
					RS1.Close 
              %> 
            
             </td>
          </tr>
          <tr> 
            <td width="12%"><font color="#0000FF">汇易图表</font></td>
            <td width="88%"> 
             <%
				SQL1 = "SELECT * FROM S_CLASS WHERE P_CLASS_NO = '990023'"
				RS1.Open SQL1,CONN,adOpenKeyset ,adLockReadOnly
					DO WHILE NOT RS1.EOF 
            %>
			  <input type="checkbox" name="spzs" value="<%=RS1("CLASS_NO")%>"  ID="Checkbox13"><%=RS1("CLASS_NAME")%>
              <%
					RS1.MoveNext 
					LOOP
					RS1.Close 
              %> 
             </td>
          </tr>
          <tr> 
            <td width="12%"><font color="#0000FF">行业报告</font></td>
            <td width="88%"> 
             <%
				SQL1 = "SELECT * FROM S_CLASS WHERE P_CLASS_NO = '990022'"
				RS1.Open SQL1,CONN,adOpenKeyset ,adLockReadOnly
					DO WHILE NOT RS1.EOF 
            %>
			  <input type="checkbox" name="zztz" value="<%=RS1("CLASS_NO")%>"  ID="Checkbox14"><%=RS1("CLASS_NAME")%>
              <%
					RS1.MoveNext 
					LOOP
					RS1.Close 
              %> 
             </td>
          </tr>
          <tr> 
            <td width="12%"><font color="#0000FF">运费基差</font></td>
            <td width="88%"> 
             <%
				SQL1 = "SELECT * FROM S_CLASS WHERE P_CLASS_NO = '990021'"
				RS1.Open SQL1,CONN,adOpenKeyset ,adLockReadOnly
					DO WHILE NOT RS1.EOF 
            %>
			  <input type="checkbox" name="yfjc" value="<%=RS1("CLASS_NO")%>"  ID="Checkbox15"><%=RS1("CLASS_NAME")%>
              <%
					RS1.MoveNext 
					LOOP
					RS1.Close 
              %> 
             </td>
          </tr>
			  <tr> 
            <td width="12%"><font color="#0000FF">汇易资讯</font></td>
            <td width="88%"> 
             <%
				SQL1 = "SELECT * FROM S_CLASS WHERE P_CLASS_NO = '990027'"
				RS1.Open SQL1,CONN,adOpenKeyset ,adLockReadOnly
					DO WHILE NOT RS1.EOF 
            %>
			  <input type="checkbox" name="hyzx" value="<%=RS1("CLASS_NO")%>"  ID="Checkbox15"><%=RS1("CLASS_NAME")%>
              <%
					RS1.MoveNext 
					LOOP
					RS1.Close 
              %> 
             </td>
          </tr>
			 <tr> 
            <td width="12%"><font color="#0000FF">市场利润</font></td>
            <td width="88%"> 
             <%
				SQL1 = "SELECT * FROM S_CLASS WHERE P_CLASS_NO = '990028'"
				RS1.Open SQL1,CONN,adOpenKeyset ,adLockReadOnly
					DO WHILE NOT RS1.EOF 
            %>
			  <input type="checkbox" name="sclr" value="<%=RS1("CLASS_NO")%>"  ID="Checkbox15"><%=RS1("CLASS_NAME")%>
              <%
					RS1.MoveNext 
					LOOP
					RS1.Close 
              %> 
             </td>
          </tr>
			 <tr> 
            <td width="12%"><font color="#0000FF">政府统计</font></td>
            <td width="88%"> 
             <%
				SQL1 = "SELECT * FROM S_CLASS WHERE P_CLASS_NO = '990029'"
				RS1.Open SQL1,CONN,adOpenKeyset ,adLockReadOnly
					DO WHILE NOT RS1.EOF 
            %>
			  <input type="checkbox" name="zftj" value="<%=RS1("CLASS_NO")%>"  ID="Checkbox15"><%=RS1("CLASS_NAME")%>
              <%
					RS1.MoveNext 
					LOOP
					RS1.Close 
              %> 
             </td>
          </tr>
        </table>
      </td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="21%" class="main">是否需要审核：</td>
      <td width="79%" class="main"> 
        <input type="radio" name="ifsh" value="是" onClick=retable();>
        是 
        <input type="radio" name="ifsh" value="否" onClick=retable1(); checked>
        否 &nbsp;<font color=red>如果不需要审核，请输入审核时间：</font> <%if hour(now()) < 21 then%> 
        <input type="text" name="check_date" size="16" value="<%=date%>">
        <%
         else
			week_day = weekday(date)
			if week_day = 6 then
         %> 
        <input type="text" name="check_date" size="16" value="<%=date()+3%>">
        <%
			else
         %> 
        <input type="text" name="check_date" size="16" value="<%=date()+1%>">
        <%
			end if
         end if
         %> </td>
    </tr>
       <tr bgcolor="#FFFFFF"> 
      <td width="21%" class="main">是否综合报道：</td>
      <td width="79%" class="main"> 
        <input type="radio" name="ifzh" value="是" >
        是 
        <input type="radio" name="ifzh" value="否" checked>
        否 </td>
    </tr>
    
    <tr bgcolor="#FFFFFF"> 
      <td width="21%" class="main">特别推荐的时间：</td>
      <td width="79%" class="main">如果推荐，请输入推荐时间： <%if hour(now()) < 21 then%> 
        <input type="text" name="tbtj_date" size="16" value="<%=date%>">
        <%
         else
			week_day = weekday(date)
			if week_day = 6 then
         %> 
        <input type="text" name="tbtj_date" size="16" value="<%=date()+3%>">
        <%
			else
         %> 
        <input type="text" name="tbtj_date" size="16" value="<%=date()+1%>">
        <%
			end if
         end if
         %> &nbsp;</td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="21%" class="main"><font color="#0000FF">是否特别推荐：</font></td>
      <td width="79%" class="main"> 
        <input type="radio" name="if_zj" value="是" >
        是 
        <input type="radio" name="if_zj" value="否" checked>
        否 （<font color="#FF0000">当天特别推荐的位置</font>）</td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="21%" class="main"><font color="#0000FF">是否（<font color=red>当前要闻</font>）：</font></td>
      <td width="79%" class="main"> 
        <input type="radio" name="if_mf" value="是" >
        是 
        <input type="radio" name="if_mf" value="否" checked>
        否 （<font color="#FF0000"> 当天滚动的位置</font>）</td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="21%" class="main"><font color=red>是否免费</font></td>
      <td width="79%" class="main"> 
        <input type="radio" name="if_zk" value="是">
        是 
        <input type="radio" name="if_zk" value="否"  checked>
        否 （<font color=red>不需要密码就可以浏览</font>）</td>
    </tr>
	 <tr bgcolor="#FFFFFF"> 
      <td width="21%" class="main"><font color="#0000FF">是否置顶：</font></td>
      <td width="79%" class="main"> 
        <input type="radio" name="if_zd" value="是">
        是 
        <input type="radio" name="if_zd" value="否"  checked>
        否 （  <select name="zd_date">
       <option value="5" selected>5天</option>
        <option value="10">10天</option>
<option value="15">15天</option>
<option value="20">20天</option>
<option value="25">25天</option>
<option value="30">30天</option>
        </select>）</td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="21%" class="main"><font color="#0000FF">品种相关：</font></td>
      <td width="79%" class="main"> 
		<%
			SQL = "SELECT * FROM B_SHORT"
			RS1.Open SQL,CONN,adOpenKeyset ,adLockReadOnly
				DO WHILE NOT RS1.EOF 
				%>
				<input type="checkbox" name="mypzxg" value="<%=RS1("B_ID")%>"  ><%=RS1("C_NAME")%>
				<%
				RS1.MoveNext 
				LOOP
			RS1.Close 
		%><p></p>
		<%
			SQL = "SELECT * FROM S_SHORT where b_id <>'1019'"
			RS1.Open SQL,CONN,adOpenKeyset ,adLockReadOnly
				DO WHILE NOT RS1.EOF 
				%>
				<input type="checkbox" name="mypzxg" value="<%=RS1("S_ID")%>" ID="Check1"><%=RS1("C_NAME")%>
				<%
				RS1.MoveNext 
				LOOP
			RS1.Close 
		%>
      </td>
    </tr>
	 <tr bgcolor="#FFFFFF"> 
      <td width="21%" class="main"><font color="#0000FF">文章权限：</font></td>
      <td width="79%" class="main"> 
        <select name="jibie">
       <option value="0" selected>0</option>
        <option value="1">1</option>
<option value="2">2</option>
<option value="3">3</option>
<option value="4">4</option>
        </select>
		  0为网络级别，3为咨询级别，4顾问级别
		  </td>
    </tr>
	  <tr bgcolor="#FFFFFF"> 
      <td width="21%" class="main"><font color="red">费用：</font></td>
      <td width="79%" class="main"> 
        <select name="fee">
		  <option value="0.5">0.5</option>
		  <option value="1">1</option>
		  <option value="2">2</option>
		  <option value="3">3</option>
		  <option value="4">4</option>
		  <option value="5">5</option>
      <option value="6">6</option>
      <option value="7">7</option>
          <option value="8">8</option>
          <option value="9">9</option>
          <option value="10">10</option>
         <option value="15">15</option>
			<option value="20">20</option>
			<option value="25">25</option>
			<option value="30">30</option>
			<option value="35">35</option>
			<%
			'查询基本费用
			SQL = "SELECT TOP 1 PLATE FROM S_CLASS WHERE IMG_PATH='新' AND CLASS_NO='" & Request("class_no") & "'"
				RS.Open SQL,CONN,1,1
					IF RS.RecordCount >0 THEN
					%>
					<option value="<%=RS("PLATE")%>" selected><%=RS("PLATE")%></option>
					<%
					END IF
				RS.CLOSE 
			%>
        </select>
      </td>
    </tr>
	 
    <tr bgcolor="#FFFFFF"> 
      <td colspan="2"> 
        <div align="center"><br>
          <input type="submit" name="Submit" value="提交申请" onClick="return checkIn();">
          <input type="reset" name="Submit2" value="重填信息">
          <input type="button" name="home" value="返    回" onClick=history.back();>
        </div>
      </td>
  </table>
</form>
<!-- Show the cropped image in modal -->
    <div class="modal fade docs-cropped" id="myNewStyleEditor" aria-hidden="true" aria-labelledby="getCroppedCanvasTitle"
        role="dialog" tabindex="-1" style="z-index:500;">
        <div class="modal-dialog modal-lg" style="width: 1200px;">
            <div class="modal-content" >
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h5 class="modal-title" id="getCroppedCanvasTitle">编辑器</h5>
                </div>
                <div class="modal-body my-editor-container">
                    <!-- Content -->
                    <div class="container">
                        <div class="row">
                            <div class="col-md-6" style="height: 100%;">
                                <div class="row left-container" style="height: 778px;">
                                    <div class="col-md-3" style="padding: 0px;">
                                        <!-- Nav tabs -->
                                        <ul class="nav nav-tabs" role="tablist">
                                            <li role="presentation" class="active" style="width: 120px;">
                                                <a href="#styles" aria-controls="styles" role="tab" data-toggle="tab">样式</a>
                                            </li>
                                            <li role="presentation" style="width: 120px;">
                                                <a href="#htmlParsersList" aria-controls="htmlParsersList" role="tab" data-toggle="tab">一键排版</a>
                                            </li>
                                            <li role="presentation" style="width: 120px;">
                                                <a href="#editor-tpls" aria-controls="editor-tpls" role="tab" data-toggle="tab">模版</a>
                                            </li>
                                            <li role="presentation" style="width: 120px;">
                                                <a href="#templateCategory" aria-controls="editor-draft" role="tab" data-toggle="tab">模版类别</a>
                                            </li>
                                            <li role="presentation" style="width: 120px;">
                                                <a href="#editor-draft" aria-controls="editor-draft" role="tab" data-toggle="tab">草稿箱</a>
                                            </li>
                                        </ul>
                                    </div>
                                    <div class="col-md-9">
                                        <!-- Tab panes -->
                                        <div class="tab-content">
                                            <div role="tabpanel" class="tab-pane active" id="styles">
                                                <ul class="nav nav-pills  nav-toolbars">
                                                    <li role="presentation" class="dropdown">
                                                        <a class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">标题
                                            <span class="caret"></span>
                                                        </a>
                                                        <ul class="dropdown-menu">
                                                            <li>
                                                                <a class="filter" data-filter=".tagtpl-229">编号标题</a>
                                                            </li>
                                                            <li>
                                                                <a class="filter" data-filter=".tagtpl-237">框线标题</a>
                                                            </li>
                                                            <li>
                                                                <a class="filter" data-filter=".tagtpl-233">底色标题</a>
                                                            </li>
                                                            <li>
                                                                <a class="filter" data-filter=".tagtpl-232">图片标题</a>
                                                            </li>
                                                            <li role="presentation">
                                                                <a class="filter" data-filter=".tagtpl-284">纯序号</a>
                                                            </li>
                                                        </ul>
                                                    </li>
                                                    <li style="width: 1px">|</li>
                                                    <li role="presentation" class="dropdown">
                                                        <a class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">正文
                                            <span class="caret"></span>
                                                        </a>
                                                        <ul class="dropdown-menu">
                                                            <li role="presentation">
                                                                <a class="filter" data-filter=".tagtpl-1089">引用</a>
                                                            </li>
                                                            <li role="presentation">
                                                                <a class="filter" data-filter=".tagtpl-238">段落文字</a>
                                                            </li>
                                                            <li role="presentation">
                                                                <a class="filter" data-filter=".tagtpl-226">边框内容</a>
                                                            </li>
                                                            <li role="presentation">
                                                                <a class="filter" data-filter=".tagtpl-228">底色内容</a>
                                                            </li>
                                                            <li role="presentation">
                                                                <a class="filter" data-filter=".tagtpl-230">序号/轴线</a>
                                                            </li>
                                                            <li role="presentation">
                                                                <a class="filter" data-filter=".tagtpl-231">单页</a>
                                                            </li>
                                                            <li role="presentation">
                                                                <a class="filter" data-filter=".tagtpl-235">竖排</a>
                                                            </li>
                                                        </ul>
                                                    </li>
                                                    <li style="width: 1px">|</li>
                                                    <li role="presentation" class="dropdown">
                                                        <a class="dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">引导
                                            <span class="caret"></span>
                                                        </a>
                                                        <ul class="dropdown-menu">
                                                            <li role="presentation">
                                                                <a class="filter" data-filter=".cate-53">分割线</a>
                                                            </li>
                                                            <li role="presentation">
                                                                <a class="filter" data-filter=".tagtpl-261">引导关注</a>
                                                            </li>
                                                            <li role="presentation">
                                                                <a class="filter" data-filter=".tagtpl-262">引导阅读原文</a>
                                                            </li>
                                                            <li role="presentation">
                                                                <a class="filter" data-filter=".tagtpl-811">引导分享</a>
                                                            </li>
                                                            <li role="presentation">
                                                                <a class="filter" data-filter=".tagtpl-263">引导赞</a>
                                                            </li>
                                                            <li role="presentation">
                                                                <a class="filter" data-filter=".tagtpl-939">二维码</a>
                                                            </li>
                                                        </ul>
                                                    </li>
                                                    <li style="width: 1px">|</li>
                                                    <li role="presentation" class="dropdown">
                                                        <a class="dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">图文
                                            <span class="caret"></span>
                                                        </a>
                                                        <ul class="dropdown-menu">
                                                            <li role="presentation">
                                                                <a class="filter" data-filter=".tagtpl-222">图片样式</a>
                                                            </li>
                                                            <li role="presentation">
                                                                <a class="filter" data-filter=".tagtpl-223">上下图文</a>
                                                            </li>
                                                            <li role="presentation">
                                                                <a class="filter" data-filter=".tagtpl-224">左右图文</a>
                                                            </li>
                                                            <li role="presentation">
                                                                <a class="filter" data-filter=".tagtpl-239">单图</a>
                                                            </li>
                                                            <li role="presentation">
                                                                <a class="filter" data-filter=".tagtpl-240">双图</a>
                                                            </li>
                                                            <li role="presentation">
                                                                <a class="filter" data-filter=".tagtpl-241">三图</a>
                                                            </li>
                                                            <li role="presentation">
                                                                <a class="filter" data-filter=".tagtpl-242">三个以上</a>
                                                            </li>
                                                            <li role="presentation">
                                                                <a class="filter" data-filter=".tagtpl-225">背景/信纸</a>
                                                            </li>
                                                            <li role="presentation">
                                                                <a class="filter" data-filter=".tagtpl-234">音频/视频</a>
                                                            </li>
                                                            <li role="presentation">
                                                                <a class="filter" data-filter=".tagtpl-236">对话</a>
                                                            </li>
                                                        </ul>
                                                    </li>
                                                    <li style="width: 1px">|</li>
                                                    <li role="presentation" class="dropdown">
                                                        <a class="dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">布局
                                            <span class="caret"></span>
                                                        </a>
                                                        <ul class="dropdown-menu">
                                                            <li role="presentation">
                                                                <a class="filter" data-filter=".tagtpl-702">左右留白</a>
                                                            </li>
                                                            <li role="presentation">
                                                                <a class="filter" data-filter=".tagtpl-292">表格样式</a>
                                                            </li>
                                                        </ul>
                                                    </li>
                                                    <li style="width: 1px">|</li>
                                                    <li role="presentation" class="dropdown">
                                                        <a class="dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">节日行业
                                            <span class="caret"></span>
                                                        </a>
                                                        <ul class="dropdown-menu" style="right: 0; left: auto; text-align: right;">
                                                            <li>
                                                                <a class="filter" data-filter=".tagtpl-248">元宵节</a>
                                                            </li>
                                                            <li>
                                                                <a class="filter" data-filter=".tagtpl-1119">春季</a>
                                                            </li>
                                                            <li>
                                                                <a class="filter" data-filter=".tagtpl-288">妇女节</a>
                                                            </li>
                                                            <li>
                                                                <a class="filter" data-filter=".tagtpl-1122">植树节</a>
                                                            </li>
                                                            <li>
                                                                <a class="filter" data-filter=".tagtpl-1123">315</a>
                                                            </li>
                                                            <li>
                                                                <a class="filter" data-filter=".tagtpl-250">清明节</a>
                                                            </li>

                                                            <li>
                                                                <a class="filter" data-filter=".tagtpl-297">教育</a>
                                                            </li>

                                                            <li>
                                                                <a class="filter" data-filter=".tagtpl-940">活动</a>
                                                            </li>
                                                            <li>
                                                                <a class="filter" data-filter=".tagtpl-257">电商</a>
                                                            </li>
                                                            <li>
                                                                <a class="filter" data-filter=".tagtpl-234">视听</a>
                                                            </li>
                                                            <li>
                                                                <a class="filter" data-filter=".tagtpl-857">医疗</a>
                                                            </li>
                                                            <li>
                                                                <a class="filter" data-filter=".tagtpl-878">母婴</a>
                                                            </li>
                                                        </ul>
                                                    </li>
                                                </ul>
                                                <div class="style-result pre-scrollable" style="max-height: 726px;">
                                                    样式...
                                                </div>

                                            </div>
                                            <div role="tabpanel" class="tab-pane pre-scrollable" id="htmlParsersList" style="max-height: 700px;">
                                                <div style="background-color: #d9edf7; padding: 10px; border-color: #bce8f1; color: #3a87ad;">
                                                    <p style="font-size: 16px; clear: none;">
                                                        <strong style="color: red;">提示：</strong>① 在编辑器中粘贴或者输入所有内容，② 点击对应的一键排版规则,③ 全文内容实现自动排版
                                                    </p>
                                                </div>


                                                <div id="html-parsers-items">
                                                </div>
                                            </div>
                                            <div role="tabpanel" class="tab-pane" id="editor-tpls" style="max-height: 700px;">
                                                <ul id="editor-tpls-navtab" class="nav nav-tabs" style="border: 0 none;">
                                                    <li class="nav-item ignore col-sm-4 active" id="personal-tpl-list-li">
                                                        <a class="nav-link" href="#personalTemplates" data-refresh="always" data-url="/user_styles/myStyles" role="tab" data-toggle="tab"
                                                            aria-selected="true">个人模板</a>
                                                    </li>
                                                    <li class="nav-item ignore col-sm-4" id="favorite-tpl-list-li">
                                                        <a class="nav-link" href="#otherColleagueTemplates" data-refresh="always" data-url="/editor_styles/favorTemplates" role="tab"
                                                            data-toggle="tab" aria-selected="false">其他模板</a>
                                                    </li>
                                                    <li class="nav-item ignore  col-sm-4">
                                                        <a class="nav-link" href="#systemTemplates" data-url="/editor_styles/systemTemplates" role="tab" data-toggle="tab" aria-selected="false">系统模板</a>
                                                    </li>
                                                </ul>
                                                <div class="tab-content" style="padding: 0px; overflow-x: hidden;" id="tpl-tab-content">
                                                    <div id="personalTemplates" class="tab-pane active  pre-scrollable" style="max-height: 700px;">
                                                    </div>
                                                    <div id="otherColleagueTemplates" class="tab-pane  pre-scrollable" style="max-height: 700px;">
                                                        
                                                    </div>
                                                    <div id="systemTemplates" class="tab-pane  pre-scrollable" style="max-height: 700px;">
                                                    </div>
                                                </div>
                                            </div>
                                            <div role="tabpanel" class="tab-pane pre-scrollable" id="templateCategory" style="max-height: 700px;">
                                                <ul id="editor-tpls-navtab" class="nav nav-tabs" style="border: 0 none;">
                                                    <li class="nav-item ignore col-sm-4 active" id="personal-tpl-list-li">
                                                        <a class="nav-link" href="#templateCategoryList" data-refresh="always" data-url="" role="tab" data-toggle="tab"
                                                            aria-selected="true">所有模板类别</a>
                                                    </li>
                                                    
                                                </ul>
                                                    <div id="templateCategoryList" class="tab-pane active " style="max-height: 700px;">
                                                        <!-- <ul id="sortable" class="list-group">
                                                            <li class="ui-state-default list-group-item"><span class="ui-icon ui-icon-arrowthick-2-n-s"></span>Item 1<button type="button" class="close" aria-label="Close"><span aria-hidden="true">&times;</span></button></li>
                                                            <li class="ui-state-default list-group-item "><span class="ui-icon ui-icon-arrowthick-2-n-s"></span>Item 2<button type="button" class="close" aria-label="Close"><span aria-hidden="true">&times;</span></button></li>
                                                            <li class="ui-state-default list-group-item"><span class="ui-icon ui-icon-arrowthick-2-n-s"></span>Item 3<button type="button" class="close" aria-label="Close"><span aria-hidden="true">&times;</span></button></li>
                                                            <li class="ui-state-default list-group-item"><span class="ui-icon ui-icon-arrowthick-2-n-s"></span>Item 4<button type="button" class="close" aria-label="Close"><span aria-hidden="true">&times;</span></button></li>
                                                            <li class="ui-state-default list-group-item"><span class="ui-icon ui-icon-arrowthick-2-n-s"></span>Item 5<button type="button" class="close" aria-label="Close"><span aria-hidden="true">&times;</span></button></li>
                                                            <li class="ui-state-default list-group-item"><span class="ui-icon ui-icon-arrowthick-2-n-s"></span>Item 6<button type="button" class="close" aria-label="Close"><span aria-hidden="true">&times;</span></button></li>
                                                            <li class="ui-state-default list-group-item"><span class="ui-icon ui-icon-arrowthick-2-n-s"></span>Item 7<button type="button" class="close" aria-label="Close"><span aria-hidden="true">&times;</span></button></li>
                                                        </ul> -->
                                                    </div>
                                                    <div>
                                                    <button class="btn btn-primary" id='addTemplateCategoryAction' data-target="#addTemplateCategory" data-toggle="modal">添加新的模板类别</button>
                                                        </div>
                                            </div>
                                            <div role="tabpanel" class="tab-pane pre-scrollable" id="editor-draft" style="max-height: 700px;">
                                                <ul id="editor-tpls-navtab" class="nav nav-tabs" style="border: 0 none;">
                                                    <li class="nav-item ignore col-sm-4 active" id="personal-tpl-list-li">
                                                        <a class="nav-link" href="#personalDraft" data-refresh="always" data-url="" role="tab" data-toggle="tab"
                                                            aria-selected="true">个人草稿</a>
                                                    </li>
                                                    
                                                </ul>
                                                    <div id="personalDraft" class="tab-pane active " style="max-height: 700px;">

                                                    </div>
                                            </div>

                                            
                                        </div>
                                    </div>
                                </div>

                            </div>
                            <div class="col-md-6">
                                <div class="right-container">
                                    <div>
                                        <script id="editor" type="text/plain" style="width: 100%; height: 600px;"></script>
                                    </div>
                                    <div class="editorslide" data-step="3" data-position="left">
                                                <button type="button" id="btn_clearData" tabindex="2" class="btn btn-default btn-xs" data-container="body" data-placement="left"
                                                    title="" data-original-title="清空编辑器内容" onclick="clearData()">清空编辑器内容</button>
                                                <button type="button" id="btn_clearData" tabindex="2" class="btn btn-default btn-xs" data-container="body" data-placement="left"
                                                    title="" data-original-title="调整图片宽度" onclick="adjustImageWidth()">调整图片宽度</button>

                                                <button  id="save-as-draft" tabindex="2" class="btn btn-default btn-xs" data-container="body" data-placement="left"
                                                    title="" data-original-title="保存内容">
                                                    保存到草稿</button>
                                 
                                          
                                                <button  data-target="#saveTemplateCategoryforArticle"  data-toggle="modal" id="save-as-template" tabindex="2" class="btn btn-default btn-xs" data-container="body" data-placement="left"
                                                    title="" data-original-title="保存内容">
                                                    保存到模板</button>
                                            
                                    </div>
                                    <!-- <div id="btns">
                        <div>
                            <button onclick="getAllHtml()">获得整个html的内容</button>
                            <button onclick="getContent()">获得内容</button>
                            <button onclick="setContent()">写入内容</button>
                            <button onclick="setContent(true)">追加内容</button>
                            <button onclick="getContentTxt()">获得纯文本</button>
                            <button onclick="getPlainTxt()">获得带格式的纯文本</button>
                            <button onclick="hasContent()">判断是否有内容</button>
                            <button onclick="setFocus()">使编辑器获得焦点</button>
                            <button onmousedown="isFocus(event)">编辑器是否获得焦点</button>
                            <button onmousedown="setblur(event)">编辑器失去焦点</button>

                        </div>
                        <div>
                            <button onclick="getText()">获得当前选中的文本</button>
                            <button onclick="insertHtml()">插入给定的内容</button>
                            <button id="enable" onclick="setEnabled()">可以编辑</button>
                            <button onclick="setDisabled()">不可编辑</button>
                            <button onclick=" UE.getEditor('editor').setHide()">隐藏编辑器</button>
                            <button onclick=" UE.getEditor('editor').setShow()">显示编辑器</button>
                            <button onclick=" UE.getEditor('editor').setHeight(300)">设置高度为300默认关闭了自动长高</button>
                        </div>

                        <div>
                            <button onclick="getLocalData()">获取草稿箱内容</button>
                            <button onclick="clearLocalData()">清空草稿箱</button>
                        </div>

                    </div>
                    <div>
                        <button onclick="createEditor()">
                            创建编辑器</button>
                        <button onclick="deleteEditor()">
                            删除编辑器</button>
                    </div> -->

                                </div>

                            </div>

                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
                    <a class="btn btn-primary" id="download" href="javascript:void(0);" onclick="completeEdit()">确定</a>
                </div>
            </div>
        </div>
    </div>
    <!-- /.modal -->

<!--保存模板的类别 -->
<div class="modal fade" id="saveTemplateCategoryforArticle" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">保存为模板</h4>
            </div>
            <div id="templateCategoryforSave" class="pre-scrollable" style="max-height: 300px;">
            </div>
            
            
            <div class="modal-footer">
                <select class="span3" id="categorySelect">
                    <option>1</option>
                    
                </select>
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" data-dismiss="modal" id="saveTemplateCategoryforArticleBtn">提交更改</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>
<!--添加模板类别 -->
<div class="modal fade" id="addTemplateCategory" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">添加新的模板分类</h4>
            </div>
            
            <input type="text" class="form-control" placeholder="模板分类名字" id="newTemplateCategory">
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" data-dismiss="modal" id="addTemplateCategoryBtn">提交更改</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>
</body>
</html>

<script>
    $(function(){
        $("[name='info_desc']").on("click",function(){
            $("#myNewStyleEditor").modal({
                backdrop: false,
                show: true
            });
        });
        $("[name='info_desc']").focus(function(){
            $(this).trigger("click");
        });
    });

    function completeEdit(){
        if($.trim(UE.getEditor("editor").getContentTxt())){
            var html = UE.getEditor("editor").getContent();
            convertTableToImage(html).then(function(data){
                $("[name='info_desc']").html(data);
                $("#myNewStyleEditor").modal("hide");
                }).catch(function(err){
                    console.log(err);
                    $("#myNewStyleEditor").modal("hide");
                });
            }
        else{
            alert("编辑器中必须包含文字");
            $("#myNewStyleEditor").modal("hide");
        }
    }
</script>