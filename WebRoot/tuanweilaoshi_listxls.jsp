<%@ page language="java" import="java.util.*" pageEncoding="gb2312"%>
<jsp:useBean id="sn" scope="page" class="com.bean.SystemBean" />
<jsp:useBean id="tuanweilaoshihsgb" scope="page" class="com.bean.TuanweilaoshiBean" /> 

<%
response.setContentType("application/vnd.ms-excel");
response.addHeader("Content-Disposition", "attachment;filename=tuanweilaoshi.xls");
%>
<html>
  <head>
    <title>��ί��ʦ</title>
  </head>

  <body >
 <%
			String sql="select * from tuanweilaoshi  order by id desc";

			
			%>
<table width="100%" border="1" align="center" cellpadding="3" cellspacing="1" bordercolor="00FFFF" style="border-collapse:collapse">  
  <tr>
    <td width="30" align="center" bgcolor="CCFFFF">���</td>
    <td align='center' bgcolor='#ebf0f7'>���</td>    <td align='center' bgcolor='#ebf0f7'>����</td>    <td align='center' bgcolor='#ebf0f7'>����</td>    <td  width='40' align='center' bgcolor='#ebf0f7'>�Ա�</td>    <td align='center' bgcolor='#ebf0f7'>��ϵ�绰</td>        
	
    <td width="120" align="center" bgcolor="CCFFFF">���ʱ��</td>
    
  </tr>
   <%		
				List pagelist3=tuanweilaoshihsgb.getAllTuanweilaoshi(8);
			if(!pagelist3.isEmpty()){
				for(int i=0;i<pagelist3.size();i++){
					List pagelist2 =(ArrayList)pagelist3.get(i);
			%>
  <tr>
    <td  align="center"><%=i+1 %></td>
    <td>${u.bianhao}</td>    <td>${u.mima}</td>    <td>${u.xingming}</td>    <td align='center' bgcolor='#ebf0f7'>${u.xingbie}</td>    <td>${u.lianxidianhua}</td>        
	
	
   
  </tr>
  	<%
  }}
   %>
   
</table>
<br>
  </body>
</html>

