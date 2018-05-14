<!-- #include virtual = "/include/mylib1105.asp" -->

<!-- #include virtual = "/include/auth.asp" -->
<!-- #include virtual = "/include/sql.asp" -->

<%
	set CONN = Server.CreateObject("ADODB.Connection")
    CONN.open CONNSTR,"",""  
	set RS = Server.CreateObject("ADODB.RecordSet")
	set RS1 = Server.CreateObject("ADODB.RecordSet")
	set RSLIB = Server.CreateObject("ADODB.RecordSet")
	

    SQL = "select Id,Name,Content,CreatedBy,CreatedDatetime from A_DRAFT WHERE CreatedBy = '" & lcase(Request.Cookies("user_name")) & "' order by CreatedDatetime desc"

    RS.Open SQL,CONN,1,1
		DO WHILE NOT RS.EOF 
%>

<div class="personalTempContainer" data-id='<%=rs("Id")%>'><%=rs("Content")%></div>
<%
		RS.MoveNext
		LOOP
	RS.CLOSE 
    
%>
