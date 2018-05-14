<%
	Const adOpenForwardOnly = 0
	Const adOpenKeyset = 1
	Const adOpenDynamic = 2
	Const adOpenStatic = 3
	Const adLockReadOnly = 1
	Const adLockPessimistic = 2
	Const adLockOptimistic = 3
	Const adLockBatchOptimistic = 4
	connstr = "Driver={SQL Server};Description=公司外部数据库;SERVER=www.chinajci.com;UID=sa;PWD=love+wuchan=love66666;DATABASE=hy_remote" 
	connstrdakayi = "Driver={SQL Server};Description=公司外部数据库;SERVER=www.dakayi.cc;UID=sa;PWD=yunqi+huiyi=8888;DATABASE=huiyi" 
	en_connstr = "Driver={SQL Server};Description=公司外部数据库;SERVER=www.chinajci.com;UID=sa;PWD=love+wuchan=love66666;DATABASE=en_remote" 
		
	Function display_name(itable,idis,ifiled1,ifiled2)
		sqllib = "select " & ifiled2  & " from " & itable & " where " & ifiled1 & " = '" & idis & "'"
		rslib.Open sqllib,conn,adOpenKeyset,adLockReadOnly
			if rslib.RecordCount > 0 then
				display_name = rslib(0)
			else
				display_name = ""
			end if
		rslib.close
	End Function
%>

<%
	
	Function id_name(idis)
		sqllib = "select " & idis & " from myid"
		rslib.Open sqllib,conn,adOpenKeyset,adLockReadOnly
			if rslib.RecordCount > 0 then
				id_name = rslib(0)
				sql1 = "update myid set " & idis & " = '" & rslib(0) + 1 & "'"
				conn.execute(sql1)
			end if
		rslib.close
	End Function
%>

<%
	Sub myselect_name(itable,idis,ifiled1,ifiled2)
		sqllib = "select " & ifiled1 & "," & ifiled2  & " from " & itable & "  order by " & ifiled2
		rslib.Open sqllib,conn,adOpenKeyset,adLockReadOnly
			if rslib.RecordCount > 0 then
				do while not rslib.EOF 
				if trim(rslib(0)) = Trim(idis) then
				Response.Write "<option value=" & trim(rslib(0)) & " selected>" & trim(rslib(1)) & " </option>"
				else
				Response.Write "<option value=" & trim(rslib(0)) & ">" & trim(rslib(1)) & " </option>"
				end if
			rslib.MoveNext 
			loop
			else
			'	response.write "没有"
			end if
		rslib.close
	End Sub
%>

<%
	Function bmyselect_name(itable,idis,ifiled1,ifiled2)
		sqllib = "select " & ifiled1 & "," & ifiled2  & " from " & itable & "  order by " & ifiled2
		rslib.Open sqllib,conn,adOpenKeyset,adLockReadOnly
			if rslib.RecordCount > 0 then
				do while not rslib.EOF 
				if trim(rslib(0)) = Trim(idis) then
				mys = mys &  "<option value=" & trim(rslib(0)) & " selected>" & trim(rslib(1)) & " </option>"
				else
				mys = mys & "<option value=" & trim(rslib(0)) & ">" & trim(rslib(1)) & " </option>"
				end if
			rslib.MoveNext 
			loop
			else
			'	response.write "没有"
			end if
		rslib.close
		bmyselect_name=mys
	End Function
%>

