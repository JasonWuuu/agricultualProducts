<!-- #include virtual = "/include/mylib1105.asp" -->

<!-- #include virtual = "/include/auth.asp" -->



<%
            
	IF REQUEST("HOME") <> "" THEN
	Response.Redirect ("default.asp")
	END IF
	IF REQUEST("search") <> "" THEN
	Response.Redirect ("article_main.asp")
	END IF
	set CONN = Server.CreateObject("ADODB.Connection")
    CONN.open CONNSTR,"",""  
	set RS = Server.CreateObject("ADODB.RecordSet")
	set RS1 = Server.CreateObject("ADODB.RecordSet")
	set RS2 = Server.CreateObject("ADODB.RecordSet")
	set RSLIB = Server.CreateObject("ADODB.RecordSet")
%>
<%

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
      




function checks(c) 

dim str,str1

  str1=c

  intlen=len(c)

  for i=0 to intlen

  str= Asc(str1)

      if (str<23 or str>126) then

      checks=0
      exit for
      else

      checks=1      

      end if

     str1=right(c,intlen-i) '�����ж��ַ�ASCIIֵ

      next     
  end function
  
  
		SQL = "UPDATE WB_HTML SET XG_DATE = '" & DATE & " " & HOUR(TIME) & ":" & MINUTE(TIME) & ":" & SECOND(TIME) & "'"
        CONN.EXECUTE(SQL)
        
	Function RndNumber(MaxNum,MinNum)
    Randomize 
    RndNumber=int((MaxNum-MinNum+1)*rnd+MinNum)
    RndNumber=RndNumber
    End Function
    
		 s_b_id = request("b_id")
		 s_s_id =  request("s_id")
		 s_state = request("state")
		 s_p_class_no =  request("p_class_no")
		 s_class_no =  request("class_no")
		 s_climate =  request("climate")
		 s_econnmy =  request("econnmy")
		 s_info_title =  request("info_title")
		 s_info_desc =   request("info_desc")
		 s_info_find =  request("info_find")
		 s_info_find1 =  request("info_find1")
		 s_info_corre =  request("info_corre")
		 s_info_source =  request("info_source")
		 s_zhuanti =  request("zhuanti")
		 s_pic = request("s_pic")
		 s_author =  request("author")
		 s_remark =  request("remark")
		 s_zt_no = request("zt_no")
		 s_s_article_no =  TRIM(request("s_article_no"))
		 s_x_article_no =  TRIM(request("x_article_no"))
		 if len(s_x_article_no) > 190 then
			s_x_article_no = mid(s_x_article_no,1,180)
		 end if
		 s_nw =  request("nw")
		 s_if_html = request("if_html")
		 s_person_ly = request("person_ly")
		 s_fangshi_ly = request("fangshi_ly")
		 s_jibie = Request("jibie")
		 s_fee = Request("fee")
		 s_city = request("city")
		 if int(s_jibie) >=0 then
		 else
		 response.Write "���������û��ѡ�񣬾ܾ��ύ"
response.end 
		 end if
