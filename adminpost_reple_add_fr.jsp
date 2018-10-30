<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
	<%@ page import="java.util.Date"%>
	<%@ page import="web2017.DBUtill"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>MyHomp</title>
<style>
td {
	text-align: center;
	vertical-align: middle;
}
</style>

</head>
<body>

	<%@ page import="java.sql.*" %>
	<%
	request.setCharacterEncoding("EUC-KR");
		
	%>

	<hr>


	<%
		Connection con = null;
		Statement stmt = null;
		PreparedStatement pstmt = null;

		String driverName = "org.gjt.mm.mysql.Driver";
		String dbURL = "jdbc:mysql://localhost:3306/membership";
		String id = request.getParameter("id");
		String reple = request.getParameter("reple");
		String now = request.getParameter("now");
		String ref = request.getParameter("ref");
		String fr = request.getParameter("fr");
		String sql ="insert into `bmr_reple` (`id`, `reple`, `time`, `ref`) values('"+id+"', '"+reple+"', '"+now+"', '"+ref+"')";
		try {
		Class.forName(driverName);
		con = DriverManager.getConnection(dbURL, "root", "1111");
			
		
			 pstmt = con.prepareStatement(sql);
		     pstmt.executeUpdate();
		 	
			

		
			} catch (Exception e) {
				out.println("MySql 데이터베이스 조회에 문제가 있습니다. <hr>");
				out.println(e.toString());
				e.printStackTrace();
			} finally {
				if (pstmt != null)
					pstmt.close();
				if (con != null)
					con.close();
			}
		
		
		%>
	
		<script language='javascript'>
		//parent.window.location.href="postingafter_frame.jsp"; 
		
		parent.window.location.href="adminpostingafter_fr.jsp?fr=<%=fr%>"; 
		</script>
	</table>
	</center>


</body>
</html>