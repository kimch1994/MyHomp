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

<script type="text/javascript">
	function searchid() {
		if (!document.SearchID.user_name.value) {
			alert("이름을 입력하세요.");
			return false;
		}
		if (isNaN(document.SearchID.user_name.value) == false) {
			alert("숫자는 입력하실 수 없습니다.");
			return false;
		}
		 else {
			alert("검색완료.");
			return true;
		}
	}
</script>

<link rel="stylesheet" type="text/css" href="defaultcss.css" />
</head>
<body>
	<%
		request.setCharacterEncoding("euc-kr");
	%>
	<%
		//id passwd가져오기
		String id = (String) session.getAttribute("id");
		String friendname = request.getParameter("user_name"); //입력받는것
		//String friend_id = request.getParameter("user_id");
		System.out.println("친구이름:"+friendname);
		Connection con = DBUtill.getMySQLConnection();
		
		String sql = "select name,id from member where name=?"; //입력받은 이름이 데이터베이스에 있다면 이름과 아이디를 가져온다.
		PreparedStatement pstmt = con.prepareStatement(sql);
		pstmt.setString(1, friendname); //입력받을?의 값	
		System.out.println("친구이름"+friendname);
		ResultSet rs = pstmt.executeQuery();
	%>
	
	<div class="wrap">
	<header> <a id="logo" href="adminafter.jsp"><strong>MyHomp</strong></a>
      <span class="right" style="padding: 3px 10px;"><a href="adminafter.jsp"><%=id %>님 &nbsp; <a
         href="logout.jsp"><input type="submit" name="Logout"
            id="Logout" value="로그아웃" /></a><a href="adminfriendlist.jsp"><input
						type="button" name="friend" value="친구찾기" id="friend" /></a>
      </span> </header>
		<section class="left">
		<strong>친구 찾기</strong> 
		<form method="post" action="adminfriendlist.jsp" name="SearchID"
			onsubmit="return searchid()">
			<table>

				<tr>
					<td></td>
					<td><input type="text" name="user_name" placeholder="이름을 검색하세요." /></td>	
					<td><input type="submit" name="submit" value="Search"
						id="Searchfriend" /></td>
				</tr>
			</table>
		</form>
		<% 
                  while(rs.next()) //rs.next: sql에 해당값이 있다면 불러온다.
                  {
                	  String friend_name=rs.getString("name"); //데이터베이스 컬럼에서 값을 가져오겠다
              		  String friend_id=rs.getString("id"); 
              		  System.out.println("아이디"+friend_id);
              		  session.setAttribute("id2", friend_id);
                  %>
		<table>
		<tr>
                     <td><a href="adminfriendpage.jsp?fr=<%=friend_id%>" target="_blank"><%=friend_name%></td>
        			 <!--  <td><%=friend_id %></td> -->
        </tr>
		</table>
		<%
                  }
		%>
		
		</section>
		<%
		//id passwd가져오기
		
		Connection con1 = DBUtill.getMySQLConnection();
		
		String sql1 = "select hometown from member where id=?";
		PreparedStatement pstmt1 = con1.prepareStatement(sql1);
		pstmt1.setString(1, id); //입력받을?의 값
		System.out.println("아이디:"+id);
		ResultSet rs1 = pstmt1.executeQuery();
		while (rs1.next()){
			String home1 = rs1.getString("hometown");
			System.out.println("거주구역:"+home1);
		
		String sql2 = "select name,id from member where hometown=? order by binary(name)"; //로그인된 계정의 거주지를 기준으로 member테이블에서 이름과 아이디를 가져온다.
		PreparedStatement pstmt2 = con1.prepareStatement(sql2);
		pstmt2.setString(1, home1); //입력받을?의 값	
		ResultSet rs2 = pstmt2.executeQuery();
		
	%>
	<aside class="right"> 
		<h3 id="reco">친구추천</h3>
		<table id="friendrecommand">
		
			<% 
				  int count=0;
				 
				  //String recommand_friend_id_session=null;
				  String recommand_friend_id[]=new String[50]; //디비에서 아이디를 가져오는 변수 선언
				  String reco_session[]=new String[50];
				  String recommandname[]=new String[50];
            	  
                  while(rs2.next()) //rs.next: sql에 해당값이 있다면 불러온다.
                  {
                	  recommandname[count]=(String)rs2.getString("name"); //데이터베이스 컬럼에서 값을 가져오겠다
                	  System.out.println("이름:"+recommandname[count]);
              		  
                	  recommand_friend_id[count]=(String)rs2.getString("id");
              		  System.out.println("추천아이디:"+recommand_friend_id[count]);
              		  session.setAttribute("id3", recommand_friend_id[count]);//세션을 생성하겠다.
              		 
              		                     
              		  reco_session[count]=(String)session.getAttribute("id3"); //세션값을 가져오겠다.
                      System.out.println("reco_session["+count+"]:"+reco_session[count]);
                    
                  %>
		
		<tr>
		<td id="listname"><a href="adminfriendrecommandpage.jsp?fr=<%= reco_session[count] %>" target="_blank"/><%= recommandname[count] %><br></td>
			
		</tr>
		<tr></tr>
		<tr></tr>
		<tr></tr>
		
		<%
		 count++;
                  }
                
		}
		%>
		</table>
		</aside>
		<footer>
		<div id="copyright">Copyright (c) 2017 project</div>
		</footer>
	</div>
</body>
</body>
</html>