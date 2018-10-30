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
			alert("�̸��� �Է��ϼ���.");
			return false;
		}
		if (isNaN(document.SearchID.user_name.value) == false) {
			alert("���ڴ� �Է��Ͻ� �� �����ϴ�.");
			return false;
		}
		 else {
			alert("�˻��Ϸ�.");
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
		//id passwd��������
		String id = (String) session.getAttribute("id");
		String friendname = request.getParameter("user_name"); //�Է¹޴°�
		//String friend_id = request.getParameter("user_id");
		System.out.println("ģ���̸�:"+friendname);
		Connection con = DBUtill.getMySQLConnection();
		
		String sql = "select name,id from member where name=?"; //�Է¹��� �̸��� �����ͺ��̽��� �ִٸ� �̸��� ���̵� �����´�.
		PreparedStatement pstmt = con.prepareStatement(sql);
		pstmt.setString(1, friendname); //�Է¹���?�� ��	
		System.out.println("ģ���̸�"+friendname);
		ResultSet rs = pstmt.executeQuery();
	%>
	
	<div class="wrap">
	<header> <a id="logo" href="adminafter.jsp"><strong>MyHomp</strong></a>
      <span class="right" style="padding: 3px 10px;"><a href="adminafter.jsp"><%=id %>�� &nbsp; <a
         href="logout.jsp"><input type="submit" name="Logout"
            id="Logout" value="�α׾ƿ�" /></a><a href="adminfriendlist.jsp"><input
						type="button" name="friend" value="ģ��ã��" id="friend" /></a>
      </span> </header>
		<section class="left">
		<strong>ģ�� ã��</strong> 
		<form method="post" action="adminfriendlist.jsp" name="SearchID"
			onsubmit="return searchid()">
			<table>

				<tr>
					<td></td>
					<td><input type="text" name="user_name" placeholder="�̸��� �˻��ϼ���." /></td>	
					<td><input type="submit" name="submit" value="Search"
						id="Searchfriend" /></td>
				</tr>
			</table>
		</form>
		<% 
                  while(rs.next()) //rs.next: sql�� �ش簪�� �ִٸ� �ҷ��´�.
                  {
                	  String friend_name=rs.getString("name"); //�����ͺ��̽� �÷����� ���� �������ڴ�
              		  String friend_id=rs.getString("id"); 
              		  System.out.println("���̵�"+friend_id);
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
		//id passwd��������
		
		Connection con1 = DBUtill.getMySQLConnection();
		
		String sql1 = "select hometown from member where id=?";
		PreparedStatement pstmt1 = con1.prepareStatement(sql1);
		pstmt1.setString(1, id); //�Է¹���?�� ��
		System.out.println("���̵�:"+id);
		ResultSet rs1 = pstmt1.executeQuery();
		while (rs1.next()){
			String home1 = rs1.getString("hometown");
			System.out.println("���ֱ���:"+home1);
		
		String sql2 = "select name,id from member where hometown=? order by binary(name)"; //�α��ε� ������ �������� �������� member���̺��� �̸��� ���̵� �����´�.
		PreparedStatement pstmt2 = con1.prepareStatement(sql2);
		pstmt2.setString(1, home1); //�Է¹���?�� ��	
		ResultSet rs2 = pstmt2.executeQuery();
		
	%>
	<aside class="right"> 
		<h3 id="reco">ģ����õ</h3>
		<table id="friendrecommand">
		
			<% 
				  int count=0;
				 
				  //String recommand_friend_id_session=null;
				  String recommand_friend_id[]=new String[50]; //��񿡼� ���̵� �������� ���� ����
				  String reco_session[]=new String[50];
				  String recommandname[]=new String[50];
            	  
                  while(rs2.next()) //rs.next: sql�� �ش簪�� �ִٸ� �ҷ��´�.
                  {
                	  recommandname[count]=(String)rs2.getString("name"); //�����ͺ��̽� �÷����� ���� �������ڴ�
                	  System.out.println("�̸�:"+recommandname[count]);
              		  
                	  recommand_friend_id[count]=(String)rs2.getString("id");
              		  System.out.println("��õ���̵�:"+recommand_friend_id[count]);
              		  session.setAttribute("id3", recommand_friend_id[count]);//������ �����ϰڴ�.
              		 
              		                     
              		  reco_session[count]=(String)session.getAttribute("id3"); //���ǰ��� �������ڴ�.
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