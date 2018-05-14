<!-- #include virtual = "/include/mylib1105.asp" -->

<!-- #include virtual = "/include/auth.asp" -->
<!-- #include virtual = "/include/sql.asp" -->


<%
 
	set CONN = Server.CreateObject("ADODB.Connection")
    CONN.open CONNSTR,"",""  
	set RS = Server.CreateObject("ADODB.RecordSet")
	set RS1 = Server.CreateObject("ADODB.RecordSet")
	set RSLIB = Server.CreateObject("ADODB.RecordSet")

	
	ids=request("ids")
	
	idArr=Split(ids,"|")
	For i = 0 To ubound(idArr)
		SQL = "update A_TEMPLATE_CATEGORY set [Order]="&i&" where id="&idArr(i)
		CONN.Execute(SQL)
	next
	Response.Write("1")
    Response.end 
%> 
