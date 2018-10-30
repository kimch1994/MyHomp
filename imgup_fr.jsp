<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko">
<head>
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="com.oreilly.servlet.MultipartRequest,com.oreilly.servlet.multipart.DefaultFileRenamePolicy,java.util.*,java.io.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="web2017.DBUtill"%>
<%@ page import="java.util.Date"%>

<%
 Date now = new Date();
 String time = ((now.getYear() + 1900) + "." + (now.getMonth()+1) + "." + now.getDate() + " " + now.getHours()
      + ":" + now.getMinutes() + ":" + now.getSeconds());
 request.setCharacterEncoding("euc-kr");
 String realFolder = "D:\\jangjonghyuk_web\\web2017\\WebContent\\save";
 String filename1 = "";
 int maxSize = 1024*1024*5;
 String encType = "euc-kr";
 String savefile = "";
 ServletContext scontext = getServletContext();
 //realFolder = scontext.getRealPath(savefile);
 
 try{
  MultipartRequest multi=new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());

  Enumeration<?> files = multi.getFileNames();
     String file1 = (String)files.nextElement();
     filename1 = multi.getFilesystemName(file1);
 } catch(Exception e) {
  e.printStackTrace();
 }
 
 String fullpath = realFolder + "\\" + filename1;
 System.out.println(fullpath);
%>
<%
      request.setCharacterEncoding("euc-kr");
		String fr = request.getParameter("fr");
     // String id = (String) session.getAttribute("id");
   %>

   <%

      Connection conn = DBUtill.getMySQLConnection();
      //�����ͺ��̽��� ����
      String sql = "insert into img(id , file1, tim) values(?,?,?)";
      //�����ͺ��̽��� �÷��� �Է¹��� �����͸� �־���
      PreparedStatement pstmt = conn.prepareStatement(sql);
      //�־��ִ� ������ ����
      System.out.println(pstmt + "<-- pstmt 1");

      pstmt.setString(1, fr);
      pstmt.setString(2, filename1);
      pstmt.setString(3, time);
      //�ԷµǴ� �������� ����
      System.out.println(pstmt + "<-- pstmt 2");

      pstmt.executeUpdate();

      DBUtill.close(pstmt);
      DBUtill.close(conn);
   %>
<jsp:forward page="photomenu_fr.jsp" />
<title>Insert title here</title>
</head>
<body>
</body>
</html> 