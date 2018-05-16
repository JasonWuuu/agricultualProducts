<!-- #include virtual = "/include/mylib1105.asp" -->

<!-- #include virtual = "/include/auth.asp" -->
<!-- #include virtual = "/include/sql.asp" -->

 <%
	'作者：马洪岩  于 2002-4-21 编写
	'功能：修改文章
	'操作：本脚本操作人员操作
 '判断级别
 
 Function check_op(s_chr,d_chr)
 	POP = INSTR(s_chr,d_chr)
		IF POP >0 THEN
		check_op = "checked"
		ELSE
		check_op = ""
		END IF	
 End Function

 Function if_opa(s_chr,d_chr)
	POP = INSTR(s_chr,d_chr)
		IF POP >0 THEN
		if_opa = "checked"
		ELSE
		if_opa = ""
		END IF	
 End Function
 
 Function if_checkbox(s_chr,d_chr)
	POP = INSTR(s_chr,"PZ"&d_chr&"ED")
		IF POP >0 THEN
		if_checkbox = "checked"
		ELSE
		if_checkbox = ""
		END IF	
 End Function 
	set CONN = Server.CreateObject("ADODB.Connection")
    CONN.open CONNSTR,"",""  
	set RS = Server.CreateObject("ADODB.RecordSet")
	set RS1 = Server.CreateObject("ADODB.RecordSet")
	set RSLIB = Server.CreateObject("ADODB.RecordSet")
	'判断权限
	IF CDBL(Request.Cookies ("PRVI")) > 0 OR  Request.Cookies ("USER_NAME") = "lq" THEN
		SQL = "SELECT * FROM WB_ARTICLE WHERE INFO_NO = '" & REQUEST("INFO_NO") & "'"
		RS.Open SQL,CONN,adOpenKeyset,adLockReadOnly
		IF RS.RecordCount >0 THEN
		ELSE
		Response.Write "对不起，本记录不能修改，原因可能是已经审核或则不是您输入的记录"
		Response.End 
		END IF
	ELSE
		SQL = "SELECT * FROM WB_ARTICLE WHERE PERSON = '" & Request.Cookies ("USER_NAME") & "' AND INFO_NO = '" & REQUEST("INFO_NO") & "'"
		RS.Open SQL,CONN,adOpenKeyset,adLockReadOnly
		IF RS.RecordCount >0 THEN
		'	IF RS("INFO_TYPE") = "否" THEN
		'	ELSE
		'		IF RS("INFO_CHECK") >0 THEN
		'		Response.Write "对不起，本记录不能修改，原因可能是已经审核或则不是您输入的记录"
		'		Response.End 
		'		ELSE
		'		END IF
		'	END IF
		ELSE
		Response.Write "对不起，本记录不能修改，原因可能是已经审核或则不是您输入的记录"
		Response.End 
		END IF
	END IF
	
	%> 
<html>
<head>
<title>内容与文章修改</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" href="../../manage/article/font.css">
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
<script src="./js/article_modi.js"></script>
<link href="./article_add.css" rel="stylesheet">
</head>

<body bgcolor="white">
<script language="javascript">
function GoToURL()
{
  
  var tURL= "article_modi.asp?p_class_no="+document.un.p_class_no.options[document.un.p_class_no.selectedIndex].value;
  var tURL3= "&class_no="+document.un.class_no.options[document.un.class_no.selectedIndex].value;
  var tURL1= "&info_no="+document.un.info_no.value;
  var tURL2= "&b_id="+document.un.b_id.value;
  document.location=tURL+tURL3+tURL1+tURL2;
}
</script>
<script language="javascript">
function retable()
{
  	document.un.check_date.value="";

}
</script>
<script language="javascript">
function retable1()
{
var date = new Date();
var hour = date.getHours();
var minute = date.getMinutes();
var second = date.getSeconds();
  yx_date="<%=rs("check_date")%>";
  today=new Date(); 
  my_month = today.getMonth()+1;
  if(yx_date=="1999-1-1")
  {
  document.un.check_date.value="2018-"+my_month+"-"+today.getDate();
  }
  else
  {
  document.un.check_date.value=yx_date;
  }
  }
