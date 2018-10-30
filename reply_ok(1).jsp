<!--  로그인 메인화면  -->
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
      String id = (String) session.getAttribute("id");
   	  String page_id_session=(String)session.getAttribute("id2");
   	  //String content = request.getParameter("memo");
   	  String page_id;
      Connection conn = DBUtill.getMySQLConnection();
      String sql = "select * from board where target=? order by tim desc";
      PreparedStatement pstmt = conn.prepareStatement(sql);
      pstmt.setString(1, id);
      ResultSet rs = pstmt.executeQuery();
      //String user_name = (String) session.getAttribute("user_name");
   	if(id.equals(page_id_session)){
    	  page_id= (String)session.getAttribute("id"); //타켓 테이블에 파라미터 넘김
    	  System.out.println("ㅎㅇ");
    	  //page_id_session=id;
    	  
      }
      else{ //다른 경우에는 홈페이지 주인의 세션 아이디를 타겟에 저장
      	page_id= (String) session.getAttribute("id");
      	//System.out.println(page_id_session);
      }
   %>
   
   <%!%>
   <script language="javascript">
      // 자바 스크립트 시작
      function replyCheck() {
         var form = document.replyform;

         if (!form.memo.value) {
            alert("내용을 적어주세요");
            form.memo.focus();
            return;
         }
         form.submit();
      }
   </script>
   <jsp:useBean id="project" class="web2017.project" scope="page" />
   <jsp:setProperty property="user_name" name="project" param="user_name" />
   <jsp:setProperty property="memo" name="project" param="memo" />
   
                     <table id="commen">
                     <form name=replyform method=post action="reply_ok(2).jsp">
                     <tr>
                        <td><textarea name="memo" id="reple" rows="1" cols="30"></textarea></td>
                        <td><input type="submit" value="확인" id="reple_submit" /></td>
                     </tr>
                     </form>
                  </table>
             <% 
                  while(rs.next())
                  {
                     String content = rs.getString("content");
                    String write = rs.getString("id");
                     String tim = rs.getString("tim");
                     System.out.println(id+ content + tim);
                  %>
                  <!--  -->
                  <table id="comen">
                  <tr>
                     <td><%= write%>:&nbsp;</td>
                     <td><%=content %>&nbsp;</td>
                     <td>//&nbsp;<%= tim %>&nbsp;//</td>
                  </tr>
                  </table>
                  <!--  -->
                  <% 
                  }
                  %>
</body>
</html>