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
			alert("아이디를 정확히 입력해주세요.");
			return false;
		}

		if (!document.LogIn.PWD.value) {
			alert("비밀번호를 정확히 입력해주세요.");
			return false;
		}
	}
</script>
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
		if (!document.SearchID.user_birth_year.value) {
			alert("연도를 입력해주세요.");
			return false;
		}
		if (!document.SearchID.user_birth_month.value) {
			alert("월을 입력해주세요.");
			return false;
		}
		if (!document.SearchID.user_birth_day.value) {
			alert("날짜를 입력해주세요.");
			return false;
		}
		if (!document.SearchID.user_phone.value) {
			alert("휴대폰번호를 입력하세요.");
			return false;
		} else {
			alert("계정을 찾았습니다.");
			return true;
		}
	}
</script>
<script type="text/javascript">
	function searchpwd() {
		if (!document.SearchPWD.user_name.value) {
			alert("이름을 입력하세요.");
			return false;
		}
		if (isNaN(document.SearchPWD.user_name.value) == false) {
			alert("숫자는 입력하실 수 없습니다.");
			return false;
		}
		if (!document.SearchPWD.user_id.value) {
			alert("아이디를 입력하세요.");
			return false;
		}
		if (SearchPWD.user_id.value.length<4 || SearchPWD.user_id.value.length>12) {
			alert("아이디는 4자리이상 12자리 미만으로 입력해주세요. ");
			return false;
		}
		for (var i = 0; i < SearchPWD.user_id.value.length; i++) {
			ch = SearchPWD.user_id.value.charAt(i);
			if (((ch >= 'ㅏ') && (ch <= '히')) || ((ch >= 'ㄱ') && (ch <= 'ㅎ'))) {
				alert("한글은 사용하실 수 없습니다.");
				SearchPWD.user_id.value = "";
				SearchPWD.user_id.focus();
				return false;
			}
		}
		if (!document.SearchPWD.user_birth_year.value) {
			alert("연도를 입력해주세요.");
			return false;
		}
		if (!document.SearchPWD.user_birth_month.value) {
			alert("월을 입력해주세요.");
			return false;
		}
		if (!document.SearchPWD.user_birth_day.value) {
			alert("날짜를 입력해주세요.");
			return false;
		}
		if (!document.SearchPWD.user_phone.value) {
			alert("휴대폰번호를 입력하세요.");
			return false;
		} else {
			alert("계정을 찾았습니다.");
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
		String e1 = request.getParameter("user_name"); //입력받는것
		String e2 = request.getParameter("user_phone");  //입력받는것
		System.out.println(e1+e2);
		ResultSet rs = null;
		Connection con = DBUtill.getMySQLConnection();
		PreparedStatement pstmt = null;
		String sql = "";
		try {
			sql = " select id from member where name=? && phone=? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, e1); //입력받을?의 값
			pstmt.setString(2, e2);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				//id있음
				String dbID = rs.getString("id");
				//String dbPass = rs.getString("passwd");
	%>
	<script type="text/javascript">
               alert(" 아이디:<%=dbID%>입니다.");
		location.href = "accountsearch.html";
	</script>
	<%
		} else {
	%>
	<script type="text/javascript">
		alert("일치하는 정보가 없습니다.");
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
				class="right" style="padding: 3px 10px;"> <a><strong>아이디</strong><Input
					type="text" name="ID" /></a> <a><strong>비밀번호</strong><Input
					type="password" name="PWD" /></a> <Input type="submit" name="Login"
				value="로그인" id="Login" /> <a href="accountsearch.jsp"><input
					type="button" name="Search" value="계정찾기" id="Search" /></a>
			</span>
		</form>
		</header>
		<section class="left"></section>
		<aside class="right"> <details> <summary>
		<strong>아이디 찾기</strong> </summary>
		<form method="post" action="accountsearch.jsp" name="SearchID"
			onsubmit="return searchid()">
			<table>

				<tr>
					<td>이름</td>
					<td><input type="text" name="user_name" /></td>
				</tr>
				<tr>
					<td>휴대폰번호</td>
					<td><input type="text" name="user_phone"
						placeholder="-없이 입력해주세요." /></td>
				</tr>
				<tr>
					<td></td>
					<td><input type="submit" name="submit" value="계정 찾기"
						id="submit" /></td>
				</tr>
			</table>
		</form>
		</details> <br>
		<details> <summary> <strong>비밀번호 찾기</strong> </summary>
		<form method="post" action="accountpasswd.jsp" name="SearchPWD"
			onsubmit="return searchpwd()">
			<table>

				<tr>
					<td>이름</td>
					<td><input type="text" name="user_name" /></td>
				</tr>
				<tr>
					<td>아이디</td>
					<td><input type="text" name="user_id" /></td>
				</tr>
				<tr>
					<td>휴대폰번호</td>
					<td><input type="text" name="user_phone"
						placeholder="-없이 입력해주세요." /></td>
				</tr>
				<tr>
					<td></td>
					<td><input type="submit" name="submit" value="계정 찾기"
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