</script>
<script language="javascript">

var lsdz = "";
function checkIn()
{
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

	
    
   if(confirm("你现在要提交吗?"))
      return true
   else
      return false;
}
</script>
<script language="javascript">
function AddItem(strFileName){
  document.un.DefaultPicUrl.value=strFileName;
  document.un.DefaultPicList.options[document.un.DefaultPicList.length]=new Option(strFileName,strFileName);
  document.un.DefaultPicList.selectedIndex+=1;
  if(document.un.UploadFiles.value==''){
	document.un.UploadFiles.value=strFileName;
  }
  else{
    document.un.UploadFiles.value=document.un.UploadFiles.value+"|"+strFileName;
  }
}

</script>
<div align="center"><font color="#0000FF" class="main">（内部资料系统管理）内容与文章系统增加 </font></div>
<hr size="1">
<form method="POST" action="article_save_up.asp" name="un">
  <input type=hidden name=id value="<%=rs("id")%>">
  <input type=hidden name=info_no value="<%=rs("info_no")%>">
   <input type=hidden name=y_p_class_no value="<%=rs("p_class_no")%>">
  <input type=hidden name=y_class_no value="<%=rs("class_no")%>">
  <input type=hidden name=s_article_no value="<%=rs("s_article_no")%>">
  <input type=hidden name=y_file_name value="<%=rs("info_file")%>">
    <input type=hidden name=up_date value="<%=YEAR(RS("CHECK_DATE"))%>-<%=MONTH(RS("CHECK_DATE"))%>-<%=DAY(RS("CHECK_DATE"))%>">
  <table width="661" border="0" bordercolordark="#99CCFF" bordercolorlight="#99CCFF" cellspacing="1" align="center" cellpadding="6" bgcolor="#000000" style="width:953px;" class="table table-bordered">
    <tr bgcolor="#FFFFFF"> 
      <td width="23%" class="main">大类别：</td>
      <td width="77%" class="main"> 
          <select name="b_id" onChange="GoToURL()">
      <%
          IF Request("b_id") = "" THEN
			CALL MYSELECT_NAME("B_SHORT",RS("CLASS_PZ"),"B_ID","C_NAME")
          ELSE
			CALL MYSELECT_NAME("B_SHORT",REQUEST("B_ID"),"B_ID","C_NAME")
		  END IF
        %>
        </select>
       </td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="23%" class="main">小类别：</td>
      <td width="77%" class="main"> 
          <select name="s_id" >
		  <option value=""> 小类别</option>
      <%
			IF REQUEST("b_id") <> "" THEN
			SQL = "SELECT * FROM S_SHORT WHERE B_ID = '" & REQUEST("B_ID") & "'"
			RS1.Open SQL,CONN,adOpenKeyset ,adLockReadOnly
				DO WHILE NOT RS1.EOF 
				if request("s_id") = rs1("s_id") then
				%> 
          <option value="<%=RS1("s_id")%>" selected><%=RS1("C_NAME")%>-<%=RS1("e_name") %></option>
          <%
				else
				%> 
          <option value="<%=RS1("s_id")%>"><%=RS1("C_NAME")%>-<%=RS1("e_name") %></option>
          <%
				end if
				RS1.MoveNext 
				LOOP
			RS1.Close 
			ELSE
			SQL = "SELECT * FROM s_short WHERE b_id = '" & RS("class_pz") & "'"
			RS1.Open SQL,CONN,adOpenKeyset ,adLockReadOnly
				DO WHILE NOT RS1.EOF 
				IF RS1("s_id") = RS("s_id") THEN
				%> 
          <option value="<%=RS1("s_id")%>" SELECTED><%=RS1("c_name")%>-<%=RS1("e_name") %></option>
          <%
				ELSE
				%> 
          <option value="<%=RS1("s_id")%>"><%=RS1("C_NAME")%>-<%=RS1("e_name") %></option>
          <%	
				END IF
				RS1.MoveNext 
				LOOP
			RS1.Close 
			END IF
        %> 
      </select>
 </td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="23%" class="main">产地：</td>
      <td width="77%" class="main">
       <select name="state" ID="Select1">
       
       <%
			SQL = "SELECT * FROM COUNTRY  ORDER BY SHORT"
			RS1.Open SQL,CONN,adOpenKeyset ,adLockReadOnly
				DO WHILE NOT RS1.EOF 
				if Rs("state") = rs1("state") then
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
      <td width="23%" class="main">网站总栏目：</td>
      <td width="77%" class="main"> 
        <select name="p_class_no" onChange="GoToURL()">
          <option value="">网站总栏目</option>
          <%
          IF Request("p_class_no") = "" THEN
			CALL MYSELECT_NAME("P_CLASS",RS("p_class_no"),"P_CLASS_NO","P_CLASS_NAME")
          ELSE
			CALL MYSELECT_NAME("P_CLASS",Request("p_class_no"),"P_CLASS_NO","P_CLASS_NAME")
		  END IF
        %> 
        </select>
      </td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="23%" class="main">网站分栏目：</td>
      <td width="77%" class="main"> 
        <select name="class_no" >
          <option value="">网站分栏目</option>
          <%
			IF REQUEST("p_class_no") <> "" THEN
			SQL = "SELECT * FROM S_CLASS WHERE P_CLASS_NO = '" & REQUEST("P_CLASS_NO") & "' ORDER BY CLASS_NO"
			RS1.Open SQL,CONN,adOpenKeyset ,adLockReadOnly
				DO WHILE NOT RS1.EOF 
				if request("class_no") = rs1("class_no") then
				%> 
          <option value="<%=RS1("CLASS_NO")%>" selected><%=RS1("CLASS_NAME")%>-<%=rs1("IMG_PATH") %></option>
          <%
				else
				%> 
          <option value="<%=RS1("CLASS_NO")%>"><%=RS1("CLASS_NAME")%>-<%=rs1("IMG_PATH") %></option>
          <%
				end if
				RS1.MoveNext 
				LOOP
			RS1.Close 
			ELSE
			SQL = "SELECT * FROM S_CLASS WHERE P_CLASS_NO = '" & RS("P_CLASS_NO") & "' ORDER BY CLASS_NO"
			RS1.Open SQL,CONN,adOpenKeyset ,adLockReadOnly
				DO WHILE NOT RS1.EOF 
				IF RS1("CLASS_NO") = RS("CLASS_NO") THEN
				%> 
          <option value="<%=RS1("CLASS_NO")%>" SELECTED><%=RS1("CLASS_NAME")%>-<%=rs1("IMG_PATH") %></option>
          <%
				ELSE
				%> 
          <option value="<%=RS1("CLASS_NO")%>"><%=RS1("CLASS_NAME")%>-<%=rs1("IMG_PATH") %></option>
          <%	
				END IF
				RS1.MoveNext 
				LOOP
			RS1.Close 
			END IF
        %> 
        </select>
      </td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="23%" class="main">气象：</td>
      <td width="77%" class="main"><small><font face="Verdana"> 
        <input type="TEXT" name="climate"  size="40" value="<%=rs("climate")%>">
        </font></small></td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="23%" class="main">经济：</td>
      <td width="77%" class="main"> 
        <input type="text" name="econnmy" size="40" value="<%=rs("econnmy")%>">
      </td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="23%" class="main">资料标题：</td>
      <td width="77%" class="main"> 
        <input type="text" name="info_title" size=50  value="<%=rs("info_title")%>"> 
