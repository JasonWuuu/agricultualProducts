<!-- #include virtual = "/include/mylib1105.asp" -->

<!-- #include virtual = "/include/auth.asp" -->
<!-- #include virtual = "/include/sql.asp" -->

 <%
	'���ߣ������  �� 2002-4-21 ��д
	'���ܣ��޸�����
	'���������ű�������Ա����
 
'ȥ���ַ���ͷβ�������Ļس��Ϳո� 
function trimVBcrlf(str) 
trimVBcrlf=rtrimVBcrlf(ltrimVBcrlf(str)) 
end function 

'ȥ���ַ�����ͷ�������Ļس��Ϳո� 
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

'ȥ���ַ���ĩβ�������Ļس��Ϳո� 
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
	'�ж�Ȩ��
	SQL = "SELECT * FROM WB_ARTICLE WHERE INFO_NO = '" & REQUEST("INFO_NO") & "'"
	RS.Open SQL,CONN,adOpenKeyset,adLockReadOnly
		IF RS.RecordCount >0 THEN
		ELSE
		Response.Write "�Բ��𣬱���¼�����޸ģ�ԭ��������Ѿ���˻�����������ļ�¼"
		Response.End 
		END IF
	
	%> 
<html>
<head>
<title>������������ϸ����</title>
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
  <p><font color="#0000FF" class="main">���ڲ�����ϵͳ��������������ϵͳ��ϸ���� </font></p>
