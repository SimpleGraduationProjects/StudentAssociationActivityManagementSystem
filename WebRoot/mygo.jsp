﻿<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title></title>
  </head>
  <body>
  <%
if(request.getSession().getAttribute("cx").equals("超级管理员") || request.getSession().getAttribute("cx").equals("普通管理员")){response.sendRedirect("left_guanliyuan.jsp");}if(request.getSession().getAttribute("cx").equals("社团")){response.sendRedirect("left_shetuan.jsp");}if(request.getSession().getAttribute("cx").equals("学生")){response.sendRedirect("left_xuesheng.jsp");}if(request.getSession().getAttribute("cx").equals("注册用户")){response.sendRedirect("left_zhuceyonghu.jsp");}
 %>
  </body>
</html>