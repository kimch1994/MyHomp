<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>
<%@ page import="web2017.DBUtill"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>MyHomp</title>
</head>
<body>
	<%
      request.setCharacterEncoding("euc-kr");
   %>
	<%
   //id passwd��������
   String id = request.getParameter("ID");
   String passwd = request.getParameter("PWD");
   ResultSet rs = null;
   Connection con = DBUtill.getMySQLConnection();
   PreparedStatement pstmt = null;
   String sql = "";
   try{
    sql = "select passwd from member where id=?";
     pstmt = con.prepareStatement(sql);
     pstmt.setString(1, id);
    //4�ܰ� ���� => rs
    rs = pstmt.executeQuery();
    //5�ܰ� �����Ͱ� ������ ���̵�����
    if(rs.next()){
     //id����
     String dbPass=rs.getString("passwd");
     if(id.equals("jangjongs") && dbPass.equals("1111")){
      %>   
            <script type="text/javascript">
              alert("������ ����Դϴ�.");
              location.href="adminafter.jsp";
              </script>
          <%   
      }
     if(passwd.equals(dbPass)){
      //��й�ȣ�� ������ ���ǰ����� "id"
      //    �̵� 
      session.setAttribute("id", id);
      %>
	<script type="text/javascript">
      alert("���ǰ� ����.�α��ο� �����ϼ̽��ϴ�.");
      location.href="loginafter.jsp";
      </script>
	<%
     }else{
      %>
	<script type="text/javascript">
      alert("��й�ȣ ����");
      history.back();
      </script>
	<%
     }
    }else{
     %>
	<script type="text/javascript">
     alert("id�� �������� �ʽ��ϴ�.");
     history.back();
     </script>
	<%
    }
   }catch (Exception e) {
    e.printStackTrace();
   }
   %>
</body>
</html>