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
   //id passwd가져오기
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
    //4단계 실행 => rs
    rs = pstmt.executeQuery();
    //5단계 데이터가 있으면 아이디있음
    if(rs.next()){
     //id있음
     String dbPass=rs.getString("passwd");
     if(id.equals("jangjongs") && dbPass.equals("1111")){
      %>   
            <script type="text/javascript">
              alert("관리자 모드입니다.");
              location.href="adminafter.jsp";
              </script>
          <%   
      }
     if(passwd.equals(dbPass)){
      //비밀번호비교 맞으면 세션값생성 "id"
      //    이동 
      session.setAttribute("id", id);
      %>
	<script type="text/javascript">
      alert("세션값 생성.로그인에 성공하셨습니다.");
      location.href="loginafter.jsp";
      </script>
	<%
     }else{
      %>
	<script type="text/javascript">
      alert("비밀번호 오류");
      history.back();
      </script>
	<%
     }
    }else{
     %>
	<script type="text/javascript">
     alert("id가 존재하지 않습니다.");
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