pop = 0
pop =instr(s_info_title,"����")
if pop >0 then
response.Write "�������н��յ��������������ڴ���"
response.end 
end if
		 
		 '���жϸ���Ʒ�ֵ���Ŀ
		' IF s_b_id = "1005" OR s_b_id = "1006" OR s_b_id = "1009" OR s_b_id = "1019" OR s_b_id = "1026" OR s_b_id = "1027" OR s_b_id = "1028" OR s_b_id = "1022" THEN
		' ELSE
		'    IF s_p_class_no = "990001" THEN
		'            SQL2 = "SELECT TOP 1 * FROM LMXZ WHERE CLASS_PZ = '" & S_B_ID & "' AND KXLM = '" & s_class_no & "'"
		'	    	RS2.Open SQL2,CONN,adOpenKeyset ,adLockReadOnly
		'			IF RS2.RecordCount >0 THEN
		'			
		'			ELSE
		'			Response.Write "�Բ�����ѡ����Ŀ��ʱ��Ӧ���ȿ�����������Ʒ�����Ƿ�����ѡ���С��Ŀ�����������ϵ����Ա�����û�У���������<Ʒ��Ƶ��>�µ�������Ŀ"
		'			Response.End 
		'			END IF
		'		RS2.Close 
		'        ELSE
		'        SQL2 = "SELECT TOP 1 * FROM LMXZ WHERE CLASS_PZ = '" & S_B_ID & "' AND KXLM = '" & s_p_class_no & "'"
		'		RS2.Open SQL2,CONN,adOpenKeyset ,adLockReadOnly
		'			IF RS2.RecordCount >0 THEN
		'			
		'			ELSE
		'			Response.Write "�Բ�����ѡ����Ŀ��ʱ��Ӧ���ȿ�����������Ʒ�����Ƿ�����ѡ�����Ŀ�����������ϵ����Ա�����û�У���������������Ŀ"
		'			Response.End 
		'			END IF
		'		RS2.Close 
		'		END IF
		'		
		' END IF
		 
		 if Request("sjjj") <> "" then
		 s_sjjj=""
			CAOZUO = TRIM(request("sjjj"))
			POP = INSTR(CAOZUO,",")
			I = 0
			WHILE POP >0
			s_sjjj = s_sjjj & "" & TRIM(MID(CAOZUO,1,POP-1)) & ""
			CAOZUO = TRIM(MID(CAOZUO,POP+1))
			POP=INSTR(CAOZUO,",")
			I = I + 1
			WEND
			s_sjjj = s_sjjj & TRIM(MID(CAOZUO,1)) & "990002"
		end if
		if request("ggny") <> "" then
			s_ggny=""
			CAOZUO = TRIM(request("ggny"))
			POP = INSTR(CAOZUO,",")
			I = 0
			WHILE POP >0
			s_ggny = s_ggny & "" & TRIM(MID(CAOZUO,1,POP-1)) & ""
			CAOZUO = TRIM(MID(CAOZUO,POP+1))
			POP=INSTR(CAOZUO,",")
			I = I + 1
			WEND
			s_ggny = s_ggny & TRIM(MID(CAOZUO,1)) & "990010"
		end if
		if request("pzpd") <> "" then
			s_pzpd=""
			CAOZUO = TRIM(request("pzpd"))
			POP = INSTR(CAOZUO,",")
			I = 0
			WHILE POP >0
			s_pzpd = s_pzpd & "" & TRIM(MID(CAOZUO,1,POP-1)) & ""
			CAOZUO = TRIM(MID(CAOZUO,POP+1))
			POP=INSTR(CAOZUO,",")
			I = I + 1
			WEND
			s_pzpd = s_pzpd & TRIM(MID(CAOZUO,1)) & "990001"
		end if
		if Request("jgqs") <> "" Then
			s_jgqs=""
			CAOZUO = TRIM(request("jgqs"))
			POP = INSTR(CAOZUO,",")
			I = 0
			WHILE POP >0
			s_jgqs = s_jgqs & "" & TRIM(MID(CAOZUO,1,POP-1)) & ""
			CAOZUO = TRIM(MID(CAOZUO,POP+1))
			POP=INSTR(CAOZUO,",")
			I = I + 1
			WEND
			s_jgqs = s_jgqs & TRIM(MID(CAOZUO,1)) & "990004"
		end if
		if request("zcdt") <> "" then	
			s_zcdt=""
			CAOZUO = TRIM(request("zcdt"))
			POP = INSTR(CAOZUO,",")
			I = 0
			WHILE POP >0
			s_zcdt = s_zcdt & "" & TRIM(MID(CAOZUO,1,POP-1)) & ""
			CAOZUO = TRIM(MID(CAOZUO,POP+1))
			POP=INSTR(CAOZUO,",")
			I = I + 1
			WEND
			s_zcdt = s_zcdt & TRIM(MID(CAOZUO,1)) & "990014"
		end if
		if request("qxyb") <> "" then
			s_qxyb=""
			CAOZUO = TRIM(request("qxyb"))
			POP = INSTR(CAOZUO,",")
			I = 0
			WHILE POP >0
			s_qxyb = s_qxyb & "" & TRIM(MID(CAOZUO,1,POP-1)) & ""
			CAOZUO = TRIM(MID(CAOZUO,POP+1))
			POP=INSTR(CAOZUO,",")
			I = I + 1
			WEND
			s_qxyb = s_qxyb & TRIM(MID(CAOZUO,1)) & "990005"
		end if
		if request("gkhg") <> "" then
		    s_gkhg=""
			CAOZUO = TRIM(request("gkhg"))
			POP = INSTR(CAOZUO,",")
			I = 0
			WHILE POP >0
			s_gkhg = s_gkhg & "" & TRIM(MID(CAOZUO,1,POP-1)) & ""
			CAOZUO = TRIM(MID(CAOZUO,POP+1))
			POP=INSTR(CAOZUO,",")
			I = I + 1
			WEND
			s_gkhg = s_gkhg & TRIM(MID(CAOZUO,1)) & "990013"
		end if
		if request("slyz") <> "" then
			s_slyz=""
			CAOZUO = TRIM(request("slyz"))
			POP = INSTR(CAOZUO,",")
			I = 0
			WHILE POP >0
			s_slyz = s_slyz & "" & TRIM(MID(CAOZUO,1,POP-1)) & ""
			CAOZUO = TRIM(MID(CAOZUO,POP+1))
			POP=INSTR(CAOZUO,",")
			I = I + 1
			WEND
			s_slyz = s_slyz & TRIM(MID(CAOZUO,1)) & "990012"
		end if
		if request("hydt") <> "" then
			s_yfzp=""
			CAOZUO = TRIM(request("hydt"))
			POP = INSTR(CAOZUO,",")
			I = 0
			WHILE POP >0
			s_yfzp = s_yfzp & "" & TRIM(MID(CAOZUO,1,POP-1)) & ""
			CAOZUO = TRIM(MID(CAOZUO,POP+1))
			POP=INSTR(CAOZUO,",")
			I = I + 1
			WEND
			s_yfzp = s_yfzp & TRIM(MID(CAOZUO,1)) & "990026"
		end if
		if request("qhbj") <> "" then
			s_qhbj=""
			CAOZUO = TRIM(request("qhbj"))
			POP = INSTR(CAOZUO,",")
			I = 0
			WHILE POP >0
			s_qhbj = s_qhbj & "" & TRIM(MID(CAOZUO,1,POP-1)) & ""
			CAOZUO = TRIM(MID(CAOZUO,POP+1))
			POP=INSTR(CAOZUO,",")
			I = I + 1
			WEND
			s_qhbj = s_qhbj & TRIM(MID(CAOZUO,1)) & "990018"
		end if
		if request("spzs") <> "" then
			s_spzs=""
			CAOZUO = TRIM(request("spzs"))
			POP = INSTR(CAOZUO,",")
			I = 0
			WHILE POP >0
			s_spzs = s_spzs & "" & TRIM(MID(CAOZUO,1,POP-1)) & ""
			CAOZUO = TRIM(MID(CAOZUO,POP+1))
			POP=INSTR(CAOZUO,",")
			I = I + 1
			WEND
			s_spzs = s_spzs & TRIM(MID(CAOZUO,1)) & "990023"
		end if
		if request("zztz") <> "" then
			s_zztz=""
			CAOZUO = TRIM(request("zztz"))
			POP = INSTR(CAOZUO,",")
			I = 0
			WHILE POP >0
			s_zztz = s_zztz & "" & TRIM(MID(CAOZUO,1,POP-1)) & ""
			CAOZUO = TRIM(MID(CAOZUO,POP+1))
			POP=INSTR(CAOZUO,",")
			I = I + 1
			WEND
			s_zztz = s_zztz & TRIM(MID(CAOZUO,1)) & "990022"
		end if
		if request("tjzl") <> "" then
			s_tjzl=""
			CAOZUO = TRIM(request("tjzl"))
			POP = INSTR(CAOZUO,",")
			I = 0
			WHILE POP >0
			s_tjzl = s_tjzl & "" & TRIM(MID(CAOZUO,1,POP-1)) & ""
			CAOZUO = TRIM(MID(CAOZUO,POP+1))
			POP=INSTR(CAOZUO,",")
			I = I + 1
			WEND
			s_tjzl = s_tjzl & TRIM(MID(CAOZUO,1)) & "990016"
		end if
		if request("yfjc") <> "" then
			s_yfjc=""
			CAOZUO = TRIM(request("yfjc"))
			POP = INSTR(CAOZUO,",")
			I = 0
			WHILE POP >0
			s_yfjc = s_yfjc & "" & TRIM(MID(CAOZUO,1,POP-1)) & ""
			CAOZUO = TRIM(MID(CAOZUO,POP+1))
			POP=INSTR(CAOZUO,",")
			I = I + 1
			WEND
			s_yfjc = s_yfjc & TRIM(MID(CAOZUO,1)) & "990021"
		end if
		if request("zhzx") <> "" then	
			s_zhzx=""
			CAOZUO = TRIM(request("zhzx"))
			POP = INSTR(CAOZUO,",")
			I = 0
			WHILE POP >0
			s_zhzx = s_zhzx & "" & TRIM(MID(CAOZUO,1,POP-1)) & ""
			CAOZUO = TRIM(MID(CAOZUO,POP+1))
			POP=INSTR(CAOZUO,",")
			I = I + 1
			WEND
			s_zhzx = s_zhzx & TRIM(MID(CAOZUO,1)) & "990015"
		end if	
		if request("nyrl") <> "" then	
			s_zhzx=""
			CAOZUO = TRIM(request("nyrl"))
			POP = INSTR(CAOZUO,",")
			I = 0
			WHILE POP >0
			s_zhzx = s_zhzx & "" & TRIM(MID(CAOZUO,1,POP-1)) & ""
			CAOZUO = TRIM(MID(CAOZUO,POP+1))
			POP=INSTR(CAOZUO,",")
			I = I + 1
			WEND
			s_nyrl = s_nyrl & TRIM(MID(CAOZUO,1)) & "990024"
		end if	
		if request("hyzx") <> "" then	
			s_hyzx=""
			CAOZUO = TRIM(request("hyzx"))
			POP = INSTR(CAOZUO,",")
			I = 0
			WHILE POP >0
			s_hyzx = s_hyzx & "" & TRIM(MID(CAOZUO,1,POP-1)) & ""
			CAOZUO = TRIM(MID(CAOZUO,POP+1))
			POP=INSTR(CAOZUO,",")
			I = I + 1
			WEND
			s_hyzx = s_hyzx & TRIM(MID(CAOZUO,1)) & "990027"
		end if	
				if request("sclr") <> "" then	
			s_sclr=""
			CAOZUO = TRIM(request("sclr"))
			POP = INSTR(CAOZUO,",")
			I = 0
			WHILE POP >0
			s_sclr = s_sclr & "" & TRIM(MID(CAOZUO,1,POP-1)) & ""
			CAOZUO = TRIM(MID(CAOZUO,POP+1))
			POP=INSTR(CAOZUO,",")
			I = I + 1
			WEND
			s_sclr = s_sclr & TRIM(MID(CAOZUO,1)) & "990028"
		end if	
				if request("zftj") <> "" then	
			s_zftj=""
			CAOZUO = TRIM(request("zftj"))
			POP = INSTR(CAOZUO,",")
			I = 0
			WHILE POP >0
			s_zftj = s_zftj & "" & TRIM(MID(CAOZUO,1,POP-1)) & ""
			CAOZUO = TRIM(MID(CAOZUO,POP+1))
			POP=INSTR(CAOZUO,",")
			I = I + 1
			WEND
			s_zftj = s_zftj & TRIM(MID(CAOZUO,1)) & "990029"
		end if	
		 s_ifsh = request("ifsh")
		 IF request("if_zj") ="��" Then
		 s_ifzx = "T"
		 ELSE
		 s_ifzx = "F"
		 end if
		 s_ifzh = request("ifzh")
		 s_if_mf = request("if_mf")
		 's_iffy = request("iffy")
		 s_if_zj = request("if_zj")
		 s_if_zk = request("if_zk")
		 s_check_date = request("check_date")
		 s_tbtj_date = request("tbtj_date")
		 's_class_history = request("class_history")
		 's_history_date = request("history_date")
		 s_info_title = replace(s_info_title,"""","��")
		 s_info_title = replace(s_info_title,"""","��")
		 s_info_title = replace(s_info_title,"'","��")
		 s_info_title = replace(s_info_title,"'","��")
		 pop = 0
		 pop =instr(s_info_title,"<")
		 if pop >0 then
	'	 Response.Write "�Բ��𣬱��ⲻ�������<���ţ���ɫ����ѡ�񣬲�������"
	'	 response.End
		 end if
		 if s_person_ly = "" Then
		    s_person_ly = "�Լ���д"
		 End if
		 if len(s_fangshi_ly)<11 and len(s_fangshi_ly) > 5 then
		    POPO = 0
		    POPO = INSTR(s_fangshi_ly,"Q")
		    if POPO >0 THEN
		    ELSE
		    s_fangshi_ly ="QQ��" & s_fangshi_ly
		    END IF
		 end if
		 if s_fangshi_ly = "" or len(s_fangshi_ly) < 6 Then
		    s_fangshi_ly = "�޷�ʽ"
		 End if
s_color_l =  ""
s_color_r = ""
			s_colorxz = Request("colorxz")
			if s_colorxz <>"" Then
			s_color_l = "<font color=red>"
			s_color_r = "</font>"
			s_ifhot="T"
			else
			s_ifhot="F"
			end if
		 

		 If s_jibie >0 Then
			pop = 0
			pop =instr(s_info_title,"VIP")
			If pop = 0 Then
			pop = 0
				pop =instr(s_info_title,"vip")
				If pop =0 Then
					Response.Write "���Ѿ�ѡ���˹��ʼ���Ŀͻ���������£����ڱ�������ʾ��VIP������лл"
					Response.End 
				End if
			End If
			
		End If
		
'�жϻ�Ѷ
if s_class_no = "100049" then
	m_year = year(s_econnmy)
	
end if
		 
If s_check_date	< date Then
	Response.Write "�Բ��𣬲����޸��������С�ڵ�������ڣ�ֻ�ܴ��ڣ���Ϊ������ǰ�ļ�¼�Ѿ����뵽��ʷ���ݿ���"
	Response.End 
End if


		 if s_info_find1 <> "" and s_class_no <> "100114" then
			pop = instr(s_qhbj,"100114")
			if pop >0 then
			else
			'Response.Write "���Ѿ�ѡ�����ڻ������ݣ�������Ŀ�����ڻ��ټң�������Ӧ�÷���ѡ���ڻ����ۣ��Ĺ���"
			'Response.End 
			end if
		end if
		 if s_if_zj = "��" and s_tbtj_date = "" then
			Response.Write "��ѡ�����ر��Ƽ��������Ƽ�������û�����룬����"
			Response.End 
		 end if
		 
		 if s_if_zj = "��" and s_b_id <>"1026" and int(hour(time)) <9 and int(minute(time)) <30 then
			Response.Write "�Բ��������Ƽ�������ֻ����8��30�Ժ�лл��ϣ�"
			Response.End 
		 end if
		 
		 
		 pop = 0 
		 pop = instr(s_info_title,"<")
		 if s_if_zj = "��" and  pop >0 then
			if s_b_id <>"1026" then
			'Response.Write "�������£�����ѡ�񣨺�ۣ�Ʒ�ִ������һ��ѡ������Ʒ�֣��뵽������ѡ��"
			'Response.End 
			end if
		 end if
 			if s_ifsh = "��" and s_check_date = "" then
				Response.Write "���Ѿ�ѡ���˲���Ҫ��ˣ�������˵�ʱ��û�У�������һ������еķ�"
				Response.End 
			end if
			if s_ifzx ="��" and s_ifzh ="��" then
				Response.Write "����һƪ���¼���������Ѷ�������ۺϱ���"
				Response.End 
			end if
		 '�жϴ����
			If s_if_tj = "��" And s_b_id <>"1026" Then
				MY_ZL = Weekday(s_tbtj_date)
				MY_ZR = Weekday(s_tbtj_date)
				If MY_ZL = 7 OR MY_ZR = 1 THEN
					Response.Write "�������������£��鿴һ����������Ƽ������Ƿ�����ȷ��"
					Response.End 
				END IF
			End if

if len(s_info_corre) <4 then
	Response.Write "���µ�����ַ�������Ҫ��̫���ˣ�����������ô����������أ�����С��Χ"
			Response.End 
end if

whichChar = s_info_corre


if checks(whichChar)=1 then
Response.write whichChar & "�����к��֣���������Դ��������Ǻ��ֵ�����ַ���Ϊ����վ��������������Դ�" 
Response.end 
end if


'�ж����µ�����ַ�
	SQL = "SELECT TOP 1 * FROM B_SHORT WHERE C_NAME='" & s_info_corre & "'"
		RS.Open SQL,CONN,adOpenKeyset ,adLockReadOnly
			IF RS.RecordCount >0 THEN
			Response.Write "���µ�����ַ�������Ҫ��̫���ˣ�����������ô����������أ�����С��Χ"
			Response.End 
			END IF
		RS.Close 
		
			SQL = "SELECT TOP 1 * FROM S_SHORT WHERE C_NAME='" & s_info_corre & "'"
		RS.Open SQL,CONN,adOpenKeyset ,adLockReadOnly
			IF RS.RecordCount >0 THEN
			Response.Write "���µ�����ַ�������Ҫ��̫���ˣ�����������ô����������أ�����С��Χ"
			Response.End 
			END IF
		RS.Close 

		 '�ж��Ƿ��ظ�
		SQL = "SELECT INFO_NO FROM WB_ARTICLE WHERE S_ARTICLE_NO = '" & s_s_article_no & "'"
		RS.Open SQL,CONN,adOpenKeyset ,adLockReadOnly
			IF RS.RecordCount >0 THEN
			Response.Write "��¼�����ظ�����鿴�Ƿ��Ѿ�����ͬ��𣬺���ͬ��������£�лл���"
			Response.End 
			END IF
		RS.Close 
		s_mypzxg=""
		if request("mypzxg") <> "" then
		CAOZUO = TRIM(REQUEST("mypzxg"))
		POP = INSTR(CAOZUO,",")
		I = 0
		WHILE POP >0
			s_mypzxg = s_mypzxg & "PZ" & TRIM(MID(CAOZUO,1,POP-1)) & "ED"
		
			CAOZUO = TRIM(MID(CAOZUO,POP+1))
			POP=INSTR(CAOZUO,",")
			I = I + 1
		WEND
		s_mypzxg = s_mypzxg & "PZ" & TRIM(MID(CAOZUO,1)) & "ED"
		
	
		end if
		'If s_b_id = "1017" Then
		'	s_mypzxg = s_mypzxg & "PZ2005ED"
		'End if
		If s_s_id = "2005" Then
			s_mypzxg = s_mypzxg & "PZ1017ED"
		End if
		
		'�ж��Ƿ���Ҫ��
				'SQL = "SELECT FILE_PATH FROM S_CLASS WHERE CLASS_NO = '" &  s_class_no & "'"
				'RS1.Open SQL,CONN,adOpenKeyset ,adLockReadOnly
				'IF RS1.RecordCount >0 THEN
			'		W_PATH = RS1("FILE_PATH")
			'	ELSE
			'		Response.Write "ϵͳ����û�з����ļ����ص�·�����������Ա������ϵ���ⲿ��"
			'		Response.Write "�����Ϊ��" & s_class_no 
			'		Response.End 
			'	END IF
			'	RS1.Close 
				
				WB_FILE_NO = ID_NAME("NB_FILE_NO")
				
				IF s_b_id = "1008" OR s_b_id = "1011" OR s_b_id = "1017" OR s_b_id = "1010" Or s_b_id="1020" THEN
					s_my_short = -1
				ELSE
					s_my_short = 0
				END IF
				s_my_short = 0
				ppp = instr(s_info_title,"<")
				if ppp >0 then
				's_my_short = 3
				end if
				if (s_s_id = "2055" or s_s_id = "2056") and s_if_zj="��" then
				s_my_short = -1
				end if
				if (s_b_id = "1008" or s_b_id = "1016") and s_if_zj="��" then
				s_my_short = -1
				end if
				if s_b_id = "1003" and s_if_zj="��" then
				s_my_short = 2
				end if
				if s_b_id = "1002" and s_if_zj="��" then
				s_my_short = 1
				end if
				if s_b_id = "1001" and s_if_zj="��" then
				s_my_short = 1
				end if
				if s_b_id = "1004" and s_if_zj="��" then
				s_my_short = 1
				end if
				if s_b_id = "1020"  and s_if_zj="��" then
				s_my_short = -1
				end if
				if s_b_id = "1024"  and s_if_zj="��" then
				s_my_short = -1
				end if
				if s_b_id = "1010"  and s_if_zj="��" then
				s_my_short = -1
				end if
				if s_b_id = "1018"  and s_if_zj="��" then
				s_my_short = -1
				end if
				if s_b_id = "1026"   then
				s_my_short = 5
				end if
				IF LCASE(Request.Cookies ("USER_NAME")) = "sylvia" and s_if_zj="��" THEN
				s_my_short = -1
				END IF
				IF s_if_zj="��" THEN
				MY_STR = "01"
				Randomize
				J = Int(( 2 * Rnd) + 1)
				SUB_STR =  Mid(MY_STR, J, 1)
				s_my_short = SUB_STR
				END IF				                    
				pop = 0
				pop = instr(s_info_title,"����")
				if  POP >0 then
				s_my_short = -1
				end if
				
					SQL = "SELECT TOP 1 * FROM WB_ARTICLE WHERE INFO_TITLE = '" & s_info_title & "'"
				RS.Open SQL,CONN,adOpenKeyset ,adLockReadOnly
					IF RS.RecordCount >0 THEN
					Response.Write "��¼�����ظ�����鿴�Ƿ��Ѿ�����ͬ��𣬺���ͬ��������£�лл���"
				'	Response.End 
					END IF
				RS.Close 
	
				SQL = "SELECT TOP 1 * FROM WB_ARTICLE WHERE INFO_NO = '" & WB_FILE_NO & "'"
				RS.Open SQL,CONN,adOpenKeyset ,adLockReadOnly
					IF RS.RecordCount >0 THEN
					WB_FILE_NO = ID_NAME("NB_FILE_NO")
					ELSE
					END IF
				RS.Close 
				s_jd = 0
				if s_class_no = "100077" then
				s_jd = 10
				end if
				if s_class_no = "100046" then
				s_jd = 30
				end if
				if s_if_zj = "��" and s_b_id = "1026" then
				s_jd = 10
				end if
				if s_pic = "" Then
					SQL = "SELECT TOP 1 PIC FROM MOBILE_PIC WHERE CLASS_PZ = '" & S_B_ID & "' AND STATUS = '0' ORDER BY ID"
					RS.Open SQL,CONN,1,1
						IF RS.RecordCount >0 THEN
						S_PIC = RS("PIC")
						SQL = "UPDATE MOBILE_PIC SET STATUS='1' WHERE CLASS_PZ='" & S_B_ID & "' AND PIC = '" & RS("PIC") & "'"
						CONN.Execute(SQL)
						ELSE
						SQL = "UPDATE MOBILE_PIC SET STATUS='0' WHERE CLASS_PZ='" & S_B_ID & "'"
						CONN.Execute(SQL)
						END IF
						RS.CLOSE 
				end if
			
				if s_pic = "" Then
					SQL = "SELECT TOP 1 PIC FROM MOBILE_PIC WHERE CLASS_PZ = '" & S_B_ID & "' AND STATUS = '0' ORDER BY ID"
					RS.Open SQL,CONN,1,1
						IF RS.RecordCount >0 THEN
						S_PIC = RS("PIC")
						SQL = "UPDATE MOBILE_PIC SET STATUS='1' WHERE CLASS_PZ='" & S_B_ID & "' AND PIC = '" & RS("PIC") & "'"
						CONN.Execute(SQL)
						ELSE
						SQL = "UPDATE MOBILE_PIC SET STATUS='0' WHERE CLASS_PZ='" & S_B_ID & "'"
						CONN.Execute(SQL)
						END IF
						RS.CLOSE 
				end if
			s_info_desc = replace(s_info_desc,"<img","<center><img")
					 s_info_desc = replace(s_info_desc,"/>","/></center>")
								M_MY_STR = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
								Randomize
								M_J = Int(( 25 * Rnd) + 1)
								M_SUB_STR = Mid(M_MY_STR, M_J, 1)
				'REsponse.Write WB_FILE_NO & M_SUB_STR
				'WB_FILE_NO 
				WB_FILE_NO = WB_FILE_NO & M_SUB_STR
	  			'���Ӽ�¼
	  			IF s_if_html = "��" THEN
	  				SQL = "SELECT top 1 * FROM WB_ARTICLE"
	  				RS1.Open SQL,CONN,adOpenKeyset ,adLockOptimistic 
	  				RS1.AddNew 
	  				RS1("P_CLASS_NO") = s_p_class_no
	  				RS1("CLASS_NO") = s_class_no
	  				RS1("CLASS_PZ") = s_b_id
	  				RS1("S_ID") = s_s_id
	  				RS1("INFO_TYPE") = s_nw
	  				'RS1("INFO_FILE") = "http://wap.chinajci.com/images/" & trim(s_pic)
				  	RS1("INFO_FILE") = "http://chart.chinajci.com/wap/" & trim(s_pic)
	  				RS1("REMARK") = s_remark
	  				RS1("INFO_NO") = WB_FILE_NO
	  				RS1("INFO_TITLE") = s_info_title
						RS1("COLOR_L") = s_color_l
						RS1("COLOR_R") = s_color_r
	  				RS1("INFO_DESC") = s_info_desc
	  				RS1("INFO_FIND") = s_info_find & s_info_find1 & s_info_title
	  				RS1("INFO_CORRE") = s_info_corre
	  				RS1("INFO_SOURCE") = s_info_source
	  				RS1("INFO_AUTHOR") = s_author
	  				IF s_ifsh = "��" THEN
	  				RS1("INFO_CHECK") = 2
	  				ELSE
	  				RS1("INFO_CHECK") = 0
	  				END IF
	  				'RS1("INFO_FILE") = REQUEST("DefaultPicUrl")
	  				RS1("READ_NUM") = 0
	  				RS1("PERSON") = Request.Cookies ("USER_NAME")
	  				'RS1("RE_DATE") = MYDD(DATE)
	  				IF s_ifsh = "��" THEN
	  					RS1("INFO_CHECK") = "2"
	  					M_M = MONTH(s_check_date)
	  						IF M_M <10 THEN
	  						M_M = "0" & M_M
	  						END IF
	  					D_D = DAY(s_check_date)
	  						IF D_D <10 THEN
	  						D_D = "0" & D_D
	  						END IF
	  					S_DATE = YEAR(s_check_date) & M_M & D_D
	  					
	  					M_M = MONTH(date)
	  						IF M_M <10 THEN
	  						M_M = "0" & M_M
	  						END IF
	  					D_D = DAY(date)
	  						IF D_D <10 THEN
	  						D_D = "0" & D_D
	  						END IF
	  					T_DATE = YEAR(DATE) & M_M & D_D		
	  					if INT(S_DATE) > INT(T_DATE) then
	  					RS1("CHECK_DATE") = s_check_date & " 08:26:05"
	  					ELSE
	  					RS1("CHECK_DATE") = s_check_date & " " & time()
	  					END IF
	  				ELSE
	  				RS1("CHECK_DATE") = "01/01/1999"
	  				END IF
	  				IF s_if_zj = "��" THEN
	  				RS1("TJ_DATE") = s_tbtj_date
	  				RS1("IF_TJ") = "��"
	  				ELSE
	  				RS1("TJ_DATE") = "01/01/1999"
	  				RS1("IF_TJ") = "��"
	  				END IF
					  if Request("if_zd") = "��" THEN
					  RS1("IF_ZD") = "��"
					  RS1("ZD_DATE") = DATE + Request("zd_date")
					  ELSE
					  RS1("IF_ZD") = "��"
					  RS1("ZD_DATE") = DATE 
					  END IF
	  				RS1("S_ARTICLE_NO") = TRIM(s_s_article_no)
	  				RS1("X_ARTICLE_NO") =  s_x_article_no
	  				RS1("IF_FB") = "��"
	  				RS1("IF_HTML") = "��"
	  				RS1("IF_ZX") = "F"
	  				RS1("MY_SHORT") = s_my_short
	  				RS1("C_SHORT") = s_my_short
	  				RS1("IF_ZH") = s_ifzh
	  				RS1("IF_ZK") = s_if_zk
	  				IF s_if_zk = "��" THEN
	  				RS1("IF_FREE") = "��"
	  				ELSE
	  				RS1("IF_FREE") = "��"
	  				END IF
	  				RS1("IF_MF") = s_if_mf
	  				RS1("IFFY") = s_iffy
	  				RS1("IF_ZJ") = s_if_zj
	  				RS1("STATE") = trim(s_state)
	  				RS1("CLIMATE") = trim(s_climate)
	  				RS1("ECONNMY") = trim(s_econnmy)
					  RS1("ZT_NO") = trim(s_zt_no)
	  				RS1("CLASS_CORRE") = trim(s_sjjj)&trim(s_ggny)&trim(s_qxyb)&trim(s_pzpd)&trim(s_zcdt)&trim(s_gkhg)&trim(s_slyz)&trim(s_zhzx)&my_dlb&trim(s_yfzp)&trim(s_qhbj)&trim(s_jgqs)&trim(s_spzs)&s_mypzxg&trim(s_tjzl)&trim(s_yfjc)&trim(s_nyrl)&trim(s_zztz)
	  				RS1("CLASS_HISTORY") = trim(s_class_history)
	  				IF trim(s_history_date) = "" THEN
	  				RS1("HISTORY_DATE") = "01/01/1999"
	  				ELSE
	  				RS1("HISTORY_DATE") = trim(s_history_date)
	  				END IF
	  				RS1("IFFY") = "��"
	  				RS1("PERSON_LY") = trim(s_person_ly)
	  				RS1("FANGSHI_LY") = trim(s_fangshi_ly)
						RS1("JIBIE") = s_jibie
						RS1("FEE") = s_fee
						RS1("IFHOT") = s_ifhot
						RS1("JD") = s_jd
						RS1("CITY") = s_city
	  				RS1.UpdateBatch 
	  				RS1.Close 
	  				
	  				SQL = "SELECT top 1 * FROM ARTICLE_LINSHI"
	  				RS1.Open SQL,CONN,adOpenKeyset ,adLockOptimistic 
	  				RS1.AddNew 
	  				RS1("P_CLASS_NO") = s_p_class_no
	  				RS1("CLASS_NO") = s_class_no
	  				RS1("CLASS_PZ") = s_b_id
	  				RS1("S_ID") = s_s_id
	  				RS1("INFO_TYPE") = s_nw
	  				RS1("REMARK") = s_remark
	  				'RS1("INFO_FILE") = "http://wap.chinajci.com/images/" & trim(s_pic)
				  	RS1("INFO_FILE") = "http://chart.chinajci.com/wap/" & trim(s_pic)
	  				RS1("INFO_NO") = WB_FILE_NO
	  				RS1("INFO_TITLE") = s_info_title
						RS1("COLOR_L") = s_color_l
						RS1("COLOR_R") = s_color_r
	  				RS1("INFO_DESC") = mid(s_info_desc,1,40)
	  				RS1("INFO_FIND") = s_info_find & s_info_find1  & s_info_title
	  				RS1("INFO_CORRE") = s_info_corre
	  				RS1("INFO_SOURCE") = s_info_source
	  				RS1("INFO_AUTHOR") = s_author
	  				IF s_ifsh = "��" THEN
	  				RS1("INFO_CHECK") = 2
	  				ELSE
	  				RS1("INFO_CHECK") = 0
	  				END IF
				  	if Request("if_zd") = "��" THEN
					  RS1("IF_ZD") = "��"
					  RS1("ZD_DATE") = DATE + Request("zd_date")
					  ELSE
					  RS1("IF_ZD") = "��"
					  RS1("ZD_DATE") = DATE 
					  END IF
	  				'RS1("INFO_FILE") = REQUEST("DefaultPicUrl")
	  				RS1("READ_NUM") = 0
	  				RS1("PERSON") = Request.Cookies ("USER_NAME")
	  				'RS1("RE_DATE") = MYDD(DATE)
	  				IF s_ifsh = "��" THEN
	  					RS1("INFO_CHECK") = "2"
	  					M_M = MONTH(s_check_date)
	  						IF M_M <10 THEN
	  						M_M = "0" & M_M
	  						END IF
	  					D_D = DAY(s_check_date)
	  						IF D_D <10 THEN
	  						D_D = "0" & D_D
	  						END IF
	  					S_DATE = YEAR(s_check_date) & M_M & D_D
	  					
	  					M_M = MONTH(date)
	  						IF M_M <10 THEN
	  						M_M = "0" & M_M
	  						END IF
	  					D_D = DAY(date)
	  						IF D_D <10 THEN
	  						D_D = "0" & D_D
	  						END IF
	  					T_DATE = YEAR(DATE) & M_M & D_D		
	  					if INT(S_DATE) > INT(T_DATE) then
	  					RS1("CHECK_DATE") = s_check_date & " 08:28:05"
	  					ELSE
	  					RS1("CHECK_DATE") = s_check_date & " " & time()
	  					END IF
	  				ELSE
	  				RS1("CHECK_DATE") = "01/01/1999"
	  				END IF
	  				IF s_if_zj = "��" THEN
	  				RS1("TJ_DATE") = s_tbtj_date
	  				RS1("IF_TJ") = "��"
	  				ELSE
	  				RS1("TJ_DATE") = "01/01/1999"
	  				RS1("IF_TJ") = "��"
	  				END IF
				  	if Request("if_zd") = "��" THEN
					  RS1("IF_ZD") = "��"
					  RS1("ZD_DATE") = DATE + Request("zd_date")
					  ELSE
					  RS1("IF_ZD") = "��"
					  RS1("ZD_DATE") = DATE 
					  END IF
	  				RS1("S_ARTICLE_NO") = TRIM(s_s_article_no)
	  				RS1("X_ARTICLE_NO") =  s_x_article_no
	  				RS1("IF_FB") = "��"
	  				RS1("IF_HTML") = "��"
	  				RS1("IF_ZX") = "F"
	  				RS1("MY_SHORT") = s_my_short
	  				RS1("C_SHORT") = s_my_short
	  				RS1("IF_ZH") = s_ifzh
	  				RS1("IF_ZK") = s_if_zk
	  				IF s_if_zk = "��" THEN
	  				RS1("IF_FREE") = "��"
	  				ELSE
	  				RS1("IF_FREE") = "��"
	  				END IF
	  				RS1("IF_MF") = s_if_mf
	  				RS1("IFFY") = s_iffy
	  				RS1("IF_ZJ") = s_if_zj
	  				RS1("STATE") = trim(s_state)
	  				RS1("CLIMATE") = trim(s_climate)
	  				RS1("ECONNMY") = trim(s_econnmy)
						RS1("ZT_NO") = trim(s_zt_no)
	  				RS1("CLASS_CORRE") = trim(s_sjjj)&trim(s_ggny)&trim(s_qxyb)&trim(s_pzpd)&trim(s_zcdt)&trim(s_gkhg)&trim(s_slyz)&trim(s_zhzx)&my_dlb&trim(s_yfzp)&trim(s_qhbj)&trim(s_jgqs)&trim(s_spzs)&s_mypzxg&trim(s_tjzl)&trim(s_yfjc)&trim(s_zztz)
	  				RS1("CLASS_HISTORY") = trim(s_class_history)
	  				IF trim(s_history_date) = "" THEN
	  				RS1("HISTORY_DATE") = "01/01/1999"
	  				ELSE
	  				RS1("HISTORY_DATE") = trim(s_history_date)
	  				END IF
	  				RS1("IFFY") = "��"
	  				RS1("PERSON_LY") = trim(s_person_ly)
	  				RS1("FANGSHI_LY") = trim(s_fangshi_ly)
						RS1("JIBIE") = s_jibie
						RS1("FEE") = s_fee
						RS1("IFHOT") = s_ifhot
						RS1("JD") = s_jd
						RS1("CITY") = s_city
	  				RS1.UpdateBatch 
	  				RS1.Close 
	  			ELSE
	  				SQL = "SELECT top 1 * FROM WB_ARTICLE"
	  				RS1.Open SQL,CONN,adOpenKeyset ,adLockOptimistic 
	  				RS1.AddNew 
	  				RS1("P_CLASS_NO") = s_p_class_no
	  				RS1("CLASS_NO") = s_class_no
	  				RS1("CLASS_PZ") = s_b_id
	  				RS1("CLASS_PZ") = s_b_id
	  				RS1("S_ID") = s_s_id
	  				RS1("INFO_TYPE") = s_nw
	  				'RS1("INFO_FILE") = "http://wap.chinajci.com/images/" & trim(s_pic)
				  	RS1("INFO_FILE") = "http://chart.chinajci.com/wap/" & trim(s_pic)
	  				RS1("REMARK") = s_remark
	  				RS1("INFO_NO") = WB_FILE_NO
	  				RS1("INFO_TITLE") = s_info_title
						RS1("COLOR_L") = s_color_l
						RS1("COLOR_R") = s_color_r
	  				RS1("INFO_DESC") = s_info_desc
	  				RS1("INFO_FIND") = s_info_find & s_info_find1
	  				RS1("INFO_CORRE") = s_info_corre
	  				RS1("INFO_SOURCE") = s_info_source
	  				RS1("INFO_AUTHOR") = s_author
	  				IF s_ifsh = "��" THEN
	  				RS1("INFO_CHECK") = 2
	  				ELSE
	  				RS1("INFO_CHECK") = 0
	  				END IF
					  if Request("if_zd") = "��" THEN
					  RS1("IF_ZD") = "��"
					  RS1("ZD_DATE") = DATE + Request("zd_date")
					  ELSE
					  RS1("IF_ZD") = "��"
					  RS1("ZD_DATE") = DATE 
					  END IF
	  				IF s_if_zj = "��" THEN
	  				RS1("TJ_DATE") = s_tbtj_date
	  				RS1("IF_TJ") = "��"
	  				ELSE
	  				RS1("TJ_DATE") = "01/01/1999"
	  				RS1("IF_TJ") = "��"
	  				END IF
	  				'RS1("INFO_FILE") = REQUEST("DefaultPicUrl")
	  				RS1("READ_NUM") = 0
	  				RS1("PERSON") = Request.Cookies ("USER_NAME")
	  				'RS1("RE_DATE") = MYDD(DATE)
	  				IF s_ifsh = "��" THEN
	  					RS1("INFO_CHECK") = "2"
	  					M_M = MONTH(s_check_date)
	  						IF M_M <10 THEN
	  						M_M = "0" & M_M
	  						END IF
	  					D_D = DAY(s_check_date)
	  						IF D_D <10 THEN
	  						D_D = "0" & D_D
	  						END IF
	  					S_DATE = YEAR(s_check_date) & M_M & D_D
	  					
	  					M_M = MONTH(date)
	  						IF M_M <10 THEN
	  						M_M = "0" & M_M
	  						END IF
	  					D_D = DAY(date)
	  						IF D_D <10 THEN
	  						D_D = "0" & D_D
	  						END IF
	  					T_DATE = YEAR(DATE) & M_M & D_D		
	  					if INT(S_DATE) > INT(T_DATE) then
	  					RS1("CHECK_DATE") = s_check_date & " 08:28:05"
	  					ELSE
	  					RS1("CHECK_DATE") = s_check_date & " " & time()
	  					END IF
	  				ELSE
	  				RS1("CHECK_DATE") = "01/01/1999"
	  				END IF
	  				RS1("S_ARTICLE_NO") = TRIM(s_s_article_no)
	  				RS1("X_ARTICLE_NO") =  s_x_article_no
	  				RS1("IF_FB") = "��"
	  				RS1("IF_HTML") = "��"
	  				RS1("IF_ZX") = "F"
	  				RS1("IF_ZH") = s_ifzh
	  				RS1("MY_SHORT") = s_my_short
	  				RS1("C_SHORT") = s_my_short
	  				RS1("IF_ZK") = s_if_zk
	  				IF s_if_zk = "��" THEN
	  				RS1("IF_FREE") = "��"
	  				ELSE
	  				RS1("IF_FREE") = "��"
	  				END IF
	  				RS1("IF_MF") = s_if_mf
	  				RS1("IFFY") = s_iffy
	  				RS1("IF_ZJ") = s_if_zj
	  				RS1("STATE") = trim(s_state)
	  				RS1("CLIMATE") = trim(s_climate)
	  				RS1("ECONNMY") = trim(s_econnmy)
						RS1("ZT_NO") = trim(s_zt_no)
	  				RS1("CLASS_CORRE") = trim(s_sjjj)&trim(s_ggny)&trim(s_qxyb)&trim(s_pzpd)&trim(s_zcdt)&trim(s_gkhg)&trim(s_slyz)&trim(s_zhzx)&my_dlb&trim(s_yfzp)&trim(s_qhbj)&trim(s_jgqs)&trim(s_spzs)&s_mypzxg&trim(s_tjzl)&trim(s_yfjc)&trim(s_zztz)&trim(s_hyzx)&trim(s_sclr)&trim(s_zftj)
	  				RS1("CLASS_HISTORY") = trim(s_class_history)
	  				IF trim(s_history_date) = "" THEN
	  				RS1("HISTORY_DATE") = "01/01/1999"
	  				ELSE
	  				RS1("HISTORY_DATE") = trim(s_history_date)
	  				END IF
	  				RS1("IFFY") = "��"
	  				RS1("PERSON_LY") = trim(s_person_ly)
	  				RS1("FANGSHI_LY") = trim(s_fangshi_ly)
						RS1("JIBIE") = s_jibie
						RS1("FEE") = s_fee
						RS1("IFHOT") = s_ifhot
						RS1("JD") = s_jd
						RS1("CITY") = s_city
	  				RS1.UpdateBatch 
	  				RS1.Close 
	  				
	  				SQL = "SELECT top 1 * FROM ARTICLE_LINSHI"
	  				RS1.Open SQL,CONN,adOpenKeyset ,adLockOptimistic 
	  				RS1.AddNew 
	  				RS1("P_CLASS_NO") = s_p_class_no
	  				RS1("CLASS_NO") = s_class_no
	  				RS1("CLASS_PZ") = s_b_id
	  				RS1("CLASS_PZ") = s_b_id
	  				RS1("S_ID") = s_s_id
	  				RS1("INFO_TYPE") = s_nw
	  				'RS1("INFO_FILE") = "http://wap.chinajci.com/images/" & trim(s_pic)
				  	RS1("INFO_FILE") = "http://chart.chinajci.com/wap/" & trim(s_pic)
	  				RS1("REMARK") = s_remark
	  				RS1("INFO_NO") = WB_FILE_NO
	  				RS1("INFO_TITLE") = s_info_title
						RS1("COLOR_L") = s_color_l
						RS1("COLOR_R") = s_color_r
	  				RS1("INFO_DESC") = mid(s_info_desc,1,40)
	  				RS1("INFO_FIND") = s_info_find & s_info_find1
	  				RS1("INFO_CORRE") = s_info_corre
	  				RS1("INFO_SOURCE") = s_info_source
	  				RS1("INFO_AUTHOR") = s_author
	  				IF s_ifsh = "��" THEN
	  				RS1("INFO_CHECK") = 2
	  				ELSE
	  				RS1("INFO_CHECK") = 0
	  				END IF
						if Request("if_zd") = "��" THEN
					  RS1("IF_ZD") = "��"
					  RS1("ZD_DATE") = DATE + Request("zd_date")
					  ELSE
					  RS1("IF_ZD") = "��"
					  RS1("ZD_DATE") = DATE 
					  END IF
	  				IF s_if_zj = "��" THEN
	  				RS1("TJ_DATE") = s_tbtj_date
	  				RS1("IF_TJ") = "��"
	  				ELSE
	  				RS1("TJ_DATE") = "01/01/1999"
	  				RS1("IF_TJ") = "��"
	  				END IF
	  				'RS1("INFO_FILE") = REQUEST("DefaultPicUrl")
	  				RS1("READ_NUM") = 0
	  				RS1("PERSON") = Request.Cookies ("USER_NAME")
	  				'RS1("RE_DATE") = MYDD(DATE)
	  				IF s_ifsh = "��" THEN
	  					RS1("INFO_CHECK") = "2"
	  					M_M = MONTH(s_check_date)
	  						IF M_M <10 THEN
	  						M_M = "0" & M_M
	  						END IF
	  					D_D = DAY(s_check_date)
	  						IF D_D <10 THEN
	  						D_D = "0" & D_D
	  						END IF
	  					S_DATE = YEAR(s_check_date) & M_M & D_D
	  					
	  					M_M = MONTH(date)
	  						IF M_M <10 THEN
	  						M_M = "0" & M_M
	  						END IF
	  					D_D = DAY(date)
	  						IF D_D <10 THEN
	  						D_D = "0" & D_D
	  						END IF
	  					T_DATE = YEAR(DATE) & M_M & D_D		
	  					if INT(S_DATE) > INT(T_DATE) then
	  					RS1("CHECK_DATE") = s_check_date & " 08:29:05"
	  					ELSE
	  					RS1("CHECK_DATE") = s_check_date & " " & time()
	  					END IF
	  				ELSE
	  				RS1("CHECK_DATE") = "01/01/1999"
	  				END IF
	  				RS1("S_ARTICLE_NO") = TRIM(s_s_article_no)
	  				RS1("X_ARTICLE_NO") =  s_x_article_no
	  				RS1("IF_FB") = "��"
	  				RS1("IF_HTML") = "��"
	  				RS1("IF_ZX") = "F"
	  				RS1("IF_ZH") = s_ifzh
	  				RS1("MY_SHORT") = s_my_short
	  				RS1("C_SHORT") = s_my_short
	  				RS1("IF_ZK") = s_if_zk
	  				IF s_if_zk = "��" THEN
	  				RS1("IF_FREE") = "��"
	  				ELSE
	  				RS1("IF_FREE") = "��"
	  				END IF
	  				RS1("IF_MF") = s_if_mf
	  				RS1("IFFY") = s_iffy
	  				RS1("IF_ZJ") = s_if_zj
	  				RS1("STATE") = trim(s_state)
	  				RS1("CLIMATE") = trim(s_climate)
	  				RS1("ECONNMY") = trim(s_econnmy)
						RS1("ZT_NO") = trim(s_zt_no)
	  				RS1("CLASS_CORRE") = trim(s_sjjj)&trim(s_ggny)&trim(s_qxyb)&trim(s_pzpd)&trim(s_zcdt)&trim(s_gkhg)&trim(s_slyz)&trim(s_zhzx)&my_dlb&trim(s_yfzp)&trim(s_qhbj)&trim(s_jgqs)&trim(s_spzs)&s_mypzxg&trim(s_tjzl)&trim(s_yfjc)&trim(s_zztz)&trim(s_hyzx)&trim(s_sclr)&trim(s_zftj)
	  				RS1("CLASS_HISTORY") = trim(s_class_history)
	  				IF trim(s_history_date) = "" THEN
	  				RS1("HISTORY_DATE") = "01/01/1999"
	  				ELSE
	  				RS1("HISTORY_DATE") = trim(s_history_date)
	  				END IF
	  				RS1("IFFY") = "��"
	  				RS1("PERSON_LY") = trim(s_person_ly)
	  				RS1("FANGSHI_LY") = trim(s_fangshi_ly)
						RS1("JIBIE") = s_jibie
						RS1("FEE") = s_fee
						RS1("IFHOT") = s_ifhot
						RS1("JD") = s_jd
						RS1("CITY") = s_city
	  				RS1.UpdateBatch 
	  				RS1.Close 
	  				
	  				END IF
		
			'�����������ݿ�
			'����������
			M_Y = YEAR(DATE)
			M_M = MONTH(DATE)
				IF M_M <10 THEN
				M_M = "0" & M_M
				END IF
			M_D = DAY(DATE)
				IF M_D <10 THEN
				M_D = "0" & M_D
				END IF
			'����Ŀǰ�ı��
			S_NO = M_Y & M_M & M_D
			SQL = "SELECT REQUEST_NO FROM MYID "
			RS1.Open SQL,CONN,adOpenKeyset ,adLockReadOnly
				IF RS1.RecordCount >0 THEN
				D_NO = MID(RS1(0),1,8)
				END IF
			RS1.Close 
			
				IF D_NO = S_NO THEN
				REQUEST_NO = ID_NAME("REQUEST_NO")
				ELSE
				REQUEST_NO = S_NO  & "001"
				SQL = "UPDATE MYID SET REQUEST_NO = '" & REQUEST_NO & "'"
				CONN.Execute (SQL)
				END IF
			if s_ifsh = "��" then
			SQL = "INSERT INTO REQUEST (REQUEST_NO,INFO_NO,S_ARTICLE_NO,CLASS_NO,REQUEST_TITLE,REQUEST_DESC,STATUS,PERSON,RE_DATE,CHECK_DATE,PRVI)"
			SQL = SQL & " VALUES('" & REQUEST_NO & "','" & WB_FILE_NO & "','" & trim(s_s_article_no) & "','����','��������','���ϻ����������ӳɹ�����ȷ��','"
			SQL = SQL & "�Ѿ�ͨ��','" & Request.Cookies ("USER_NAME") & "','" & MYDD(DATE) & "','" & s_check_date & "',0)"
			ELSE
			SQL = "INSERT INTO REQUEST (REQUEST_NO,INFO_NO,S_ARTICLE_NO,CLASS_NO,REQUEST_TITLE,REQUEST_DESC,STATUS,PERSON,RE_DATE,CHECK_DATE,PRVI)"
			SQL = SQL & " VALUES('" & REQUEST_NO & "','" & WB_FILE_NO & "','" & trim(s_s_article_no) & "','����','��������','���ϻ����������ӳɹ�����ȷ��','"
			SQL = SQL & "������-����','" & Request.Cookies ("USER_NAME") & "','" & MYDD(DATE) & "','01/01/1999',0)"
			END IF
			CONN.Execute (SQL)
%>
<html>
<head>
<title>�������������ӳɹ�</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" href="font.css">
<style type="text/css">
<!--
.main {  font-size: 9pt}
-->
</style>
</head>

<body bgcolor="white">
<div align="center"><font color="#0000FF" class="main">���ڲ�����ϵͳ��������������ϵͳ���� </font></div>
<hr>
<form method="POST" action="article_main.asp" name="un" >
  <table width="580" border="0" bordercolordark="#99CCFF" bordercolorlight="#99CCFF" cellspacing="1" align="center" cellpadding="6" bgcolor="#000000">
    <tr bgcolor="#FFFFFF"> 
      <td width="32%" class="main">�����</td>
      <td width="68%" class="main"> 
          <%=DISPLAY_NAME("B_SHORT",s_b_id,"B_ID","C_NAME")
        %> 
        </select>
      </td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="32%" class="main">С���</td>
      <td width="68%" class="main"> 
         <%=DISPLAY_NAME("S_SHORT",s_s_id,"S_ID","C_NAME")
        %> 
        </select>
      </td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="32%" class="main">���أ�</td>
      <td width="68%" class="main"> 
         <%=DISPLAY_NAME("COUNTRY",s_state,"state","C_NAME")
        %> 
      </td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="32%" class="main">��վ����Ŀ��</td>
      <td width="68%" class="main"> 
         <%=DISPLAY_NAME("P_CLASS",s_p_class_no,"P_CLASS_NO","P_CLASS_NAME")
        %> 
      </td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="32%" class="main">��վ����Ŀ��</td>
      <td width="68%" class="main"> 
         <%=DISPLAY_NAME("S_CLASS",s_class_no,"CLASS_NO","CLASS_NAME")
        %> 
      </td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="32%" class="main">����</td>
      <td width="68%" class="main"><small><font face="Verdana"> 
        <%=s_climate%>
        </font></small></td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="32%" class="main">���ã�</td>
      <td width="68%" class="main"> 
      <%=s_econnmy%>
        
      </td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="32%" class="main">��Ϣѯ���ˣ�</td>
      <td width="68%" class="main"> 
      <%=s_person_ly%>
        
      </td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="32%" class="main">��ϵ��ʽ��</td>
      <td width="68%" class="main"> 
      <%=s_fangshi_ly%>
        
      </td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="32%" class="main">���ϱ��⣺</td>
      <td width="68%" class="main"><small><font face="Verdana"> 
      <%=s_info_title%>
        </font></small></td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="32%" class="main">��飺</td>
      <td width="68%" class="main"> 
		<%
		IF s_if_html = "��" THEN
		Response.Write s_info_desc
		Else
		
		  MHY_S = ""
            EE = Split(s_info_desc, Chr(13))
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
		
		%>
		<%=my_text%>
        <%
        END IF
        %>
      </td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="32%" class="main">���ϵ��ļ���</td>
      <td width="68%" class="main"><small><font face="Verdana"> 
        <%=varfname%>
        </font></small></td>
    </tr>
    <tr bgcolor="#FFFFFF">
      <td width="32%" class="main">�����ַ�����</td>
      <td width="68%" class="main">
      <%=s_info_find%>
        
      </td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="32%" class="main">��ز�ѯ�ַ���</td>
      <td width="68%" class="main"><small> 
      <%=s_info_corre%>
        </td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="32%" class="main">������Դ��</td>
      <td width="68%" class="main"> 
      <%=s_info_source%>
        
      </td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="32%" class="main">���ߣ� </td>
      <td width="68%" class="main"><small><font face="Verdana"> 
      <%=s_author%>
        </font></small></td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="32%" class="main">��ע��</td>
      <td width="68%" class="main"><small><font face="Verdana"> 
      <%=s_remark%>
        </font></small></td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="32%" class="main">���±�ţ�</td>
      <td width="68%" class="main"><small><font face="Verdana"> 
      <%=s_s_article_no%>
        </font></small></td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="32%" class="main">��Դ��ţ�</td>
      <td width="68%" class="main"><small><font face="Verdana"> 
      <%=s_x_article_no%>
        </font></small></td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="32%" class="main">�Ƿ����������</td>
      <td width="68%" class="main"><small><font face="Verdana"> 
      <%=s_nw%>
        </font></small></td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td colspan="2"> 
        <div align="center"><br>
          <input type="submit" name="add" value="��������">
           <input type="submit" name="addn" value="�������루�£�">
          <input type="submit" name="home" value="������ҳ">
          <input type="submit" name="search" value="�����ѯ">
        </div>
      </td>
  </table>
</form>
</body>
</html>
