<!-- #include virtual = "/include/mylib1105.asp" -->

<!-- #include virtual = "/include/auth.asp" -->
<!-- #include virtual = "/include/sql.asp" -->

 <%
	'作者：马洪岩  于 2002-4-21 编写
	'功能：修改文章
	'操作：本脚本操作人员操作
 
'去掉字符串头尾的连续的回车和空格 
function trimVBcrlf(str) 
trimVBcrlf=rtrimVBcrlf(ltrimVBcrlf(str)) 
end function 

'去掉字符串开头的连续的回车和空格 
function ltrimVBcrlf(str) 
dim pos,isBlankChar 
pos=1 
isBlankChar=true 
while isBlankChar 
if mid(str,pos,1)=" " then 
pos=pos+1 
elseif mid(str,pos,2)=VBcrlf then 
pos=pos+2 
else 
isBlankChar=false 
end if 
wend 
ltrimVBcrlf=right(str,len(str)-pos+1) 
end function 

'去掉字符串末尾的连续的回车和空格 
function rtrimVBcrlf(str) 
dim pos,isBlankChar 
pos=len(str) 
isBlankChar=true 
while isBlankChar and pos>=2 
if mid(str,pos,1)=" " then 
pos=pos-1 
elseif mid(str,pos-1,2)=VBcrlf then 
pos=pos-2 
else 
isBlankChar=false 
end if 
wend 
rtrimVBcrlf=rtrim(left(str,pos)) 
end function 
      

  Function check_op(s_chr,d_chr)
	POP = INSTR(s_chr,d_chr)
		IF POP >0 THEN
		check_op = "checked"
		ELSE
		check_op = ""
		END IF	
 End Function
	set CONN = Server.CreateObject("ADODB.Connection")
    CONN.open CONNSTR,"",""  
	set RS = Server.CreateObject("ADODB.RecordSet")
	set RS1 = Server.CreateObject("ADODB.RecordSet")
	set RSLIB = Server.CreateObject("ADODB.RecordSet")
	'判断权限
	SQL = "SELECT * FROM WB_ARTICLE WHERE INFO_NO = '" & REQUEST("INFO_NO") & "'"
	RS.Open SQL,CONN,adOpenKeyset,adLockReadOnly
		IF RS.RecordCount >0 THEN
		ELSE
		Response.Write "对不起，本记录不能修改，原因可能是已经审核或则不是您输入的记录"
		Response.End 
		END IF
	
	%> 
<html>
<head>
<title>内容与文章详细内容</title>
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
  <p>&nbsp;</p>
  <p><font color="#0000FF" class="main">（内部资料系统管理）内容与文章系统详细内容 </font></p>
