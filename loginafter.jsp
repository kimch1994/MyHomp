<!--  �α��� ����ȭ��  -->
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
</head>
<body>
   <%
      request.setCharacterEncoding("euc-kr");
   %>
   <%
      String id = (String) session.getAttribute("id");
   	  String friend_id=(String)session.getAttribute("id2");
      Connection conn = DBUtill.getMySQLConnection();
      String sql = "select * from board where target=? order by tim desc";
      PreparedStatement pstmt = conn.prepareStatement(sql);
      pstmt.setString(1, id);
      ResultSet rs = pstmt.executeQuery();
      //String user_name = (String) session.getAttribute("user_name");
   %>
   
   <%!%>
   <script language="javascript">
      // �ڹ� ��ũ��Ʈ ����
      function replyCheck() {
         var form = document.replyform;

         if (!form.memo.value) {
            alert("������ �����ּ���");
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
      <span class="right" style="padding: 3px 10px;"><a href="loginafter.jsp"><%=id %>�� &nbsp; <a
         href="logout.jsp"><input type="submit" name="Logout"
            id="Logout" value="�α׾ƿ�" /></a><a href="friendlist.jsp"><input
						type="button" name="friend" value="ģ��ã��" id="friend" /></a>
      </span> </header>
    
      <section class="left">
      <div class="section_warp">

         <div class="fileBox">

            <div id="left_area">
               	������
             <div id="profile">
             	
               <% 
               String sql2 = "select * from face_img where id= ?";
               PreparedStatement pstmt1 = conn.prepareStatement(sql2);
               pstmt1.setString(1, id);
               ResultSet rs1 = pstmt1.executeQuery();
               if(rs1.next())
               {  
                  String realfile1 = rs1.getString("file");
                  System.out.println(realfile1);
               %>
              
               <img src="face_img\<%=realfile1%>" id="profile1"  >
               
               <%
               }
               %>
               
              </div>
              <div id="up">
                 <form method="post" enctype="multipart/form-data" action="imgup2.jsp">
               <input type=file id="ex_file1" name="filename e1" accept=".jpg, .jpeg, .png" multiple>
               <input type=submit value="����" id="ex_file2"  >
               </form>
               </div>
            </div>

            <div id="right_area">
               <strong id="pageid">&nbsp;&nbsp;<%=id%>�� �� �̴�Ȩ��
               </strong>
               <div id="inner">
               	<iframe src="reply_ok(1).jsp" width="100%" height="450px"
								name="quotation" frameborder="0" allowTransparency="true" ></iframe>
               </div>
               <div id="menu">
                  <table>
                     <tr>
                        <td><a href="loginafter.jsp"><label class="btn_file">Ȩ</label></a></td>
                     </tr>
                     <tr>
                        <td><a href="photomenu.jsp"><label for="uploadBtn"
                              class="btn_file">����</label></a></td>
                     </tr>
                     <tr>
                        <td><a href="postingafter_mine.jsp"><label class="btn_file">����</label></a></td>
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