</div>
<hr width="600" size="0">
<form method="POST" action="article_modi.asp" name="un" >
  <input type=hidden name=info_no value="<%=request("info_no")%>">
  <table width="767" border="0" bordercolordark="#99CCFF" bordercolorlight="#99CCFF" cellspacing="1" align="center" cellpadding="6" bgcolor="#000000">
    <tr bgcolor="#FFFFFF"> 
      <td width="14%" class="main">�����</td>
      <td width="32%" class="main"> <%=DISPLAY_NAME("B_SHORT",RS("CLASS_PZ"),"B_ID","C_NAME")
        %> </td>
      <td width="13%" class="main">С���</td>
      <td width="41%" class="main"><%=DISPLAY_NAME("S_SHORT",RS("S_ID"),"S_ID","C_NAME")
        %></td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="14%" class="main">���ң�</td>
      <td width="32%" class="main"> <%=DISPLAY_NAME("COUNTRY",RS("STATE"),"STATE","C_NAME")
        %> </td>
      <td width="13%" class="main">��վ����Ŀ��</td>
      <td width="41%" class="main"><%=DISPLAY_NAME("P_CLASS",RS("P_CLASS_NO"),"P_CLASS_NO","P_CLASS_NAME")
        %></td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="14%" class="main">��վ����Ŀ��</td>
      <td width="32%" class="main"> <%=DISPLAY_NAME("S_CLASS",RS("CLASS_NO"),"CLASS_NO","CLASS_NAME")
        %> </td>
      <td width="13%" class="main">����</td>
      <td width="41%" class="main"><small><font face="Verdana"> <%=rs("climate")%></font></small></td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="14%" class="main">���ã�</td>
      <td width="32%" class="main"> <%=rs("econnmy")%></td>
      <td width="13%" class="main">���ϱ��⣺</td>
      <td width="41%" class="main"><%=rs("info_title")%></td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="14%" class="main">��飺</td>
      <td colspan="3" class="main"> <%
      IF RS("IF_HTML") = "��" Then
      
		  MHY_S = ""
            EE = Split(rs("info_desc"), Chr(13))
            For EI = 0 To UBound(EE)

                If Len(EE(EI)) > 1 Then

                    ss_info_desc = trimVBcrlf(EE(EI))

                    MHY_S = MHY_S & ss_info_desc & Chr(13)

                End If

            Next
            my_text = MHY_S

            XTH = "<p style='text-indent: 2em; text-align: justify; line-height: 1.5em; margin-bottom: 15px; margin-top: 15px;'>    <span style='color: rgb(0, 0, 0); font-family: ΢���ź�, 'Microsoft YaHei';'>"
            XTHJW = "</span></p>"
            my_text = Replace(my_text, Chr(13), XTHJW & XTH)
            my_text = XTH & my_text & XTHJW
			body = my_text
	  ELSE
		body = RS("INFO_DESC")
	  END IF
      %><%=body%> <%
        IF RS("INFO_SOURCE") = "�����ձ�" THEN
			IF TRIM(RS("INFO_DESC")) = "ѹե����" THEN
			%> <a href="/lan_manage/gdrb/profit_nb_search.asp" target='blank'>��ϸ����</a> 
        <%
			ELSE
			%> <a href="/lan_manage/gdrb/gdrb_fb_search.asp" target='blank'>��ϸ����</a> 
        <%
			END IF
        END IF
        %> <%
        IF RS("INFO_SOURCE") = "GDRB" THEN
			%> <a href="/lan_manage/gwrb/news_gwrb.asp" target='blank'>��ϸ����</a> 
        <%
        END IF
        %> </td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="14%" class="main">���ϵ��ļ���</td>
      <td width="32%" class="main"><small><font face="Verdana"> (Ŀǰ�ļ�Ϊ��<a href="/<%=display_name("b_short",rs("class_pz"),"b_id","file_path")%>/<%=rs("info_file")%>" target='blank'><%=rs("info_file")%></a>) 
        </font></small></td>
      <td width="13%" class="main">�����ַ�����</td>
      <td width="41%" class="main"><%=rs("info_find")%></td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="14%" class="main">��ز�ѯ�ַ���</td>
      <td width="32%" class="main"><small> <%=rs("info_corre")%></small></td>
      <td width="13%" class="main">������Դ��</td>
      <td width="41%" class="main"><%=rs("info_source")%></td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="14%" class="main">���ߣ� </td>
      <td width="32%" class="main"><small><font face="Verdana"> <%=rs("info_author")%></font></small></td>
      <td width="13%" class="main">��ע��</td>
      <td width="41%" class="main"><%=rs("remark")%></td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="14%" class="main" height="37">���±�ţ�</td>
      <td width="32%" class="main" height="37"><small><font face="Verdana"><%=rs("s_article_no")%> 
        </font></small></td>
      <td width="13%" class="main" height="37">��Դ��ţ�</td>
      <td width="41%" class="main" height="37"><%=rs("x_article_no")%></td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="14%" class="main">�Ƿ����������</td>
      <td width="32%" class="main"><%=rs("info_type")%> </td>
      <td width="13%" class="main">�����ˣ�</td>
      <td width="41%" class="main"><%=rs("person")%></td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="23%" class="main">������</td>
      <td colspan="3" class="main">   <table width="100%" border="1" cellspacing="0" cellpadding="3" class="main" bordercolor="#000000" bordercolordark="#FFFFFF" bordercolorlight="#000000">
      
        <%
          if Rs("p_class_no") <> "990002" then
          %> 
          <tr> 
            <td width="12%"><font color="#0000FF">���羭��</font></td>
            <td width="88%"> 
              <input type="radio" name="sjjj" value="" checked>
              �� 
              <input type="radio" name="sjjj" value="100005" <%=check_op(rs("class_corre"),"100005")%>>
              ���� 
              <input type="radio" name="sjjj" value="100006" <%=check_op(rs("class_corre"),"100006")%>>
              �й� 
              <input type="radio" name="sjjj" value="100007" <%=check_op(rs("class_corre"),"100007")%>>
              ���� 
              <input type="radio" name="sjjj" value="100008" <%=check_op(rs("class_corre"),"100008")%>>
              ŷ�� 
              <input type="radio" name="sjjj" value="100009" <%=check_op(rs("class_corre"),"100009")%>>
              �ձ� 
              <input type="radio" name="sjjj" value="100010" <%=check_op(rs("class_corre"),"100010")%>>
              ���� </td>
          </tr>
          <%
          else
          %> 
          <tr> 
            <td width="12%"><font color="#0000FF">���羭��</font></td>
            <td width="88%"> 
              <input type="radio" name="sjjj" value="" checked>
              �� ��<font color=red>�����Ѿ�ѡ���˱���Ŀ</font>��<font color=blue>���羭��</font>---><font color=red><%=display_name("s_class",rs("class_no"),"class_no","class_name")%></font> 
            </td>
          </tr>
          <%
          end if
          %> <%
         if Rs("p_class_no") <> "990010" then
         %> 
          <tr> 
            <td width="12%"><font color="#0000FF">����ũҵ</font></td>
            <td width="88%"> 
              <input type="radio" name="ggny" value="" checked>
              �� 
              <input type="radio" name="ggny" value="100040" <%=check_op(rs("class_corre"),"100040")%>>
              ���� 
              <input type="radio" name="ggny" value="100041" <%=check_op(rs("class_corre"),"100041")%>>
              ���� 
              <input type="radio" name="ggny" value="100042" <%=check_op(rs("class_corre"),"100042")%>>
              ���� 
              <input type="radio" name="ggny" value="100043" <%=check_op(rs("class_corre"),"100043")%>>
              ŷ�� 
              <input type="radio" name="ggny" value="100044" <%=check_op(rs("class_corre"),"100044")%>>
              �й� 
              <input type="radio" name="ggny" value="100045" <%=check_op(rs("class_corre"),"100045")%>>
              ����</td>
          </tr>
          <%
          else
          %> 
          <tr> 
            <td width="12%"><font color="#0000FF">����ũҵ</font></td>
            <td width="88%"> 
              <input type="radio" name="ggny" value="" checked>
              �� ��<font color=red>�����Ѿ�ѡ���˱���Ŀ</font>��<font color=blue>����ũҵ</font>---><font color=red><%=display_name("s_class",Rs("class_no"),"class_no","class_name")%></font> 
            </td>
          </tr>
          <%
          end if
          %> <%
         if Rs("p_class_no") <> "990012" then
         %> 
          <tr> 
            <td width="12%"><font color="#0000FF">������ֳ</font></td>
            <td width="88%"> 
              <input type="radio" name="slyz" value="" checked>
              �� 
              <input type="radio" name="slyz" value="100052" <%=check_op(rs("class_corre"),"100052")%>>
              ���� 
              <input type="radio" name="slyz" value="100067" <%=check_op(rs("class_corre"),"100067")%>>
              ��̬ 
              <input type="radio" name="slyz" value="100053" <%=check_op(rs("class_corre"),"100053")%>>
              ���� 
              <input type="radio" name="slyz" value="100055" <%=check_op(rs("class_corre"),"100055")%>>
              ����
              <input type="radio" name="slyz" value="100065" <%=check_op(rs("class_corre"),"100065")%>>
              ����
              <input type="radio" name="slyz" value="100066" <%=check_op(rs("class_corre"),"100066")%>>
              ˮ��
              <input type="radio" name="slyz" value="100054" <%=check_op(rs("class_corre"),"100054")%>>
              �۸�
              <input type="radio" name="slyz" value="100068" <%=check_op(rs("class_corre"),"100068")%>>
              ���� </td>
          </tr>
          <%
          else
          %> 
          <tr> 
            <td width="12%"><font color="#0000FF">������ֳ</font></td>
            <td width="88%"> 
              <input type="radio" name="slyz" value="" checked>
              �� ��<font color=red>�����Ѿ�ѡ���˱���Ŀ</font>��<font color=blue>������ֳ</font>---><font color=red><%=display_name("s_class",rs("class_no"),"class_no","class_name")%></font> 
            </td>
          </tr>
          <%
          end if
          %> <%
         if RS("p_class_no") <> "990016" then
         %> 
          <tr> 
            <td width="12%"><font color="#0000FF">ͳ������</font></td>
            <td width="88%"> 
              <input type="radio" name="tjzl" value="" checked>
              �� 
              <input type="radio" name="tjzl" value="100071" <%=check_op(rs("class_corre"),"100071")%>>
              ƽ��ͼ�� 
              <input type="radio" name="tjzl" value="100072" <%=check_op(rs("class_corre"),"100072")%>>
              �������� 
              <input type="radio" name="tjzl" value="100073" <%=check_op(rs("class_corre"),"100073")%>>
              ����ͼ�� 
              <input type="radio" name="tjzl" value="100074" <%=check_op(rs("class_corre"),"100074")%>>
              �۸�ͼ�� 
              <input type="radio" name="tjzl" value="100075" <%=check_op(rs("class_corre"),"100075")%>>
              ����ͼ�� 
              <input type="radio" name="tjzl" value="100076" <%=check_op(rs("class_corre"),"100076")%>>
              �������� </td>
          </tr>
          <%
          else
          %> 
          <tr> 
            <td width="12%"><font color="#0000FF">ͳ������</font></td>
            <td width="88%"> 
              <input type="radio" name="tjzl" value="" checked>
              �� ��<font color=red>�����Ѿ�ѡ���˱���Ŀ</font>��<font color=blue>ͳ������</font>---><font color=red><%=display_name("s_class",Rs("class_no"),"class_no","class_name")%></font> 
            </td>
          </tr>
          <%
          end if
          %> <%
         if Rs("p_class_no") <> "990005" then
         %> 
          <tr> 
            <td width="12%"><font color="#0000FF">����Ԥ��</font></td>
            <td width="88%"> 
              <input type="radio" name="qxyb" value="" checked>
              �� 
              <input type="radio" name="qxyb" value="100019" <%=check_op(rs("class_corre"),"100019")%>>
              �й� 
              <input type="radio" name="qxyb" value="100020" <%=check_op(rs("class_corre"),"100020")%>>
              ���� 
              <input type="radio" name="qxyb" value="100021" <%=check_op(rs("class_corre"),"100021")%>>
              ���� 
              <input type="radio" name="qxyb" value="100022" <%=check_op(rs("class_corre"),"100022")%>>
              ����͢ 
              <input type="radio" name="qxyb" value="100023" <%=check_op(rs("class_corre"),"100023")%>>
              ��³ 
              <input type="radio" name="qxyb" value="100024" <%=check_op(rs("class_corre"),"100024")%>>
              ����֪ʶ</td>
          </tr>
          <%
          else
          %> 
          <tr> 
            <td width="12%"><font color="#0000FF">����Ԥ��</font></td>
            <td width="88%"> 
              <input type="radio" name="qxyb" value="" checked>
              �� ��<font color=red>�����Ѿ�ѡ���˱���Ŀ</font>��<font color=blue>����Ԥ��</font>---><font color=red><%=display_name("s_class",rs("class_no"),"class_no","class_name")%></font> 
            </td>
          </tr>
          <%
          end if
          %> <%
         if Rs("p_class_no") <> "990013" then
         %> 
          <tr> 
            <td width="12%"><font color="#0000FF">�ۿں���</font></td>
            <td width="88%"> 
              <input type="radio" name="gkhg" value="" checked>
              �� 
              <input type="radio" name="gkhg" value="100057" <%=check_op(rs("class_corre"),"100057")%>>
              Ԥ������ 
              <input type="radio" name="gkhg" value="100030" <%=check_op(rs("class_corre"),"100030")%>>
              ͳ�� </td>
          </tr>
          <%
          else
          %> 
          <tr> 
            <td width="12%"><font color="#0000FF">�ۿں���</font></td>
            <td width="88%"> 
              <input type="radio" name="gkhg" value="" checked>
              �� ��<font color=red>�����Ѿ�ѡ���˱���Ŀ</font>��<font color=blue>�ۿں���</font>---><font color=red><%=display_name("s_class",rs("class_no"),"class_no","class_name")%></font> 
            </td>
          </tr>
          <%
          end if
          %> <%
         if Rs("p_class_no") <> "990014" then
         %> 
          <tr> 
            <td width="12%"><font color="#0000FF">���߶�̬</font></td>
            <td width="88%"> 
              <input type="radio" name="zcdt" value="" checked>
              �� 
              <input type="radio" name="zcdt" value="100058" <%=check_op(rs("class_corre"),"100058")%>>
              ũҵ���� 
              <input type="radio" name="zcdt" value="100060" <%=check_op(rs("class_corre"),"100060")%>>
              ��ʳ���� 
              <input type="radio" name="zcdt" value="100061" <%=check_op(rs("class_corre"),"100061")%>>
              �������� 
              <input type="radio" name="zcdt" value="100062" <%=check_op(rs("class_corre"),"100062")%>>
              ó������ 
              <input type="radio" name="zcdt" value="100063" <%=check_op(rs("class_corre"),"100063")%>>
              ������� 
              <input type="radio" name="zcdt" value="100064" <%=check_op(rs("class_corre"),"100064")%>>
              ���ұ�׼ </td>
          </tr>
          <%
          else
          %> 
          <tr> 
            <td width="12%"><font color="#0000FF">���߶�̬</font></td>
            <td width="88%"> 
              <input type="radio" name="zcdt" value="" checked>
              �� ��<font color=red>�����Ѿ�ѡ���˱���Ŀ</font>��<font color=blue>���߶�̬</font>---><font color=red><%=display_name("s_class",rs("class_no"),"class_no","class_name")%></font> 
            </td>
          </tr>
          <%
          end if
          %> <%
         if Rs("p_class_no") <> "990015" then
         %> 
          <tr> 
            <td width="12%"><font color="#0000FF">�ۺ���Ѷ</font></td>
            <td width="88%"> 
              <input type="radio" name="zhzx" value="" checked>
              �� 
              <input type="radio" name="zhzx" value="100036" <%=check_op(rs("class_corre"),"100036")%>>
              ������̸ 
              <input type="radio" name="zhzx" value="100037" <%=check_op(rs("class_corre"),"100037")%>>
              �����ڻ� 
              <input type="radio" name="zhzx" value="100038" <%=check_op(rs("class_corre"),"100038")%>>
              ����԰�� 
              <input type="radio" name="zhzx" value="100039" <%=check_op(rs("class_corre"),"100039")%>>
              �Ƽ����� 
              <input type="radio" name="zhzx" value="100048" <%=check_op(rs("class_corre"),"100048")%>>
              ������� 
              <input type="radio" name="zhzx" value="100049" <%=check_op(rs("class_corre"),"100049")%>>
              ��չ��Ѷ </td>
          </tr>
          <%
          else
          %> 
          <tr> 
            <td width="12%"><font color="#0000FF">�ۺ���Ѷ</font></td>
            <td width="88%"> 
              <input type="radio" name="zhzx" value="" checked>
              �� ��<font color=red>�����Ѿ�ѡ���˱���Ŀ</font>��<font color=blue>�ۺ���Ѷ</font>---><font color=red><%=display_name("s_class",rs("class_no"),"class_no","class_name")%></font> 
            </td>
          </tr>
          <%
          end if
          %> <%
         if Rs("p_class_no") <> "990001" then
         %> 
          <tr> 
            <td width="12%"><font color="#0000FF">Ʒ��Ƶ��</font></td>
            <td width="88%"> 
              <input type="radio" name="pzpd" value="" checked>
              �� 
              <input type="radio" name="pzpd" value="100001" <%=check_op(rs("class_corre"),"100059")%>>
              �ʴ�԰�� 
              <input type="radio" name="pzpd" value="100001" <%=check_op(rs("class_corre"),"100001")%>>
              �ر𱨵� 
              <input type="radio" name="pzpd" value="100011" <%=check_op(rs("class_corre"),"100011")%>>
              ����Ԥ�� 
              <input type="radio" name="pzpd" value="100002" <%=check_op(rs("class_corre"),"100002")%>>
              ÿ������ 
              <input type="radio" name="pzpd" value="100003" <%=check_op(rs("class_corre"),"100003")%>>
              �¶����� 
              <input type="radio" name="pzpd" value="100004" <%=check_op(rs("class_corre"),"100004")%>>
              ������� 
              <input type="radio" name="pzpd" value="100046" <%=check_op(rs("class_corre"),"100046")%>>
              �����ӵ� 
              <input type="radio" name="pzpd" value="100047" <%=check_op(rs("class_corre"),"100047")%>>
              ���Ҫ�� 
              <input type="radio" name="pzpd" value="100014" <%=check_op(rs("class_corre"),"100014")%>>
              ó�� 
              <input type="radio" name="pzpd" value="100016" <%=check_op(rs("class_corre"),"100016")%>>
              �ڻ� </td>
          </tr>
          <%
          else
          %> 
          <tr> 
            <td width="12%"><font color="#0000FF">Ʒ��Ƶ��</font></td>
            <td width="88%"> 
              <input type="radio" name="pzpd" value="" checked>
              �� ��<font color=red>�����Ѿ�ѡ���˱���Ŀ</font>��<font color=blue>Ʒ��Ƶ��</font>---><font color=red><%=display_name("s_class",rs("class_no"),"class_no","class_name")%></font> 
            </td>
          </tr>
          <%
          end if
          %> 
        </table>
      </td>
    </tr>
    
   
    <tr bgcolor="#FFFFFF">
      <td width="23%" class="main">�Ƿ�������Ѷ��</td>
      <td colspan="3" class="main"><%=rs("if_zx")%></td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="23%" class="main">�Ƿ��ۺϱ�����</td>
      <td colspan="3" class="main"><%=rs("if_zh")%></td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="23%" class="main">�Ƿ��Ƽ���Ѷ��</td>
      <td colspan="3" class="main"><%=rs("if_tj")%> </td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td colspan="4"> 
        <div align="center"><br>
          <input type="button" name="home" value="�رմ���" onClick=self.close();>
          <input type="submit" name="Submit" value="�޸ļ�¼">
        </div>
      </td>
  </table>
</form>
</body>
</html>
