<%@ page language="java" import="java.util.*" pageEncoding="gb2312"%>
<jsp:useBean id="sn" scope="page" class="com.bean.SystemBean" />
<jsp:useBean id="shetuanhuodonghsgb" scope="page" class="com.bean.ShetuanhuodongBean" /> 

<%
response.setContentType("application/vnd.ms-excel");
response.addHeader("Content-Disposition", "attachment;filename=shetuanhuodong.xls");
%>
<html>
  <head>
    <title>���Ż</title>
  </head>

  <body >
 <%
			String sql="select * from shetuanhuodong  order by id desc";

			
			%>
<table width="100%" border="1" align="center" cellpadding="3" cellspacing="1" bordercolor="00FFFF" style="border-collapse:collapse">  
  <tr>
    <td width="30" align="center" bgcolor="CCFFFF">���</td>
    <td align='center' bgcolor='#ebf0f7'>�����</td>    <td  width='95' align='center' bgcolor='#ebf0f7'>�ʱ��</td>    <td align='center' bgcolor='#ebf0f7'>���ű��</td>    <td align='center' bgcolor='#ebf0f7'>��������</td>        <td  width='80' align='center' bgcolor='#ebf0f7'>�Ƿ����</td>
	
    <td width="120" align="center" bgcolor="CCFFFF">���ʱ��</td>
    
  </tr>
   <%		
				List pagelist3=shetuanhuodonghsgb.getAllShetuanhuodong(8);
			if(!pagelist3.isEmpty()){
				for(int i=0;i<pagelist3.size();i++){
					List pagelist2 =(ArrayList)pagelist3.get(i);
			%>
  <tr>
    <td  align="center"><%=i+1 %></td>
    <td>${u.huodongmingcheng}</td>    <td>${u.huodongshijian}</td>    <td>${u.shetuanbianhao}</td>    <td>${u.shetuanmingcheng}</td>        <td align='center'>${u.issh} <input type="button" value="���" onclick="javascript:location.href='sh.jsp?id=${u.id}&yuan=${u.issh}&tablename=shetuanhuodong'"/></td>
	
	
   
  </tr>
  	<%
  }}
   %>
   
</table>
<br>
  </body>
</html>

