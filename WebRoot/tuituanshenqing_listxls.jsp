<%@ page language="java" import="java.util.*" pageEncoding="gb2312"%>
<jsp:useBean id="sn" scope="page" class="com.bean.SystemBean" />
<jsp:useBean id="tuituanshenqinghsgb" scope="page" class="com.bean.TuituanshenqingBean" /> 

<%
response.setContentType("application/vnd.ms-excel");
response.addHeader("Content-Disposition", "attachment;filename=tuituanshenqing.xls");
%>
<html>
  <head>
    <title>��������</title>
  </head>

  <body >
 <%
			String sql="select * from tuituanshenqing  order by id desc";

			
			%>
<table width="100%" border="1" align="center" cellpadding="3" cellspacing="1" bordercolor="00FFFF" style="border-collapse:collapse">  
  <tr>
    <td width="30" align="center" bgcolor="CCFFFF">���</td>
    <td align='center' bgcolor='#ebf0f7'>���ű��</td>    <td align='center' bgcolor='#ebf0f7'>��������</td>    <td align='center' bgcolor='#ebf0f7'>ѧ��</td>    <td align='center' bgcolor='#ebf0f7'>����</td>    <td align='center' bgcolor='#ebf0f7'>Ժϵ</td>    <td align='center' bgcolor='#ebf0f7'>��������</td>    <td  width='80' align='center' bgcolor='#ebf0f7'>�Ƿ����</td>
	
    <td width="120" align="center" bgcolor="CCFFFF">���ʱ��</td>
    
  </tr>
   <%		
				List pagelist3=tuituanshenqinghsgb.getAllTuituanshenqing(9);
			if(!pagelist3.isEmpty()){
				for(int i=0;i<pagelist3.size();i++){
					List pagelist2 =(ArrayList)pagelist3.get(i);
			%>
  <tr>
    <td  align="center"><%=i+1 %></td>
    <td>${u.shetuanbianhao}</td>    <td>${u.shetuanmingcheng}</td>    <td>${u.xuehao}</td>    <td>${u.xingming}</td>    <td>${u.yuanxi}</td>    <td>${u.tuituanliyou}</td>    <td align='center'>${u.issh} <input type="button" value="���" onclick="javascript:location.href='sh.jsp?id=${u.id}&yuan=${u.issh}&tablename=tuituanshenqing'"/></td>
	
	
   
  </tr>
  	<%
  }}
   %>
   
</table>
<br>
  </body>
</html>

