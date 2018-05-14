<!-- #include virtual = "/include/mylib1105.asp" -->

<!-- #include virtual = "/include/sql.asp" -->

<%
	set CONN = Server.CreateObject("ADODB.Connection")
    CONN.open CONNSTR,"",""  
	set RS = Server.CreateObject("ADODB.RecordSet")
	set RS1 = Server.CreateObject("ADODB.RecordSet")
	set RSLIB = Server.CreateObject("ADODB.RecordSet")
	%> 
<%
	IF Request.Form ("USER_name") <> "" AND Request.Form ("user_PASS") <> "" THEN
			SQL = "SELECT * FROM PERSON WHERE USER_NAME = '" & Request.Form ("USER_NAME") & "' AND USER_PASS = '" & Request.Form ("USER_PASS") & "'"
			RS.Open SQL,CONN,adOpenKeyset ,adLockReadOnly
				IF RS.RecordCount >0 THEN
			
				'用户的密码合法 
				Response.Cookies ("user_name") = Request.Form ("USER_name")
				Response.Cookies ("user_pass") = Request.Form ("user_PASS")
				Response.Cookies ("PRVI") = RS("PRVI")
				Response.Cookies ("EMAIL") = RS("EMAIL")
				Response.Redirect ("default.ASP")
				ELSE
				Response.Redirect ("user_login.ASP")
			END IF
		
	ELSE
	'用户输入的不完整
			
	Response.Redirect ("user_login.ASP")
	END IF
%>