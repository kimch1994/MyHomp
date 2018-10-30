<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko">
<head>
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="com.oreilly.servlet.MultipartRequest,com.oreilly.servlet.multipart.DefaultFileRenamePolicy,java.util.*,java.io.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="web2017.DBUtill"%>
<%@ page import="java.util.Date"%>

<%
 request.setCharacterEncoding("euc-kr");
 String realFolder = "D:\\jangjonghyuk_web\\web2017\\WebContent\\face_img";
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
      String id = (String) session.getAttribute("id");
   %>
   <%
      Connection conn = DBUtill.getMySQLConnection();
      //데이터베이스와 연결
      String sql = "insert into face_img(id , file) values(?,?)";
      //데이터베이스의 컬럼에 입력받은 데이터를 넣어줌
      PreparedStatement pstmt = conn.prepareStatement(sql);
      //넣어주는 동작을 수행
      System.out.println(pstmt + "<-- pstmt 1");

      pstmt.setString(1, id);
      pstmt.setString(2, filename1);
      //입력되는 데이터의 순서
      System.out.println(pstmt + "<-- pstmt 2");

      pstmt.executeUpdate();

      DBUtill.close(pstmt);
      DBUtill.close(conn);
   %>
<jsp:forward page="adminafter.jsp" />
<title>Insert title here</title>
</head>
<body>
</body>
</html> 