<!-- #include virtual = "/include/mylib1105.asp" -->

<!-- #include virtual = "/include/auth.asp" -->



<%
	set CONN = Server.CreateObject("ADODB.Connection")
    CONN.open CONNSTR,"",""  
	set RS = Server.CreateObject("ADODB.RecordSet")
	set RS1 = Server.CreateObject("ADODB.RecordSet")
	set RSLIB = Server.CreateObject("ADODB.RecordSet")
	
     content = request("content")
	 cid = request("cid")
    Dim TypeLib  
    Set TypeLib = Server.CreateObject("Scriptlet.TypeLib") 
   
	SQL = "insert into A_TEMPLATE(name,content,createdby,createddatetime,CategoryId)values('" & Mid(TypeLib.Guid,2,36) & "', '" & content & "', '" & lcase(Request.Cookies("user_name")) & "', getdate()," & cid  & ")"
      
    'SQL = "insert into A_TEMPLATE(name,content,createdby,createddatetime)values('" & Mid(TypeLib.Guid,2,36) & "', '" & content & "', '" & "cong" & "', getdate())"
	CONN.Execute(SQL)
	Response.Write("1")
    Response.end 
%> 