</div>
<hr width="600" size="0">
<form method="POST" action="article_modi.asp" name="un" >
  <input type=hidden name=info_no value="<%=request("info_no")%>">
  <table width="767" border="0" bordercolordark="#99CCFF" bordercolorlight="#99CCFF" cellspacing="1" align="center" cellpadding="6" bgcolor="#000000">
    <tr bgcolor="#FFFFFF"> 
      <td width="14%" class="main">大类别：</td>
      <td width="32%" class="main"> <%=DISPLAY_NAME("B_SHORT",RS("CLASS_PZ"),"B_ID","C_NAME")
        %> </td>
      <td width="13%" class="main">小类别：</td>
      <td width="41%" class="main"><%=DISPLAY_NAME("S_SHORT",RS("S_ID"),"S_ID","C_NAME")
        %></td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="14%" class="main">国家：</td>
      <td width="32%" class="main"> <%=DISPLAY_NAME("COUNTRY",RS("STATE"),"STATE","C_NAME")
        %> </td>
      <td width="13%" class="main">网站总栏目：</td>
      <td width="41%" class="main"><%=DISPLAY_NAME("P_CLASS",RS("P_CLASS_NO"),"P_CLASS_NO","P_CLASS_NAME")
        %></td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="14%" class="main">网站次栏目：</td>
      <td width="32%" class="main"> <%=DISPLAY_NAME("S_CLASS",RS("CLASS_NO"),"CLASS_NO","CLASS_NAME")
        %> </td>
      <td width="13%" class="main">气象：</td>
      <td width="41%" class="main"><small><font face="Verdana"> <%=rs("climate")%></font></small></td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="14%" class="main">经济：</td>
      <td width="32%" class="main"> <%=rs("econnmy")%></td>
      <td width="13%" class="main">资料标题：</td>
      <td width="41%" class="main"><%=rs("info_title")%></td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="14%" class="main">简介：</td>
      <td colspan="3" class="main"> <%
      IF RS("IF_HTML") = "否" Then
      
		  MHY_S = ""
            EE = Split(rs("info_desc"), Chr(13))
            For EI = 0 To UBound(EE)

                If Len(EE(EI)) > 1 Then

                    ss_info_desc = trimVBcrlf(EE(EI))

                    MHY_S = MHY_S & ss_info_desc & Chr(13)

                End If

            Next
            my_text = MHY_S

            XTH = "<p style='text-indent: 2em; text-align: justify; line-height: 1.5em; margin-bottom: 15px; margin-top: 15px;'>    <span style='color: rgb(0, 0, 0); font-family: 微软雅黑, 'Microsoft YaHei';'>"
            XTHJW = "</span></p>"
            my_text = Replace(my_text, Chr(13), XTHJW & XTH)
            my_text = XTH & my_text & XTHJW
			body = my_text
	  ELSE
		body = RS("INFO_DESC")
	  END IF
      %><%=body%> <%
        IF RS("INFO_SOURCE") = "各地日报" THEN
			IF TRIM(RS("INFO_DESC")) = "压榨利润" THEN
			%> <a href="/lan_manage/gdrb/profit_nb_search.asp" target='blank'>详细内容</a> 
        <%
			ELSE
			%> <a href="/lan_manage/gdrb/gdrb_fb_search.asp" target='blank'>详细内容</a> 
        <%
			END IF
        END IF
        %> <%
        IF RS("INFO_SOURCE") = "GDRB" THEN
			%> <a href="/lan_manage/gwrb/news_gwrb.asp" target='blank'>详细内容</a> 
        <%
        END IF
        %> </td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="14%" class="main">资料的文件：</td>
      <td width="32%" class="main"><small><font face="Verdana"> (目前文件为：<a href="/<%=display_name("b_short",rs("class_pz"),"b_id","file_path")%>/<%=rs("info_file")%>" target='blank'><%=rs("info_file")%></a>) 
        </font></small></td>
      <td width="13%" class="main">查找字符串：</td>
      <td width="41%" class="main"><%=rs("info_find")%></td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="14%" class="main">相关查询字符：</td>
      <td width="32%" class="main"><small> <%=rs("info_corre")%></small></td>
      <td width="13%" class="main">资料来源：</td>
      <td width="41%" class="main"><%=rs("info_source")%></td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="14%" class="main">作者： </td>
      <td width="32%" class="main"><small><font face="Verdana"> <%=rs("info_author")%></font></small></td>
      <td width="13%" class="main">备注：</td>
      <td width="41%" class="main"><%=rs("remark")%></td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="14%" class="main" height="37">文章编号：</td>
      <td width="32%" class="main" height="37"><small><font face="Verdana"><%=rs("s_article_no")%> 
        </font></small></td>
      <td width="13%" class="main" height="37">来源编号：</td>
      <td width="41%" class="main" height="37"><%=rs("x_article_no")%></td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="14%" class="main">是否放入外网：</td>
      <td width="32%" class="main"><%=rs("info_type")%> </td>
      <td width="13%" class="main">操作人：</td>
      <td width="41%" class="main"><%=rs("person")%></td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="23%" class="main">相关类别：</td>
      <td colspan="3" class="main">   <table width="100%" border="1" cellspacing="0" cellpadding="3" class="main" bordercolor="#000000" bordercolordark="#FFFFFF" bordercolorlight="#000000">
      
        <%
          if Rs("p_class_no") <> "990002" then
          %> 
          <tr> 
            <td width="12%"><font color="#0000FF">世界经济</font></td>
            <td width="88%"> 
              <input type="radio" name="sjjj" value="" checked>
              无 
              <input type="radio" name="sjjj" value="100005" <%=check_op(rs("class_corre"),"100005")%>>
              世界 
              <input type="radio" name="sjjj" value="100006" <%=check_op(rs("class_corre"),"100006")%>>
              中国 
              <input type="radio" name="sjjj" value="100007" <%=check_op(rs("class_corre"),"100007")%>>
              美国 
              <input type="radio" name="sjjj" value="100008" <%=check_op(rs("class_corre"),"100008")%>>
              欧洲 
              <input type="radio" name="sjjj" value="100009" <%=check_op(rs("class_corre"),"100009")%>>
              日本 
              <input type="radio" name="sjjj" value="100010" <%=check_op(rs("class_corre"),"100010")%>>
              其他 </td>
          </tr>
          <%
          else
          %> 
          <tr> 
            <td width="12%"><font color="#0000FF">世界经济</font></td>
            <td width="88%"> 
              <input type="radio" name="sjjj" value="" checked>
              无 （<font color=red>上面已经选择了本栏目</font>）<font color=blue>世界经济</font>---><font color=red><%=display_name("s_class",rs("class_no"),"class_no","class_name")%></font> 
            </td>
          </tr>
          <%
          end if
          %> <%
         if Rs("p_class_no") <> "990010" then
         %> 
          <tr> 
            <td width="12%"><font color="#0000FF">各国农业</font></td>
            <td width="88%"> 
              <input type="radio" name="ggny" value="" checked>
              无 
              <input type="radio" name="ggny" value="100040" <%=check_op(rs("class_corre"),"100040")%>>
              世界 
              <input type="radio" name="ggny" value="100041" <%=check_op(rs("class_corre"),"100041")%>>
              美国 
              <input type="radio" name="ggny" value="100042" <%=check_op(rs("class_corre"),"100042")%>>
              南美 
              <input type="radio" name="ggny" value="100043" <%=check_op(rs("class_corre"),"100043")%>>
              欧洲 
              <input type="radio" name="ggny" value="100044" <%=check_op(rs("class_corre"),"100044")%>>
              中国 
              <input type="radio" name="ggny" value="100045" <%=check_op(rs("class_corre"),"100045")%>>
              其他</td>
          </tr>
          <%
          else
          %> 
          <tr> 
            <td width="12%"><font color="#0000FF">各国农业</font></td>
            <td width="88%"> 
              <input type="radio" name="ggny" value="" checked>
              无 （<font color=red>上面已经选择了本栏目</font>）<font color=blue>各国农业</font>---><font color=red><%=display_name("s_class",Rs("class_no"),"class_no","class_name")%></font> 
            </td>
          </tr>
          <%
          end if
          %> <%
         if Rs("p_class_no") <> "990012" then
         %> 
          <tr> 
            <td width="12%"><font color="#0000FF">饲料养殖</font></td>
            <td width="88%"> 
              <input type="radio" name="slyz" value="" checked>
              无 
              <input type="radio" name="slyz" value="100052" <%=check_op(rs("class_corre"),"100052")%>>
              政策 
              <input type="radio" name="slyz" value="100067" <%=check_op(rs("class_corre"),"100067")%>>
              动态 
              <input type="radio" name="slyz" value="100053" <%=check_op(rs("class_corre"),"100053")%>>
              饲料 
              <input type="radio" name="slyz" value="100055" <%=check_op(rs("class_corre"),"100055")%>>
              畜牧
              <input type="radio" name="slyz" value="100065" <%=check_op(rs("class_corre"),"100065")%>>
              家禽
              <input type="radio" name="slyz" value="100066" <%=check_op(rs("class_corre"),"100066")%>>
              水产
              <input type="radio" name="slyz" value="100054" <%=check_op(rs("class_corre"),"100054")%>>
              价格
              <input type="radio" name="slyz" value="100068" <%=check_op(rs("class_corre"),"100068")%>>
              其它 </td>
          </tr>
          <%
          else
          %> 
          <tr> 
            <td width="12%"><font color="#0000FF">饲料养殖</font></td>
            <td width="88%"> 
              <input type="radio" name="slyz" value="" checked>
              无 （<font color=red>上面已经选择了本栏目</font>）<font color=blue>饲料养殖</font>---><font color=red><%=display_name("s_class",rs("class_no"),"class_no","class_name")%></font> 
            </td>
          </tr>
          <%
          end if
          %> <%
         if RS("p_class_no") <> "990016" then
         %> 
          <tr> 
            <td width="12%"><font color="#0000FF">统计资料</font></td>
            <td width="88%"> 
              <input type="radio" name="tjzl" value="" checked>
              无 
              <input type="radio" name="tjzl" value="100071" <%=check_op(rs("class_corre"),"100071")%>>
              平衡图表 
              <input type="radio" name="tjzl" value="100072" <%=check_op(rs("class_corre"),"100072")%>>
              海关数据 
              <input type="radio" name="tjzl" value="100073" <%=check_op(rs("class_corre"),"100073")%>>
              产量图表 
              <input type="radio" name="tjzl" value="100074" <%=check_op(rs("class_corre"),"100074")%>>
              价格图表 
              <input type="radio" name="tjzl" value="100075" <%=check_op(rs("class_corre"),"100075")%>>
              播种图表 
              <input type="radio" name="tjzl" value="100076" <%=check_op(rs("class_corre"),"100076")%>>
              其它数据 </td>
          </tr>
          <%
          else
          %> 
          <tr> 
            <td width="12%"><font color="#0000FF">统计资料</font></td>
            <td width="88%"> 
              <input type="radio" name="tjzl" value="" checked>
              无 （<font color=red>上面已经选择了本栏目</font>）<font color=blue>统计资料</font>---><font color=red><%=display_name("s_class",Rs("class_no"),"class_no","class_name")%></font> 
            </td>
          </tr>
          <%
          end if
          %> <%
         if Rs("p_class_no") <> "990005" then
         %> 
          <tr> 
            <td width="12%"><font color="#0000FF">气象预报</font></td>
            <td width="88%"> 
              <input type="radio" name="qxyb" value="" checked>
              无 
              <input type="radio" name="qxyb" value="100019" <%=check_op(rs("class_corre"),"100019")%>>
              中国 
              <input type="radio" name="qxyb" value="100020" <%=check_op(rs("class_corre"),"100020")%>>
              美国 
              <input type="radio" name="qxyb" value="100021" <%=check_op(rs("class_corre"),"100021")%>>
              巴西 
              <input type="radio" name="qxyb" value="100022" <%=check_op(rs("class_corre"),"100022")%>>
              阿根廷 
              <input type="radio" name="qxyb" value="100023" <%=check_op(rs("class_corre"),"100023")%>>
              秘鲁 
              <input type="radio" name="qxyb" value="100024" <%=check_op(rs("class_corre"),"100024")%>>
              气象知识</td>
          </tr>
          <%
          else
          %> 
          <tr> 
            <td width="12%"><font color="#0000FF">气象预报</font></td>
            <td width="88%"> 
              <input type="radio" name="qxyb" value="" checked>
              无 （<font color=red>上面已经选择了本栏目</font>）<font color=blue>气象预报</font>---><font color=red><%=display_name("s_class",rs("class_no"),"class_no","class_name")%></font> 
            </td>
          </tr>
          <%
          end if
          %> <%
         if Rs("p_class_no") <> "990013" then
         %> 
          <tr> 
            <td width="12%"><font color="#0000FF">港口海关</font></td>
            <td width="88%"> 
              <input type="radio" name="gkhg" value="" checked>
              无 
              <input type="radio" name="gkhg" value="100057" <%=check_op(rs("class_corre"),"100057")%>>
              预报与库存 
              <input type="radio" name="gkhg" value="100030" <%=check_op(rs("class_corre"),"100030")%>>
              统计 </td>
          </tr>
          <%
          else
          %> 
          <tr> 
            <td width="12%"><font color="#0000FF">港口海关</font></td>
            <td width="88%"> 
              <input type="radio" name="gkhg" value="" checked>
              无 （<font color=red>上面已经选择了本栏目</font>）<font color=blue>港口海关</font>---><font color=red><%=display_name("s_class",rs("class_no"),"class_no","class_name")%></font> 
            </td>
          </tr>
          <%
          end if
          %> <%
         if Rs("p_class_no") <> "990014" then
         %> 
          <tr> 
            <td width="12%"><font color="#0000FF">政策动态</font></td>
            <td width="88%"> 
              <input type="radio" name="zcdt" value="" checked>
              无 
              <input type="radio" name="zcdt" value="100058" <%=check_op(rs("class_corre"),"100058")%>>
              农业政策 
              <input type="radio" name="zcdt" value="100060" <%=check_op(rs("class_corre"),"100060")%>>
              粮食政策 
              <input type="radio" name="zcdt" value="100061" <%=check_op(rs("class_corre"),"100061")%>>
              饲料政策 
              <input type="radio" name="zcdt" value="100062" <%=check_op(rs("class_corre"),"100062")%>>
              贸易政策 
              <input type="radio" name="zcdt" value="100063" <%=check_op(rs("class_corre"),"100063")%>>
              其他相关 
              <input type="radio" name="zcdt" value="100064" <%=check_op(rs("class_corre"),"100064")%>>
              国家标准 </td>
          </tr>
          <%
          else
          %> 
          <tr> 
            <td width="12%"><font color="#0000FF">政策动态</font></td>
            <td width="88%"> 
              <input type="radio" name="zcdt" value="" checked>
              无 （<font color=red>上面已经选择了本栏目</font>）<font color=blue>政策动态</font>---><font color=red><%=display_name("s_class",rs("class_no"),"class_no","class_name")%></font> 
            </td>
          </tr>
          <%
          end if
          %> <%
         if Rs("p_class_no") <> "990015" then
         %> 
          <tr> 
            <td width="12%"><font color="#0000FF">综合资讯</font></td>
            <td width="88%"> 
              <input type="radio" name="zhzx" value="" checked>
              无 
              <input type="radio" name="zhzx" value="100036" <%=check_op(rs("class_corre"),"100036")%>>
              股市杂谈 
              <input type="radio" name="zhzx" value="100037" <%=check_op(rs("class_corre"),"100037")%>>
              中外期货 
              <input type="radio" name="zhzx" value="100038" <%=check_op(rs("class_corre"),"100038")%>>
              管理园地 
              <input type="radio" name="zhzx" value="100039" <%=check_op(rs("class_corre"),"100039")%>>
              科技生活 
              <input type="radio" name="zhzx" value="100048" <%=check_op(rs("class_corre"),"100048")%>>
              社会新闻 
              <input type="radio" name="zhzx" value="100049" <%=check_op(rs("class_corre"),"100049")%>>
              会展会讯 </td>
          </tr>
          <%
          else
          %> 
          <tr> 
            <td width="12%"><font color="#0000FF">综合资讯</font></td>
            <td width="88%"> 
              <input type="radio" name="zhzx" value="" checked>
              无 （<font color=red>上面已经选择了本栏目</font>）<font color=blue>综合资讯</font>---><font color=red><%=display_name("s_class",rs("class_no"),"class_no","class_name")%></font> 
            </td>
          </tr>
          <%
          end if
          %> <%
         if Rs("p_class_no") <> "990001" then
         %> 
          <tr> 
            <td width="12%"><font color="#0000FF">品种频道</font></td>
            <td width="88%"> 
              <input type="radio" name="pzpd" value="" checked>
              无 
              <input type="radio" name="pzpd" value="100001" <%=check_op(rs("class_corre"),"100059")%>>
              问答园地 
              <input type="radio" name="pzpd" value="100001" <%=check_op(rs("class_corre"),"100001")%>>
              特别报道 
              <input type="radio" name="pzpd" value="100011" <%=check_op(rs("class_corre"),"100011")%>>
              分析预测 
              <input type="radio" name="pzpd" value="100002" <%=check_op(rs("class_corre"),"100002")%>>
              每周评论 
              <input type="radio" name="pzpd" value="100003" <%=check_op(rs("class_corre"),"100003")%>>
              月度述评 
              <input type="radio" name="pzpd" value="100004" <%=check_op(rs("class_corre"),"100004")%>>
              年度综述 
              <input type="radio" name="pzpd" value="100046" <%=check_op(rs("class_corre"),"100046")%>>
              独家视点 
              <input type="radio" name="pzpd" value="100047" <%=check_op(rs("class_corre"),"100047")%>>
              相关要闻 
              <input type="radio" name="pzpd" value="100014" <%=check_op(rs("class_corre"),"100014")%>>
              贸易 
              <input type="radio" name="pzpd" value="100016" <%=check_op(rs("class_corre"),"100016")%>>
              期货 </td>
          </tr>
          <%
          else
          %> 
          <tr> 
            <td width="12%"><font color="#0000FF">品种频道</font></td>
            <td width="88%"> 
              <input type="radio" name="pzpd" value="" checked>
              无 （<font color=red>上面已经选择了本栏目</font>）<font color=blue>品种频道</font>---><font color=red><%=display_name("s_class",rs("class_no"),"class_no","class_name")%></font> 
            </td>
          </tr>
          <%
          end if
          %> 
        </table>
      </td>
    </tr>
    
   
    <tr bgcolor="#FFFFFF">
      <td width="23%" class="main">是否最新资讯：</td>
      <td colspan="3" class="main"><%=rs("if_zx")%></td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="23%" class="main">是否综合报道：</td>
      <td colspan="3" class="main"><%=rs("if_zh")%></td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="23%" class="main">是否推荐资讯：</td>
      <td colspan="3" class="main"><%=rs("if_tj")%> </td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td colspan="4"> 
        <div align="center"><br>
          <input type="button" name="home" value="关闭窗口" onClick=self.close();>
          <input type="submit" name="Submit" value="修改记录">
        </div>
      </td>
  </table>
</form>
</body>
</html>
