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
			System.out.println("����̹��� �����ϴ�.");
		}catch(MySQLDataException e)
		{
			System.out.println("�����ͺ��̽��� �����ϴ�.");
		}catch(SQLException e) {
			System.out.println("����� ���� �Ǵ� ��й�ȣ�� ��ġ���� �ʽ��ϴ�.<br/>");
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