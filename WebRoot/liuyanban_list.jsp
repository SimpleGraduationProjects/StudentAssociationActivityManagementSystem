﻿<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
	<TITLE>留言板查询</TITLE>
	<script type="text/javascript" src="js/My97DatePicker/WdatePicker.js" charset="gb2312"></script>
	<link rel="stylesheet" href="images/hsgcommon/common.css" type="text/css">
<link rel="stylesheet" href="images/hsgcommon/div.css" type="text/css">
	</head>
	<body>
	<table width="100%" border="1" cellpadding="0" cellspacing="0">
			<tr valign="top">
				<td>
					<table width="100%" border="0" align="center" cellpadding="4" cellspacing="1" bgcolor="#aec3de">
						<tr align="left" bgcolor="#F2FDFF">
							<td height="30" colspan="17" background="images/table_header.gif">留言板列表</td>
						</tr>
					</table>
				</td>
			</tr>
			
			<tr valign="top">
			  <td bgcolor="#FFFFFF">
			  <table width="100%" border="1" align="center" cellpadding="4" cellspacing="1" bgcolor="#aec3de">
						
					<tr align="right" bgcolor="#ebf0f7">
					  <td colspan="21">
					  <table width="100%" border="0" align="center" cellpadding="4" cellspacing="1" >
						<tr align="left" >
							<td height="30" colspan="17">
								<form action="liuyanbanList.do" name="myform" method="post">
									查询   昵称：<input name="cheng" type="text" id="cheng" class="form-control2" />  性别：<input name="xingbie" type="text" id="xingbie" class="form-control2" />
									<input type="submit" value="查询" class="btn btn-info btn-small" />
						        </form>								</td>
						</tr></table>
					  </td>
			    </tr>
					
						<tr align="center">
						<td style="padding-left:0px; padding-right:0px;"><table width="100%" border="0" align="center" cellpadding="4" cellspacing="1" bgcolor="#ebf0f7">
                          <tr>
                            <td width="30px" height="30" align="center" bgcolor="#ebf0f7">序号</td>
                            <td height="30" align='center' bgcolor="#ebf0f7">昵称</td>
    <td  width='40' height="30" align='center' bgcolor="#ebf0f7">表情</td>
    <td height="30" align='center' bgcolor="#ebf0f7">QQ</td>
    <td height="30" align='center' bgcolor="#ebf0f7">邮箱</td>
    <td height="30" align='center' bgcolor="#ebf0f7">手机</td>
    <td height="30" align='center' bgcolor="#ebf0f7">内容</td>
    <td height="30" align='center' bgcolor="#ebf0f7">回复内容</td>
    
                            <td width="150px" height="30" align="center" bgcolor="#ebf0f7"> 添加时间 </td>
                            <td width="150px" height="30" align="center" bgcolor="#ebf0f7"> 操作 </td>
                          </tr>
                          <%
					int i=0;
				%>
                          <c:forEach items="${list }" var="u">
                            <%
					i++;
				%>
                            <tr align="center" bgcolor="#FFFFFF">
                              <td align="center"><%=i%></td>
                             <td>${u.cheng}</td>
    <td align='center'><img width='70'height='70' src=img/${u.xingbie}.gif border=0></td>
    <td>${u.QQ}</td>
    <td>${u.youxiang}</td>
    <td>${u.shouji}</td>
    <td>${u.neirong}</td>
    <td>${u.huifuneirong}</td>
    
                              <td align="center"> ${u.addtime } </td>
                              <td align="center"><a class="btn btn-info btn-small" href="doUpdateLiuyanbanlb.do?id=${u.id }">回复</a>  <a class="btn btn-info btn-small" href="deleteLiuyanban.do?id=${u.id }"
										onclick="{if(confirm('确定要删除吗?')){return true;}return false;}">删除</a> </td>
                            </tr>
                          </c:forEach>
                        </table></td>
						</tr>
					</table>
					
					
			  </td>
	  </tr>
		</table>
			<p align="center" class="fy"> <c:if test="${sessionScope.p==1 }">
		 <c:if test="${page.page>1}">
              <a href="liuyanbanList.do?page=1" >首页</a>
             <a href="liuyanbanList.do?page=${page.page-1 }"> 上一页</a>             </c:if>
    	     <c:if test="${page.page<page.totalPage}">
			<a href="liuyanbanList.do?page=${page.page+1 }">下一页</a>
			<a href="liuyanbanList.do?page=${page.totalPage }">末页</a>		    </c:if>		
	</c:if>
	</p>
			
			
			
			
			
	</body>
</html>
