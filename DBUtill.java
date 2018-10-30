package web2017;
import java.sql.*;

import com.mysql.jdbc.exceptions.jdbc4.MySQLDataException;

public class DBUtill {
	public static Connection getMySQLConnection()
	{
		Connection conn = null;

		try
		{
			Class.forName("com.mysql.jdbc.Driver");
			String jdbcDriver = "jdbc:mysql://localhost:3306/membership";
			String dbUser = "root";
			String dbPass = "1111";
			conn = DriverManager.getConnection(jdbcDriver, dbUser , dbPass);
		}catch(ClassNotFoundException e)
		{
			System.out.println("드라이버가 없습니다.");
		}catch(MySQLDataException e)
		{
			System.out.println("데이터베이스가 없습니다.");
		}catch(SQLException e) {
			System.out.println("사용자 계정 또는 비밀번호가 일치하지 않습니다.<br/>");
		}
		return conn;
	}
	public static void close(Connection conn)
	{
		try { if(conn != null) {conn.close(); } }catch(Exception e) {e.printStackTrace();}
	}
	public static void close(Statement stmt)
	{
		try { if(stmt != null) {stmt.close(); } }catch(Exception e) {e.printStackTrace();}
	}
	public static void close(ResultSet rs)
	{
		try { if(rs != null) {rs.close(); } }catch(Exception e) {e.printStackTrace();}
	}
}