<%
	Function bpreselect_name(itable,idis,zidis,ifiled1,ifiled2)
		sqllib = "select " & ifiled1 & "," & ifiled2  & " from " & itable & " where pre_class_no = '" & idis & "' and pre_class_no <> class_no"
		rslib.Open sqllib,conn,adOpenKeyset,adLockReadOnly
			if rslib.RecordCount > 0 then
				do while not rslib.EOF 
				if trim(rslib(0)) = Trim(zidis) then
				mys=mys & "<option value=" & trim(rslib(0)) & " selected>" & trim(rslib(1)) & " </option>"
				else
				mys = mys & "<option value=" & trim(rslib(0)) & ">" & trim(rslib(1)) & " </option>"
				end if
			rslib.MoveNext 
			loop
			else
				mys ="no"
			end if
		rslib.close
		bpreselect_name=mys
	End Function
	
	Sub mypreselect_name(itable,idis,zidis,ifiled1,ifiled2)
		sqllib = "select " & ifiled1 & "," & ifiled2  & " from " & itable & " where pre_class_no = '" & idis & "' and pre_class_no <> class_no"
		rslib.Open sqllib,conn,adOpenKeyset,adLockReadOnly
			if rslib.RecordCount > 0 then
				do while not rslib.EOF 
				if trim(rslib(0)) = Trim(zidis) then
				Response.Write "<option value=" & trim(rslib(0)) & " selected>" & trim(rslib(1)) & " </option>"
				else
				Response.Write "<option value=" & trim(rslib(0)) & ">" & trim(rslib(1)) & " </option>"
				end if
			rslib.MoveNext 
			loop
			else
			'	response.write "没有"
			end if
		rslib.close
	End Sub
%>

<%
	Sub myselect_name_dis(itable,idis,adis,ifiled1,ifiled2)
		sqllib = "select " & ifiled1 & "," & ifiled2  & " from " & itable & " where " & adis & "='" & idis & "'"
		rslib.Open sqllib,conn,adOpenKeyset,adLockReadOnly
			if rslib.RecordCount > 0 then
				do while not rslib.EOF 
				Response.Write "<option value=" & trim(rslib(0)) & ">" & trim(rslib(1)) & " </option>"
				
			rslib.MoveNext 
			loop
			else
			'	response.write "没有"
			end if
		rslib.close
	End Sub
	
	Function mycheck(itable,idis,ifiled1)
		sqllib = "select * from " & itable & " where " & ifiled1 & " like '%" & idis & "%'"
		rslib.Open sqllib,conn,adOpenKeyset,adLockReadOnly
			if rslib.RecordCount > 0 then
				mycheck = "checked"
			else
				mycheck = ""
			end if
		rslib.close
	End Function
	
	Function bmycheck(itable,idis,ifiled1,mybs)
		sqllib = "select * from " & itable & " where " & ifiled1 & " like '%" & idis & "%' and user_name = '" & mybs & "'"
		rslib.Open sqllib,conn,adOpenKeyset,adLockReadOnly
			if rslib.RecordCount > 0 then
				bmycheck = "checked"
			else
				bmycheck = ""
			end if
		rslib.close
	End Function
	
	Function bmystatus(itable,idis)
		sqllib = "select * from " & itable & " where user_name = '" & idis & "'"
		rslib.Open sqllib,conn,adOpenKeyset,adLockReadOnly
			if rslib.RecordCount > 0 then
				bmystatus = "已编辑"
			else
				bmystatus = "未编辑"
			end if
		rslib.close
	End Function
	
	Function mydd(idis)
		m = month(idis)
			if m < 10 then
				m = "0" & m
			end if
		d = day(idis)
			if d < 10 then
				d = "0" & d
			end if
		y = year(idis)
		mydd = m & "/" & d & "/" & y
	End Function
	
	Function modejy(idis)
		dim dm (100)
			dm(0) = "买入"
			dm(1) = "卖出"
			dm(2) = "合作"
			dm(3) = "代理"
		For i = 0 to 3
			if dm(i) = idis then
				Response.Write "<option value=" & dm(i) & " selected>" & dm(i) & "</option>"
			else
				Response.Write "<option value=" & dm(i) & ">" & dm(i) & "</option>"
			end if
		next
	End Function
	
	Function bmodejy(idis)
		dim dm (100)
			dm(0) = "买入"
			dm(1) = "卖出"
			dm(2) = "合作"
			dm(3) = "代理"
		For i = 0 to 3
			if dm(i) = idis then
				mys = mys & "<option value=" & dm(i) & " selected>" & dm(i) & "</option>"
			else
				mys = mys & "<option value=" & dm(i) & ">" & dm(i) & "</option>"
			end if
		next
		bmodejy=mys
	End Function
%>
