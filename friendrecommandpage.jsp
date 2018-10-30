<!--  로그인 메인화면  -->
<%@ page language="java" contentType="text/html; charset=EUC-KR"
   pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>
<%@ page import="web2017.DBUtill"%>
<%@ page import="java.util.ArrayList" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>MyHomp</title>
<link rel="stylesheet" type="text/css" href="defaultcss.css" />
</head>
<body>
   <%
      request.setCharacterEncoding("euc-kr");
   %>
   <%
   	  //int count=2;
      String id = (String) session.getAttribute("id");
   	  String reco_session[]=new String[50];
   	 // reco_session[count]=(String)session.getAttribute("id3");
   	  //System.out.println(reco_session[count]);
   	  String fr = request.getParameter("fr"); //친구찾기에서 
   	  
      Connection conn = DBUtill.getMySQLConnection();
      String sql = "select * from board where target=? order by tim desc";
      PreparedStatement pstmt = conn.prepareStatement(sql);
      pstmt.setString(1, fr);
      ResultSet rs = pstmt.executeQuery();
      //String user_name = (String) session.getAttribute("user_name");
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
   <div class="wrap">
      <header> <a id="logo" href="loginafter.jsp"><strong>MyHomp</strong></a>
      <span class="right" style="padding: 3px 10px;"><a href="loginafter.jsp"><%=id %>님 &nbsp; <a
         href="logout.jsp"><input type="submit" name="Logout"
            id="Logout" value="로그아웃" /></a><a href="friendlist.jsp"><input
						type="button" name="friend" value="친구찾기" id="friend" /></a>
      </span> </header>

      <section class="left">
      <div class="section_warp">

         <div class="fileBox">

            <div id="left_area">
              	프로필
              <div id="profile">
               <!--  
               <form method="post" enctype="multipart/form-data" action="imgup2.jsp">
               <input type=file id="ex_file1" name="filename e1" accept=".jpg, .jpeg, .png" multiple>
               <input type=submit value="업로드" id="ex_file2"  >
               </form>
               -->
               <% 
               String sql2 = "select * from face_img where id= ?";
               PreparedStatement pstmt1 = conn.prepareStatement(sql2);
               pstmt1.setString(1, fr);
               ResultSet rs1 = pstmt1.executeQuery();
               if(rs1.next())
               {  
                  String realfile1 = rs1.getString("file");
                  System.out.println(realfile1);
               %>
              
               <img src="face_img\<%=realfile1%>" id="profile1" >
               
               <%
               }
               %>
               </div>
            </div>

            <div id="right_area">
               <strong id="pageid">&nbsp;&nbsp;<%=fr%>님 의 미니홈피
               </strong>
               <div id="inner">
                  <table>
                     <form name=replyform method=post action="reply_ok_fr.jsp?fr=<%=fr%>">
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
                  <table>
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
               </div>
               <div id="menu">
                  <table>
                     <tr>
                        <td><a href="friendrecommandpage.jsp?fr=<%=fr%>"><label class="btn_file">홈</label></a></td>
                     </tr>
                     <tr>
                        <td><a href="photomenu_fr.jsp?fr=<%=fr%>"><label for="uploadBtn"
                              class="btn_file">사진</label></a></td>
                     </tr>
                     <tr>
                        <td><a href="postingafter_fr.jsp?fr=<%=fr%>"><label class="btn_file">방명록</label></a></td>
                     </tr>
                  </table>
               </div>
            </div>
         </div>

      </div>
      </section>
      <aside class="right"> </aside>
      <footer>
      <div id="copyright">Copyright (c) 2017 project</div>
      </footer>
   </div>
</body>
</html>