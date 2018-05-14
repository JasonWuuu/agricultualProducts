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
	
     content = request("content")

    Dim TypeLib  
    Set TypeLib = Server.CreateObject("Scriptlet.TypeLib") 
   
	SQL = "insert into A_DRAFT(name,content,createdby,createddatetime)values('" & Mid(TypeLib.Guid,2,36) & "', '" & content & "', '" & lcase(Request.Cookies("user_name")) & "', getdate())"
      
    'SQL = "insert into A_TEMPLATE(name,content,createdby,createddatetime)values('" & Mid(TypeLib.Guid,2,36) & "', '" & content & "', '" & "cong" & "', getdate())"
	CONN.Execute(SQL)
	Response.Write("1")
    Response.end 
%> 
