<!-- #include virtual = "/include/mylib1105.asp" -->

<!-- #include virtual = "/include/auth.asp" -->
<!-- #include virtual = "/include/sql.asp" -->


<%
'×÷Õß£ºÂíºéÑÒ  ÓÚ 2002-4-21 ±àÐ´
'¹¦ÄÜ£ºÎÄÕÂµÄÈ·ÈÏ
'²Ù×÷£º±¾½Å±¾ÓÉ²¿ÃÅ¾­ÀíÒÔÉÏ²Ù×÷
 'ÅÐ¶Ï¼¶±ð
 
	set CONN = Server.CreateObject("ADODB.Connection")
    CONN.open CONNSTR,"",""  
	set RS = Server.CreateObject("ADODB.RecordSet")
	set RS1 = Server.CreateObject("ADODB.RecordSet")
	set RSLIB = Server.CreateObject("ADODB.RecordSet")
	'ÅÐ¶ÏÈ¨ÏÞ
	

    SQL = "select Id,Name FROM A_TEMPLATE_CATEGORY ORDER BY [Order] asc"

    RS.Open SQL,CONN,1,1
		DO WHILE NOT RS.EOF 
%>

<div class="categoryContainer" data-id='<%=rs("Id")%>'><%=rs("Name")%></div>
<%
		RS.MoveNext
		LOOP
	RS.CLOSE 
    
%>
