<!--  로그인 메인화면  -->
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>
<%@ page import="web2017.DBUtill"%>
<%@ page import="java.util.Date"%>
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

	<jsp:useBean id="project" class="web2017.project" scope="page" />
	<jsp:setProperty property="user_name" name="project" param="user_name" />
	<%
		Date now = new Date();
		String time = ((now.getYear() + 1900) + "." + (now.getMonth()+1) + "." + now.getDate() + " " + now.getHours()
				+ ":" + now.getMinutes() + ":" + now.getSeconds());

		String id = (String) session.getAttribute("id");
		String friend_id=(String)session.getAttribute("id2");
	  	if (friend_id == null)
	  		friend_id = id;
	  	
		String from = friend_id; //현재 페이지의 주인 닉네임
		String profile = "a.png"; // 현재 로그인된 사람의 프로필 사진 링크 

		Connection conn = DBUtill.getMySQLConnection();
		String sql = "select * from member where id = ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		String fr = request.getParameter("fr");
		ResultSet rs = pstmt.executeQuery();
		rs.next();
		//String user_name = (String) session.getAttribute("user_name");
	%>
	<form class="" action="post_add_friend.jsp?fr=<%=fr %>" method="post">
		<table border='1'>
		<tr>
		<td>
		<TEXTAREA name="text" id="visited"
			style="overflow: hidden; width: 500px; height: 100px;"></TEXTAREA>
		</td></tr>
		<tr>
		<td>
		<input type="hidden" name="id" value="<%=id%>"> <input
			type="hidden" name="now" value="<%=time%>"> <input
			type="hidden" name="from" value="<%=from%>"> <input
			type="submit" name="bmr_write" value="작성" id="bmr_write">
		</td></tr>
		</table>
	</form>


	<%
		Connection con = null;
		Statement stmt = null;
		PreparedStatement pstmt2 = null;

		String driverName = "org.gjt.mm.mysql.Driver";
		String dbURL = "jdbc:mysql://localhost:3306/membership";

		String sql2 = "select * from bmr where your ='"+from+"'and writer='"+id+ "'order by bmkNum desc;";

		try {
			Class.forName(driverName);
			con = DriverManager.getConnection(dbURL, "root", "1111");

			pstmt2 = con.prepareStatement(sql2);
			ResultSet rs2 = pstmt2.executeQuery();
	%>


	<%
		while (rs2.next()) {
	%>
	<table border="1" width="500">
		<tr>
			<td colspan="2" id="headline">
				<p>
				<!--  
					번호 :
					<%=rs2.getInt(1)%>
					-->
					작성자 :
					<%=rs2.getString(3)%>
					시간:
					<%=rs2.getString(6)%></p>
			</td>
		</tr>
		<tr>
			<td width="150"><img src="img/a.png"
				style="width: 100px; height: 100px;" alt="<%=rs2.getString(5)%>"></td>
			<td><TEXTAREA disabled name="bmr_read" id="visit"
					style="overflow: hidden; width: 400px; height: 100px;"><%=rs2.getString(2)%></TEXTAREA>
			</td>
		</tr>
		<tr>
			<td colspan="2">
			<form class="" action="post_reple_add_friend.jsp?fr=<%=fr%>" method="post">
			
		<input type="text" id="visitor" name="reple" style=" width: 440px; height: 20px;" >

		<input type="hidden" name="id" value="<%=id%>">
		 <input	type="hidden" name="now" value="<%=time%>"> 
		 <input	type="hidden" name="ref" value="<%=rs2.getInt(1)%>"> 
		 <input	type="submit" name="rp_write" value="작성" id="rp_write">

	</form>
			<% 
			String sql3 ="select * from bmr_reple where ref = '"+rs2.getInt(1)+"' order by time desc;";
			
				pstmt2 = con.prepareStatement(sql3); 
				ResultSet  rs3 = pstmt2.executeQuery(); 
			%>
			


				<table border="1" width="500">

					<%
						while (rs3.next()) {
					%><tr>
						<td colspan="2"><%=rs3.getString(2)%> : <%=rs3.getString(3)%>
							&nbsp;-&nbsp; (<%=rs3.getString(4)%>)</td>
					</tr>
					<%
						}
					%>


				</table>
			</td>
		</tr>
	</table>


	<%
		}
	%>
	<%
		rs2.next();

		} catch (Exception e) {
			out.println("MySql 데이터베이스 조회에 문제가 있습니다. <hr>");
			out.println(e.toString());
			e.printStackTrace();
		} finally {
			if (pstmt2 != null)
				pstmt2.close();
			if (con != null)
				con.close();
		}
	%>
	<%!%>
	</div>
</body>
</html>