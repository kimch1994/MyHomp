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

</head>
<body>
	<%
		request.setCharacterEncoding("euc-kr");
	%>
	<%
		String id = (String) session.getAttribute("id");
	String fr = request.getParameter("fr");
		Connection conn = DBUtill.getMySQLConnection();
		String sql = "select * from member where id = ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, fr);
		ResultSet rs = pstmt.executeQuery();
		rs.next();
		//String user_name = (String) session.getAttribute("user_name");
	%>
	<%!%>
	</script>
	<jsp:useBean id="project" class="web2017.project" scope="page" />
	<jsp:setProperty property="user_name" name="project" param="user_name" />
	<div class="wrap">
		<header> <a id="logo" href="loginafter.jsp"><strong>MyHomp</strong></a>
		<span class="right" style="padding: 3px 10px;"><a href="loginafter.jsp"><%=id %>님 &nbsp;  <a
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
               String sql3 = "select * from face_img where id= ?";
               PreparedStatement pstmt3 = conn.prepareStatement(sql3);
               pstmt3.setString(1, fr);
               ResultSet rs3 = pstmt3.executeQuery();
               if(rs3.next())
               {  
                  String realfile1 = rs3.getString("file");
                  System.out.println(realfile1);
               %>
              
               <img src="face_img\<%=realfile1%>" id="profile1"  >
               
               <%
               }
               %>
					</div>
				</div>

				<div id="right_area">
					<strong id="pageid">&nbsp;&nbsp;<%=fr%>님 의 미니홈피
					</strong><!--  <input type="file" value="게시글" />-->
					<div id="inner">
						<div class="filebox">
						<!--  	<label for="ex_file">업로드</label> <input type="file" id="ex_file"
								accept=".jpg, .jpeg, .png" multiple>
								<input type="submit" value="업로드">-->
								<table>
                        <%
                     String sql2 = "select file1,tim from img where id= ?";
                     PreparedStatement pstmt1 = conn.prepareStatement(sql2);
                     pstmt1.setString(1, fr);
                     System.out.println(pstmt1);
                     ResultSet rs1 = pstmt1.executeQuery();
                     while(rs1.next())
                     {
                        String realfile1 = rs1.getString("file1");
                        String time1 = rs1.getString("tim");
                        System.out.println(realfile1);
                        %>
                        <tr>      
                           <td><img src="save\<%=realfile1%>" width="150" height="50"></td>
                           <td><%=time1%></td>
                        </tr>
                        <% 
                     
                     }
                     %>
                     
                     </table> 
						</div>
						<!-- <img src="img_load.jsp" border="0">-->
					</div>
					<div id="menu">
						<table>
							<tr>
								<td><a href="friendpage.jsp?fr=<%=fr%>"><label class="btn_file">홈</label></a></td>
							</tr>
							<tr>
								<td><a href="photomenu_friend.jsp?fr=<%=fr%>"><label for="uploadBtn"
										class="btn_file">사진</label></a></td>
							</tr>
							<tr>
								<td><a href="postingafter_friend.jsp?fr=<%=fr%>"><label class="btn_file">방명록</label></a></td>
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