<%
pop = 0
pop = instr(rs("color_r"),"<")
if pop >0 then
%>
<input type="radio" name="colorxz" checked value="">
            正常
             <input type="radio" name="colorxz" checked value="标红">
            标红
<%
else%>
<input type="radio" name="colorxz" checked value="">
            正常
             <input type="radio" name="colorxz"  value="标红">
            标红
<%end if%>
      </td>
    </tr>
	 	<%
		
		INFO_DESC=RS("INFO_DESC")
		if rs("if_html") = "否" THEN 
		INFO_DESC = REPLACE(INFO_DESC,"<p style='text-indent: 2em; text-align: justify; line-height: 1.5em; margin-bottom: 15px; margin-top: 15px;'>    <span style='color: rgb(0, 0, 0); font-family: 微软雅黑, 'Microsoft YaHei';'>",chr(13))
		INFO_DESC = REPLACE(INFO_DESC,"</span></p>",chr(13))
		END IF		
		%>
    <tr bgcolor="#FFFFFF"> 
      <td width="23%" class="main">简介：</td>
      <td width="77%" class="main"> 
        <textarea name="info_desc" rows="10" cols="60" ><%=CHR(13)%><%=INFO_DESC%></textarea>
      </td>
    </tr>
     <tr bgcolor="#FFFFFF"> 
      <td width="21%" class="main">专题相关：</td>
      <td width="79%" class="main"> 
        <%
				SQL1 = "SELECT * FROM SPECAIL "
				RS1.Open SQL1,CONN,adOpenKeyset ,adLockReadOnly
					DO WHILE NOT RS1.EOF 
            %>
			  <input type="checkbox" name="zhuanti" value="<%=RS1("SPECAIL_NO")%>"   <%=CHECK_OP(RS("INFO_FILE"),RS1("SPECAIL_NO"))%>><%=RS1("SPECAIL_NAME")%>
              <%
					RS1.MoveNext 
					LOOP
					RS1.Close 
              %> </td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="23%" class="main">是否是HTML方式：</td>
      <td width="77%" class="main"><%
		IF RS("IF_HTML") = "是" THEN
      %> 
        <input type="radio" name="if_html" value="是" checked>
        是 
        <input type="radio" name="if_html" value="否" >
        否 <%
        ELSE
        %> 
        <input type="radio" name="if_html" value="是" >
        是 
        <input type="radio" name="if_html" value="否" checked>
        否 <%
        END IF
        %> </td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="23%" class="main">是否更换文件：</td>
      <td width="77%" class="main"> 
        <input type="radio" name="if_tp" value="是">
        是 
        <input type="radio" name="if_tp" value="否" checked>
        否 <br>
        <br>
        （如果您选择<font color="#FF0000">更换</font>，但是没有<font color="#FF0000">选择</font>文件，系统将<font color="#FF0000">删除</font>文件）</td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="23%" class="main">查找字符串：</td>
      <td width="77%" class="main"> 
      <%
		pop = instr(rs("info_find"),"20")
		IF POP >0 THEN
      %>
      <select name="info_find">
      <option value="" selected>如果是期货请选择</option>
          <%
			SQL = "SELECT * FROM S_SHORT WHERE B_ID = '1019'"
			RS1.Open SQL,CONN,adOpenKeyset ,adLockReadOnly
				DO WHILE NOT RS1.EOF 
				IF RS1("S_ID") = RS("INFO_FIND") THEN
				%> 
				<option value="<%=RS1("S_ID")%>" selected><%=RS1("C_NAME")%></option>
				<%
				ELSE
				%>
          <option value="<%=RS1("S_ID")%>"><%=RS1("C_NAME")%></option>
          <%
				END IF
				RS1.MoveNext 
				LOOP
			RS1.Close 
			%> 
        </select>
        <%
        ELSE
        %>
        <input type="text" name="info_find" size="30" value="<%=rs("info_find")%>">
        <select name="info_find1">
      <option value="" selected>如果是期货请选择</option>
          <%
			SQL = "SELECT * FROM S_SHORT WHERE B_ID = '1019'"
			RS1.Open SQL,CONN,adOpenKeyset ,adLockReadOnly
				DO WHILE NOT RS1.EOF 
				IF RS1("S_ID") = RS("INFO_FIND") THEN
				%> 
				<option value="<%=RS1("S_ID")%>" selected><%=RS1("C_NAME")%></option>
				<%
				ELSE
				%>
          <option value="<%=RS1("S_ID")%>"><%=RS1("C_NAME")%></option>
          <%
				END IF
				RS1.MoveNext 
				LOOP
			RS1.Close 
			%> 
        </select>
        <%
        END IF
        %>
        
      </td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="23%" class="main">相关查询字符：</td>
      <td width="77%" class="main"><small> 
        <input type="text" name="info_corre" size="30" value="<%=rs("info_corre")%>">
        <span class="main"> （输入相关的关键字符）</span></small></td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="23%" class="main">资料来源：</td>
      <td width="77%" class="main"> 
        <input type="text" name="info_source" size="30" value="<%=rs("info_source")%>">
      </td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="23%" class="main">作者： </td>
      <td width="77%" class="main"><small><font face="Verdana"> 
        <input type="text" name="author" size="20" value="<%=rs("info_author")%>">
        </font></small></td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="23%" class="main">备注：</td>
      <td width="77%" class="main"><small><font face="Verdana"> 
        <input type="text" name="remark" size="50" value="<%=rs("remark")%>">
        </font></small></td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="23%" class="main">文章编号：</td>
      <td width="77%" class="main"><small><font face="Verdana"> <%=rs("s_article_no")%> 
        </font></small></td>
    </tr>
	 <tr bgcolor="#FFFFFF"> 
      <td width="23%" class="main">图片名称：</td>
      <td width="77%" class="main"><input type="text" name="s_pic" size="50" value="<%=rs("info_file")%>">
        </td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="23%" class="main">手机网简介：</td>
		
      <td width="77%" class="main">
		
 <textarea name="x_article_no" rows="3" cols="60" ><%=CHR(13)%><%=rs("x_article_no")%></textarea>
