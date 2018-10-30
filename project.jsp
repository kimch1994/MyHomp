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
		for (var i = 0; i < LogIn.ID.value.length; i++) {
			ch = LogIn.ID.value.charAt(i);
			if (((ch >= '��') && (ch <= '��')) || ((ch >= '��') && (ch <= '��'))) {
				alert("�ѱ��� ����Ͻ� �� �����ϴ�.");
				LogIn.ID.value = "";
				LogIn.ID.value.focus();
				return false;
			}
		}
		if (!document.LogIn.PWD.value) {
			alert("��й�ȣ�� ��Ȯ�� �Է����ּ���.");
			return false;
		}
	}
</script>
<script type="text/javascript">
	function check() {
		var num = document.userInfo;

		if (!document.userInfo.user_name.value) {
			alert("�̸��� �Է��ϼ���.");
			return false;
		}

		if (isNaN(num.user_name.value) == false) {
			alert("���ڴ� �Է��Ͻ� �� �����ϴ�.");
			return false;
		}

		if (!document.userInfo.user_id.value) {
			alert("���̵� �Է��ϼ���.");
			return false;
		}
		if (userInfo.user_id.value.length<4 || userInfo.user_id.value.length>12) {
			alert("���̵�� 4�ڸ��̻� 12�ڸ� �̸����� �Է����ּ���. ");
			return false;
		}

		for (var i = 0; i < userInfo.user_id.value.length; i++) {
			ch = userInfo.user_id.value.charAt(i);
			if (((ch >= '��') && (ch <= '��')) || ((ch >= '��') && (ch <= '��'))) {
				alert("�ѱ��� ����Ͻ� �� �����ϴ�.");
				userInfo.user_id.value = "";
				userInfo.user_id.focus();
				return false;
			}
		}

		if (!document.userInfo.user_pw.value) {
			alert("��й�ȣ�� �Է��ϼ���.");
			return false;
		}
		if (!document.userInfo.user_pw2.value) {
			alert("��й�ȣ Ȯ���� ���ּ���.");
			return false;
		}
		// ��й�ȣ�� ��й�ȣ Ȯ�ο� �Էµ� ���� �������� Ȯ��
		if (document.userInfo.user_pw.value != document.userInfo.user_pw2.value) {
			alert("��й�ȣ�� ��ġ���� �ʽ��ϴ�.");
			return false;
		}
		if (!document.userInfo.user_birth_year.value) {
			alert("������ �Է����ּ���.");
			return false;
		}
		if (!document.userInfo.user_birth_month.value) {
			alert("���� �Է����ּ���.");
			return false;
		}
		if (!document.userInfo.user_birth_day.value) {
			alert("��¥�� �Է����ּ���.");
			return false;
		}
		if (!document.userInfo.user_phone.value) {
			alert("�޴�����ȣ�� �Է��ϼ���.");
			return false;
		} else {
			alert("ȸ�������� ȯ���մϴ�.");
			return true;
			location.href = "project.jsp";
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
		String name = request.getParameter("user_name");
		String id = request.getParameter("user_id");
		String pw = request.getParameter("user_pw");
		String pw2 = request.getParameter("user_pw2");
		String birth_year = request.getParameter("user_birth_year");
		String birth_month = request.getParameter("user_birth_month");
		String birth_day = request.getParameter("user_birth_day");
		String phone = request.getParameter("user_phone");
		String hometown = request.getParameter("user_hometown");

		Connection conn = DBUtill.getMySQLConnection();
		//�����ͺ��̽��� ����
		String sql = "insert into member(name , id , passwd , year , month , day, phone,hometown) values(? ,? ,? ,? ,? ,? ,?,?)";
		//�����ͺ��̽��� �÷��� �Է¹��� �����͸� �־���
		PreparedStatement pstmt = conn.prepareStatement(sql);
		//�־��ִ� ������ ����
		System.out.println(pstmt + "<-- pstmt 1");

		pstmt.setString(1, name);
		pstmt.setString(2, id);
		pstmt.setString(3, pw);
		pstmt.setString(4, birth_year);
		pstmt.setString(5, birth_month);
		pstmt.setString(6, birth_day);
		pstmt.setString(7, phone);
		pstmt.setString(8, hometown);
		//�ԷµǴ� �������� ����
		System.out.println(pstmt + "<-- pstmt 2");

		pstmt.executeUpdate();

		DBUtill.close(pstmt);
		DBUtill.close(conn);
	%>
	<jsp:useBean id="project" class="web2017.project" scope="page" />
	<jsp:setProperty property="user_name" name="project" param="user_name" />
	<jsp:setProperty property="user_id" name="project" param="user_id" />
	<jsp:setProperty property="user_pw" name="project" param="user_pw" />
	<jsp:setProperty property="user_pw2" name="project" param="user_pw2" />
	<jsp:setProperty property="user_birth_year" name="project"
		param="user_birth_year" />
	<jsp:setProperty property="user_birth_month" name="project"
		param="user_birth_month" />
	<jsp:setProperty property="user_birth_day" name="project"
		param="user_birth_day" />
	<jsp:setProperty property="user_phone" name="project"
		param="user_phone" />
	<div class="wrap">
		<header>

		<form method="post" action="project_LogIn.jsp" name="LogIn"
			onsubmit="return LOGIN()">

			<a id="logo" href="project.html"><strong>MyHomp</strong></a> <span
				class="right" style="padding: 3px 10px;"> <a><strong>���̵�</strong><Input
					type="text" name="ID" /></a> <a><strong>��й�ȣ</strong><Input
					type="password" name="PWD" /></a> <Input type="submit" name="Login"
				value="�α���" id="Login" /> <a href="accountsearch.html"><input
					type="button" name="Search" value="����ã��" id="Search" /></a>
			</span>

		</form>
		</header>
		<form method="post" action="project.jsp" name="userInfo"
			onsubmit="return check()">
			<section class="left"> <img src="img/sns.jpg" width="800"
				height="350" id="sns" /></section>
			<aside class="right">
			<p>
				<strong>�� ���� �����</strong>
			</p>
			<p>�Ʒ� �׸��� �Է����ּ���.</p>
			<table>

				<tr>
					<td>�̸�(�ʼ�)</td>
					<td><input type="text" name="user_name" /></td>
				</tr>
				<tr>
					<td>���̵�(�ʼ�)</td>
					<td><input type="text" name="user_id" /></td>
				</tr>
				<tr>
					<td>��й�ȣ(�ʼ�)</td>
					<td><input type="password" name="user_pw" /></td>
				</tr>
				<tr>
					<td>��й�ȣ Ȯ��(�ʼ�)</td>
					<td><input type="password" name="user_pw2" /></td>
				</tr>
				<tr>
					<td>�������(�ʼ�)</td>
					<td><select name="user_birth_year">
							<option value="">&nbsp;</option>
							<option value="1950">1950</option>
							<option value="1951">1951</option>
							<option value="1952">1952</option>
							<option value="1953">1953</option>
							<option value="1954">1954</option>
							<option value="1955">1955</option>
							<option value="1956">1956</option>
							<option value="1957">1957</option>
							<option value="1958">1958</option>
							<option value="1959">1959</option>
							<option value="1960">1960</option>
							<option value="1961">1961</option>
							<option value="1962">1962</option>
							<option value="1963">1963</option>
							<option value="1964">1964</option>
							<option value="1965">1965</option>
							<option value="1966">1966</option>
							<option value="1967">1967</option>
							<option value="1968">1968</option>
							<option value="1969">1969</option>
							<option value="1970">1970</option>
							<option value="1971">1971</option>
							<option value="1972">1972</option>
							<option value="1973">1973</option>
							<option value="1974">1974</option>
							<option value="1975">1975</option>
							<option value="1976">1976</option>
							<option value="1977">1977</option>
							<option value="1978">1978</option>
							<option value="1979">1979</option>
							<option value="1980">1980</option>
							<option value="1981">1981</option>
							<option value="1982">1982</option>
							<option value="1983">1983</option>
							<option value="1984">1984</option>
							<option value="1985">1985</option>
							<option value="1986">1986</option>
							<option value="1987">1987</option>
							<option value="1988">1988</option>
							<option value="1989">1989</option>
							<option value="1990">1990</option>
							<option value="1991">1991</option>
							<option value="1992">1992</option>
							<option value="1993">1993</option>
							<option value="1994">1994</option>
							<option value="1995">1995</option>
							<option value="1996">1996</option>
							<option value="1997">1997</option>
							<option value="1998">1998</option>
							<option value="1999">1999</option>
							<option value="2000">2000</option>
							<option value="2001">2001</option>
							<option value="2002">2002</option>
							<option value="2003">2003</option>
							<option value="2004">2004</option>
							<option value="2005">2005</option>
							<option value="2006">2006</option>
							<option value="2007">2007</option>
							<option value="2008">2008</option>
							<option value="2009">2009</option>
							<option value="2010">2010</option>
							<option value="2011">2011</option>
							<option value="2012">2012</option>
							<option value="2013">2013</option>
							<option value="2014">2014</option>
							<option value="2015">2015</option>
							<option value="2016">2016</option>
							<option value="2017">2017</option>

					</select> �� <select name="user_birth_month">
							<option value="">&nbsp;</option>
							<option value="1">1</option>
							<option value="2">2</option>
							<option value="3">3</option>
							<option value="4">4</option>
							<option value="5">5</option>
							<option value="6">6</option>
							<option value="7">7</option>
							<option value="8">8</option>
							<option value="9">9</option>
							<option value="10">10</option>
							<option value="11">11</option>
							<option value="12">12</option>
					</select> �� <select name="user_birth_day">
							<option value="">&nbsp;</option>
							<option value="1">1</option>
							<option value="2">2</option>
							<option value="3">3</option>
							<option value="4">4</option>
							<option value="5">5</option>
							<option value="6">6</option>
							<option value="7">7</option>
							<option value="8">8</option>
							<option value="9">9</option>
							<option value="10">10</option>
							<option value="11">11</option>
							<option value="12">12</option>
							<option value="13">13</option>
							<option value="14">14</option>
							<option value="15">15</option>
							<option value="16">16</option>
							<option value="17">17</option>
							<option value="18">18</option>
							<option value="19">19</option>
							<option value="20">20</option>
							<option value="21">21</option>
							<option value="22">22</option>
							<option value="23">23</option>
							<option value="24">24</option>
							<option value="25">25</option>
							<option value="26">26</option>
							<option value="27">27</option>
							<option value="28">28</option>
							<option value="29">29</option>
							<option value="30">30</option>
							<option value="31">31</option>
					</select> ��</td>
				</tr>
				<tr>
					<td>�޴�����ȣ(�ʼ�)</td>
					<td><input type="text" name="user_phone"
						placeholder="-���� �Է����ּ���." /></td>
				</tr>
				<tr>
						<td>�����(����)</td>
						<td><input type="text" name="user_hometown" placeholder="ģ����õ�� ������ �˴ϴ�."/></td>
					</tr>
				<tr>
					<td></td>
					<td><input type="submit" name="submit" value="���� �����"
						id="submit" /></td>
				</tr>
			</table>
			</aside>
		</form>
		<footer>
		<div id="copyright">Copyright (c) 2017 project</div>
		</footer>
	</div>
</body>
</html>