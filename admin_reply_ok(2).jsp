<%@ page language="java" contentType="text/html; charset=EUC-KR"
   pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>
<%@ page import="web2017.DBUtill"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>MyHomp</title>
<link rel="stylesheet" type="text/css" href="defaultcss.css" />
<style type="text/css">
            body{
                background-color: pink;
            }
        </style>
</head>
<body>
<%
   request.setCharacterEncoding("euc-kr");
%>
<%
      String id = (String) session.getAttribute("id"); //�α����� ����
	  String page_id_session=(String)session.getAttribute("id2"); //�����ִ� �������� �̴�Ȩ�� ����
      
	  String content = request.getParameter("memo"); 
      String page_id; //Ÿ�� ���̺� �Ķ���� �ѱ�
      Connection conn = DBUtill.getMySQLConnection();
      //�����ͺ��̽��� ����
     
      //�ԷµǴ� �������� ����
       
      //�α����� ����ڿ� �����ִ� Ȩ�������� ������ ������ ���Ͽ� ���ǰ��� ���ٸ� target�� �α����� ������� ���̵� ����
      System.out.println("test :" + id);
      
      if(id.equals(page_id_session)){
    	  page_id= (String)session.getAttribute("id"); //Ÿ�� ���̺� �Ķ���� �ѱ�
    	  System.out.println("����");
    	  //page_id_session=id;
    	  
      }
      else{ //�ٸ� ��쿡�� Ȩ������ ������ ���� ���̵� Ÿ�ٿ� ����
      	page_id= (String) session.getAttribute("id");
      	//System.out.println(page_id_session);
      }
      
      String sql = "insert into board(id,content,target) values(?,?,?)";
      //�����ͺ��̽��� �÷��� �Է¹��� �����͸� �־���
      PreparedStatement pstmt = conn.prepareStatement(sql);
      //�־��ִ� ������ ����
      System.out.println(pstmt + "<-- pstmt 1");
      
      pstmt.setString(1, id);
      pstmt.setString(2, content);
      pstmt.setString(3, page_id);
      
      System.out.println(pstmt + "<-- pstmt 2");

      pstmt.executeUpdate();

      DBUtill.close(pstmt);
      DBUtill.close(conn);
	      
   
   %>
  <script language=javascript>
   self.window.alert("�Է��� ���� �����Ͽ����ϴ�.");
   location.href="admin_reply_ok(1).jsp";
  </script>
  </body>
  </html>
  