</td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="23%" class="main">是否放入外网：</td>
      <td width="77%" class="main"><%
		IF RS("INFO_TYPE") = "是" THEN
      %> 
        <input type="radio" name="nw" value="是" checked>
        是 
        <input type="radio" name="nw" value="否" >
        否 <%
        ELSE
        %> 
        <input type="radio" name="nw" value="是" >
        是 
        <input type="radio" name="nw" value="否" checked>
        否 <%
        END IF
        %> </td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="23%" class="main">相关类别：</td>
      <td width="77%" class="main"> 
        <table width="100%" border="1" cellspacing="0" cellpadding="3" class="main" bordercolor="#000000" bordercolordark="#FFFFFF" bordercolorlight="#000000" ID="Table1">
          <tr> 
            <td width="12%"><font color="#0000FF">世界经济</font></td>
            <td width="88%"> 
            <%
				SQL1 = "SELECT * FROM S_CLASS WHERE P_CLASS_NO = '990002'"
				RS1.Open SQL1,CONN,adOpenKeyset ,adLockReadOnly
					DO WHILE NOT RS1.EOF 
            %>
			  <input type="checkbox" name="sjjj" value="<%=RS1("CLASS_NO")%>"  <%=IF_OPA(RS("CLASS_CORRE"),RS1("CLASS_NO"))%> ID="Checkbox2"><%=RS1("CLASS_NAME")%>
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
			  <input type="checkbox" name="ggny" value="<%=RS1("CLASS_NO")%>"  <%=IF_OPA(RS("CLASS_CORRE"),RS1("CLASS_NO"))%>  ID="Checkbox3"><%=RS1("CLASS_NAME")%>
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
			  <input type="checkbox" name="slyz" value="<%=RS1("CLASS_NO")%>"  <%=IF_OPA(RS("CLASS_CORRE"),RS1("CLASS_NO"))%> ID="Checkbox4"><%=RS1("CLASS_NAME")%>
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
			  <input type="checkbox" name="qxyb" value="<%=RS1("CLASS_NO")%>" <%=IF_OPA(RS("CLASS_CORRE"),RS1("CLASS_NO"))%>  ID="Checkbox5"><%=RS1("CLASS_NAME")%>
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
			  <input type="checkbox" name="gkhg" value="<%=RS1("CLASS_NO")%>" <%=IF_OPA(RS("CLASS_CORRE"),RS1("CLASS_NO"))%>  ID="Checkbox6"><%=RS1("CLASS_NAME")%>
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
			  <input type="checkbox" name="tjzl" value="<%=RS1("CLASS_NO")%>" <%=IF_OPA(RS("CLASS_CORRE"),RS1("CLASS_NO"))%>  ID="Checkbox7"><%=RS1("CLASS_NAME")%>
              <%
					RS1.MoveNext 
					LOOP
					RS1.Close 
              %>  </td>
          </tr><tr> 
            <td width="12%"><font color="#0000FF">价格动态</font></td>
            <td width="88%"> 
              <%
				SQL1 = "SELECT * FROM S_CLASS WHERE P_CLASS_NO = '990004'"
				RS1.Open SQL1,CONN,adOpenKeyset ,adLockReadOnly
					DO WHILE NOT RS1.EOF 
            %>
			  <input type="checkbox" name="jgqs" value="<%=RS1("CLASS_NO")%>" <%=IF_OPA(RS("CLASS_CORRE"),RS1("CLASS_NO"))%>  ID="Checkbox8"><%=RS1("CLASS_NAME")%>
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
			  <input type="checkbox" name="zcdt" value="<%=RS1("CLASS_NO")%>" <%=IF_OPA(RS("CLASS_CORRE"),RS1("CLASS_NO"))%>  ID="Checkbox9"><%=RS1("CLASS_NAME")%>
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
			  <input type="checkbox" name="zhzx" value="<%=RS1("CLASS_NO")%>" <%=IF_OPA(RS("CLASS_CORRE"),RS1("CLASS_NO"))%>  ID="Checkbox10"><%=RS1("CLASS_NAME")%>
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
			  <input type="checkbox" name="pzpd" value="<%=RS1("CLASS_NO")%>" <%=IF_OPA(RS("CLASS_CORRE"),RS1("CLASS_NO"))%>  ID="Checkbox11"><%=RS1("CLASS_NAME")%>
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
			  <input type="checkbox" name="hydt" value="<%=RS1("CLASS_NO")%>" <%=IF_OPA(RS("CLASS_CORRE"),RS1("CLASS_NO"))%>  ID="Checkbox12"><%=RS1("CLASS_NAME")%>
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
			  <input type="checkbox" name="qhbj" value="<%=RS1("CLASS_NO")%>" <%=IF_OPA(RS("CLASS_CORRE"),RS1("CLASS_NO"))%>  ID="Checkbox13"><%=RS1("CLASS_NAME")%>
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
			  <input type="checkbox" name="spzs" value="<%=RS1("CLASS_NO")%>" <%=IF_OPA(RS("CLASS_CORRE"),RS1("CLASS_NO"))%>  ID="Checkbox14"><%=RS1("CLASS_NAME")%>
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
			  <input type="checkbox" name="zztz" value="<%=RS1("CLASS_NO")%>" <%=IF_OPA(RS("CLASS_CORRE"),RS1("CLASS_NO"))%>  ID="Checkbox15"><%=RS1("CLASS_NAME")%>
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
			  <input type="checkbox" name="yfjc" value="<%=RS1("CLASS_NO")%>" <%=IF_OPA(RS("CLASS_CORRE"),RS1("CLASS_NO"))%>  ID="Checkbox16"><%=RS1("CLASS_NAME")%>
              <%
					RS1.MoveNext 
					LOOP
					RS1.Close 
              %> 
             </td>
          </tr>
            <tr> 
            <td width="12%"><font color="#0000FF">能源燃料</font></td>
            <td width="88%"> 
             <%
				SQL1 = "SELECT * FROM S_CLASS WHERE P_CLASS_NO = '990024'"
				RS1.Open SQL1,CONN,adOpenKeyset ,adLockReadOnly
					DO WHILE NOT RS1.EOF 
            %>
			  <input type="checkbox" name="nyrl" value="<%=RS1("CLASS_NO")%>" <%=IF_OPA(RS("CLASS_CORRE"),RS1("CLASS_NO"))%>  ID="Checkbox17"><%=RS1("CLASS_NAME")%>
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
			  <input type="checkbox" name="hyzx" value="<%=RS1("CLASS_NO")%>" <%=IF_OPA(RS("CLASS_CORRE"),RS1("CLASS_NO"))%>  ID="Checkbox17"><%=RS1("CLASS_NAME")%>
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
			  <input type="checkbox" name="sclr" value="<%=RS1("CLASS_NO")%>" <%=IF_OPA(RS("CLASS_CORRE"),RS1("CLASS_NO"))%>  ID="Checkbox17"><%=RS1("CLASS_NAME")%>
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
			  <input type="checkbox" name="zftj" value="<%=RS1("CLASS_NO")%>" <%=IF_OPA(RS("CLASS_CORRE"),RS1("CLASS_NO"))%>  ID="Checkbox17"><%=RS1("CLASS_NAME")%>
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
      <td width="79%" class="main"> <%
		IF RS("CHECK_DATE") <> "1999-1-1" THEN
      %> 
        <input type="radio" name="ifsh" value="是" onclick=retable();>
        是 
        <input type="radio" name="ifsh" value="否" onclick=retable1(); checked>
        否 <%
        ELSE
        %> 
        <input type="radio" name="ifsh" value="是" onclick=retable(); checked>
        是 
        <input type="radio" name="ifsh" value="否" onclick=retable1();>
        否 <%
        END IF
        %> &nbsp;<font color=red>如果不需要审核，请输入审核时间：</font> <%if  RS("CHECK_DATE") <> "1999-1-1" then%> 
        <input type="text" name="check_date" size="16" value="<%=YEAR(rs("check_date"))%>-<%=MONTH(rs("check_date"))%>-<%=DAY(rs("check_date"))%>">
        <%
         else
         %> 
        <input type="text" name="check_date" size="16" value="">
        <%
         end if
         %> </td>
    </tr>
   
    <tr bgcolor="#FFFFFF"> 
      <td width="21%" class="main">是否综合报道：</td>
      <td width="79%" class="main"> <%
		IF RS("IF_ZH") = "是" THEN
      %> 
        <input type="radio" name="ifzh" value="是" checked>
        是 
        <input type="radio" name="ifzh" value="否" >
        否 <%
      ELSE
      %> 
        <input type="radio" name="ifzh" value="是" >
        是 
        <input type="radio" name="ifzh" value="否" checked>
        否 <%
      END IF
      %> </td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="21%" class="main"><font color=red>是否特别报道：</font></td>
      <td width="79%" class="main"><%
		IF RS("IFFY") = "是" THEN
      %> 
        <input type="radio" name="iffy" value="是" checked>
        是 
        <input type="radio" name="iffy" value="否" >
        否 <%
      ELSE
      %> 
        <input type="radio" name="iffy" value="是" >
        是 
        <input type="radio" name="iffy" value="否" checked>
        否 <%
      END IF
      %> </td>
    </tr>
    <tr bgcolor="#FFFFFF">
      <td width="21%" class="main">特别推荐日期：</td>
      <td width="79%" class="main">如果推荐，请输入推荐时间：<%if  RS("TJ_DATE") <> "1999-1-1" then%> 
        <input type="text" name="tbtj_date" size="16" value="<%=YEAR(rs("tj_date"))%>-<%=MONTH(rs("tj_date"))%>-<%=DAY(rs("tj_date"))%>">
        <%
         else
         %> 
        <input type="text" name="tbtj_date" size="16" value="">
        <%
         end if
         %> &nbsp;</td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="21%" class="main"><font color="#0000FF">是否特别推荐：</font></td>
      <td width="79%" class="main"><%
		IF RS("IF_TJ") = "是" THEN
      %> 
        <input type="radio" name="if_zj" value="是" checked>
        是 
        <input type="radio" name="if_zj" value="否" >
        否 <%
      ELSE
      %> 
        <input type="radio" name="if_zj" value="是" >
        是 
        <input type="radio" name="if_zj" value="否" checked>
        否 <%
      END IF
      %> （当天特别推荐的位置）</td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="21%" class="main"><font color="#0000FF">是否（<font color=red>当前要闻</font>）：</font></td>
      <td width="79%" class="main"><%
		IF RS("IF_MF") = "是" THEN
      %> 
        <input type="radio" name="if_mf" value="是" checked>
        是 
        <input type="radio" name="if_mf" value="否" >
        否 <%
      ELSE
      %> 
        <input type="radio" name="if_mf" value="是" >
        是 
        <input type="radio" name="if_mf" value="否" checked>
        否 <%
      END IF
      %> （当天滚动的位置）</td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="21%" class="main"><font color=red>是否免费</font></td>
      <td width="79%" class="main"><%
		IF RS("IF_ZK") = "是" THEN
      %> 
        <input type="radio" name="if_zk" value="是" checked>
        是 
        <input type="radio" name="if_zk" value="否" >
        否 <%
      ELSE
      %> 
        <input type="radio" name="if_zk" value="是" >
        是 
        <input type="radio" name="if_zk" value="否" checked>
        否 <%
      END IF
      %> （<font color=red>不需要密码就可以浏览</font>）</td>
    </tr>
	 <tr bgcolor="#FFFFFF"> 
      <td width="21%" class="main"><font color="#0000FF">是否置顶：</font></td>
      <td width="79%" class="main"> 
		<%
		IF RS("IF_ZD") = "是" THEN
      %> 
        <input type="radio" name="if_zd" value="是"  checked>
        是 
        <input type="radio" name="if_zd" value="否" >
        否
