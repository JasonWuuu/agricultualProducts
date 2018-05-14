<% 
'防止SQL注入
'<!--#include file="sql.asp"-->

Query_Badword="'|;|--|/**|create |master.|select |update |user_name()|dbname()|.js|(|)|<script|select|delete|exec|decl|insert|and|exec|insert|select|delete|update|count|chr|*|chr|mid|master|truncate|char|declare" 
'在这部份定义get非法参数    

Form_Badword="'|;|--|/**|create |master.|select |update |user_name()|dbname()|.js|(|)|<script|select|delete|exec|decl|insert|and|exec|insert|select|delete|update|count|chr|*|chr|mid|master|truncate|char|declare"  
'在这部份定义post非法参数

'------定义部份  尾
'On Error Resume Next

'----- 对 get query 值 的过滤.
if request.QueryString<>"" then
	Chk_badword1=split(Query_Badword,"|")
	For i=0 to ubound(Chk_badword1)
		If Instr(LCase(request.QueryString),Chk_badword1(i))>0 Then
			Response.Write "Sorry!您使用了非法字符！（*，--，**）Get"
			Response.End
		End If
	NEXT
End if

'-----对 post 表 单值的过滤.
if request.form<>"" then
	Chk_badword2=split(Form_Badword,"|")
	For i=0 to ubound(Chk_badword2)
		If Instr(LCase(request.Form),Chk_badword2(i))>0 Then
		        Response.Write "Sorry!您使用了非法字符！（*，--，**）Form"
			Response.End
		End If
	NEXT
end if
%>
