<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>
<%@ page import="web2017.DBUtill"%>
<%
   request.setCharacterEncoding("euc-kr");
%>
<%
      String id = (String) session.getAttribute("id"); //로그인한 세션
	  String page_id_session=(String)session.getAttribute("id2"); //보고있는 페이지의 미니홈피 주인
      
	  String content = request.getParameter("memo"); 
      String page_id; //타켓 테이블에 파라미터 넘김
      Connection conn = DBUtill.getMySQLConnection();
      //데이터베이스와 연결
     
      //입력되는 데이터의 순서
       
      //로그인한 사용자와 보고있는 홈페이지의 주인의 세션을 비교하여 세션값이 같다면 target에 로그인한 사용자의 아이디를 저장
      System.out.println("test :" + page_id_session);
      
      if(id.equals(page_id_session)){
    	  page_id= (String)session.getAttribute("id"); //타켓 테이블에 파라미터 넘김
    	  System.out.println("ㅎㅇ");
    	  //page_id_session=id;
    	  
      }
      else{ //다른 경우에는 홈페이지 주인의 세션 아이디를 타겟에 저장
      	page_id= (String) session.getAttribute("id2");
      	//System.out.println(page_id_session);
      }
      
      String sql = "insert into board(id,content,target) values(?,?,?)";
      //데이터베이스의 컬럼에 입력받은 데이터를 넣어줌
      PreparedStatement pstmt = conn.prepareStatement(sql);
      //넣어주는 동작을 수행
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
   self.window.alert("입력한 글을 저장하였습니다.");
   location.href="reply_ok2(1).jsp";
  </script>