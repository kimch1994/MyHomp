package web2017;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.mysql.jdbc.PreparedStatement;

public class loginafter {

	public static boolean pass(String id, String password){
		String pass;
		Connection conn = DBUtill.getMySQLConnection();
		String sql ="select *from member where id=?";
		try{
			PreparedStatement pstmt = (PreparedStatement) conn.prepareStatement(sql);
			pstmt.setString(1, id);
			ResultSet rs = pstmt.executeQuery();
			rs.next();
			pass= rs.getString("password");
			DBUtill.close(rs);
			DBUtill.close(pstmt);
			DBUtill.close(conn);
			if(pass.equals(password)){
				return true;
			}
		}catch (SQLException e){
			e.printStackTrace();
		}
		return false;
	}
}
