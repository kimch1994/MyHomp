<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>
<%@ page import="web2017.DBUtill"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>MyHomp</title>
<script type="text/javascript">
	function LOGIN() {
		if (!document.LogIn.ID.value) {
			alert("���̵� ��Ȯ�� �Է����ּ���.");
			return false;
		}

		if (!document.LogIn.PWD.value) {
			alert("��й�ȣ�� ��Ȯ�� �Է����ּ���.");
			return false;
		}
	}
</script>
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
		if (!document.SearchID.user_birth_year.value) {
			alert("������ �Է����ּ���.");
			return false;
		}
		if (!document.SearchID.user_birth_month.value) {
			alert("���� �Է����ּ���.");
			return false;
		}
		if (!document.SearchID.user_birth_day.value) {
			alert("��¥�� �Է����ּ���.");
			return false;
		}
		if (!document.SearchID.user_phone.value) {
			alert("�޴�����ȣ�� �Է��ϼ���.");
			return false;
		} else {
			alert("������ ã�ҽ��ϴ�.");
			return true;
		}
	}
</script>
<script type="text/javascript">
	function searchpwd() {
		if (!document.SearchPWD.user_name.value) {
			alert("�̸��� �Է��ϼ���.");
			return false;
		}
		if (isNaN(document.SearchPWD.user_name.value) == false) {
			alert("���ڴ� �Է��Ͻ� �� �����ϴ�.");
			return false;
		}
		if (!document.SearchPWD.user_id.value) {
			alert("���̵� �Է��ϼ���.");
			return false;
		}
		if (SearchPWD.user_id.value.length<4 || SearchPWD.user_id.value.length>12) {
			alert("���̵�� 4�ڸ��̻� 12�ڸ� �̸����� �Է����ּ���. ");
			return false;
		}
		for (var i = 0; i < SearchPWD.user_id.value.length; i++) {
			ch = SearchPWD.user_id.value.charAt(i);
			if (((ch >= '��') && (ch <= '��')) || ((ch >= '��') && (ch <= '��'))) {
				alert("�ѱ��� ����Ͻ� �� �����ϴ�.");
				SearchPWD.user_id.value = "";
				SearchPWD.user_id.focus();
				return false;
			}
		}
		if (!document.SearchPWD.user_birth_year.value) {
			alert("������ �Է����ּ���.");
			return false;
		}
		if (!document.SearchPWD.user_birth_month.value) {
			alert("���� �Է����ּ���.");
			return false;
		}
		if (!document.SearchPWD.user_birth_day.value) {
			alert("��¥�� �Է����ּ���.");
			return false;
		}
		if (!document.SearchPWD.user_phone.value) {
			alert("�޴�����ȣ�� �Է��ϼ���.");
			return false;
		} else {
			alert("������ ã�ҽ��ϴ�.");
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
		String e1 = request.getParameter("user_name"); //�Է¹޴°�
		String e2 = request.getParameter("user_phone");  //�Է¹޴°�
		System.out.println(e1+e2);
		ResultSet rs = null;
		Connection con = DBUtill.getMySQLConnection();
		PreparedStatement pstmt = null;
		String sql = "";
		try {
			sql = " select id from member where name=? && phone=? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, e1); //�Է¹���?�� ��
			pstmt.setString(2, e2);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				//id����
				String dbID = rs.getString("id");
				//String dbPass = rs.getString("passwd");
	%>
	<script type="text/javascript">
               alert(" ���̵�:<%=dbID%>�Դϴ�.");
		location.href = "accountsearch.html";
	</script>
	<%
		} else {
	%>
	<script type="text/javascript">
		alert("��ġ�ϴ� ������ �����ϴ�.");
		history.back();
	</script>
	<%
		}
		} catch (Exception e) {
			e.printStackTrace();
		}
	%>
	<div class="wrap">
		<header>

		<form method="post" action="project_LogIn.jsp" name="LogIn"
			onsubmit="return LOGIN()">

			<a id="logo" href="project.html"><strong>MyHomp</strong></a> <span
				class="right" style="padding: 3px 10px;"> <a><strong>���̵�</strong><Input
					type="text" name="ID" /></a> <a><strong>��й�ȣ</strong><Input
					type="password" name="PWD" /></a> <Input type="submit" name="Login"
				value="�α���" id="Login" /> <a href="accountsearch.jsp"><input
					type="button" name="Search" value="����ã��" id="Search" /></a>
			</span>
		</form>
		</header>
		<section class="left"></section>
		<aside class="right"> <details> <summary>
		<strong>���̵� ã��</strong> </summary>
		<form method="post" action="accountsearch.jsp" name="SearchID"
			onsubmit="return searchid()">
			<table>

				<tr>
					<td>�̸�</td>
					<td><input type="text" name="user_name" /></td>
				</tr>
				<tr>
					<td>�޴�����ȣ</td>
					<td><input type="text" name="user_phone"
						placeholder="-���� �Է����ּ���." /></td>
				</tr>
				<tr>
					<td></td>
					<td><input type="submit" name="submit" value="���� ã��"
						id="submit" /></td>
				</tr>
			</table>
		</form>
		</details> <br>
		<details> <summary> <strong>��й�ȣ ã��</strong> </summary>
		<form method="post" action="accountpasswd.jsp" name="SearchPWD"
			onsubmit="return searchpwd()">
			<table>

				<tr>
					<td>�̸�</td>
					<td><input type="text" name="user_name" /></td>
				</tr>
				<tr>
					<td>���̵�</td>
					<td><input type="text" name="user_id" /></td>
				</tr>
				<tr>
					<td>�޴�����ȣ</td>
					<td><input type="text" name="user_phone"
						placeholder="-���� �Է����ּ���." /></td>
				</tr>
				<tr>
					<td></td>
					<td><input type="submit" name="submit" value="���� ã��"
						id="submit" /></td>
				</tr>
			</table>
		</form>
		</details> </aside>
		<footer>
		<div id="copyright">Copyright (c) 2017 project</div>
		</footer>
	</div>
</body>
</body>
</html>