<%
ELSE
%>
  <input type="radio" name="if_zd" value="是" >
        是 
        <input type="radio" name="if_zd" value="否"  checked>
        否
<%
END IF
%>
(<%=rs("zd_date")%>)（  <select name="zd_date">
       <option value="5">5天</option>
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
				<input type="checkbox" name="mypzxg" value="<%=RS1("B_ID")%>"  <%=IF_CHECKBOX(RS("CLASS_CORRE"),RS1("B_ID"))%> ID="Checkbox1"><%=RS1("C_NAME")%>
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
				<input type="checkbox" name="mypzxg" value="<%=RS1("S_ID")%>" <%=IF_CHECKBOX(RS("CLASS_CORRE"),RS1("S_ID"))%> ID="Check1"><%=RS1("C_NAME")%>
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
		  <option value="<%=rs("jibie")%>" select><%=rs("jibie")%></option>
       <option value="0">0</option>
        <option value="1">1</option>
<option value="2">2</option>
<option value="3">3</option>
<option value="4">4</option>
        </select>
		  0为网络级别，3为咨询级别，4顾问级别
		  </td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td colspan="2"> 
        <div align="center"><br>
          <input type="submit" name="msave" value="提交修改" onClick="return checkIn();">
          <input type="reset" name="Submit2" value="恢复原样">
          <input type="button" name="home" value="关闭窗口" onClick=self.close();>
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

function putArticleToEditor(){
    var current_editor = UE.getEditor("editor");
    var article = $("[name=info_desc]").val();
    //var uncodeHtml = $("<div></div>").html(article).text();
    //current_editor.execCommand("inserthtml", article);

     current_editor.setContent(article, false);
}

$(function(){
    $("[name='info_desc']").on("click",function(){
        $("#myNewStyleEditor").modal({
            backdrop: false,
            show: true
        });
        putArticleToEditor();
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
